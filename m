Return-Path: <robertw@healthhero.com>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A6C@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
   Robert Wlaschin
	 <robertw@healthhero.com>
Cc: "'bluez-devel@lists.sourceforge.net'"
	 <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
Date: Wed, 5 Oct 2005 10:32:11 -0700 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C9D2.B804BAC0"
List-ID: <bluez-devel.lists.sourceforge.net>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C9D2.B804BAC0
Content-Type: text/plain;
	charset="iso-8859-1"

Marcel,

Thanks so much for the help thus far.  Yes the rfcomm0 device is created:
This is the output from rfcomm; rfcomm0: 00:A0:96:0D:3B:80 channel 1 closed,
I have also seen it report [tty-attached] when I am attempting to
read/write/connect, but it says 'config' not 'open'

So, I saw this error message:

> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:A0:96:0D:3B:80 type ACL encrypt 0x00
    Error: Authentication Failure

So I did this: hciconfig hci0 auth, but I still got the same error, so I
followed with this: hciconfig hci0 encrypt, but I still seem to be getting
the error message.

Thanks,
Robert

--- hcidump -V -X ---

HCI sniffer - Bluetooth packet analyzer ver 1.25
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:0D:3B:80 class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:80 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:0D:3B:80
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:A0:96:0D:3B:80 key 5375351370402E9AE37B284D7DD72EDC
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:A0:96:0D:3B:80
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:A0:96:0D:3B:80 type ACL encrypt 0x00
    Error: Authentication Failure
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:0D:3B:80 class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:80 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:0D:3B:80
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:A0:96:0D:3B:80 key 5375351370402E9AE37B284D7DD72EDC
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:A0:96:0D:3B:80
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 42 bdaddr 00:A0:96:0D:3B:80 type ACL encrypt 0x00
    Error: Authentication Failure
Usage: microcom [options]
 [options] include:
    -Ddevfile       use the specified serial port device;
                    if a port is not provided, microcom
                        will try to autodetect a modem
           example: -D/dev/ttyS3
    -S              run script from script.scr (default)
    -Sscrfile       run script from scrfile

microcom provides session logging in microcom.log file
Exitcode 2 - cannot open device /dev/rfcomm0

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Tuesday, October 04, 2005 9:11 PM
To: Robert Wlaschin
Cc: 'bluez-devel@lists.sourceforge.net'
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm


Hi Robert,

> That was a good suggestion.  I've seen usage of those programs on
> various help/websites.
> 
> Due to a hardware limitations, I only have microcom available which
> seems flaky at best.  I seem to be getting the 'Exitcode 2 - cannot
> open device /dev/rfcomm0' error message.  But I have tried opening a
> standard serial connection with microcom and it does function.
> 
> The code in attest should work given the method I am using, is this
> correct?  If so I can just rewrite it to something ... a little more
> towards my purpose.

check if the /dev/rfcomm0 device node has been created and if yes, then
run "hcidump -X -V" to see why the RFCOMM channel can't be opened.

Regards

Marcel


------_=_NextPart_001_01C5C9D2.B804BAC0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: [Bluez-devel] Cannot send through serial device =
rfcomm</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Marcel,</FONT>
</P>

<P><FONT SIZE=3D2>Thanks so much for the help thus far.&nbsp; Yes the =
rfcomm0 device is created:</FONT>
<BR><FONT SIZE=3D2>This is the output from rfcomm; rfcomm0: =
00:A0:96:0D:3B:80 channel 1 closed, I have also seen it report =
[tty-attached] when I am attempting to read/write/connect, but it says =
'config' not 'open'</FONT></P>

<P><FONT SIZE=3D2>So, I saw this error message:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; HCI Event: Connect Complete (0x03) plen =
11</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; status 0x05 handle 41 bdaddr =
00:A0:96:0D:3B:80 type ACL encrypt 0x00</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Error: Authentication =
Failure</FONT>
</P>

<P><FONT SIZE=3D2>So I did this: hciconfig hci0 auth, but I still got =
the same error, so I followed with this: hciconfig hci0 encrypt, but I =
still seem to be getting the error message.</FONT></P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>Robert</FONT>
</P>

<P><FONT SIZE=3D2>--- hcidump -V -X ---</FONT>
</P>

