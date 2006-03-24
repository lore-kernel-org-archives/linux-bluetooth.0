Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY114-DAV124F287E0911BA1EB7BD6CA6DF0@phx.gbl>
From: "kunasen" <kunasen@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <20060324040501.D6072898E8@sc8-sf-spam1.sourceforge.net>
Subject: [Bluez-devel] =?gb2312?B?tPC4tDogQmx1ZXotZGV2ZWwgZGlnZXN0LCBWb2wgMSAjMTk2MyAtIDYgbXM=?=
 =?gb2312?B?Z3M=?=
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
Date: Fri, 24 Mar 2006 16:17:02 +0800

How can I get the source code of=20
kernel 2.6.15
bluez-libs 2.25
bluez-utils 2.25
bluez-hcidump 1.29
btsco 0.41
.....

I cann't find them on bluez.org website.

Thank you.

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] =B4=FA=B1=ED
bluez-devel-request@lists.sourceforge.net
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA3=D4=C224=C8=D5 12:04
=CA=D5=BC=FE=C8=CB: bluez-devel@lists.sourceforge.net
=D6=F7=CC=E2: Bluez-devel digest, Vol 1 #1963 - 6 msgs

Send Bluez-devel mailing list submissions to
	bluez-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/bluez-devel
or, via email, send a message with subject or body 'help' to
	bluez-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	bluez-devel-admin@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-devel digest..."


Today's Topics:

   1. btsco not working with 3Com 3CREB96 and SE HBH-602 (Tom K)
   2. EVT_EXTENDED_INQUIRY_RESULT (Andreas Faerber)
   3. Re: EVT_EXTENDED_INQUIRY_RESULT (Marcel Holtmann)
   4. Re: btsco not working with 3Com 3CREB96 and SE HBH-602 (Mitja =
Pufic)
   5. Re: EVT_EXTENDED_INQUIRY_RESULT (Andreas Faerber)
   6. Re: btsco not working with 3Com 3CREB96 and SE HBH-602 (Tom K)

--__--__--

Message: 1
Date: Thu, 23 Mar 2006 11:23:08 +0000
From: Tom K <tomk@runbox.com>
To:  bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] btsco not working with 3Com 3CREB96 and SE =
HBH-602
Reply-To: bluez-devel@lists.sourceforge.net

First post here, not a developer, but I'm posting here as advised on the =

bluetooth-alsa site.

I have a 3Com 3CREB96 USB dongle and a SonyEricsson HBH-602 headset. I=20
have the following installed on the laptop:

kernel 2.6.15
bluez-libs 2.25
bluez-utils 2.25
bluez-hcidump 1.29
btsco 0.41

Bluetooth daemons are running, snd-bt-sco is loaded, hci0 is up, with=20
the voice 0x0060 setting. The devices are paired successfully. I now run =

btsco -v A1:B2:C3:D4:E5:F6, and get the following response:

btsco v0.41
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT*ECBP=3D?
recieved AT+CLIP=3D1
recieved AT+CSCS=3D"UTF-8"
recieved AT+CLAN?

In another terminal, I try aplay -B 1000000 -D plughw:Headset test.wav,=20
and the following is added in the btsco terminal:

i/o needed: connecting sco...
Can't connect SCO audio channel
: Connection refused

I shut down btsco, and after nearly 30 seconds, I hear a single beep in=20
the headset. I run btsco again as above, with the same initial response, =

and run aplay again. This time, the sound file plays through the=20
headset, and btsco shows the following:

i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D12
Sending up speaker change 12
speaker volume: 12 mic volume: 11
driver is not in use
disconnected SCO channel
RFCOMM channel lost

btsco then shuts itself down.

All the above is consistently reproducable. Also, the same responses are =

seen if arecord is used instead of aplay, except of course that a file=20
is recorded instead of played on the second attempt.

About a year ago, I had the same headset working correctly with btsco=20
and a 3Com BT PCMCIA card, which I unfortunately can no longer use.

