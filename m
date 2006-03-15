Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20603142002u6505290dp6d6a40242c4bcb8d@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: Bluez-devel@lists.sourceforge.net
In-Reply-To: <fe0a97c20603140444l69c2991fg68221729d23361e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1972_15603676.1142395334754"
References: <fe0a97c20603140444l69c2991fg68221729d23361e6@mail.gmail.com>
Subject: [Bluez-devel] initiating pairing
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
Date: Wed, 15 Mar 2006 09:32:14 +0530

------=_Part_1972_15603676.1142395334754
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> Hi guys... I have tried initiate pairing... by switching to security mode
> 3... that is my linux box is askin my windows PC to give PIN number :
>
> but Iam gettin some error in my linux box
>
> [root@zin03uislnx-10 blue]# hcitool cc 11:11:11:11:11:11
> Can't create connection: Input/output error
>
>  and I don't see the "paired" tick mark in My Bluetooth Places ...
>
> am i missing something???
>
> On 3/14/06, Sowmya Gattupalli <sowmya.gattupalli@gmail.com> wrote:
> >
> > Hi all...
> >
> > Iam trying to use : sdptool browse and Iam getting the error
> > Service Search failed: Connection timed out
> >
> > (1)[root@zin03uislnx-10 blue]# sdptool browse 11:11:11:11:11:11
> > Browsing 11:11:11:11:11:11 ...
> > Service Search failed: Connection timed out
> >
> > I am trying out the thing from my Linux Box which has CSR chipset for
> > which there are Bluez drivers.
> > The bdaddr "11:11:11:11:11:11" is that of a dongle's (ISSC I guess)
> > which is connected to my Windows PC running on XP using the bluetooth s=
/w.
> >
> > Though Iam able to connect to it ... (the icon in the tray turns green)
> > but iam unable to do sdpsearch ...
> > ne ideas??
> >
> >
> > (2) Can I not initiate pairing from my linux box???
> > when i give hcitool cc 11:11:11:11:11:11 , the icon turns green thats
> > all....
> >
> > but when i pair from the windows machine, it gets paired... the hcidump
> > output is
> >
> > [root@zin03uislnx-10 blue]# hcidump -X -V
> > HCI sniffer - Bluetooth packet analyzer ver 1.29
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > > HCI Event: Connect Request (0x04) plen 10
> >     bdaddr 11:11:11:11:11:11 class 0x320104 type ACL
> > < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> >     bdaddr 11:11:11:11:11:11 role 0x01
> >     Role: Slave
> > > HCI Event: Command Status (0x0f) plen 4
> >     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > > HCI Event: PIN Code Request (0x16) plen 6
> >     bdaddr 11:11:11:11:11:11
> > < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> >     bdaddr 11:11:11:11:11:11 len 6 pin '123456'
> > > HCI Event: Command Complete (0x0e) plen 10
> >     PIN Code Request Reply (0x01|0x000d) ncmd 1
> >     status 0x00 bdaddr 11:11:11:11:11:11
> > < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> >     bdaddr 11:11:11:11:11:11 len 6 pin '123456'
> > > HCI Event: Command Complete (0x0e) plen 10
> >     PIN Code Request Reply (0x01|0x000d) ncmd 1
> >     status 0x00 bdaddr 11:11:11:11:11:11
> > < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> >     bdaddr 11:11:11:11:11:11 len 6 pin '123456'
> > > HCI Event: Command Complete (0x0e) plen 10
> >     PIN Code Request Reply (0x01|0x000d) ncmd 1
> >     status 0x00 bdaddr 11:11:11:11:11:11
> > < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> >     bdaddr 11:11:11:11:11:11 len 6 pin '123456'
> > > HCI Event: Command Complete (0x0e) plen 10
> >     PIN Code Request Reply (0x01|0x000d) ncmd 1
> >     status 0x00 bdaddr 11:11:11:11:11:11
> > > HCI Event: Link Key Notification (0x18) plen 23
> >     bdaddr 11:11:11:11:11:11 key C1C171F0606D4668886322A9E76698B2 type =
0
> > > HCI Event: Connect Complete (0x03) plen 11
> >     status 0x00 handle 40 bdaddr 11:11:11:11:11:11 type ACL encrypt 0x0=
0
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> >     handle 40 policy 0x0f
> >     Link policy: RSWITCH HOLD SNIFF PARK
> > > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> >     bdaddr 11:11:11:11:11:11 mode 1
> > > HCI Event: Max Slots Change (0x1b) plen 3
> >     handle 40 slots 5
> > > HCI Event: Command Complete (0x0e) plen 6
> >     Write Link Policy Settings (0x02|0x000d) ncmd 1
> >     status 0x00 handle 40
> > < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> >     handle 40 ptype 0xcc18
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Command Status (0x0f) plen 4
> >     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> > > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> >     status 0x00 handle 40 ptype 0xcc18
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Disconn Complete (0x05) plen 4
> >     status 0x00 handle 40 reason 0x13
> >     Reason: Remote User Terminated Connection
> >
> > Please help me in this problem....
> > Soumya
> >
> >
> >
>

------=_Part_1972_15603676.1142395334754
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"></span><div><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">Hi guys... I have tried initiate pairing... by switc=
hing to security
mode 3... that is my linux box is askin my windows PC to give PIN
number : <br><br>but Iam gettin some error in my linux box<br><br>[root@zin=
03uislnx-10 blue]# hcitool cc 11:11:11:11:11:11
<br>Can't create connection: Input/output error<br><br>&nbsp;and I don't se=
e the &quot;paired&quot; tick mark in My Bluetooth Places ... <br><br>am i =
missing something???<br><br><div><span class=3D"gmail_quote">On 3/14/06, <b=
 class=3D"gmail_sendername">

