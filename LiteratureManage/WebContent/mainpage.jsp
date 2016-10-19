<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的主页</title>
<!-- 去往开始和结尾 -->
<style>
.city {
float: left;
margin: 5px;
padding: 20px;
width: 48.5%;
height: 100px;
border: 1px solid green;
background-color: #F9F9F9;
} 
</style>
<script type="text/javascript">
    var goToWhere = function (where)
    {
        var me = this;
        clearInterval (me.interval);
        me.site = [];
        var dom = !/.*chrome.*/i.test (navigator.userAgent) ? document.documentElement : document.body;
        var height = !!where ? dom.scrollHeight : 0;
        me.interval = setInterval (function ()
        {
            var speed = (height - dom.scrollTop) / 16;
            if (speed == me.site[0])
            {
                clearInterval (me.interval);
                return null;
            }
            dom.scrollTop += speed;
            me.site.unshift (speed);
        }, 16);
    };
</script>
</head>
<body>

<!-- 得到当前用户信息 -->
<% String usermail = (String) session.getAttribute("usermail"); %>
<% String username = (String) session.getAttribute("username"); %>
<!-- 没有登录或者掉线 设置页面隐藏-->
<% if (usermail == null) {%>
<% out.println("你的输入不合法哎，瞧瞧是不是掉线了呢 ╮(╯▽╰)╭"); %>
<% out.print("<div class=\"container\"  style=\"display: none\">");%>
<!-- session中含有登录信息 -->
<%} else { %>
<% out.print("<div class=\"container\" >");%>

<%} %>
<div class="row clearfix">	
	<div class="col-md-12 column">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<p><br><br><br></p>
			</div>
			<div class="col-md-4 column;" style='text-align:center'>
			<!-- 显示头像 -->
				<img src="sources/pics/Avatar.png" height="200" width="200" class="img-rounded"/>
				<p class="text-center">
					<hr>
					<span class="glyphicon glyphicon-user ">
					<!-- 显示用户名和邮箱 -->
					<%
					    out.print(username);
					%>
						<br><br>
						<span class="glyphicon glyphicon-send ">
					<% 
						out.print(usermail);
					%>
				</p>
			</div>
			<div class="col-md-8 column">					
				<br>
