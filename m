Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3e890f530605161349s305b64c9ve35134ad9f5f99c7@mail.gmail.com>
From: "Javier Rodas" <javier.rodas@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Inquiry with RSSI on Broadcom BCM2035 - not supported ?
In-Reply-To: <1147789208.24761.73.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_85903_5803854.1147812543379"
References: <3e890f530605131204w2980dee2v586468fed3fe16ed@mail.gmail.com>
	 <1147789208.24761.73.camel@localhost>
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
Date: Tue, 16 May 2006 22:49:03 +0200

------=_Part_85903_5803854.1147812543379
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/5/16, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Javier,
>
> > I have make this question on bluez-users mailing list some time ago,
> > without answer.
> >
> >
> > I have tested the D-Link DBT-122 dongle (BCM2035 chipset) with
> > BlueZ-utils and I find the following features list:
> >
> > # hciconfig hci0 features
> > hci0:   Type: USB
> >         BD Address: 00:13:46:01:22:90 ACL MTU: 377:10 SCO MTU: 16:0
> >         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
> >                 <3-slot packets> <5-slot packets> <encryption> <slot
> > offset>
> >                 <timing accuracy> <role switch> <hold mode> <sniff
> > mode>
> >                 <RSSI> <channel quality> <SCO link> <HV2 packets>
> >                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power
> > control>
> >                 <transparent SCO> <enhanced iscan> <interlaced iscan>
> >                 <interlaced pscan> <AFH cap. slave> <AFH cap. master>
> >
> > Looking the manufactured specification page of BCM2035 chipset it says
> > that it implements the Bluetooth v1.2 specification. Nevertheless I
> > found that it's not true, because this dongle doesn't support the
> > <Inquiry with RSSI> feature, that belongs to that version and
> > following of the BT specification.
> >
> >
> > I have also tested other usb dongles, for example CSR BlueCore4,
> > successfully with this feature:
> >
> > # hciconfig hci0 features
> > hci0:   Type: USB
> >         BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU: 64:8
> >         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
> >                 <3-slot packets> <5-slot packets> <encryption> <slot
> > offset>
> >                 <timing accuracy> <role switch> <hold mode> <sniff
> > mode>
> >                 <park state> <RSSI> <channel quality> <SCO link> <HV2
> > packets>
> >                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
> > scheme>
> >                 <power control> <transparent SCO> <broadcast encrypt>
> >                 <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
> >                 <interlaced iscan> <interlaced pscan> <inquiry with
> > RSSI>  <-----
> >                 <extended SCO> <EV4 packets> <EV5 packets> <AFH cap.
> > slave>
> >                 <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
> >                 <AFH cap. master> <AFH class. master> <EDR eSCO 2
> > Mbps>
> >                 <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended
> > features>
> >
> >
> >
> > Please, could you confirm me that it's impossible to make an "Inquiry
> > with RSSI" operation with the BCM2035 chipset from Broadcom ?
> > Do you know on existence of an firmware upgrade for this chipsets that
> > solves this lack ?
>
> simply try "hciconfig hci0 inqmode 1" and monitor with "hcidump -X -V"
> what happens if you call "hcitool scan". I've seen some Broadcom chips
> that don't set the feature bit for inquiry with RSSI, but they do
> support it.
>
> Regards
>
> Marcel
>

I try the following (as root) with my D-Link DBT-122 dongle (BCM2035
chipset):

# hciconfig hci0 inqmode
Can't read inquiry mode on hci0: Input/output error (5)
# hciconfig hci0 inqmode 1
Can't set inquiry mode on hci0: Input/output error (5)
# hciconfig hci0 inqmode
Can't read inquiry mode on hci0: Input/output error (5)
# hciconfig hci0 inqmode 0
Can't set inquiry mode on hci0: Input/output error (5)
# hciconfig hci0 inqmode
Can't read inquiry mode on hci0: Input/output error (5)
# hcitool inq --flush
Inquiring ...
        00:13:FD:D7:CD:B8       clock offset: 0x4cca    class: 0x50020c
