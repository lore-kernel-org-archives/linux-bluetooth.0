Return-Path: <Peter.K.Martin@t-online.de>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>,
   "'Marcel Holtmann'" <marcel@holtmann.org>
Subject: Again dund
Date: Wed, 3 Nov 2004 16:37:50 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAHto2ynyVvEq9bHwqgPtPJQEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C4C1C3.7B6E5BB0"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C4C1C3.7B6E5BB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
I tried to start hcid by typing it at the command-line, but I don't know =
how
to control if this daemon runs.
=20
Hcidump -x gives nearly no response, only the version-no
=20
Some other informations, but I don't know how to step further in oredr =
to
get the BT connection
=20
Linux-Notebook:~ # hcitool scan

Scanning ...

        00:0B:CE:00:01:8F       Bluetooth-Modul

Linux-Notebook:~ # hciconfig

hci0:   Type: USB

        BD Address: 00:03:7A:08:54:80 ACL MTU: 192:8  SCO MTU: 64:8

        UP RUNNING PSCAN ISCAN

        RX bytes:676 acl:0 sco:0 events:22 errors:0

        TX bytes:334 acl:0 sco:0 commands:16 errors:0

=20

Linux-Notebook:~ # hciconfig hci0 up

Linux-Notebook:~ # hciconfig -a

hci0:   Type: USB

        BD Address: 00:03:7A:08:54:80 ACL MTU: 192:8  SCO MTU: 64:8

        UP RUNNING PSCAN ISCAN

        RX bytes:676 acl:0 sco:0 events:22 errors:0

        TX bytes:334 acl:0 sco:0 commands:16 errors:0

        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00

        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

        Link policy: RSWITCH HOLD SNIFF PARK

        Link mode: SLAVE ACCEPT

        Name: 'BlueZ (0)'

        Class: 0x000100

        Service Classes: Unspecified

        Device Class: Computer, Uncategorized

        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d

        Manufacturer: Cambridge Silicon Radio (10)

=20

=20

Linux-Notebook:~ # hcitool scan

Scanning ...

        00:0B:CE:00:01:8F       Bluetooth-Modul

Linux-Notebook:~ # hcitool info 00:0B:CE:00:01:8F

Requesting information ...

        BD Address:  00:0B:CE:00:01:8F

        Device Name: Bluetooth-Modul

        LMP Version: 1.1 (0x1) LMP Subversion: 0x175

        Manufacturer: Cambridge Silicon Radio (10)

        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00

                <3-slot packets> <5-slot packets> <encryption> <slot =
offset>

                <timing accuracy> <role switch> <hold mode> <sniff mode>

                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>

                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging =
scheme>

                <power control> <transparent SCO>

Linux-Notebook:~ # rfcomm show

Linux-Notebook:~ # rfcomm bind 0 00:0B:CE:00:01:8F 1

Linux-Notebook:~ # rfcomm show

rfcomm0: 00:0B:CE:00:01:8F channel 1 clean

Linux-Notebook:~ # rfcomm release 0

Linux-Notebook:~ # rfcomm show

Linux-Notebook:~ # rfcomm connect 0 00:0B:CE:00:01:8F 1

Can't connect RFCOMM socket: Connection refused

=20

=20

Linux-Notebook:~ # sdptool browse 00:0B:CE:00:01:8F

Failed to connect to SDP server on 00:0B:CE:00:01:8F: Connection refused

=20

Marcel, please be so kind to help me and give me some more ideas.

=20

In the meantime I tried to change to kernel-version 2.6.8.1 --> the only
result was a KERNEL PANIC

I have a SuSE 9.1 Distri and now I met the wall, so I remove to the =
running
kernel

=20

Thanks for help on BT

Peter


