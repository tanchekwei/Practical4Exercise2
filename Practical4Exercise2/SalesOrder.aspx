<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesOrder.aspx.cs" Inherits="Practical4Exercise2.SalesOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }

        .radioButtonList label {
            display: inline;
        }
        .auto-style2 {
            width: 281px;
        }
        .auto-style3 {
            margin-left: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Sales Order Information By Staff</h1>
        <table>
            <tr>
                <td class="auto-style1">Please select staff name:</td>
                <td class="auto-style1">Please select year:</td>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList ID="ddlStaff" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="EmployeeID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT (LastName + ' '  + FirstName) AS Name, EmployeeID FROM Employees"></asp:SqlDataSource>
                </td>
                <td>
                    <asp:RadioButtonList ID="rblYear" runat="server" DataSourceID="SqlDataSource2" DataTextField="OrderYear" DataValueField="OrderYear">
                    </asp:RadioButtonList>
                    <asp:Button ID="btnSearc" runat="server" OnClick="btnSearc_Click" Text="Search" />
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT DATEPART(year, OrderDate) AS OrderYear FROM Orders"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <br />
        <span style="color:blue"><b><u><asp:Label ID="lblTitle" runat="server"></asp:Label></u></b></span>

        <br />

        <table>
            <tr>
                <td>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BorderStyle="Dashed" DataKeyNames="OrderID" DataSourceID="SqlDataSource3">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                <asp:BoundField DataField="OrderDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="OrderDate" SortExpression="OrderDate" />
            </Columns>
        </asp:GridView>
                </td>
                <td class="auto-style2">
        <asp:DataList ID="DataList1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="auto-style3" DataSourceID="SqlDataSource4" GridLines="Both" Width="230px">
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <ItemStyle ForeColor="#000066" />
            <ItemTemplate>
                Product Name:
                <asp:Label ID="Product_NameLabel" runat="server" Text='<%# Eval("[Product Name]") %>' />
                <br />
                Unit Price: 
                $<asp:Label ID="Unit_PriceLabel" runat="server" Text='<%#string.Format("{0:n2}", Eval("[Unit Price]")) %>' />
                <br />
                Quantity:
                <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                <br />
                Discount:
                <asp:Label ID="DiscountLabel" runat="server" Text='<%# Eval("Discount") %>' />%
                <br />
                Sales: 
                $<asp:Label ID="SalesLabel" runat="server" Text='<%#string.Format("{0:n2}", Eval("Sales")) %>' />
                <br />
<br />
            </ItemTemplate>
            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ProductName AS [Product Name], od.UnitPrice AS [Unit Price], Quantity, Discount, (Quantity * od.UnitPrice) AS Sales
FROM  [Order Details] od, Orders o, Products p
WHERE od.OrderID = o. OrderID
 AND od.ProductID = p.ProductID
 AND od.OrderID = @OrderID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="OrderID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

        <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT OrderID, OrderDate
FROM Orders o, Employees e
WHERE o.EmployeeID = e.EmployeeID
AND e.EmployeeID = @EmployeeID
AND YEAR(o.OrderDate) = @OrderDate
">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlStaff" Name="EmployeeID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="rblYear" Name="OrderDate" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
