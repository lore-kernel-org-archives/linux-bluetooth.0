Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <019d01c47543$d6aa4c40$df0618ac@USI08844>
From: "taylor" <taylor@ms.usi.com.tw>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_019A_01C47586.D7E9D5B0"
Subject: [Bluez-users] How add correctly add SP service record to SDP daemon
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Jul 2004 16:12:28 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_019A_01C47586.D7E9D5B0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Dear,
 I could use those step to connect the Linux SP to Windows Series =
profile

At the linux side:
step 1:rfcomm connect 0 <BD address> 1
setp 2:open minicom -s,=20
          set the device as /dev/rfcomm0
          set the baud rate as 19200 8N1, no flow control
          exit
At the windows site:
step 1: open the hyerpterminal,
           set up baud rate as 19200 8N1 , no flow control
step 2: sucessfuly transfer the data=20

But I hope ass the SP profile service record into SDP daemon, I do thoe =
step
At the linux side
step 1: rfcomm bind 0 <BD Addreess> 1
step 2: sdp add SP 1

At the windows site:
step1: Obrowse the SP service
step 2: reject SP connect, the port is not correct.=20

Taylor Shieh
Engineer, Bluetooth Module Section
New Technology Development Dept., R&D Division
Tel:886-49-2325876 Ext:2188

------=_NextPart_000_019A_01C47586.D7E9D5B0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Dear,</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;I could use those step to connect the Linux SP =
to=20
Windows Series profile</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>At the linux side:<BR>step 1:rfcomm connect 0 &lt;BD =

address&gt; 1</FONT></DIV>
<DIV><FONT size=3D2>setp 2:open minicom -s, </FONT></DIV>
<DIV><FONT =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set the=20
device as /dev/rfcomm0</FONT></DIV>
<DIV><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set =

the&nbsp;baud rate as 19200 8N1, no flow control</FONT></DIV>
<DIV><FONT =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
exit</FONT></DIV>
<DIV><FONT size=3D2>At the windows site:</FONT></DIV>
<DIV><FONT size=3D2>step 1: open the hyerpterminal,</FONT></DIV>
<DIV><FONT =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
set up baud rate as 19200 8N1 , no flow control</FONT></DIV>
<DIV><FONT size=3D2>step 2: sucessfuly transfer the =
data&nbsp;</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>But I hope ass the SP profile service record into =
SDP daemon,=20
I do thoe step</FONT></DIV>
<DIV><FONT size=3D2>At the linux side</FONT></DIV>
<DIV><FONT size=3D2>step 1: rfcomm bind 0 &lt;BD Addreess&gt; =
1</FONT></DIV>
<DIV><FONT size=3D2>step 2: sdp add SP 1</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>At the windows site:</FONT></DIV>
<DIV><FONT size=3D2>step1: Obrowse the SP service</FONT></DIV>
<DIV><FONT size=3D2>step 2:&nbsp;reject&nbsp;SP connect, the port is not =

correct.</FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Taylor Shieh<BR>Engineer, Bluetooth Module =
Section<BR>New=20
Technology Development Dept., R&amp;D Division<BR>Tel:886-49-2325876=20
Ext:2188</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_019A_01C47586.D7E9D5B0--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
