Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f9801a770601061409n7efcf93ep@mail.gmail.com>
From: Arthur Breitman <arthur.breitman@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with hcitool scan
In-Reply-To: <10e392ce0601061234j12dcc8dfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1359_29987902.1136585385348"
References: <10e392ce0601061203k45c59478j@mail.gmail.com>
	 <10e392ce0601061234j12dcc8dfw@mail.gmail.com>
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
Date: Fri, 6 Jan 2006 23:09:45 +0100

------=_Part_1359_29987902.1136585385348
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Look at the previous messages.... same notebook, same problem, no ansswer

2006/1/6, Cyberalex <cyberalexgm@gmail.com>:
>
> I have a latitude x1 with integrated dongle connected by usb bus.
> I installed bluez-libs and bluez-utils and added modules (bluetooth
> l2cap rfcomm bnep hidp hci_usb)
> I start services and hciconfig -a return:
> tuxone ~ # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:10:C6:D1:07:A1 ACL MTU: 384:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:697 acl:0 sco:0 events:55 errors:0
>         TX bytes:640 acl:0 sco:0 commands:32 errors:0
>         Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x679
>         Manufacturer: Cambridge Silicon Radio (10)
> tuxone ~ #
>
> The dongle led flash,it seems working.
> I have 2 nokia 3650 and an other pc with bluetooth and they work.
> If i enter hcitool scan from latitude :
>
> tuxone ~ # hcitool scan
> Scanning ...
> tuxone ~ #
>
> It doesn't recognize all bt hosts.
>
> If i do a scanning from an other host i can't recognize the notebook
> (but the led of its dongle flash with a different timed during the
> scanning).
>
> Can anyone help me?
>
> Alex
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_idv37&alloc_id=16865&opclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_1359_29987902.1136585385348
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Look at the previous messages.... same notebook, same problem, no ansswer<b=
r><br><div><span class=3D"gmail_quote">2006/1/6, Cyberalex &lt;<a href=3D"m=
ailto:cyberalexgm@gmail.com">cyberalexgm@gmail.com</a>&gt;:</span><blockquo=
te class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204)=
; margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I have a latitude x1 with integrated dongle connected by usb bus.<br>I inst=
alled bluez-libs and bluez-utils and added modules (bluetooth<br>l2cap rfco=
mm bnep hidp hci_usb)<br>I start services and hciconfig -a return:<br>tuxon=
e ~ # hciconfig -a
<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;BD Address: 00:10:C6:D1:07:A1 ACL MTU: 384:8 SCO MTU: 64:8<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UP RUNNING PSCAN ISCAN AUTH ENCR=
YPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RX bytes:697 acl:0 s=
co:0 events:55 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
TX bytes:640 acl:0 sco:0 commands:32 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Features: 0xff 0xff 0x9=
f 0xfe 0x9b 0xf9 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Link mode: SLAVE ACCEPT<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name: 'BlueZ (0)'
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Class: 0x3e0100<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Service Classes: Networking, Re=
ndering, Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Devic=
e Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0=
x679<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Manufacturer: Cambridge Sil=
icon Radio (10)<br>tuxone ~ #<br><br>The dongle led flash,it seems working.=
<br>I have 2 nokia 3650 and an other pc with bluetooth and they work.<br>If=
 i enter hcitool scan from latitude :
<br><br>tuxone ~ # hcitool scan<br>Scanning ...<br>tuxone ~ #<br><br>It doe=
sn't recognize all bt hosts.<br><br>If i do a scanning from an other host i=
 can't recognize the notebook<br>(but the led of its dongle flash with a di=
fferent timed during the
<br>scanning).<br><br>Can anyone help me?<br><br>Alex<br><br><br>----------=
---------------------------------------------<br>This SF.net email is spons=
ored by: Splunk Inc. Do you grep through log files<br>for problems?&nbsp;&n=
bsp;Stop!&nbsp;&nbsp;Download the new AJAX search engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad_idv37&amp;alloc_=
id=16865&amp;opclick">http://ads.osdn.com/?ad_idv37&amp;alloc_id=16865&amp;=
opclick</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourcef=
orge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/=
lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_1359_29987902.1136585385348--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
