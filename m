Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000c01c566b8$29caa850$2203a8c0@campos>
From: "Bruno Campos" <b-campos@criticalsoftware.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----=_NextPart_000_0009_01C566B8.26B7EA10"
Subject: [Bluez-users] Bluettoth problems
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 1 Jun 2005 14:42:35 -0000

This is a multi-part message in MIME format...

------=_NextPart_000_0009_01C566B8.26B7EA10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hello
  I have a IPAQ 5500, with familiar 0.7.2, + bluez, but i have a problem wi=
th bueltooth, when i try:
  pand -D --connect 00:09:DD:10:44:84 --role PANU --service GN --persist
  I can do ping on my PDA(169.254.10.119) to PC(169.254.10.117), and ping o=
n my PC to PDA, and it works fine, but after a few minuts, the connection g=
oing down, and i can't ping again. So, i don't know what it is. If i try tu=
nr off the bluetooth an turn on again, the connection going up again but af=
ter a few minuts going down. So anyone knows what problem is??

  When i do : hcidump:
  .
  .
  .
  > HCI Event: Hardware Error(0x10) plen 1
  > ACL data: handle 0x0001 flags 0x02 dlen 85
      L2CAP(d): cid 0x40 len 81 [psm 0]
  < ACL data: handle 0x0001 flags 0x02 dlen 113
      L2CAP(d): cid 0x67 len 109 [psm 0]
  > ACL data: handle 0x0001 flags 0x02 dlen 130
      L2CAP(d): cid 0x40 len 126 [psm 0]
  > ACL data: handle 0x0001 flags 0x02 dlen 85
      L2CAP(d): cid 0x40 len 81 [psm 0]
  < ACL data: handle 0x0001 flags 0x02 dlen 113
      L2CAP(d): cid 0x67 len 109 [psm 0]
  > ACL data: handle 0x0001 flags 0x02 dlen 339

  Best Regards
  Bruno Campos bmac@student.dei.uc.pt



DISCLAIMER: This message may contain confidential information or privileged=
 material and is intended only for the individual(s) named. If you are not =
a named addressee and mistakenly received this message you should not copy =
or otherwise disseminate it: please delete this e-mail from your system and=
 notify the sender immediately. E-mail transmissions are not guaranteed to =
be secure or error-free as information could be intercepted, corrupted, los=
t, destroyed, arrive late or incomplete or contain viruses. Therefore, the =
sender does not accept liability for any errors or omissions in the content=
s of this message that arise as a result of e-mail transmissions. Please re=
quest a hard copy version if verification is required. Critical Software.



------=_NextPart_000_0009_01C566B8.26B7EA10
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LE=
FT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV>
  <DIV>
  <DIV><FONT face=3DArial size=3D2>Hello</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>I have a IPAQ 5500, with familiar 0.7.2,=
 + bluez,=20
  but i have a problem with bueltooth, when i try:</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>pand -D --connect 00:09:DD:10:44:84 --ro=
le PANU=20
  --service GN --persist</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>I can do ping on my PDA(169.254.10.119) =
to=20
  PC(169.254.10.117), and ping on my PC to PDA, and it works fine, but afte=
r a=20
  few minuts, the connection going down, and i can't ping again. So, i don'=
t=20
  know&nbsp;what it is. If i try tunr off the bluetooth an turn on again, t=
he=20
  connection going up again but after a few minuts going down. So&nbsp;anyo=
ne=20
  knows what problem is??</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>When i do : hcidump:</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>.</FONT></DIV>
  <DIV><FONT size=3D2><FONT face=3DArial>&gt; HCI Event: Hardware Error(0x1=
0) plen=20
  1<BR>&gt; ACL data: handle 0x0001 flags 0x02 dlen 85<BR>&nbsp;&nbsp;&nbsp=
;=20
  L2CAP(d): cid 0x40 len 81 [psm 0]<BR>&lt; ACL data: handle 0x0001 flags 0=
x02=20
  dlen 113<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x67 len 109 [psm 0]<BR>&gt;=
 ACL=20
  data: handle 0x0001 flags 0x02 dlen 130<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): c=
id=20
  0x40 len 126 [psm 0]<BR>&gt; ACL data: handle 0x0001 flags 0x02 dlen=20
  85<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 81 [psm 0]<BR>&lt; ACL da=
ta:=20
  handle 0x0001 flags 0x02 dlen 113<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x6=
7 len=20
  109 [psm 0]<BR>&gt; ACL data: handle 0x0001 flags 0x02 dlen=20
  339</FONT></DIV></FONT>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Best Regards</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>Bruno Campos</FONT>&nbsp;<FONT face=3DAr=
ial=20
  size=3D2><A=20
  href=3D"mailto:bmac@student.dei.uc.pt">bmac@student.dei.uc.pt</A></FONT><=
/DIV>
  <DIV><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</DIV></DIV></DIV></BLOCKQUOTE><br><br><Font size=3D"=
1" color=3D"#0000ff">DISCLAIMER: This message may contain confidential info=
rmation or privileged material and is intended only for the individual(s) n=
amed. If you are not a named addressee and mistakenly received this message=
 you should not copy or otherwise dissemenate it: please delete this e-mail=
 from your system and notify the sender immediately. E-mail transmissions a=
re not guaranteed to be secure or error-free as information could be interc=
epted, corrupted, lost, destroyed, arrive late or incomplete, or contain vi=
ruses. Therefore, the sender does not accept liability for any errors or om=
issions in the contents of this message that arise as a result of e-mail tr=
ansmissions. Please request a hard-copy version if verification is required=
. Critical Software.</Font><br><br>
</BODY></HTML>

------=_NextPart_000_0009_01C566B8.26B7EA10--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