# hciconfig hci0 inqmode 1
Can't set inquiry mode on hci0: Input/output error (5)
# hcitool inq --flush
Inquiring ...
        00:13:FD:D7:CD:B8       clock offset: 0x4cca    class: 0x50020c


And these are the lines shown with "hcidump -x":
< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0
> HCI Event: Command Complete (0x0e) plen 4
  01 44 0C 11
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
  01
> HCI Event: Command Complete (0x0e) plen 4
  01 45 0C 11
< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0
> HCI Event: Command Complete (0x0e) plen 4
  01 44 0C 11
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
  00
> HCI Event: Command Complete (0x0e) plen 4
  01 45 0C 11
< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0
> HCI Event: Command Complete (0x0e) plen 4
  01 44 0C 11
< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 08 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Complete (0x01) plen 1
  00
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
  01
> HCI Event: Command Complete (0x0e) plen 4
  01 45 0C 11
< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 08 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C
> HCI Event: Inquiry Complete (0x01) plen 1
  00



As you can see it does not change the inquiry mode from "Standard Inquiry"
to "Inquiry with RSSI".
It responds with standard inquiry result events "HCI Event: Inquiry Result
(0x02)", it doesn't respond with "HCI Event: Inquiry Result with RSSI
(0x22)" neither.

On the other hand if I read the possible commands supported in this dongle =
I
found:

# hciconfig hci0 commands
hci0:   Type: USB
        BD Address: 00:13:46:01:2D:95 ACL MTU: 377:10 SCO MTU: 16:0
        Commands: Octet 0  =3D 0x7f (Bit 0 1 2 3 4 5 6)
                  Octet 1  =3D 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 2  =3D 0xaf (Bit 0 1 2 3 5 7)
                  Octet 3  =3D 0x01 (Bit 0)
                  Octet 4  =3D 0xce (Bit 1 2 3 6 7)
                  Octet 5  =3D 0xc7 (Bit 0 1 2 6 7)
                  Octet 6  =3D 0xef (Bit 0 1 2 3 5 6 7)
                  Octet 7  =3D 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 8  =3D 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 9  =3D 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 10 =3D 0xff (Bit 0 1 2 3 4 5 6 7)
                  Octet 11 =3D 0x9f (Bit 0 1 2 3 4 7)
                  Octet 12 =3D 0x03 (Bit 0 1)
                  Octet 14 =3D 0xb8 (Bit 3 4 5 7)
                  Octet 15 =3D 0x7f (Bit 0 1 2 3 4 5 6)
                  Octet 16 =3D 0x04 (Bit 2)
        'Inquiry' 'Inquiry Cancel' 'Periodic Inquiry Mode'
        'Exit Periodic Inquiry Mode' 'Create Connection' 'Disconnect'
        'Add SCO Connection' 'Accept Connection Request'
        'Reject Connection Request' 'Link Key Request Reply'
        'Link Key Request Negative Reply' 'PIN Code Request Reply'
        'PIN Code Request Negative Reply' 'Change Connection Packet Type'
        'Authentication Requested' 'Set Connection Encryption'
        'Change Connection Link Key' 'Master Link Key' 'Remote Name Request=
'
        'Read Remote Supported Features' 'Read Remote Version Information'
        'Read Clock Offset' 'Hold Mode' 'Sniff Mode' 'Exit Sniff Mode'
        'QoS Setup' 'Role Discovery' 'Switch Role' 'Read Link Policy
Settings'
        'Write Link Policy Settings' 'Set Event Mask' 'Reset'
        'Set Event Filter' 'Flush' 'Read PIN Type' 'Write PIN Type'
        'Read Stored Link Key' 'Write Stored Link Key'
        'Delete Stored Link Key' 'Write Local Name' 'Read Local Name'
        'Read Connection Accept Timeout' 'Write Connection Accept Timeout'
        'Read Page Timeout' 'Write Page Timeout' 'Read Scan Enable'
        'Write Scan Enable' 'Read Page Scan Activity'
        'Write Page Scan Activity' 'Read Inquiry Scan Activity'
        'Write Inquiry Scan Activity' 'Read Authentication Enable'
        'Write Authentication Enable' 'Read Encryption Mode'
        'Write Encryption Mode' 'Read Class Of Device' 'Write Class Of