If more info is required - hcidump, logs, etc - let me know. I am aware=20
that this is a dev list, so I will understand completely if nobody is=20
interested.

All the best
Tom K.


--__--__--

Message: 2
Date: Thu, 23 Mar 2006 14:05:14 +0100
From: Andreas Faerber <afaerber@rumms.uni-mannheim.de>
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] EVT_EXTENDED_INQUIRY_RESULT
Reply-To: bluez-devel@lists.sourceforge.net

Hello,

We've just received an HCI 2.0 dongle (Belkin/Broadcom) and I've=20
recompiled my periodic scan code (on SuSE 10.1b8 w/BlueZ 2.24) to enable =

support for EVT_EXTENDED_INQUIRY_RESULT. Unfortunately I still get the=20
"old" EVT_INQUIRY_RESULT only; I could not find an=20
OCF_EXTENDED_PERIODIC_INQUIRY command or the like so my expectation was=20
to simply get back EVT_EXTENDED_INQUIRY_RESULT from OCF_PERIODIC_INQUIRY =

now that our hardware supports it (and I include it in the filter).

Am I missing anything? Do I need to enable this feature somewhere?

We want either EVT_INQUIRY_RESULT_WITH_RSSI or=20
EVT_EXTENDED_INQUIRY_RESULT because we need to read the RSSI without=20
connecting.

Regards,

Andreas


--__--__--

Message: 3
Subject: Re: [Bluez-devel] EVT_EXTENDED_INQUIRY_RESULT
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 23 Mar 2006 14:54:20 +0100
Reply-To: bluez-devel@lists.sourceforge.net

Hi Andreas,

> We've just received an HCI 2.0 dongle (Belkin/Broadcom) and I've=20
> recompiled my periodic scan code (on SuSE 10.1b8 w/BlueZ 2.24) to =
enable=20
> support for EVT_EXTENDED_INQUIRY_RESULT. Unfortunately I still get the =

> "old" EVT_INQUIRY_RESULT only; I could not find an=20
> OCF_EXTENDED_PERIODIC_INQUIRY command or the like so my expectation =
was=20
> to simply get back EVT_EXTENDED_INQUIRY_RESULT from =
OCF_PERIODIC_INQUIRY=20
> now that our hardware supports it (and I include it in the filter).
>=20
> Am I missing anything? Do I need to enable this feature somewhere?
>=20
> We want either EVT_INQUIRY_RESULT_WITH_RSSI or=20
> EVT_EXTENDED_INQUIRY_RESULT because we need to read the RSSI without=20
> connecting.

call "hciconfig hci0 inqmode 1" first to switch the device into the
correct inquiry mode. However the extended inquiry will be only
supported by Bluetooth 2.1 (aka Lisbon) devices.

You can also check the features with "hciconfig hci0 features" if it
tells you it supports inquiry with RSSI. However in case of some
Broadcom chips, this doesn't mean anything, because they support it
anyway even if the features bit is not set.

Regards

Marcel




--__--__--

Message: 4
Date: Thu, 23 Mar 2006 16:22:56 +0100 (CET)
From: Mitja Pufic <m@section-one.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco not working with 3Com 3CREB96 and SE
HBH-602
Reply-To: bluez-devel@lists.sourceforge.net

Hello,

This is a very old dongle, with bluecore01 and confirms with bluetooth=20
1.0b specification. And as far as I know it has SCO mapped to PCM and =
not=20
HCI, so this is the reason, why your setup is not working. Check mail=20
list archive how to change this, or if it is even possible on this old=20
chip. PCMCIA version does not have this problem.

br, Mitja

On Thu, 23 Mar 2006, Tom K wrote:

