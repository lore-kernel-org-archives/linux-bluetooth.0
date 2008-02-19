Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Feb 2008 09:51:55 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <946355.48557.qm@web8415.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1698589175=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1698589175==
Content-Type: multipart/alternative; boundary="0-792113666-1203394915=:48557"

--0-792113666-1203394915=:48557
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi All=0AI got my headset working ...=0AI bought one new BT dongle which cl=
amed it supports HS audio Gtaeway.=0AIt is a product of ENTER multimedia.=
=0Athis is it.=0A[root@localhost Pramod]# /usr/local/sbin/hciconfig -a=0Ahc=
i0:   Type: USB=0A        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO =
MTU: 48:10=0A        UP RUNNING PSCAN ISCAN=0A        RX bytes:10283222 acl=
:386 sco:201151 events:719 errors:0=0A        TX bytes:10319322 acl:347 sco=
:202172 commands:192 errors:0=0A        Features: 0xbf 0xfe 0x8d 0x78 0x08 =
0x18 0x00 0x00=0A        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=
=0A        Link policy: RSWITCH HOLD SNIFF PARK=0A        Link mode: SLAVE =
ACCEPT=0A        Name: 'BlueZ (0)'=0A        Class: 0x080100=0A        Serv=
ice Classes: Capturing=0A        Device Class: Computer, Uncategorized=0A  =
      HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1f=
e=0A        Manufacturer: Integrated System Solution Corp. (57)=0A=0AThanks=
 to all who have given me their valuable time for this.=0AEspecially thanks=
 to Jayjwa who helped me a lot.=0AHope to have the same co-operation in com=
ing time.=0A =0AThanks and Best regards =0APramod=0A=0A----- Original Messa=
ge ----=0AFrom: Guillaume Bedot <littletux@zarb.org>=0ATo: bluez-users@list=
s.sourceforge.net=0ASent: Monday, 18 February, 2008 8:11:19 PM=0ASubject: R=
e: [Bluez-users] Headset not playing audio HELP PLEASE=0A=0AQuoting =0AGuil=
laume =0ABedot =0A<littletux@zarb.org>:=0A>=0A> =0AThis =0Apatch =0Amakes =
=0Athe =0Akernel =0Asearch =0Afor =0Aboth =0Atypes =0Awhen =0Areceiving=0A>=
 =0A"Synchronous =0AConnection =0AComplete" =0Aevent.=0A>=0ASorry, =0Athe =
=0Apatch =0Ain =0Athe =0Aprevious =0Apaost =0Awas =0Aincomplete =0A/ =0Abug=
gy, =0Ayou'd  =0Arather =0Atry =0Athe =0Aincluded =0Aone.=0A=0A=0A=0A-----I=
nline Attachment Follows-----=0A=0A--- =0Anet/bluetooth/hci_event.c.orig   =
 =0A2008-02-18 =0A14:02:20.000000000 =0A+0100=0A+++ =0Anet/bluetooth/hci_ev=