Device'
        'Read Voice Setting' 'Write Voice Setting'
        'Read Automatic Flush Timeout' 'Write Automatic Flush Timeout'
        'Read Num Broadcast Retransmissions'
        'Write Num Broadcast Retransmissions' 'Read Hold Mode Activity'
        'Write Hold Mode Activity' 'Read Transmit Power Level'
        'Read Synchronous Flow Control Enable'
        'Write Synchronous Flow Control Enable'
        'Set Host Controller To Host Flow Control' 'Host Buffer Size'
        'Host Number Of Completed Packets' 'Read Link Supervision Timeout'
        'Write Link Supervision Timeout' 'Read Number of Supported IAC'
        'Read Current IAC LAP' 'Write Current IAC LAP' 'Read Page Scan Mode=
'
        'Write Page Scan Mode' 'Set AFH Channel Classification'
        'Read Local Version Information' 'Read Local Supported Commands'
        'Read Local Supported Features' 'Read Buffer Size' 'Read Country
Code'
        'Read BD ADDR' 'Read Failed Contact Counter'
        'Reset Failed Contact Counter' 'Get Link Quality' 'Read RSSI'
        'Read AFH Channel Map' 'Enable Device Under Test Mode'


And "hcidump -x" shows:
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 68
  01 02 10 00 7F FF AF 01 CE C7 EF FF FF FF FF 9F 03 00 B8 7F
  04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00



In the list shown there are not the 'Read Inquiry Mode' and 'Write Inquiry
Mode' commands, and for that reason the change (or write) of the inquiry
mode with "hciconfig hci0 inqmode 1" didn't work, and the read of the
inquiry mode with "hciconfig hci0 inqmode" neither.



When I try exactly the same commands with BlueCore4 chipset from CSR, all o=
f
them worked perfectly, for example:

# hciconfig hci0 inqmode                   <---- Read the inquiry mode
hci0:   Type: USB
        BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU: 64:8
        Inquiry mode: Standard Inquiry     <---- "Standard Inquiry" mode by
default
# hcitool -i hci0 inquiry --flush          <---- First inquiry in "Standard
Inquiry" mode
Inquiring ...
        00:13:FD:D7:CD:B8       clock offset: 0x47c0    class: 0x50020c
# hciconfig hci0 inqmode 1                 <---- Change the inquiry mode to
"Inquiry with RSSI" mode
# hciconfig hci0 inqmode                   <---- Read the inquiry mode
hci0:   Type: USB
        BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU: 64:8
        Inquiry mode: Inquiry with RSSI    <---- It changed correctly !!!!
# hcitool -i hci0 inquiry --flush          <---- Second inquiry in "Inquiry
with RSSI" mode
Inquiring ...
        00:13:FD:D7:CD:B8       clock offset: 0x46be    class: 0x50020c


The "hcidump -x" shows:
< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0       <---- Read of
the inquiry mode
> HCI Event: Command Complete (0x0e) plen 5
  01 44 0C 00 00                   <---- The last byte is 00 =3D> "Standard
Inquiry" mode.
< HCI Command: Inquiry (0x01|0x0001) plen 5                 <---- First
inquiry in "Standard Inquiry" mode
  33 8B 9E 08 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
  01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C0 47
> HCI Event: Inquiry Complete (0x01) plen 1
  00

It shows a normal HCI event "Inquiry Result (0x02)". That's right because w=
e
are still in normal inquiry mode. Let's continue.

< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1      <---- We change
the inquiry mode to "Inquiry with RSSI" mode
  01
> HCI Event: Command Complete (0x0e) plen 4
  01 45 0C 00
< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0       <---- We read
the inquiry mode
> HCI Event: Command Complete (0x0e) plen 5
  01 44 0C 00 01                   <---- The last byte is 01 =3D> "Inquiry
with RSSI" mode