<P><FONT SIZE=3D2>HCI sniffer - Bluetooth packet analyzer ver =
1.25</FONT>
<BR><FONT SIZE=3D2>device: hci0 snap_len: 1028 filter: =
0xffffffff</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Connect Request (0x04) plen =
10</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80 class =
0x000000 type ACL</FONT>
<BR><FONT SIZE=3D2>&lt; HCI Command: Accept Connection Request =
(0x01|0x0009) plen 7</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80 role =
0x01</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Role: Slave</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Command Status (0x0f) plen 4</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Accept Connection Request =
(0x01|0x0009) status 0x00 ncmd 1</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Link Key Request (0x17) plen =
6</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80</FONT>
<BR><FONT SIZE=3D2>&lt; HCI Command: Link Key Request Reply =
(0x01|0x000b) plen 22</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80 key =
5375351370402E9AE37B284D7DD72EDC</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Command Complete (0x0e) plen =
10</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Link Key Request Reply =
(0x01|0x000b) ncmd 1</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr =
00:A0:96:0D:3B:80</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Connect Complete (0x03) plen =
11</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; status 0x05 handle 41 bdaddr =
00:A0:96:0D:3B:80 type ACL encrypt 0x00</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Error: Authentication =
Failure</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Connect Request (0x04) plen =
10</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80 class =
0x000000 type ACL</FONT>
<BR><FONT SIZE=3D2>&lt; HCI Command: Accept Connection Request =
(0x01|0x0009) plen 7</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80 role =
0x01</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Role: Slave</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Command Status (0x0f) plen 4</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Accept Connection Request =
(0x01|0x0009) status 0x00 ncmd 1</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Link Key Request (0x17) plen =
6</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80</FONT>
<BR><FONT SIZE=3D2>&lt; HCI Command: Link Key Request Reply =
(0x01|0x000b) plen 22</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; bdaddr 00:A0:96:0D:3B:80 key =
5375351370402E9AE37B284D7DD72EDC</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Command Complete (0x0e) plen =
10</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Link Key Request Reply =
(0x01|0x000b) ncmd 1</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr =
00:A0:96:0D:3B:80</FONT>
<BR><FONT SIZE=3D2>&gt; HCI Event: Connect Complete (0x03) plen =
11</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; status 0x05 handle 42 bdaddr =
00:A0:96:0D:3B:80 type ACL encrypt 0x00</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; Error: Authentication =
Failure</FONT>
<BR><FONT SIZE=3D2>Usage: microcom [options]</FONT>
<BR><FONT SIZE=3D2>&nbsp;[options] include:</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; =
-Ddevfile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use the specified serial =
port device;</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if a port is not =
provided, microcom</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; will try to autodetect a modem</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
example: -D/dev/ttyS3</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; =
-S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; run script from script.scr (default)</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; =
-Sscrfile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; run script from =
scrfile</FONT>
</P>

<P><FONT SIZE=3D2>microcom provides session logging in microcom.log =
file</FONT>
<BR><FONT SIZE=3D2>Exitcode 2 - cannot open device /dev/rfcomm0</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Marcel Holtmann [<A =
HREF=3D"mailto:marcel@holtmann.org">mailto:marcel@holtmann.org</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Tuesday, October 04, 2005 9:11 PM</FONT>
<BR><FONT SIZE=3D2>To: Robert Wlaschin</FONT>
<BR><FONT SIZE=3D2>Cc: 'bluez-devel@lists.sourceforge.net'</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Bluez-devel] Cannot send through =
serial device rfcomm</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi Robert,</FONT>
</P>

<P><FONT SIZE=3D2>&gt; That was a good suggestion.&nbsp; I've seen =
usage of those programs on</FONT>
<BR><FONT SIZE=3D2>&gt; various help/websites.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Due to a hardware limitations, I only have =
microcom available which</FONT>
<BR><FONT SIZE=3D2>&gt; seems flaky at best.&nbsp; I seem to be getting =
the 'Exitcode 2 - cannot</FONT>
<BR><FONT SIZE=3D2>&gt; open device /dev/rfcomm0' error message.&nbsp; =
But I have tried opening a</FONT>
<BR><FONT SIZE=3D2>&gt; standard serial connection with microcom and it =
does function.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; The code in attest should work given the method =
I am using, is this</FONT>
<BR><FONT SIZE=3D2>&gt; correct?&nbsp; If so I can just rewrite it to =
something ... a little more</FONT>
<BR><FONT SIZE=3D2>&gt; towards my purpose.</FONT>
</P>

<P><FONT SIZE=3D2>check if the /dev/rfcomm0 device node has been =
created and if yes, then</FONT>
<BR><FONT SIZE=3D2>run &quot;hcidump -X -V&quot; to see why the RFCOMM =
channel can't be opened.</FONT>
</P>

<P><FONT SIZE=3D2>Regards</FONT>
</P>

<P><FONT SIZE=3D2>Marcel</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5C9D2.B804BAC0--
