Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 10 Apr 2007 08:03:37 -0700 (PDT)
From: shaun lim <psicokhel@yahoo.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2EB6297382462046A9427D7324788A4801C72749@MCLNEXVS06.resource.ds.bah.com>
MIME-Version: 1.0
Message-ID: <855075.73379.qm@web50209.mail.re2.yahoo.com>
Subject: Re: [Bluez-devel] Mutliple Dongles with Bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1006373294=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1006373294==
Content-Type: multipart/alternative; boundary="0-1944892858-1176217417=:73379"
Content-Transfer-Encoding: 8bit

--0-1944892858-1176217417=:73379
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

thanks for the replies guys! i'll try it out and post my experience here

"Williams, Richard" <williams_richard_b@bah.com> wrote:      Shaun, 
 > Anybody knows if  its possible to interface multiple bluetooth dongles with Bluez?  
 > I would like to get pass the maximum 7  connections per dongle limitation of Bluetooth  
 > by installing more than one bluetooth dongle to a  computer and thus increasing the  
 > number of connections available.
 > 
 > Anybody have  experience developing such applications?
 > 
 
 This  works fine, but make sure you have the latest Bluez libs. And make sure you  have a 
 kernel  at least 2.6.20 vintage. If  not, then when you're running two simultaneous commands to 
 two  different Bluetooth devices, you may get a kernel oops.
  
 Otherwise, its easy enough to write a multi-threaded application that  addresses multiple dongles.
 And it  works very well.
  
 -Rich
  

---------------------------------
 We won't tell. Get more on shows  you hate to love
(and love to hate): Yahoo!  TV's Guilty Pleasures list.-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


 
---------------------------------
 Get your own web address.
 Have a HUGE year through Yahoo! Small Business.
--0-1944892858-1176217417=:73379
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

thanks for the replies guys! i'll try it out and post my experience here<br><br><b><i>"Williams, Richard" &lt;williams_richard_b@bah.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">   <meta http-equiv="Content-Type" content="text/html; charset=us-ascii"> <meta content="MSHTML 6.00.2900.3059" name="GENERATOR"><font color="#0000ff" face="Arial" size="2"></font> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;Shaun,&nbsp;</font></span><br><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;&gt;&nbsp;</font></span>Anybody knows if  its possible to interface multiple bluetooth dongles with Bluez?&nbsp;<span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&gt;</font>&nbsp;</span>I would like to
 get pass the maximum 7  connections per dongle limitation of Bluetooth&nbsp;<span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&gt;</font>&nbsp;</span>by installing more than one bluetooth dongle to a  computer and thus increasing the&nbsp;<span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&gt;</font>&nbsp;</span>number of connections available.<br><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;&gt;&nbsp;</font></span><br><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;&gt;&nbsp;</font></span>Anybody have  experience developing such applications?<br><span class="774122414-10042007"><font color="#0000ff" face="Arial"
 size="2">&nbsp;&gt;&nbsp;</font></span><br><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">&nbsp;</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">This  works fine, but make sure you have the latest Bluez&nbsp;libs. And make sure you  have a </font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">kernel  at least 2.6.20 vintage.</font>&nbsp;<font color="#0000ff" face="Arial" size="2">If  not, then when you're running two simultaneous commands to </font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">two  different Bluetooth devices, you may get a kernel oops.</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">Otherwise, its easy enough to
 write a multi-threaded application that  addresses multiple dongles.</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">And it  works very well.</font></span></div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2"></font></span>&nbsp;</div> <div><span class="774122414-10042007"><font color="#0000ff" face="Arial" size="2">-Rich</font></span></div> <div> </div><hr size="1"> We won't tell. Get more on <a href="http://us.rd.yahoo.com/evt=49980/*http://tv.yahoo.com/collections/265">shows  you hate to love</a><br>(and love to hate): <a href="http://us.rd.yahoo.com/evt=49980/*http://tv.yahoo.com/collections/265">Yahoo!  TV's Guilty Pleasures list.</a>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics
 through brief surveys-and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________<br>Bluez-devel mailing list<br>Bluez-devel@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-devel<br></blockquote><br><p>&#32;

<hr size=1>
<a href="http://us.rd.yahoo.com/evt=49678/*http://smallbusiness.yahoo.com/domains/?p=BESTDEAL"> Get your own web address.</a><br> Have a HUGE year through <a href="
http://us.rd.yahoo.com/evt=49678/*http://smallbusiness.yahoo.com/domains/?p=BESTDEAL">Yahoo! Small Business.</a>
--0-1944892858-1176217417=:73379--


--===============1006373294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1006373294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1006373294==--
