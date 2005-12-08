Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <45bf5ff80512071633x7abfe08dnfccd0aee21b94008@mail.gmail.com>
From: Artur Almeida <fidalgo.a@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Inquiry Time
In-Reply-To: <1133961236.3752.27.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15347_25269400.1134002015511"
References: <45bf5ff80512070503g6cfc5189hec21ab22768ed9cd@mail.gmail.com>
	 <1133961236.3752.27.camel@blade>
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
Date: Thu, 8 Dec 2005 00:33:35 +0000

------=_Part_15347_25269400.1134002015511
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Marcel

I have 3 dongles attached to my pc, in attach the hciconfig -a output:



hci0:   Type: USB

        BD Address: 00:11:B1:08:A0:92 ACL MTU: 192:8 SCO MTU: 64:8

        UP RUNNING PSCAN ISCAN INQUIRY

        RX bytes:2128101 acl:39869 sco:0 events:152683 errors:0

        TX bytes:1166603 acl:39621 sco:0 commands:44590 errors:0

        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80

        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

        Link policy: RSWITCH

        Link mode: MASTER

        Name: 'Mo #0'

        Class: 0x500204

        Service Classes:

        Device Class: Phone, Cellular

        HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver:
0x512

        Manufacturer: Cambridge Silicon Radio (10)



hci1:   Type: USB

        BD Address: 00:11:B1:08:A0:9E ACL MTU: 192:8 SCO MTU: 64:8

        UP RUNNING PSCAN ISCAN

        RX bytes:742522 acl:21877 sco:0 events:41391 errors:0

        TX bytes:2353244 acl:31777 sco:0 commands:3103 errors:0

        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80

        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

        Link policy: RSWITCH

        Link mode: MASTER

        Name: 'Mo #1'

        Class: 0x000100

        Service Classes: Unspecified

        Device Class: Computer, Uncategorized

        HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver:
0x512

        Manufacturer: Cambridge Silicon Radio (10)



hci2:   Type: USB

        BD Address: 00:11:B1:08:A0:A0 ACL MTU: 192:8 SCO MTU: 64:8

        UP RUNNING

        RX bytes:160 acl:0 sco:0 events:19 errors:0

        TX bytes:322 acl:0 sco:0 commands:16 errors:0

        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80

        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

        Link policy: RSWITCH

        Link mode: MASTER

        Name: 'Mo #2'

        Class: 0x500204

        Service Classes:

        Device Class: Phone, Cellular

        HCI Ver: 1.2 (0x2) HCI Rev: 0x512 LMP Ver: 1.2 (0x2) LMP Subver:
0x512

        Manufacturer: Cambridge Silicon Radio (10)


Regards
Artur

