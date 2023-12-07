<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:MultiView ID="CBF110041_MV1" runat="server">
                <asp:View ID="CBF110041_View1" runat="server">
                    <asp:GridView ID="CBF110041_GV1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSource1" EmptyDataText="沒有資料錄可顯示。" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False" ItemStyle-Wrap="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="更新"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="編輯"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text="刪除"></asp:LinkButton>
                                </ItemTemplate>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="word" HeaderText="word" SortExpression="word" />
                            <asp:BoundField DataField="ch_explanation" HeaderText="ch_explanation" SortExpression="ch_explanation" />
                            <asp:TemplateField HeaderText="sentence" SortExpression="sentence">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sentence") %>' Width="98%" TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("sentence") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="sno" HeaderText="sno" SortExpression="sno" />
                            <asp:BoundField DataField="level" HeaderText="level" SortExpression="level" />

                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString1 %>" DeleteCommand="DELETE FROM [gept_words] WHERE [Id] = @Id" InsertCommand="INSERT INTO [gept_words] ([Id], [word], [ch_explanation], [sentence], [sno], [level], [frequency], [weight]) VALUES (@Id, @word, @ch_explanation, @sentence, @sno, @level, @frequency, @weight)" SelectCommand="SELECT [Id], [word], [ch_explanation], [sentence], [sno], [level], [frequency], [weight] FROM [gept_words]" UpdateCommand="UPDATE [gept_words] SET [word] = @word, [ch_explanation] = @ch_explanation, [sentence] = @sentence, [sno] = @sno, [level] = @level, [frequency] = @frequency, [weight] = @weight WHERE [Id] = @Id">
                        <DeleteParameters>
                            <asp:Parameter Name="Id" Type="Double" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Id" Type="Double" />
                            <asp:Parameter Name="word" Type="String" />
                            <asp:Parameter Name="ch_explanation" Type="String" />
                            <asp:Parameter Name="sentence" Type="String" />
                            <asp:Parameter Name="sno" Type="String" />
                            <asp:Parameter Name="level" Type="Double" />
                            <asp:Parameter Name="frequency" Type="Double" />
                            <asp:Parameter Name="weight" Type="Double" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="word" Type="String" />
                            <asp:Parameter Name="ch_explanation" Type="String" />
                            <asp:Parameter Name="sentence" Type="String" />
                            <asp:Parameter Name="sno" Type="String" />
                            <asp:Parameter Name="level" Type="Double" />
                            <asp:Parameter Name="frequency" Type="Double" />
                            <asp:Parameter Name="weight" Type="Double" />
                            <asp:Parameter Name="Id" Type="Double" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:DropDownList ID="CBF110041_DDL1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="word" DataValueField="ch_explanation" OnSelectedIndexChanged="CBF110041_DDL1_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:Button ID="CBF110041_PreviousButton" runat="server" Text="PreviousButton" OnClick="CBF110041_PreviousButton_Click" />
                    <asp:Button ID="CBF110041_NextButton" runat="server" Text="NextButton" OnClick="CBF110041_NextButton_Click" />
                    <asp:Button ID="CBF110041_testBtn" runat="server" OnClick="CBF110041_testBtn_Click" Text="測驗去" />
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString1 %>"
                        SelectCommand="SELECT TOP 10 * FROM (SELECT ROW_NUMBER() OVER (ORDER BY [Id]) AS RowNum, * FROM [gept_words]) AS Sub WHERE RowNum > @StartRowIndex">
                        <SelectParameters>
                            <asp:Parameter Name="StartRowIndex" Type="Int32" DefaultValue="0" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Literal ID="CBF110041_cambridge" runat="server"></asp:Literal>
                    <br />
                    <br />
                    <a href="https://github.com/Jie042l/QUIZ5/blob/main/gept_words_reflections.htmll">GitHub心得</a>&nbsp; <a href="gept_words_reflections.html">本地端心得網頁</a>
                </asp:View>
                <asp:View ID="CBF110041_View2" runat="server">                    
                    <asp:Literal ID="CBF110041_ch_hint" runat="server"></asp:Literal>
                    <asp:TextBox ID="CBF110041_input" runat="server" onclick="this.setSelectionRange(0,999)" onfocus="this.setSelectionRange(0,999)" AutoComplete="off"  autofocus="autofocus"></asp:TextBox>
                    <asp:Button ID="CBF110041_nextQBtn" runat="server" Text="下一題" OnClick="CBF110041_nextQBtn_Click1" />
                    <asp:Button ID="CBF110041_end" runat="server" OnClick="CBF110041_end_Click" Text="結束" />
                    <br />
                    <asp:Literal ID="CBF110041_Literal" runat="server">請輸入完整單字(底線是用來提示有幾個字元, 如果消失了可以移動滑鼠至方格上來查看.)</asp:Literal>
                    <br />
                    <asp:HyperLink ID="CBF110041_HL1" runat="server" NavigateUrl="Default.aspx">重玩</asp:HyperLink>
                    <br />

                    
                </asp:View>
            </asp:MultiView>
        </div>
    </form>
</body>
</html>
