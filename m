Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sco links
References: <4045E93F.4040900@soft.uni-linz.ac.at> <4045F5AF.2000107@superbug.demon.co.uk> <200403031717.06139.bluez-devel@schaettgen.de>
In-Reply-To: <200403031717.06139.bluez-devel@schaettgen.de>
MIME-Version: 1.0
Cc: Simon Vogl <vogl@soft.uni-linz.ac.at>,
   James Courtier-Dutton <James@superbug.demon.co.uk>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403031753.25894.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 3 Mar 2004 17:53:25 +0100

On Wednesday 03 March 2004 17:17, Fred Sch=E4ttgen wrote:
> I have also noticed that problem. When I just tried with hstest, 2 out of=
 5
> tries were noise, the rest was perfect.
> I don't think is has anything to do with interrupts, because the the
> problem lasts for the whole duration of the connection or it doesn't appe=
ar
> at all. Also could I work around that problem somewhat in an own
> application by guessing the byte order of the 16-bit audio samples. So I
> also think that there is something wrong with some offset.
>
> Btw. I'm currently running 2.4.24, so maybe this has been fixed in 2.4.25.
> When comparing the ouput of scotest with that of hcidump, it looks like it
> is not the same every time... with scotest and hcidump running on the same
> machine, shouldn't the SCO data that's displayed by hcidump be exactly the
> same as the output of hstest?

I've noticed two things when comparing the hcidumps and the output of hstes=
t:
The first packet that is received (as displayed by hcidump) has got a=20
different handle than the following packets - most certainly the one of the=
=20
previous SCO connection. This first packet doesn't appear in the output of=
=20
hstest, so it seems that BlueZ is ignoring that packet, which seems to be=20
perfectly right.

The following packets then seem in fact to be shifted by one byte:
 1078328725.638104 > SCO data: handle 0x003d dlen 48   <--- different handl=
e!
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
    00 00 00 00 00 00 00 00 00 00 00 FF FF 00 00 00 00 00 00 FF=20
    FF FF FF 00 00 FF FF FF=20
1078328725.638106 > SCO data: handle 0x003a dlen 48
    FF FF FF 00 00 FF FF FF FF FF FF 00 00 FF FF FF FF 00 00 00=20
    00 FF FF FF FF 00 00 FF FF FF FF FF FF 00 00 FF FF FF FF FF=20
    FF 00 00 FF FF FF FF 00=20
1078328725.648104 > SCO data: handle 0x003a dlen 48
    00 00 00 FF FF FF FF 00 00 FF FF FF FF FF FF 00 00 FF FF FF=20
    FF FF FF 00 00 FF FF FF FF 00 00 00 00 FF FF FF FF 00 00 FF=20
    FF FF FF FF FF 00 00 FF=20

It seems to be the same as the data received by hstest, except for the firs=
t=20
packet, which seems to be discarded because of the different handle. So thi=
s=20
is certainly a problem with the Bluetooth dongle. Or is there still a chanc=
e=20
for BlueZ to get it wrong?
Mine is a Conceptronic.. uhm.. CBT100U(?).

$ sudo hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:10:60:A4:AC:15 ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x=
20d
        Manufacturer: Cambridge Silicon Radio (10)
$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:60:A4:AC:15 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

greetings
=46red


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