Sowmya Gattupalli</b> &lt;<a href=3D"mailto:sowmya.gattupalli@gmail.com" ta=
rget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">so=
wmya.gattupalli@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">

<div style=3D"direction: ltr;">Hi all... <br><br>Iam trying to use : sdptoo=
l browse and Iam getting the error <br>Service Search failed: Connection ti=
med out<br><br>(1)[root@zin03uislnx-10 blue]# sdptool browse 11:11:11:11:11=
:11
<br>Browsing 11:11:11:11:11:11 ...
<br>Service Search failed: Connection timed out<br><br>I am trying out the =
thing from my Linux Box which has CSR chipset for which there are Bluez dri=
vers.<br>The
bdaddr &quot;11:11:11:11:11:11&quot; is that of a dongle's (ISSC I guess) w=
hich
is connected to my Windows PC running on XP using the bluetooth s/w. <br><b=
r>Though Iam able to connect to it ... (the icon in the tray turns green)&n=
bsp; but iam unable to do sdpsearch ... <br>ne ideas?? <br><br><br>(2) Can =
I not initiate pairing from my linux box???=20
<br>when i give hcitool cc 11:11:11:11:11:11 , the icon turns green thats a=
ll....=20
<br><br>but when i pair from the windows machine, it gets paired... the hci=
dump output is<br><br>[root@zin03uislnx-10 blue]# hcidump -X -V<br>HCI snif=
fer - Bluetooth packet analyzer ver 1.29<br>device: hci0 snap_len: 1028 fil=
ter: 0xffffffff
<br>&gt; HCI Event: Connect Request (0x04) plen 10<br>&nbsp;&nbsp;&nbsp; bd=
addr 11:11:11:11:11:11 class 0x320104 type ACL<br>&lt; HCI Command: Accept =
Connection Request (0x01|0x0009) plen 7<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:=
11:11:11:11 role 0x01<br>

&nbsp;&nbsp;&nbsp; Role: Slave
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp;&nbsp;&nbsp; Acce=
pt Connection Request (0x01|0x0009) status 0x00 ncmd 1<br>&gt; HCI Event: P=
IN Code Request (0x16) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:1=
1<br>&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:11 len 6 pin '123456'<br>&gt; =
HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code R=
equest Reply (0x01|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr =
11:11:11:11:11:11<br>&lt; HCI Command: PIN Code Request Reply (0x01|0x000d)=
 plen 23
<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:11 len 6 pin '123456'<br>&gt; =
HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code R=
equest Reply (0x01|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr =
11:11:11:11:11:11<br>&lt; HCI Command: PIN Code Request Reply (0x01|0x000d)=
 plen 23
<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:11 len 6 pin '123456'<br>&gt; =
HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code R=
equest Reply (0x01|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr =
11:11:11:11:11:11<br>&lt; HCI Command: PIN Code Request Reply (0x01|0x000d)=
 plen 23
<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:11 len 6 pin '123456'<br>&gt; =
HCI Event: Command Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code R=
equest Reply (0x01|0x000d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr =
11:11:11:11:11:11<br>&gt; HCI Event: Link Key Notification (0x18) plen 23
<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:11 key C1C171F0606D4668886322A=
9E76698B2 type 0<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbs=
p;&nbsp;&nbsp; status 0x00 handle 40 bdaddr 11:11:11:11:11:11 type ACL encr=
ypt 0x00<br>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen=
 4
<br>&nbsp;&nbsp;&nbsp; handle 40 policy 0x0f<br>&nbsp;&nbsp;&nbsp; Link pol=
icy: RSWITCH HOLD SNIFF PARK<br>&gt; HCI Event: Page Scan Repetition Mode C=
hange (0x20) plen 7<br>&nbsp;&nbsp;&nbsp; bdaddr 11:11:11:11:11:11 mode 1<b=
r>&gt; HCI Event: Max Slots Change (0x1b) plen 3
<br>&nbsp;&nbsp;&nbsp; handle 40 slots 5<br>&gt; HCI Event: Command Complet=
e (0x0e) plen 6<br>&nbsp;&nbsp;&nbsp; Write Link Policy Settings (0x02|0x00=
0d) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 40<br>&lt; HCI Command:=
 Change Connection Packet Type (0x01|0x000f) plen 4
<br>&nbsp;&nbsp;&nbsp; handle 40 ptype 0xcc18<br>&nbsp;&nbsp;&nbsp; Packet =
type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Command Status (0x0f) plen=
 4<br>&nbsp;&nbsp;&nbsp; Change Connection Packet Type (0x01|0x000f) status=
 0x00 ncmd 1<br>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen =
5
<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 40 ptype 0xcc18<br>&nbsp;&nbsp;&n=
bsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>&gt; HCI Event: Disconn Comple=
te (0x05) plen 4<br>&nbsp;&nbsp;&nbsp; status 0x00 handle 40 reason 0x13<br=
>&nbsp;&nbsp;&nbsp; Reason: Remote User Terminated Connection
<br><br>Please help me in this problem.... <br>Soumya<br><br><br>

</div></blockquote></div><br>

</blockquote></div><br>

------=_Part_1972_15603676.1142395334754--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