ent.c    =0A2008-02-18 =0A15:19:04.000000000 =0A+0100=0A@@ =0A-1313,8 =0A+1=
313,15 =0A@@=0A =0A    =0Ahci_dev_lock(hdev);=0A =0A =0A    =0Aconn =0A=3D =
=0Ahci_conn_hash_lookup_ba(hdev, =0Aev->link_type, =0A&ev->bdaddr);=0A-    =
=0Aif =0A(!conn)=0A-    =0A    =0Agoto =0Aunlock;=0A+    =0Aif =0A(!conn) =
=0A{=0A+    =0A    =0Aif =0A(ev->link_type=3D=3DSCO_LINK) =0A{=0A+    =0A  =
  =0A    =0Aconn =0A=3D =0Ahci_conn_hash_lookup_ba(hdev, =0AESCO_LINK, =0A&=
ev->bdaddr);=0A+    =0A    =0A    =0Aif =0A(!conn)=0A+    =0A    =0A    =0A=
    =0Agoto =0Aunlock;=0A+    =0A    =0A    =0Aelse=0A+    =0A    =0A    =
=0A    =0Aconn->type=3DSCO_LINK;=0A+    =0A    =0A    =0A}=0A+    =0A}=0A =
=0A =0A    =0Aif =0A(!ev->status) =0A{=0A =0A    =0A    =0Aconn->handle =0A=
=3D =0A__le16_to_cpu(ev->handle);=0A=0A=0A=0A-----Inline Attachment Follows=
-----=0A=0A----------------------------------------------------------------=
---------=0AThis =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft=
=0ADefy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.=
=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A=0A=0A-----Inl=
ine Attachment Follows-----=0A=0A__________________________________________=
_____=0ABluez-users =0Amailing =0Alist=0ABluez-users@lists.sourceforge.net=
=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=
=0A=0A=0A=0A      Now you can chat without downloading messenger. Go to htt=
p://in.messenger.yahoo.com/webmessengerpromo.php
--0-792113666-1203394915=:48557
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi All<br>I got my headset working ...<br>I bought one new =
BT dongle which clamed it supports HS audio Gtaeway.<br>It is a product of =
ENTER multimedia.<br>this is it.<br>[root@localhost Pramod]# /usr/local/sbi=
n/hciconfig -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 <span style=
=3D"font-style: italic; font-weight: bold; text-decoration: underline;">SCO=
 MTU: 48:10</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING=
 PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1028322=
2 acl:386 sco:201151 events:719 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; TX bytes:10319322 acl:347 sco:202172 commands:192 errors:0<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x78 0x0=
8
 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: =
DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Name: 'BlueZ (0)'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C=
lass: 0x080100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classe=
s: Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Co=
mputer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver=
: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Integrated System Solution=
 Corp. (57)<br><br>Thanks to all who have given me their valuable time for =
this.<br>Especially thanks to Jayjwa who helped me a lot.<br>Hope to have t=
he same co-operation in coming time.<br><div>&nbsp;</div>Thanks and
 Best regards<div>&nbsp;</div><div>Pramod<div style=3D"font-family: times n=
ew roman,new york,times,serif; font-size: 12pt;"><br><br><div style=3D"font=
-family: times new roman,new york,times,serif; font-size: 12pt;">----- Orig=
inal Message ----<br>From: Guillaume Bedot &lt;littletux@zarb.org&gt;<br>To=
: bluez-users@lists.sourceforge.net<br>Sent: Monday, 18 February, 2008 8:11=
:19 PM<br>Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE<=
br><br>Quoting =0AGuillaume =0ABedot =0A&lt;<a ymailto=3D"mailto:littletux@=
zarb.org" href=3D"mailto:littletux@zarb.org">littletux@zarb.org</a>&gt;:<br=
>&gt;<br>&gt; =0AThis =0Apatch =0Amakes =0Athe =0Akernel =0Asearch =0Afor =
=0Aboth =0Atypes =0Awhen =0Areceiving<br>&gt; =0A"Synchronous =0AConnection=
 =0AComplete" =0Aevent.<br>&gt;<br>Sorry, =0Athe =0Apatch =0Ain =0Athe =0Ap=
revious =0Apaost =0Awas =0Aincomplete =0A/ =0Abuggy, =0Ayou'd&nbsp; <br>rat=
her =0Atry =0Athe =0Aincluded =0Aone.<br><br><!-- kill --><div><br><br>----=
-Inline Attachment Follows-----<br><br>--- =0Anet/bluetooth/hci_event.c.ori=
g&nbsp;&nbsp;&nbsp; =0A2008-02-18 =0A14:02:20.000000000 =0A+0100<br>+++ =0A=
net/bluetooth/hci_event.c&nbsp;&nbsp;&nbsp; =0A2008-02-18 =0A15:19:04.00000=
0000 =0A+0100<br>@@ =0A-1313,8 =0A+1313,15 =0A@@<br> =0A&nbsp;&nbsp;&nbsp; =
=0Ahci_dev_lock(hdev);<br> <br> =0A&nbsp;&nbsp;&nbsp; =0Aconn =0A=3D =0Ahci=
_conn_hash_lookup_ba(hdev, =0Aev-&gt;link_type, =0A&amp;ev-&gt;bdaddr);<br>=
-&nbsp;&nbsp;&nbsp; =0Aif =0A(!conn)<br>-&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;=
&nbsp; =0Agoto =0Aunlock;<br>+&nbsp;&nbsp;&nbsp; =0Aif =0A(!conn) =0A{<br>+=
&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0Aif =0A(ev-&gt;link_type=3D=3DSC=
O_LINK) =0A{<br>+&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&n=
bsp; =0Aconn =0A=3D =0Ahci_conn_hash_lookup_ba(hdev, =0AESCO_LINK, =0A&amp;=
ev-&gt;bdaddr);<br>+&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp=
;&nbsp; =0Aif =0A(!conn)<br>+&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&n=
bsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0Agoto =0Aunlock;<br>+&nbsp;&nbsp;&=
nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0Aelse<br>+&nbsp;&nbsp;&=
nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A=
conn-&gt;type=3DSCO_LINK;<br>+&nbsp;&nbsp;&nbsp; =0A&nbsp;&nbsp;&nbsp; =0A&=
nbsp;&nbsp;&nbsp; =0A}<br>+&nbsp;&nbsp;&nbsp; =0A}<br> <br> =0A&nbsp;&nbsp;=
&nbsp; =0Aif =0A(!ev-&gt;status) =0A{<br> =0A&nbsp;&nbsp;&nbsp; =0A&nbsp;&n=
bsp;&nbsp; =0Aconn-&gt;handle =0A=3D =0A__le16_to_cpu(ev-&gt;handle);<br></=
div><!-- kill --><div><br><br>-----Inline Attachment Follows-----<br><br>--=
-----------------------------------------------------------------------<br>=
This =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>Defy =0Aa=
ll =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.<br><a href=
=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D"_bla=
nk">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a></div><!-- k=
ill --><div><br><br>-----Inline Attachment Follows-----<br><br>____________=
___________________________________<br>Bluez-users =0Amailing =0Alist<br><a=
 ymailto=3D"mailto:Bluez-users@lists.sourceforge.net" href=3D"mailto:Bluez-=
users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a hr=
ef=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_=
blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></di=
v></div><br></div></div></div><br>=0A=0A=0A      <!--5--><hr size=3D1></hr>=
 Get the freedom to save as many mails as you wish. <a href=3D"http://in.rd=
.yahoo.com/tagline_mail_5/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/=
tools/tools-08.html/">Click here to know how.</a></body></html>
--0-792113666-1203394915=:48557--


--===============1698589175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1698589175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1698589175==--
