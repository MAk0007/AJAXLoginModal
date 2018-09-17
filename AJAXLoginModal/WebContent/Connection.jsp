<%@ page import="java.sql.*"%>  
  
<%  
String name=request.getParameter("name");
String pass=request.getParameter("pass");

if(name==null || name.trim().equals("")){  
out.println("Please enter username");
}else if(pass==null || pass.trim().equals("")){
	out.print("Please enter password");

}else{  
try{  
Class.forName("oracle.jdbc.driver.OracleDriver");  
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","akram97ulla");  
PreparedStatement ps=con.prepareStatement("select username,password from users where username=?");  
ps.setString(1,name);
String uname=null,pw=null;
ResultSet rs=ps.executeQuery();  
while(rs.next()){  
uname=rs.getString(1);
pw=rs.getString(2);
}  
if(name.equals(uname)){
	if(pass.equals(pw)){
		HttpSession session1 = request.getSession(true);
		session1.setAttribute("name", uname);
		RequestDispatcher rd = request.getRequestDispatcher("Display.jsp");
		rd.forward(request, response);
	}else{
	out.println("Incorrect password..!!");
}
	}else{
	out.println("No user found in database..!!");
}
con.close();  
}catch(Exception e){e.printStackTrace();}  
}  
%>