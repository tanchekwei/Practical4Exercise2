using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practical4Exercise2
{
    public partial class SalesOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearc_Click(object sender, EventArgs e)
        {
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strCon);

            string strCountProd = "SELECT SUM(UnitPrice * Quantity) " +
                "FROM [Order Details] od, Orders o " +
                "WHERE od.OrderID = o.OrderID " +
                "AND o.EmployeeID = @EmployeeID " +
                "AND YEAR(o.OrderDate) = @OrderDate";
            con.Open();
            SqlCommand command = new SqlCommand(strCountProd, con);
            command.Parameters.Add(new SqlParameter("EmployeeID", ddlStaff.SelectedValue));
            command.Parameters.Add(new SqlParameter("OrderDate", rblYear.SelectedValue));
            decimal sales = (decimal)command.ExecuteScalar();

            lblTitle.Text = "Sales Order by " + ddlStaff.SelectedItem + " in year of " + rblYear.SelectedValue + ". Grand Total Sales: $" + String.Format("{0:n}", sales);
        }
    }
}