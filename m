Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 18:21:35 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060731182135.488b017c@localhost.localdomain>
In-Reply-To: <20060728133933.034e4e13@localhost.localdomain>
References: <E65CD2CAB74C80498703D6EF7624BB4C023974A7@zmaex.zma.zoran.com>
	<1154051769.7650.20.camel@localhost>
	<20060728123724.47e76a7f@localhost.localdomain>
	<20060728133933.034e4e13@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Hci Reset Problem - Caused by USB Hub
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

further tests proofed that the problem described here are caused by
the USB-hub used. It seems to be unable to handle the load and just
breaks down. The same operations are working on other (higher quality) hubs.

Watch out for lines like

    usb 1-1: USB disconnect, address 29

in syslog and/or dmesg to check if your problem is similar. Make sure
not to mess with real physical disconnects which produce the same log
output.

I guess the HCI_RESET is issued by bluez after the device comes back on.

Greetings

Andy



On Fri, 28 Jul 2006 13:39:33 +0200
Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com> wrote:

> Hi,
> 
> I have evidence that this may be caused by the usb-part of these devices
> (B-Speech, Model: DataSpeed). Other devices (Level One, MDU-0025USB)
> don't show this problem on first sight. Both use BlueCore04, HCI 19.2.
> 
> The tests where run using USB 2 Hub with 4 bt-devices pumping obex
> traffic at max possible speed and this Host Controller:
> 
> 00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1e) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Flags: bus master, medium devsel, latency 32, IRQ 12
>         I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
> 
> ## dmesg ##
> hub 1-1:1.0: port 2 disabled by hub (EMI?), re-enabling...
> usb 1-1.2: USB disconnect, address 31
> usb 1-1.2: new full speed USB device using address 34
> hub 1-1:1.0: port 3 disabled by hub (EMI?), re-enabling...
> usb 1-1.3: USB disconnect, address 32
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
> hub 1-1:1.0: cannot disable port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: cannot reset port 3 (err = -71)
> hub 1-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
> hub 1-1:1.0: cannot disable port 3 (err = -71)
> hub 1-1:1.0: cannot disable port 3 (err = -71)
> hub 1-0:1.0: port 1 disabled by hub (EMI?), re-enabling...
> usb 1-1: USB disconnect, address 29
> usb 1-1.1: USB disconnect, address 30
> usb 1-1.2: USB disconnect, address 34
> usb 1-1.4: USB disconnect, address 33
> usb 1-1: new full speed USB device using address 37
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 4 ports detected
> usb 1-1.1: new full speed USB device using address 38
> 
> Do you want one of these for your "nightmare chamber" marcel? ;)
> 
> Lan, can you check your dmesg/syslog for usb related problems please.
> 
> Greetings
> 
> Andy
> 
> On Fri, 28 Jul 2006 12:37:24 +0200
> Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com> wrote:
> 
> > Hi,
> > 
> > I guess I'm approaching the same or at least a related problem. I don't
> > feel like getting close the root of the problem yet but maybe the
> > attached output helps marcel or someone else to see clearer.
> > 
> > I can't pretend that the reset in the attached log is not beeing sent from a
> > user-application but i felt like the oops is worth posting.
> > 
> > Kernel used is 2.6.8.1 but i know that the thing happens also with 2.6.17.6.
> > 
> > Hardware used:
> > 
> > hci1:   Type: USB
> >         BD Address: 00:02:5B:00:BF:66 ACL MTU: 384:8 SCO MTU: 64:8
> >         HCI 19.2
> >         Chip version: BlueCore4-ROM
> >         Max key size: 128 bit
> >         SCO mapping:  HCI
> >         BD Address: 00:02:5B:00:BF:66 ACL MTU: 384:8 SCO MTU: 64:8
> >         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
> >                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
> >                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
> >                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
> >                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
> >                 <power control> <transparent SCO> <broadcast encrypt> 
> >                 <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
> >                 <interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
> >                 <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
> >                 <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
> >                 <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
> >                 <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features> 
> > 
> > I don't expect any feedback on this, I'll post in this thread if I find anything..
> > 
> > Greetings
> > 
> > Andy
> > 
> > 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
