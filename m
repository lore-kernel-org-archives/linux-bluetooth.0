Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <OF9A811F48.3D259B3A-ONC1257004.002BB233-C1257004.002F049A@telemotive.de>
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] HCI-Uart Driver & Kernel 2.4.25 , Headset/Handsfree
 Profile
MIME-Version: 1.0
Message-ID: <OF10239440.63442787-ON48257004.00320E99-48257004.00334A4C@zte.com.cn>
From: gao.yingbin@zte.com.cn
Content-Type: multipart/alternative; boundary="=_alternative 00334A4B48257004_="
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
Date: Tue, 17 May 2005 17:26:44 +0800

This is a multipart message in MIME format.
--=_alternative 00334A4B48257004_=
Content-Type: text/plain; charset="US-ASCII"

I have faced this problem when I debug my applications over bluez 
kernel,on embedded OS. Everytimes I turned on the macro 
"CONFIG_BLUEZ_DEBUG" to display the debug information and compiled, when 
bluez was running ,and  other device was connected to it, the following 
erro appeared:
............
h4_recv: Unknown HCI packet type 05 
h4_recv: Unknown HCI packet type 00 
............
and the connection was failed. maybe try it again, the connection could 
finish.

However, When I turned on the macro "CONFIG_BLUEZ_DEBUG", the connection 
always finished very well, so I didn't mind the problem any more. I think 
there are some little bugs in the HCI uart driver, which affect the 
application of bluez on embedded linux OS.
 


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

--=_alternative 00334A4B48257004_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">I have faced this problem when I debug
my applications over bluez kernel,on embedded OS. Everytimes I turned on
the macro &quot;CONFIG_BLUEZ_DEBUG&quot; to display the debug information
and compiled, when bluez was running ,and &nbsp;other device was connected
to it, the following erro appeared:</font>
<br><font size=2 face="sans-serif">............</font>
<br><font size=2 face="sans-serif">h4_recv: Unknown HCI packet type 05
&nbsp; </font>
<br><font size=2 face="sans-serif">h4_recv: Unknown HCI packet type 00
&nbsp;</font>
<br><font size=2 face="sans-serif">............</font>
<br><font size=2 face="sans-serif">and the connection was failed. maybe
try it again, the connection could finish.</font>
<br>
<br><font size=2 face="sans-serif">However, When I turned on the macro
&quot;CONFIG_BLUEZ_DEBUG&quot;, the connection always finished very well,
so I didn't mind the problem any more. I think there are some little bugs
in the HCI uart driver, which affect the application of bluez on embedded
linux OS.</font>
<br><font size=2 face="sans-serif">&nbsp;</font><br><br><br>
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

--=_alternative 00334A4B48257004_=--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
