Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OFD779B58D.5D315849-ON482570D5.00402621-482570D5.00422C3C@zte.com.cn>
From: gao.yingbin@zte.com.cn
Content-Type: multipart/alternative; boundary="=_alternative 00422C33482570D5_="
Subject: [Bluez-devel] After two SCO links been created, Can not transfer ACL data
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 12 Dec 2005 20:02:18 +0800

This is a multipart message in MIME format.
--=_alternative 00422C33482570D5_=
Content-Type: text/plain; charset="US-ASCII"

hello, everybody,
After I creat two SCO links from two different Teminal devices to one 
Gateway device, I can not transfer any ACL data between the gateway and 
teminal.
the note is:
# hcitool con
Connections:
        < SCO 00:00:11:22:33:44 handle 2 state 1 lm SLAVE 
        < SCO 00:00:55:66:77:88 handle 1 state 1 lm SLAVE
        > ACL 00:00:11:22:33:44 handle 7 state 1 lm MASTER
        > ACL 00:00:55:66:77:88 handle 6 state 1 lm MASTER

Software: Using bluez stacks;
hareware: using broardcom bluetooth chip or CSR bluetooth chip.
I watch the uart port of the bluetooth chip and find that some ACL data 
have been sent to bluetooth chip of gateway, but no any acl data have been 
received from bluetooth chip of teminal.

Is bugs of the bluetooth chips , or the bluez stacks is wrongly used? btw: 
the surport of chip  manufacturer is poor. 


***********************************************
信息安全声明：本邮件包含信息归ZTE所有，
ZTE对该邮件拥有所有权利。请接收者注意
保密，未经发件人书面许可，不得向任何第
三方组织和个人透露本邮件所含信息的全部
或部分。以上声明仅适用于工作邮件。
Information Security  Notice：
The information contained in this mail is
solely property of  ZTE Corporation. 
This mail communication is confidential.
Recipients named above are obligated to
maintain secrecy and are not permitted to
disclose the contents of this communication
to others.
***********************************************

--=_alternative 00422C33482570D5_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">hello, everybody,</font>
<br><font size=2 face="sans-serif">After I creat two SCO links from two
different Teminal devices to one Gateway device, I can not transfer any
ACL data between the gateway and teminal.</font>
<br><font size=2 face="sans-serif">the note is:</font>
<br><font size=2 face="sans-serif"># hcitool con</font>
<br><font size=2 face="sans-serif">Connections:</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &lt; SCO
00:00:11:22:33:44 handle 2 state 1 lm SLAVE &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &lt; SCO
00:00:55:66:77:88 handle 1 state 1 lm SLAVE</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &gt; ACL
00:00:11:22:33:44 handle 7 state 1 lm MASTER</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &gt; ACL
00:00:55:66:77:88 handle 6 state 1 lm MASTER</font>
<br>
<br><font size=2 face="sans-serif">Software: Using bluez stacks;</font>
<br><font size=2 face="sans-serif">hareware: using broardcom bluetooth
chip or CSR bluetooth chip.</font>
<br><font size=2 face="sans-serif">I watch the uart port of the bluetooth
chip and find that some ACL data have been sent to bluetooth chip of gateway,
but no any acl data have been received from bluetooth chip of teminal.</font>
<br>
<br><font size=2 face="sans-serif">Is bugs of the bluetooth chips , or
the bluez stacks is wrongly used? btw: the surport of chip &nbsp;manufacturer
is poor. &nbsp; </font><br><br><br>
***********************************************<br>
信息安全声明：本邮件包含信息归ZTE所有，<br>
ZTE对该邮件拥有所有权利。请接收者注意<br>
保密，未经发件人书面许可，不得向任何第<br>
三方组织和个人透露本邮件所含信息的全部<br>
或部分。以上声明仅适用于工作邮件。<br>
Information&nbsp;Security&nbsp;&nbsp;Notice：<br>
The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is<br>
solely&nbsp;property&nbsp;of&nbsp;&nbsp;ZTE&nbsp;Corporation.&nbsp;<br>
This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.<br>
Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to<br>
maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to<br>
disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication<br>
to&nbsp;others.<br>
***********************************************<br>

--=_alternative 00422C33482570D5_=--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
