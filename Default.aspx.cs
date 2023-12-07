using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    List<int> shuffledIndices = new List<int>();
    HashSet<int> usedIndices = new HashSet<int>();
    int currentIndex = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["A"] = 9;
            CBF110041_PreviousButton.Enabled = false;
            CBF110041_NextButton.Enabled = true;            

            ShuffleQuestions();

            CBF110041_MV1.ActiveViewIndex = 0;


            if (CBF110041_DDL1.Items.Count > 0)
            {
                string url = $"https://dictionary.cambridge.org/zht/詞典/英語-漢語-繁體/{CBF110041_DDL1.Items[0].Text}";
                string hyperlink = $"<a href='{url}'>{CBF110041_DDL1.Items[0].Text}</a>";
                CBF110041_cambridge.Text = $"{hyperlink} => {CBF110041_DDL1.Items[0].Value}<br/>";
            }
        }
    }

    protected void CBF110041_DDL1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string url = $"https://dictionary.cambridge.org/zht/詞典/英語-漢語-繁體/{CBF110041_DDL1.SelectedItem.Text}";

        string hyperlink = $"<a href='{url}'>{CBF110041_DDL1.SelectedItem.Text}</a>";

        CBF110041_cambridge.Text += $"{hyperlink}" + "=>" + $" {CBF110041_DDL1.SelectedValue}" + "<br/>";

    }

    protected void CBF110041_PreviousButton_Click(object sender, EventArgs e)
    {
        int startRowIndex = Convert.ToInt32(SqlDataSource2.SelectParameters["StartRowIndex"].DefaultValue);
        startRowIndex -= 10;

        if (startRowIndex < 0)
        {
            startRowIndex = 0;
        }

        SqlDataSource2.SelectParameters["StartRowIndex"].DefaultValue = startRowIndex.ToString();
        CBF110041_DDL1.DataBind();

        CBF110041_DDL1.DataBind();
        Session["A"] = (int)Session["A"] - 10;
        CBF110041_DDL1.DataBind();
        
        if ((int)Session["A"] == 9) CBF110041_PreviousButton.Enabled = false;
        CBF110041_NextButton.Enabled = true;
        CBF110041_DDL1.DataBind();
        CBF110041_cambridge.Text = "";
        if (CBF110041_DDL1.Items.Count > 0)
        {
            string url = $"https://dictionary.cambridge.org/zht/詞典/英語-漢語-繁體/{CBF110041_DDL1.Items[0].Text}";
            string hyperlink = $"<a href='{url}'>{CBF110041_DDL1.Items[0].Text}</a>";
            CBF110041_cambridge.Text = $"{hyperlink} => {CBF110041_DDL1.Items[0].Value}<br/>";
        }
    }

    protected void CBF110041_NextButton_Click(object sender, EventArgs e)
    {
        int startRowIndex = Convert.ToInt32(SqlDataSource2.SelectParameters["StartRowIndex"].DefaultValue);
        startRowIndex += 10;

        SqlDataSource2.SelectParameters["StartRowIndex"].DefaultValue = startRowIndex.ToString();
        CBF110041_DDL1.DataBind();

        CBF110041_DDL1.DataBind();
        Session["A"] = (int)Session["A"] + 10;
        CBF110041_DDL1.DataBind();
        
        CBF110041_PreviousButton.Enabled = true;
        CBF110041_DDL1.DataBind();
        CBF110041_cambridge.Text = "";
        if (CBF110041_DDL1.Items.Count > 0)
        {
            string url = $"https://dictionary.cambridge.org/zht/詞典/英語-漢語-繁體/{CBF110041_DDL1.Items[0].Text}";
            string hyperlink = $"<a href='{url}'>{CBF110041_DDL1.Items[0].Text}</a>";
            CBF110041_cambridge.Text = $"{hyperlink} => {CBF110041_DDL1.Items[0].Value}<br/>";
        }
    }

    protected void CBF110041_testBtn_Click(object sender, EventArgs e)
    {
        CBF110041_MV1.ActiveViewIndex = 1;
        CBF110041_end.Visible = false;
        CBF110041_HL1.Visible = false;

        if (CBF110041_DDL1.SelectedItem != null)
        {
            string chineseExplanation = CBF110041_DDL1.SelectedItem.Value;
            CBF110041_ch_hint.Text = chineseExplanation;
        }

        // Set the initial letter(s) of the English word with underscores for character count
        if (CBF110041_DDL1.SelectedItem != null)
        {
            string selectedWord = CBF110041_DDL1.SelectedItem.Text;
            string initialLetters = selectedWord.Substring(0, 1); // Get the first letter
            int wordLength = selectedWord.Length;
            string underscorePlaceholder = string.Join(" ", new string('_', wordLength - 1).ToCharArray()); // Create underscores for the remaining characters
            string displayText = initialLetters + underscorePlaceholder;
            CBF110041_input.Text = displayText;
        }
    }

    protected void CBF110041_nextQBtn_Click(object sender, EventArgs e)
    {
        if (currentIndex < shuffledIndices.Count)
        {
            int nextIndex = shuffledIndices[currentIndex];
            CBF110041_DDL1.SelectedIndex = nextIndex;

            // Update UI based on the selected question (similar logic as before)
            if (CBF110041_DDL1.SelectedItem != null)
            {
                string chineseExplanation = CBF110041_DDL1.SelectedItem.Value;
                CBF110041_ch_hint.Text = chineseExplanation;

                string selectedWord = CBF110041_DDL1.SelectedItem.Text;
                string initialLetters = selectedWord.Substring(0, 1); // Get the first letter
                int wordLength = selectedWord.Length;

                string underscorePlaceholder = string.Join(" ", new string('_', wordLength - 1).ToCharArray());

                string displayText = initialLetters + underscorePlaceholder;
                CBF110041_input.Text = displayText;
            }

            currentIndex++;
        }
        else
        {
            // If all questions are asked, reshuffle for the next round
            ShuffleQuestions();
            currentIndex = 0;
        }
    }

    private void ShuffleQuestions()
    {
        // Clear used indices when all questions are used
        if (usedIndices.Count == CBF110041_DDL1.Items.Count)
        {
            usedIndices.Clear();
        }

        // Generate shuffled indices until a unique set is obtained
        shuffledIndices.Clear();
        Random rng = new Random();
        int itemCount = CBF110041_DDL1.Items.Count;

        while (shuffledIndices.Count < itemCount)
        {
            int randomIndex = rng.Next(itemCount);

            // Ensure the index is not already used
            if (!usedIndices.Contains(randomIndex))
            {
                shuffledIndices.Add(randomIndex);
                usedIndices.Add(randomIndex);
            }
        }
    }

    protected void CBF110041_nextQBtn_Click1(object sender, EventArgs e)
    {
        CBF110041_MV1.ActiveViewIndex = 1;
        if (CBF110041_DDL1.SelectedIndex < CBF110041_DDL1.Items.Count - 1)
        {
            CBF110041_DDL1.SelectedIndex += 1;
            CBF110041_testBtn_Click(sender, e);
        }
        else
        {
            CBF110041_end.Visible = true;
            CBF110041_HL1.Visible = true;


            CBF110041_cambridge.Visible = false;
            CBF110041_input.Visible = false;
            CBF110041_nextQBtn.Visible = false;
            CBF110041_ch_hint.Visible = false;
        }
    }

    protected void CBF110041_end_Click(object sender, EventArgs e)
    {
        CBF110041_end.Visible = false;
        CBF110041_Literal.Visible = false;
        CBF110041_HL1.Visible = false;
    }
}