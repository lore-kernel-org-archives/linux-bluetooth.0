Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAcQVCQupGlk2RyIgNqeo5ggEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C4C0D2.E22F91D0"
Subject: [Bluez-users] dund
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
Date: Tue, 2 Nov 2004 11:55:37 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C4C0D2.E22F91D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,
I need additional help to establish a connection from my Toshiba to an
accesspoint. The AP supports LAP via DUN but needs a password for the
connection.
 
I'm able to find the AP
 

Linux-Notebook:~ # hcitool scan

Scanning ...

        00:0B:CE:00:01:8F       Bluetooth-Modul

 
but I'm not able to connect via dund
 
Linux-Notebook:~ # dund --connect 00:0B:CE:00:01:8F

 

there is no response. lsmod gives me

 

Linux-Notebook:~ # lsmod

bluetooth              45796  8 l2cap,hci_vhci,hci_uart,hci_usb

 
and sdptool browse gives the response, that the access is rejected.
 
What can I do to connect to the AP?
I would be happy to get help on this question.
 
Thanks
Peter

------=_NextPart_000_000A_01C4C0D2.E22F91D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Nachricht</TITLE>

<META content=3D"MSHTML 6.00.2800.1476" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial><SPAN class=3D231213910-02112004>Hi =
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial><SPAN class=3D231213910-02112004>I need =
additional help to=20
establish a connection from my&nbsp;Toshiba&nbsp;to an accesspoint. The =
AP=20
supports LAP via DUN but needs a password for the=20
connection.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial><SPAN =
class=3D231213910-02112004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><SPAN class=3D231213910-02112004>I'm able to =
find the=20
AP</SPAN></FONT></DIV><FONT face=3DArial><SPAN =
class=3D231213910-02112004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT=20
face=3D"Times New Roman"></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT face=3D"Times New =
Roman">Linux-Notebook:~ #=20
hcitool scan<?xml:namespace prefix =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" =
/><o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT face=3D"Times New =
Roman">Scanning=20
...<o:p></o:p></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT=20
face=3D"Times New Roman"><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>00:0B:CE:</SPAN><?xml:namespace prefix =3D st1 ns =3D=20
"urn:schemas-microsoft-com:office:smarttags" /><st1:time Hour=3D"0"=20
Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Bluetooth-Modul<o:p></o:p></SPAN></FONT></P>
<DIV><SPAN class=3D231213910-02112004><FONT=20
face=3D"Times New Roman"></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D231213910-02112004><FONT>but</FONT></SPAN>&nbsp;<SPAN =

class=3D231213910-02112004>I'm not able to connect via dund</SPAN></DIV>
<DIV><SPAN class=3D231213910-02112004></SPAN>&nbsp;</DIV><SPAN=20
class=3D231213910-02112004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT face=3D"Times New =
Roman">Linux-Notebook:~ #=20
dund --connect 00:0B:CE:00:01:8F</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT=20
face=3D"Times New Roman"></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p><SPAN =
class=3D231213910-02112004>there is no=20
response. lsmod gives me</SPAN></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p><SPAN=20
class=3D231213910-02112004></SPAN></o:p></SPAN>&nbsp;</P><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p><SPAN =
class=3D231213910-02112004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT face=3D"Times New =
Roman">Linux-Notebook:~ #=20
lsmod</FONT></SPAN></P><SPAN lang=3DEN-GB style=3D"mso-ansi-language: =
EN-GB">
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT face=3D"Times New =
Roman">bluetooth<SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;=20
</SPAN>45796<SPAN style=3D"mso-spacerun: yes">&nbsp; </SPAN>8=20
l2cap,hci_vhci,hci_uart,hci_usb<o:p></o:p></FONT></SPAN></P>
<DIV><o:p><FONT face=3D"Times New Roman"></FONT></o:p>&nbsp;</DIV>
<DIV><o:p><SPAN class=3D231213910-02112004>and sdptool browse gives the =
response,=20
that the access is rejected.</SPAN></o:p></DIV>
<DIV><o:p><SPAN class=3D231213910-02112004></SPAN></o:p>&nbsp;</DIV>
<DIV><o:p><SPAN class=3D231213910-02112004>What can I do to&nbsp;connect =
to the=20
AP?</SPAN></o:p></DIV>
<DIV><o:p><SPAN class=3D231213910-02112004>I would be happy to get help =
on this=20
question.</SPAN></o:p></DIV>
<DIV><o:p><SPAN class=3D231213910-02112004></SPAN></o:p>&nbsp;</DIV>
<DIV><o:p><SPAN class=3D231213910-02112004>Thanks</SPAN></o:p></DIV>
<DIV><o:p><SPAN=20
class=3D231213910-02112004>Peter</SPAN></o:p></SPAN></SPAN></o:p></SPAN><=
/SPAN></SPAN></FONT></DIV></BODY></HTML>

------=_NextPart_000_000A_01C4C0D2.E22F91D0--




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