> First post here, not a developer, but I'm posting here as advised on =
the
> bluetooth-alsa site.
>=20
> I have a 3Com 3CREB96 USB dongle and a SonyEricsson HBH-602 headset. I
have
> the following installed on the laptop:
>=20
> kernel 2.6.15
> bluez-libs 2.25
> bluez-utils 2.25
> bluez-hcidump 1.29
> btsco 0.41
>=20
> Bluetooth daemons are running, snd-bt-sco is loaded, hci0 is up, with =
the
> voice 0x0060 setting. The devices are paired successfully. I now run =
btsco
-v
> A1:B2:C3:D4:E5:F6, and get the following response:
>=20
> btsco v0.41
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> recieved AT*ECBP=3D?
> recieved AT+CLIP=3D1
> recieved AT+CSCS=3D"UTF-8"
> recieved AT+CLAN?
>=20
> In another terminal, I try aplay -B 1000000 -D plughw:Headset =
test.wav,
and
> the following is added in the btsco terminal:
>=20
> i/o needed: connecting sco...
> Can't connect SCO audio channel
> : Connection refused
>=20
> I shut down btsco, and after nearly 30 seconds, I hear a single beep =
in
the
> headset. I run btsco again as above, with the same initial response, =
and
run
> aplay again. This time, the sound file plays through the headset, and
btsco
> shows the following:
>=20
> i/o needed: connecting sco...
> connected SCO channel
> Done setting sco fd
> recieved AT+VGS=3D12
> Sending up speaker change 12
> speaker volume: 12 mic volume: 11
> driver is not in use
> disconnected SCO channel
> RFCOMM channel lost
>=20
> btsco then shuts itself down.
>=20
> All the above is consistently reproducable. Also, the same responses =
are
seen
> if arecord is used instead of aplay, except of course that a file is
recorded
> instead of played on the second attempt.
>=20
> About a year ago, I had the same headset working correctly with btsco =
and
a
> 3Com BT PCMCIA card, which I unfortunately can no longer use.
>=20
> If more info is required - hcidump, logs, etc - let me know. I am =
aware
that
> this is a dev list, so I will understand completely if nobody is
interested.
>=20
> All the best
> Tom K.
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting
language
> that extends applications into web and mobile media. Attend the live
webcast
> and join the prime developer group breaking into this new coding
territory!
> =
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


--__--__--

Message: 5
Date: Thu, 23 Mar 2006 16:54:04 +0100
From: Andreas Faerber <afaerber@rumms.uni-mannheim.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] EVT_EXTENDED_INQUIRY_RESULT
Reply-To: bluez-devel@lists.sourceforge.net

Hi Marcel,

>call "hciconfig hci0 inqmode 1" first to switch the device into the
>correct inquiry mode.
>
Thanks a lot, that worked!

>You can also check the features with "hciconfig hci0 features" if it
>tells you it supports inquiry with RSSI. However in case of some
>Broadcom chips, this doesn't mean anything, because they support it
>anyway even if the features bit is not set.
> =20
>
The feature is actually listed. The only weird thing I'm still tracking=20
down is that I only get inquiry results every five minutes while it did=20
work as expected with the previous dongles...

Thanks again,

Andreas


--__--__--

Message: 6
Date: Thu, 23 Mar 2006 17:25:50 +0000
From: Tom K <tomk@runbox.com>
To:  bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco not working with 3Com 3CREB96 and SE
HBH-602
Reply-To: bluez-devel@lists.sourceforge.net

Mitja Pufic wrote:
> Hello,
>
> This is a very old dongle, with bluecore01 and confirms with bluetooth =

> 1.0b specification. And as far as I know it has SCO mapped to PCM and =
not=20
> HCI, so this is the reason, why your setup is not working. Check mail=20
> list archive how to change this, or if it is even possible on this old =

> chip. PCMCIA version does not have this problem.
>
>  =20
Many thanks for your response.
It's pretty old alright, but hciconfig hci0 revision gives me

hci0:   Type: USB
        BD Address: 00:04:76:AD:12:E3 ACL MTU: 128:8 SCO MTU: 64:8
        HCI 10.3
        Chip version: BlueCore01b (ES)
        SCO mapping:  HCI

which looked promising to me. Still, if it's not the right stuff, I'll=20
hunt around for another one.



--__--__--

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
