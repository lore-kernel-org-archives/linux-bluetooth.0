Return-Path: <cyrus@holtmann.org>
Message-ID: <003c01c84945$64d21600$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
	<1198437472.8050.305.camel@aeonflux>
	<001001c84619$20f716d0$0200a8c0@jester>
	<1198493046.8050.311.camel@aeonflux>
	<000601c84639$c8ef8640$0200a8c0@jester>
	<1198556761.8050.329.camel@aeonflux>
Date: Fri, 28 Dec 2007 12:32:56 +0100
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Add 3 HCI commands / concurrent connection setup
	question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

> However you should read the radio and baseband part of the Bluetooth
> specification and then you will realize that AFH will not help you to
> solve any page issues you see. It simply doesn't work this way and
> Bluetooth is _not_ WiFi.

I have read the specs and unfortunately certainly missed the reason why it 
won't work, since AFH makes paging restricted to the provided frequency 
range (not inquiry, but paging). However if you think trying this out is a 
waste of time and won't help, I will follow you.

> We try with the next connection attempt once the radio is free again.
> And this is if no inquiry and no page attempt is running.

All of this is perfectly clear, however, there is something I don't get 
here. Why in the case I try to setup 4 connections from 4 different devices 
I still get delays (or page timeouts), as they all have their own radio. If 
it's not a radio issue, I thought about interferences (so wondering about 
AFH use). I suppose locks in the stack are anyway "per device".

You'll find hcidumps of 4 connection setup from 4 different dongles below.

Best regards,
Oli

-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.662180 < HCI Command: Create Connection (0x01|0x0005)
plen 13
    bdaddr 00:19:2D:15:FF:0E ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.665286 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:11:41.758270 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:19:2D:15:FF:0E type ACL encrypt 0x00
...
-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci1 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.663603 < HCI Command: Create Connection (0x01|0x0005)
plen 13
    bdaddr 00:17:B0:1E:54:FD ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.666283 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:11:42.779225 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:17:B0:1E:54:FD type ACL encrypt 0x00
...
-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci2 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.664980 < HCI Command: Create Connection (0x01|0x0005)
plen 13
    bdaddr 00:12:D1:65:27:7F ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.668350 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:12:02.148460 > HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:12:D1:65:27:7F type ACL encrypt 0x00
    Error: Page Timeout

-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci3 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.666608 < HCI Command: Create Connection (0x01|0x0005)
plen 13
    bdaddr 00:12:D1:6E:4C:96 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.669339 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:12:02.149466 > HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:12:D1:6E:4C:96 type ACL encrypt 0x00
    Error: Page Timeout

----------- 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
