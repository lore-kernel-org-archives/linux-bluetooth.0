Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 18 Jul 2006 16:28:27 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060718142827.GP10190@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost>
	<20060711133956.GD13809@suse.de>
	<1152625591.15028.35.camel@localhost>
	<20060711154501.GE13809@suse.de>
	<1152885278.25660.27.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152885278.25660.27.camel@localhost>
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1
	SCO	packet	for	unknown connection handle 0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Fri, Jul 14, 2006 at 03:54:38PM +0200, Marcel Holtmann wrote:
> Hi Stefan,
> =

> > > actually with isco=3D1 the SCO transfers are still on, but limited to
> > > 8-bit instead of 16-bit with isoc=3D2. So if you have isoc=3D2 it fil=
ls up
> > > your syslog. Can you extract some of these SCO packets with hcidump f=
or
> > > me.
 =

> > root@strolchi:~# hcidump -i hci1
> > HCI sniffer - Bluetooth packet analyzer ver 1.29
> > device: hci1 snap_len: 1028 filter: 0xffffffff
> > > SCO data: handle 0 dlen 0
> > > SCO data: handle 0 dlen 0

> > This happens immediately after plugging the thing in, there is no pairi=
ng
> > or any application involved that might trigger this AFAICT.
> =

> Another RTX based dongle with RTX chip (0400:0807) has already been
> blacklisted by me. I have no idea, why they can't get this right.
 =

> It would be interesting if this will work with isoc=3D1 and a 16-bit PCM
> stream. You should really try some stuff from the btsco package.

I did this and could not get it to work at all, means it did not play any s=
ound
with btsco and aplay to a Belkin F8T060xHDST headset. I got some "pops" on =
the
earpiece when opening the device, but it did not play back anything.

The headset worked with a Belkin F8T013 after applying the SCO MTU patch and
with a Gigabyte GN-BTD02 out of the box. The SCO MTU patch did not help for
the Abe dongle.

I guess this piece of silicon is just plain crap :-)

Details for your blacklisting pleasure:
cf51:~ # lsusb -s 1:19
Bus 001 Device 019: ID 0400:080a National Semiconductor Corp.
cf51:~ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:78:31:11:0A ACL MTU: 339:4 SCO MTU: 64:9
        UP RUNNING PSCAN ISCAN
        RX bytes:1108 acl:0 sco:0 events:63 errors:0
        TX bytes:348 acl:0 sco:0 commands:24 errors:0
        Features: 0xff 0xff 0x81 0x00 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ cf51 (0)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x222 LMP Ver: 1.2 (0x2) LMP Subver: 0x=
222
        Manufacturer: RTX Telecom A/S (21)
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