< HCI Command: Inquiry (0x01|0x0001) plen 5                 <---- Second
inquiry in "Inquiry with RSSI" mode
  33 8B 9E 08 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AB
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AD
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AC
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AD
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
  01 B8 CD D7 FD 13 00 01 00 0C 02 50 BE 46 AD
> HCI Event: Inquiry Complete (0x01) plen 1
  00

It shows some HCI events "Inquiry Result with RSSI (0x22)". That's right
because we have changed it.
The last byte shows the RSSI signal level. In this example, the inquiry
results are around 0xAD value.



I repeat the question I made the first time, do you think that it's
impossible to change the inquiry mode to "Inquiry with RSSI" with the
BCM2035 chipset from Broadcom ?
Do you think it would be possible to solve this lack with an firmware
upgrade for this chipset, and in this case do you know on existence of any
public firmware for download ?

Should I do any other kind of tests with my dongles ?


Thanks for all.

Best regards.

Javier.

------=_Part_85903_5803854.1147812543379
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/5/16, Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org" targe=
t=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">marce=
l@holtmann.org</a>&gt;:<div><span class=3D"gmail_quote"></span><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Hi Javier,<br><br>&gt; I have make this question on bluez-users mailing lis=
t some time ago,<br>&gt; without answer.<br>&gt;<br>&gt;<br>&gt; I have tes=
ted the D-Link DBT-122 dongle (BCM2035 chipset) with<br>&gt; BlueZ-utils an=
d I find the following features list:
<br>&gt;<br>&gt; # hciconfig hci0 features<br>&gt; hci0:&nbsp;&nbsp; Type: =
USB<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:=
13:46:01:22:90 ACL MTU: 377:10 SCO MTU: 16:0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00=
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot<br>&gt; offset&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff<br>=
&gt; mode&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2
packets&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;
&lt;power<br>&gt; control&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;transparent SCO&gt; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt;<br>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;interlaced pscan&gt; &lt;AFH cap. slave&gt; &lt;AFH cap. master&gt;<br>=
&gt;<br>&gt; Looking the manufactured specification page of BCM2035 chipset=
 it says<br>&gt; that it implements the Bluetooth v1.2 specification. Never=