------=_NextPart_000_0010_01C4C1C3.7B6E5BB0
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
<DIV><SPAN class=3D204432215-03112004><FONT face=3DArial>Hi=20
Marcel,</FONT></SPAN></DIV>
<DIV><SPAN class=3D204432215-03112004><FONT face=3DArial>I tried to =
start hcid by=20
typing it at the command-line, but I don't know how to control if this =
daemon=20
runs.</FONT></SPAN></DIV>
<DIV><SPAN class=3D204432215-03112004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D204432215-03112004><FONT face=3DArial>Hcidump -x =
gives nearly no=20
response, only the version-no</FONT></SPAN></DIV>
<DIV><SPAN class=3D204432215-03112004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D204432215-03112004><FONT face=3DArial>Some other =
informations,=20
but I don't know how to step further in oredr to get the BT=20
connection</FONT></SPAN></DIV>
<DIV><SPAN class=3D204432215-03112004><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D204432215-03112004>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # hcitool =
scan<?xml:namespace=20
prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Scanning ...<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>00:0B:CE:</SPAN><?xml:namespace prefix =3D st1 ns =3D=20
"urn:schemas-microsoft-com:office:smarttags" /><st1:time Hour=3D"0"=20
Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Bluetooth-Modul<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ #=20
hciconfig<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">hci0:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Type: =
USB<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>BD=20
Address: </SPAN><st1:time Hour=3D"0" Minute=3D"3"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:03</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:7A:08:54:80 ACL MTU: 192:8<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>SCO MTU: =
64:8<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>UP RUNNING PSCAN=20
ISCAN<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>RX=20
bytes:676 acl:0 sco:0 events:22 errors:0<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>TX=20
bytes:334 acl:0 sco:0 commands:16 errors:0<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # hciconfig hci0=20
up<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # hciconfig=20
-a<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">hci0:<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp; </SPAN>Type: =
USB<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>BD=20
Address: </SPAN><st1:time Hour=3D"0" Minute=3D"3"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:03</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:7A:08:54:80 ACL MTU: 192:8<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>SCO MTU: =
64:8<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>UP=20
RUNNING PSCAN ISCAN<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>RX=20
bytes:676 acl:0 sco:0 events:22 errors:0<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>TX=20
bytes:334 acl:0 sco:0 commands:16 errors:0<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 =
0x00<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN><SPAN lang=3DEN-GB style=3D"mso-ansi-language: EN-GB">Link =
policy: RSWITCH=20
HOLD SNIFF PARK<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>Link=20
mode: SLAVE ACCEPT<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Name: 'BlueZ (0)'<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Class: 0x000100<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Service Classes: Unspecified<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Device Class: Computer, Uncategorized<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>HCI=20
Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:=20
0x20d<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Manufacturer: Cambridge Silicon Radio (10)</SPAN></P><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # hcitool=20
scan<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Scanning ...<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>00:0B:CE:</SPAN><st1:time Hour=3D"0" Minute=3D"1"><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Bluetooth-Modul<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # hcitool info=20
00:0B:CE:</SPAN><st1:time Hour=3D"0" Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Requesting information=20
...<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>BD=20
Address:<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>00:0B:CE:</SPAN><st1:time=20
Hour=3D"0" Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Device Name: Bluetooth-Modul<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</SPAN>LMP=20
Version: 1.1 (0x1) LMP Subversion: 0x175<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Manufacturer: </SPAN><st1:City><st1:place><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: =
EN-GB">Cambridge</SPAN></st1:place></st1:City><SPAN=20
lang=3DEN-GB style=3D"mso-ansi-language: EN-GB"> Silicon Radio=20
(10)<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 =
0x00<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; =
&lt;slot=20
offset&gt;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; =
&lt;sniff=20
mode&gt;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>&lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO =
link&gt;=20
&lt;HV2 packets&gt;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; =
&lt;CVSD&gt;=20
&lt;paging scheme&gt;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><SPAN=20
style=3D"mso-spacerun: =
yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>&lt;power control&gt; &lt;transparent =
SCO&gt;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # rfcomm=20
show<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # rfcomm bind 0=20
00:0B:CE:</SPAN><st1:time Hour=3D"0" Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F 1<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # rfcomm=20
show<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">rfcomm0: 00:0B:CE:</SPAN><st1:time =
Hour=3D"0"=20
Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F channel 1 =
clean<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # rfcomm release=20
0<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # rfcomm=20
show<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Linux-Notebook:~ # rfcomm connect 0=20
00:0B:CE:</SPAN><st1:time Hour=3D"0" Minute=3D"1"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">00:01</SPAN></st1:time><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">:8F 1<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">Can't connect RFCOMM socket: =
Connection=20
refused<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT =
face=3DArial=20
size=3D2></FONT></o:p></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt">Linux-Notebook:~ # =
sdptool browse=20
00:0B:CE:00:01:8F</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt">Failed to connect to =
SDP server=20
on 00:0B:CE:00:01:8F: Connection refused</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT face=3DArial>Marcel, please be so kind =
to help me=20
and give me some more ideas.</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT face=3DArial></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT face=3DArial>In the meantime I tried to =
change to=20
kernel-version 2.6.8.1 --&gt; the only result was a KERNEL=20
PANIC</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT face=3DArial>I have a SuSE 9.1 Distri =
and now I met=20
the wall, so I remove to the running kernel</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT face=3DArial></FONT></SPAN>&nbsp;</P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT face=3DArial>Thanks for help on=20
BT</FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN=20
class=3D204432215-03112004><FONT=20
face=3DArial>Peter</FONT></SPAN></o:p></SPAN></P></SPAN></DIV></BODY></HT=
ML>

------=_NextPart_000_0010_01C4C1C3.7B6E5BB0--