On 12/7/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Artur,
>
> >  The Bt specification says that once you send a inquiry request, you
> > should get all the responses +-11 seconds. Many times i send an
> > inquiry and it lasts a lot more then that (Sometimes it goes over a
> > minute). Can someone explain how can i limit the inquiry time to the
> > 11 sec window? Why does this happens?  Also, where can i find a
> > detailed document with all the features and parameters of the
> > hciconfig?
>
> what does "hciconfig -a" says? I never saw a problem like this.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_15347_25269400.1134002015511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Marcel<br><br>I have 3 dongles attached to my pc, in attach the hcico=
nfig -a output:<br><br><br><br><p><font color=3D"navy" face=3D"Arial" size=
=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; color: navy;">hc=
i0:&nbsp;&nbsp; Type: USB
</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; BD Address: 00:11:B1:08:A0:92 ACL
MTU: 192:8 SCO MTU: 64:8</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; UP RUNNING PSCAN ISCAN INQUIRY</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; RX bytes:2128101 acl:39869 sco:0
events:152683 errors:0</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TX bytes:1166603 acl:39621 sco:0
commands:44590 errors:0</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Features: 0xff 0xff 0x8f 0xf8 0x18
0x18 0x00 0x80</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span></font><font color=3D"navy" face=3D"Arial" size=3D"2"><span=
 style=3D"font-size: 10pt; font-family: Arial; color: navy;" lang=3D"DA">
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;" lang=3D"DA">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span></font><font color=3D"navy" face=3D"Arial" size=
=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; color: navy;">
Link policy: RSWITCH</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Link mode: MASTER</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Name: 'Mo #0'</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Class: 0x500204</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Service Classes:</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Device Class: Phone, Cellular</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x512
LMP Ver: 1.2 (0x2) LMP Subver: 0x512</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Manufacturer: Cambridge Silicon Radio (10)</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">hci1:&nbsp;&nbsp; Type: USB</span>=
</font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; BD Address: 00:11:B1:08:A0:9E ACL
MTU: 192:8 SCO MTU: 64:8</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; UP RUNNING PSCAN ISCAN</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; RX bytes:742522 acl:21877 sco:0
events:41391 errors:0</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TX bytes:2353244 acl:31777 sco:0
commands:3103 errors:0</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Features: 0xff 0xff 0x8f 0xf8 0x18
0x18 0x00 0x80</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span></font><font color=3D"navy" face=3D"Arial" size=3D"2"><span=
 style=3D"font-size: 10pt; font-family: Arial; color: navy;" lang=3D"DA">
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;" lang=3D"DA">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span></font><font color=3D"navy" face=3D"Arial" size=
=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; color: navy;">
Link policy: RSWITCH</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Link mode: MASTER</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Name: 'Mo #1'</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Class: 0x000100</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Service Classes: Unspecified</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Device Class: Computer,
Uncategorized</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x512
LMP Ver: 1.2 (0x2) LMP Subver: 0x512</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Manufacturer: Cambridge Silicon Radio (10)</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">hci2:&nbsp;&nbsp; Type: USB</span>=
</font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; BD Address: 00:11:B1:08:A0:A0 ACL
MTU: 192:8 SCO MTU: 64:8</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; UP RUNNING</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;RX bytes:160 acl:0 sco:0 events:19
errors:0</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TX bytes:322 acl:0 sco:0
commands:16 errors:0</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Features: 0xff 0xff 0x8f 0xf8 0x18
0x18 0x00 0x80</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; </span></font><font color=3D"navy" face=3D"Arial" size=3D"2"><span=
 style=3D"font-size: 10pt; font-family: Arial; color: navy;" lang=3D"DA">
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;" lang=3D"DA">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span></font><font color=3D"navy" face=3D"Arial" size=
=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; color: navy;">
Link policy: RSWITCH</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Link mode: MASTER</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Name: 'Mo #2'</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Class: 0x500204</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Service Classes:</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Device Class: Phone, Cellular</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x512
LMP Ver: 1.2 (0x2) LMP Subver: 0x512</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Manufacturer: Cambridge Silicon Radio (10)</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>Regards<br=
>Artur<br><br><div><span class=3D"gmail_quote">On 12/7/05, <b class=3D"gmai=
l_sendername">
Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtm=
ann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
Hi Artur,<br><br>&gt;&nbsp;&nbsp;The Bt specification says that once you se=
nd a inquiry request, you<br>&gt; should get all the responses +-11 seconds=
. Many times i send an<br>&gt; inquiry and it lasts a lot more then that (S=
ometimes it goes over a
<br>&gt; minute). Can someone explain how can i limit the inquiry time to t=
he<br>&gt; 11 sec window? Why does this happens?&nbsp;&nbsp;Also, where can=
 i find a<br>&gt; detailed document with all the features and parameters of=
 the<br>
&gt; hciconfig?<br><br>what does &quot;hciconfig -a&quot; says? I never saw=
 a problem like this.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-----=
--------------------------------------------------<br>This SF.net email is =
sponsored by: Splunk Inc. Do you grep through log files
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes<br>searching your log files as easy as surfing the&nbsp;&=
nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad=
_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick">
http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a><b=
r>_______________________________________________<br>Bluez-devel mailing li=
st<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@list=
s.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_15347_25269400.1134002015511--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
