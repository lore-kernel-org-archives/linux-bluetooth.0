Return-Path: <keyurde@nortelnetworks.com>
Message-ID: <E337F6C8A5154F4C8E95349BA276D63008FBB5@zrtphxm0.corp.nortel.com>
From: "KEYUR DESAI" <keyurde@nortelnetworks.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Connection failed error (110)
Date: Mon, 25 Oct 2004 01:41:48 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4BA55.13B193DA"
List-ID: <bluez-users.lists.sourceforge.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4BA55.13B193DA
Content-Type: text/plain;
	charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

Here are the details:

I am using kernel 2.6.10 (fedora core -2)
My hardware is Belkin Dongle

I have the latest bluez utilities and library files
bluez-hcidump-1.12         bluez-libs-2.10    =20
bluez-utils-2.10


[root@localhost Bluez]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:3A:50:4B:4D ACL MTU: 192:8=20
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:77 acl:0 sco:0 events:9 errors:0
        TX bytes:31 acl:0 sco:0 commands:8 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
(0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
                                                     =20
Here is the error....
                        =20
[root@localhost Bluez]# hciconfig hci0 up
[root@localhost Bluez]# hciconfig hci0 down
[root@localhost Bluez]# hciconfig hci0 up
Can't init device hci0. Connection timed out(110) [root@localhost =
Bluez]#




Regards,
Keyur Desai=20
ESN 352-8467 (919-992-8467)
Cell : 214-693-0822=20
keyurde@nortelnetworks.com

=20

=20


-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Sunday, October 24, 2004 11:58 PM
To: DESAI, KEYUR [GWRTP:T830:EXCH]
Cc: BlueZ Mailing List
Subject: Re: [Bluez-users] Connection failed error (110)

Hi Keyur,

> Here is my current scenario
>=20
> =20
>=20
> Hardware: Belkin Dongle
>=20
> O.S.: Fedora Core 2 Kernel 2.6.5-1.358
>=20
> =20
>=20
> =20
>=20
> Here is the problem:
>=20
> =20
>=20
> When I do=20
>=20
> #hciconfig hci0 up The device works fine.
>=20
> =20
>=20
> However on doing a hciconfig hci0 down followed by a hciconfig hci0
> up . The dongle does not work.
>=20
> It gives an error=20
>=20
> Can=A2t init device hci0. Connection timed out (110).

what kind of dongle is this (hciconfig -a) and why don't you update to
the latest Linux kernel and BlueZ utils first?

Regards

Marcel




------_=_NextPart_001_01C4BA55.13B193DA
Content-Type: text/html;
	charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-7">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: [Bluez-users] Connection failed error (110)</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Here are the details:</FONT>
</P>

<P><FONT SIZE=3D2>I am using kernel 2.6.10 (fedora core -2)</FONT>
<BR><FONT SIZE=3D2>My hardware is Belkin Dongle</FONT>
</P>

<P><FONT SIZE=3D2>I have the latest bluez utilities and library =
files</FONT>
<BR><FONT =
SIZE=3D2>bluez-hcidump-1.12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bluez-libs-2.10&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>bluez-utils-2.10</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>[root@localhost Bluez]# hciconfig -a</FONT>
<BR><FONT SIZE=3D2>hci0:&nbsp;&nbsp; Type: USB</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD =
Address: 00:0A:3A:50:4B:4D ACL MTU: 192:8 </FONT>
<BR><FONT SIZE=3D2>SCO MTU: 64:8</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP =
RUNNING PSCAN ISCAN</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX =
bytes:77 acl:0 sco:0 events:9 errors:0</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
bytes:31 acl:0 sco:0 commands:8 errors:0</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: =
0xff 0xff 0x0f 0x00 0x00 0x00 0x00</FONT>
<BR><FONT SIZE=3D2>0x00</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet =
type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2</FONT>
<BR><FONT SIZE=3D2>HV3</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link =
policy:</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link =
mode: SLAVE ACCEPT</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: =
'BlueZ (0)'</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: =
0x000000</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service =
Classes: Unspecified</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device =
Class: Miscellaneous,</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: =
1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1</FONT>
<BR><FONT SIZE=3D2>(0x1) LMP Subver: 0x20d</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Manufacturer: Cambridge Silicon Radio (10)</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>Here is the error....</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>[root@localhost Bluez]# hciconfig hci0 up</FONT>
<BR><FONT SIZE=3D2>[root@localhost Bluez]# hciconfig hci0 down</FONT>
<BR><FONT SIZE=3D2>[root@localhost Bluez]# hciconfig hci0 up</FONT>
<BR><FONT SIZE=3D2>Can't init device hci0. Connection timed out(110) =
[root@localhost Bluez]#</FONT>
</P>
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>Regards,</FONT>
<BR><FONT SIZE=3D2>Keyur Desai </FONT>
<BR><FONT SIZE=3D2>ESN 352-8467 (919-992-8467)</FONT>
<BR><FONT SIZE=3D2>Cell : 214-693-0822 </FONT>
<BR><FONT SIZE=3D2>keyurde@nortelnetworks.com</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>] =
</FONT>
<BR><FONT SIZE=3D2>Sent: Sunday, October 24, 2004 11:58 PM</FONT>
<BR><FONT SIZE=3D2>To: DESAI, KEYUR [GWRTP:T830:EXCH]</FONT>
<BR><FONT SIZE=3D2>Cc: BlueZ Mailing List</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [Bluez-users] Connection failed error =
(110)</FONT>
</P>

<P><FONT SIZE=3D2>Hi Keyur,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Here is my current scenario</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Hardware: Belkin Dongle</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; O.S.: Fedora Core 2 Kernel 2.6.5-1.358</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Here is the problem:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; When I do </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; #hciconfig hci0 up The device works =
fine.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; However on doing a hciconfig hci0 down followed =
by a hciconfig hci0</FONT>
<BR><FONT SIZE=3D2>&gt; up . The dongle does not work.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; It gives an error </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Can=A2t init device hci0. Connection timed out =
(110).</FONT>
</P>

<P><FONT SIZE=3D2>what kind of dongle is this (hciconfig -a) and why =
don't you update to</FONT>
<BR><FONT SIZE=3D2>the latest Linux kernel and BlueZ utils =
first?</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>Marcel</FONT>
</P>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C4BA55.13B193DA--