theless I
<br>&gt; found that it's not true, because this dongle doesn't support the<=
br>&gt; &lt;Inquiry with RSSI&gt; feature, that belongs to that version and=
<br>&gt; following of the BT specification.<br>&gt;<br>&gt;<br>&gt; I have =
also tested other usb dongles, for example CSR BlueCore4,
<br>&gt; successfully with this feature:<br>&gt;<br>&gt; # hciconfig hci0 f=
eatures<br>&gt; hci0:&nbsp;&nbsp; Type: USB<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO M=
TU: 64:8<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: =
0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot<br>&gt; offset&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff<br>=
&gt; mode&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO
link&gt; &lt;HV2<br>&gt; packets&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;
&lt;paging<br>&gt; scheme&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;power control&gt; &lt;transparent SCO&gt; &lt;broadcast encrypt&gt;<br>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;EDR ACL 2 Mbps&gt; &lt;EDR ACL 3 Mbps&gt; &lt;enhanced iscan&gt;<br>&gt=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
&lt;interlaced iscan&gt; &lt;interlaced pscan&gt; &lt;inquiry with<br>&gt; =
RSSI&gt;&nbsp;&nbsp;&lt;-----<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;extended SCO&gt; &lt;EV4 packets&gt; &lt;EV5 packets&gt; &lt;AFH
cap.<br>&gt; slave&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;AFH class. slave&gt; &lt;3-slot EDR ACL&gt; &lt;5-slot EDR ACL&gt;<br>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
&lt;AFH cap. master&gt; &lt;AFH class. master&gt; &lt;EDR eSCO 2<br>&gt; Mb=
ps&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;EDR eSCO 3 Mbps&gt; &lt;3-slot EDR eSCO&gt; &lt;extended<br>&gt; featur=
es&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; Please, could you confirm me that it=
's impossible to make an &quot;Inquiry<br>&gt; with RSSI&quot; operation wi=
th the BCM2035 chipset from Broadcom ?
<br>&gt; Do you know on existence of an firmware upgrade for this chipsets =
that<br>&gt; solves this lack ?<br><br>simply try &quot;hciconfig hci0 inqm=
ode 1&quot; and monitor with &quot;hcidump -X -V&quot;<br>what happens if y=
ou call &quot;hcitool scan&quot;. I've seen some Broadcom chips
<br>that don't set the feature bit for inquiry with RSSI, but they do<br>su=
pport it.<br><br>Regards<br><br>Marcel<br></blockquote></div><br>
I try the following (as root) with my D-Link DBT-122 dongle (BCM2035 chipse=
t):<br>
<br>
# hciconfig hci0 inqmode<br>
Can't read inquiry mode on hci0: Input/output error (5)<br>
# hciconfig hci0 inqmode 1<br>
Can't set inquiry mode on hci0: Input/output error (5)<br>
# hciconfig hci0 inqmode<br>
Can't read inquiry mode on hci0: Input/output error (5)<br>
# hciconfig hci0 inqmode 0<br>
Can't set inquiry mode on hci0: Input/output error (5)<br>
# hciconfig hci0 inqmode<br>
Can't read inquiry mode on hci0: Input/output error (5)<br>
# hcitool inq --flush<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:13:FD:D7:CD:B8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x4cca&nbsp;&nbsp;&nbsp; class: 0x50020c<br>
# hciconfig hci0 inqmode 1<br>
Can't set inquiry mode on hci0: Input/output error (5)<br>
# hcitool inq --flush<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:13:FD:D7:CD:B8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x4cca&nbsp;&nbsp;&nbsp; class: 0x50020c<br>
<br>
<br>
And these are the lines shown with &quot;hcidump -x&quot;:<br>
&lt; HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 44 0C 11<br>
&lt; HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1<br>
&nbsp; 01<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 45 0C 11<br>
&lt; HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 44 0C 11<br>
&lt; HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1<br>
&nbsp; 00<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 45 0C 11<br>
&lt; HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 44 0C 11<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp; 33 8B 9E 08 00<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 01 04<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CB 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 00<br>
&lt; HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1<br>
&nbsp; 01<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 45 0C 11<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp; 33 8B 9E 08 00<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 01 04<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C9 4C<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 CA 4C<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 00<br>
<br>
<br>
<br>
As you can see it does not change the inquiry mode from &quot;Standard Inqu=
iry&quot; to &quot;Inquiry with RSSI&quot;.<br>
It responds with standard inquiry result events &quot;HCI Event: Inquiry
Result (0x02)&quot;, it doesn't respond with &quot;HCI Event: Inquiry Resul=
t with
RSSI (0x22)&quot; neither.<br>
<br>
On the other hand if I read the possible commands supported in this dongle =
I found:<br>
<br>
# hciconfig hci0 commands<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:13:46:01:2D:95 AC=
L MTU: 377:10 SCO MTU: 16:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Commands: Octet 0&nbsp; =3D 0x7f=
 (Bit 0 1 2 3 4 5 6)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 1&nbsp; =3D 0xff (Bit 0 1 2 3 4 5 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 2&nbsp; =3D 0xaf (Bit 0 1 2 3 5 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 3&nbsp; =3D 0x01 (Bit 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 4&nbsp; =3D 0xce (Bit 1 2 3 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 5&nbsp; =3D 0xc7 (Bit 0 1 2 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 6&nbsp; =3D 0xef (Bit 0 1 2 3 5 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 7&nbsp; =3D 0xff (Bit 0 1 2 3 4 5 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 8&nbsp; =3D 0xff (Bit 0 1 2 3 4 5 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 9&nbsp; =3D 0xff (Bit 0 1 2 3 4 5 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 10 =3D 0xff (Bit 0 1 2 3 4 5 6 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 11 =3D 0x9f (Bit 0 1 2 3 4 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Octet 12 =3D 0x03 (Bit 0 1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 14 =3D 0xb8 (Bit 3 4 5 7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
Octet 15 =3D 0x7f (Bit 0 1 2 3 4 5 6)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Octet 16 =3D 0x04 (Bit 2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Inquiry' 'Inquiry Cancel' 'Peri=
odic Inquiry Mode'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Exit Periodic Inquiry Mode' 'Cr=
eate Connection' 'Disconnect'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Add SCO Connection' 'Accept Con=
nection Request'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Reject Connection Request' 'Lin=
k Key Request Reply'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Link Key Request Negative Reply=
' 'PIN Code Request Reply'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'PIN Code Request Negative Reply=
' 'Change Connection Packet Type'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Authentication Requested' 'Set =
Connection Encryption'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Change Connection Link Key' 'Ma=
ster Link Key' 'Remote Name Request'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Remote Supported Features'=
 'Read Remote Version Information'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Clock Offset' 'Hold Mode' =
'Sniff Mode' 'Exit Sniff Mode'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'QoS Setup' 'Role Discovery' 'Sw=
itch Role' 'Read Link Policy Settings'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Link Policy Settings' 'Se=
t Event Mask' 'Reset'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Set Event Filter' 'Flush' 'Read=
 PIN Type' 'Write PIN Type'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Stored Link Key' 'Write St=
ored Link Key'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Delete Stored Link Key' 'Write =
Local Name' 'Read Local Name'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Connection Accept Timeout'=
 'Write Connection Accept Timeout'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Page Timeout' 'Write Page =
Timeout' 'Read Scan Enable'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Scan Enable' 'Read Page S=
can Activity'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Page Scan Activity' 'Read=
 Inquiry Scan Activity'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Inquiry Scan Activity' 'R=
ead Authentication Enable'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Authentication Enable' 'R=
ead Encryption Mode'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Encryption Mode' 'Read Cl=
ass Of Device' 'Write Class Of Device'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Voice Setting' 'Write Voic=
e Setting'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Automatic Flush Timeout' '=
Write Automatic Flush Timeout'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Num Broadcast Retransmissi=
ons'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Num Broadcast Retransmiss=
ions' 'Read Hold Mode Activity'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Hold Mode Activity' 'Read=
 Transmit Power Level'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Synchronous Flow Control E=
nable'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Synchronous Flow Control =
Enable'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Set Host Controller To Host Flo=
w Control' 'Host Buffer Size'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Host Number Of Completed Packet=
s' 'Read Link Supervision Timeout'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Link Supervision Timeout'=
 'Read Number of Supported IAC'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Current IAC LAP' 'Write Cu=
rrent IAC LAP' 'Read Page Scan Mode'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Write Page Scan Mode' 'Set AFH =
Channel Classification'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Local Version Information'=
 'Read Local Supported Commands'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read Local Supported Features' =
'Read Buffer Size' 'Read Country Code'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read BD ADDR' 'Read Failed Cont=
act Counter'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Reset Failed Contact Counter' '=
Get Link Quality' 'Read RSSI'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Read AFH Channel Map' 'Enable D=
evice Under Test Mode'<br>
<br>
<br>
And &quot;hcidump -x&quot; shows:<br>
&lt; HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0<br>
&gt; HCI Event: Command Complete (0x0e) plen 68<br>
&nbsp; 01 02 10 00 7F FF AF 01 CE C7 EF FF FF FF FF 9F 03 00 B8 7F<br>
&nbsp; 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
&nbsp; 00 00 00 00 00 00 00 00<br>
<br>
<br>
<br>
In the list shown there are not the 'Read Inquiry Mode' and 'Write
Inquiry Mode' commands, and for that reason the change (or write) of
the inquiry mode with &quot;hciconfig hci0 inqmode 1&quot; didn't work, and=
 the
read of the inquiry mode with &quot;hciconfig hci0 inqmode&quot; neither.<b=
r>
<br>
<br>
<br>
When I try exactly the same commands with BlueCore4 chipset from CSR, all o=
f them worked perfectly, for example:<br>
<br>
# hciconfig hci0
inqmode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;---- Read the inquiry mode<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:5A:46:2D:51 AC=
L MTU: 384:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Inquiry mode: Standard
Inquiry&nbsp;&nbsp;&nbsp;&nbsp; &lt;---- &quot;Standard Inquiry&quot; mode =
by
default<br>
# hcitool -i hci0 inquiry
--flush&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;----
First inquiry in &quot;Standard Inquiry&quot; mode<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:13:FD:D7:CD:B8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x47c0&nbsp;&nbsp;&nbsp; class: 0x50020c<br>
# hciconfig hci0 inqmode
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
&lt;---- Change the inquiry mode to &quot;Inquiry with RSSI&quot; mode<br>
# hciconfig hci0
inqmode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;---- Read the inquiry mode<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:5A:46:2D:51 AC=
L MTU: 384:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Inquiry mode: Inquiry with RSSI&=
nbsp;&nbsp;&nbsp; &lt;---- It changed correctly !!!!<br>
# hcitool -i hci0 inquiry
--flush&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;----
Second inquiry in &quot;Inquiry with RSSI&quot; mode<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:13:FD:D7:CD:B8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x46be&nbsp;&nbsp;&nbsp; class: 0x50020c<br>
<br>
<br>
The &quot;hcidump -x&quot; shows:<br>
&lt; HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &lt;---- Read of the inquiry mode<br>
&gt; HCI Event: Command Complete (0x0e) plen 5<br>
&nbsp; 01 44 0C 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;---- The last byte is 00 =3D&gt; &quot;Standard Inquiry&quot; mode.<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
&lt;---- First inquiry in &quot;Standard Inquiry&quot; mode<br>
&nbsp; 33 8B 9E 08 00<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 01 04<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 00 0C 02 50 C0 47<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 00<br>
<br>
It shows a normal HCI event &quot;Inquiry Result (0x02)&quot;. That's right=
 because we are still in normal inquiry mode. Let's continue.<br>
<br>
&lt; HCI Command: Write Inquiry Mode (0x03|0x0045) plen
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;---- We change the inquiry mode to
&quot;Inquiry with RSSI&quot; mode<br>
&nbsp; 01<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 01 45 0C 00<br>
&lt; HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &lt;---- We read the inquiry mode<br>
&gt; HCI Event: Command Complete (0x0e) plen 5<br>
&nbsp; 01 44 0C 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;---- The last byte is 01 =3D&gt; &quot;Inquiry with RSSI&quot; mode<br>
<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
&lt;---- Second inquiry in &quot;Inquiry with RSSI&quot; mode<br>
&nbsp; 33 8B 9E 08 00<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 01 04<br>
&gt; HCI Event: Inquiry Result with RSSI (0x22) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AB<br>
&gt; HCI Event: Inquiry Result with RSSI (0x22) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AD<br>
&gt; HCI Event: Inquiry Result with RSSI (0x22) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AC<br>
&gt; HCI Event: Inquiry Result with RSSI (0x22) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 0C 02 50 BD 46 AD<br>
&gt; HCI Event: Inquiry Result with RSSI (0x22) plen 15<br>
&nbsp; 01 B8 CD D7 FD 13 00 01 00 0C 02 50 BE 46 AD<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 00<br>
<br>
It shows some HCI events &quot;Inquiry Result with RSSI (0x22)&quot;. That'=
s right because we have changed it.<br>
The last byte shows the RSSI signal level. In this example, the inquiry res=
ults are around 0xAD value.<br>
<br>
<br>
<br>
I repeat the question I made the first time, do you think that it's
impossible to change the inquiry mode to &quot;Inquiry with RSSI&quot; with=
 the
BCM2035 chipset from Broadcom ?<br>
Do you think it would be possible to solve this lack with an firmware
upgrade for this chipset, and in this case do you know on existence of
any public firmware for download ?<br>
<br>
Should I do any other kind of tests with my dongles ?<br>
<br>
<br>
Thanks for all.<br>
<br>
Best regards.<br>
<br>
Javier.<br>


------=_Part_85903_5803854.1147812543379--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