<!-- 载入页面过程中执行action 得到各种书籍 -->
<s:action name="getAllKindOfArticles" executeResult="true" />
<!--从session中得到所有书籍 -->
<% int not_read = 0; %>
<% int read_little = 0; %>
<% int read_all = 0; %>
<% int all_files = 0; %>
<% ArrayList<Map<String, String>> notread = (ArrayList<Map<String, String>>) session.getAttribute("notread");%>
<% ArrayList<Map<String, String>> readlittle = (ArrayList<Map<String, String>>) session.getAttribute("readlittle");%>
<% ArrayList<Map<String, String>> readall = (ArrayList<Map<String, String>>) session.getAttribute("readall");%>
<% ArrayList<Map<String, String>> all = (ArrayList<Map<String, String>>) session.getAttribute("all");%>
<% not_read = notread.size(); %>
<% read_little = readlittle.size(); %>
<% read_all = readall.size(); %>
<% all_files = all.size(); %>
				<!-- 选项卡栏 -->
				<div class="tabbable" id="tabs-79182">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-779078" data-toggle="tab">未读内容&nbsp;<span class="badge"><%out.println(not_read); %></span></a>
						</li>
						<li >
							<a href="#panel-238826" data-toggle="tab">已经粗读&nbsp;<span class="badge"><%out.println(read_little); %></span></a>
						</li>
						<li>
							 <a href="#panel-238827" data-toggle="tab">已经精读&nbsp;<span class="badge"><%out.println(read_all); %></span></a>
						</li>
						<li>
							<a href="#panel-238828" data-toggle="tab">全部内容&nbsp;<span class="badge"><%out.println(all_files); %></span></a>
						</li>
					</ul>						
					<!-- 搜索面板 -->
					<div class="panel panel-default">
						<div class="panel-body">
        			    	<div class="input-group">
                   				<input type="text" class="form-control" placeholder="搜索你的资料库">
                    				<span class="input-group-btn">
                        				<button class="btn btn-success" type="button" style="width:200px;">搜索</button>                   		
                    				</span>
                   			</div><!-- /input-group -->
    					</div>
    				</div>
					<hr>
					<!-- 那些信息们 -->
					<div class="tab-content">
						<div class="tab-pane fade in active" id="panel-779078">
							<!-- 没有读的 -->
							<%for (int i = not_read - 1; i >= 0; i--) { %>								
								<div class="city" style="border: 1px solid #9D0808;">
									<h5>
										<span class="glyphicon glyphicon-paperclip" style="color: rgb(81, 119, 197);"> 
										<a href=readArticle?url=<% out.print(notread.get(i).get("2"));%>&articlename=<% out.print(notread.get(i).get("1"));%>>
										<%out.print(notread.get(i).get("1")); %></a></span>
									</h5>
									<span class="glyphicon glyphicon-tags" style="color: rgb(81, 119, 197);"> 标签</span>
									
							</div>								
							<%} %>											
						</div>
						<div class="tab-pane fade" id="panel-238826">								
						<!-- 已经粗读过哦 -->								
						<%for (int i = read_little - 1; i >= 0; i--) { %>
							<div class="city" style="border: 1px solid #CFC500;">
								<h5>
									<span class="glyphicon glyphicon-paperclip" style="color: rgb(81, 119, 197);">  
									<a href=readArticle?url=<% out.print(readlittle.get(i).get("2"));%>&articlename=<% out.print(readlittle.get(i).get("1"));%>>
										<%out.print(readlittle.get(i).get("1")); %></a></span>
								</h5>
								<span class="glyphicon glyphicon-tags" style="color: rgb(81, 119, 197);"> </span>
							</div>
						<%} %>	
						</div>
						<div class="tab-pane fade" id="panel-238827">
							<!--  	已经精读过哦 -->	
							<%for (int i = read_all - 1; i >= 0; i--) { %>
								<div class="city" style="border: 1px solid #51C200;">
									<h5>
										<span class="glyphicon glyphicon-paperclip" style="color: rgb(81, 119, 197);">  
	  									<a href=readArticle?url=<% out.print(readall.get(i).get("2"));%>&articlename=<% out.print(readall.get(i).get("1"));%>>
	    									<%out.print(readall.get(i).get("1")); %></a></span>
	  								</h5>
	  								

									<span class="glyphicon glyphicon-tags" style="color: rgb(81, 119, 197);"> </span>
								</div>
							<%} %>
						</div>					
						<div class="tab-pane fade" id="panel-238828">
						<!--  全部哦 -->								
						<%for (int i = all_files - 1; i >= 0; i--) { %>
							<div class="city" style="border: 1px solid black;">	
							<h5>
							<span class="glyphicon glyphicon-paperclip" style="color: rgb(81, 119, 197);">  
								<a href=readArticle?url=<% out.print(all.get(i).get("2"));%>&articlename=<% out.print(all.get(i).get("1"));%>>		
									<%out.print(all.get(i).get("1")); %></a></span>						
							</h5>
							<span class="glyphicon glyphicon-tags" style="color: rgb(81, 119, 197);"> </span>
							</div>
						<%} %>
						</div>
					</div>
				</div>
			</div>
		</div>
		<nav class="navbar navbar-default navbar-fixed-top"
					role="navigation">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span><span
							class="icon-bar"></span><span class="icon-bar"></span><span
							class="icon-bar"></span>
				</button>
					<a class="navbar-brand" href=personalCenter?<%out.print("2333"); %>><span class="glyphicon glyphicon-cloud "></a>
			</div>
			<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
				<form action="search" class="navbar-form navbar-left" role="search">
					<div class="form-group">
						<input class="form-control" type="text" placeholder="搜索内容"/>
					</div>
					<button type="submit" class="btn btn-default">开始搜索</button>
				</form>
					<ul class="nav navbar-nav navbar-right" style="padding-right:10px;">					
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><img src="sources/pics/Avatar.png" height="20" width="20" /><strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li><a href=mainPage>我的主页</a></li>
								<li><a href=fileManage>内容管理</a></li>
								<li><a href=timeLine>时间线</a></li>
								
								<li><a href=settings>设置</a></li>
								<li class="divider"></li>
								<li><a href=signOut>注销</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<div class="row clearfix">
		<div class="col-md-12 column"></div>
	</div>
	<hr>
	<footer>
		<p>&copy; TEAM 高文成 黄沛 张东昌 @2016</p>
	</footer>



	<div id="back-up" onclick="goToWhere(0)"
    style=" position: fixed; cursor: pointer; right: 90px; bottom: 160px;"><img src= "sources/pics/up.png" /></div>
<div id="back-up" onclick="goToWhere(1)"
     style="position: fixed; cursor: pointer; right: 90px; bottom: 50px;"><img src= "sources/pics/down.png" /></div>
<link href="sources/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="sources/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css"></script>
<script src="sources/jquery-3.1.1/jquery-3.1.1.min.js"></script>
<script src="sources/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>