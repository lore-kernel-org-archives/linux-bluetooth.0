Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4523113E.4000608@vasmac.com>
References: <4521DCC4.6090705@vasmac.com>
	<e1effdeb0610030954o50ef2d6elf25e77e3a85737ac@mail.gmail.com>
	<e1effdeb0610031048i3e290d5cu59f3d8670627d8b2@mail.gmail.com>
	<4523113E.4000608@vasmac.com>
Date: Wed, 04 Oct 2006 10:26:23 +0200
Message-Id: <1159950383.1601.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Error: Authentication Failure
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jose,

> >>> I've run into authentication problems doing the following:
> >>>
> >>> 1. Pair device (say headset) with USB Bluetooth dongle on Linux with Bluez.
> >>> 2. Disconnect dongle and insert on Windows. Windows will ask for
> >>>     the key.
> >>> 3. Disconnect device from Windows and put back on Linux.
> >>>     Linux is unable to connect to the device.
> >>>
> >>> Here's a trace for step 3:
> >>>
> >>> HCI sniffer - Bluetooth packet analyzer ver 1.32
> >>> < HCI Command: Create Connection (0x01|0x0005) plen 13
> >>>     bdaddr 00:14:CF:00:A7:76 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> >>>  > HCI Event: Command Status (0x0f) plen 4
> >>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> >>>  > HCI Event: Link Key Request (0x17) plen 6
> >>>     bdaddr 00:14:CF:00:A7:76
> >>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> >>>     bdaddr 00:14:CF:00:A7:76 key 3FECD3A6AB67EA063B3E78CCB155CBC1
> >>>  > HCI Event: Command Complete (0x0e) plen 10
> >>>     Link Key Request Reply (0x01|0x000b) ncmd 1
> >>>     status 0x00 bdaddr 00:14:CF:00:A7:76
> >>>  > HCI Event: Connect Complete (0x03) plen 11
> >>>     status 0x05 handle 42 bdaddr 00:14:CF:00:A7:76 type ACL encrypt 0x00
> >>>     Error: Authentication Failure
> >>> < HCI Command: Create Connection (0x01|0x0005) plen 13
> >>>     bdaddr 00:0C:55:06:CE:46 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> >>>  > HCI Event: Command Status (0x0f) plen 4
> >>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> >>>  > HCI Event: Link Key Request (0x17) plen 6
> >>>     bdaddr 00:0C:55:06:CE:46
> >>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> >>>     bdaddr 00:0C:55:06:CE:46 key 843E102AA026008F44FC7A2D5DDE0306
> >>>  > HCI Event: Command Complete (0x0e) plen 10
> >>>     Link Key Request Reply (0x01|0x000b) ncmd 1
> >>>     status 0x00 bdaddr 00:0C:55:06:CE:46
> >>>  > HCI Event: Connect Complete (0x03) plen 11
> >>>     status 0x05 handle 42 bdaddr 00:0C:55:06:CE:46 type ACL encrypt 0x00
> >>>     Error: Authentication Failure
> >>>
> >>> The problem is that hcid contains a cached key that is no longer valid.
> >>> Once it gets the first authentication failure it should discard that
> >>> and ask the user for a new pin (i.e. invoke the passkey agent) but it
> >>> doesn't do that. I've tested with bluez-utils-3.7.
> >>
> >> Good catch! if there is an invalid cached key the client must call
> >> RemoveBonding to remove the invalid entry. I will check with Marcel if
> >> it is possible remove the key automatically on this situation without
> >> insert a complex code. I am not sure, but I think some implementations
> >> drop the connection automatically when the pairing fails. Consequently
> >> ask a new PIN automatically will be more complex.
> >
> > Could you explain exactly how do you reproduce this issue?
> > The hcidump is not matching with our description, the connect bdaddr
> > and the link key are different. They should to be the same in the
> > second attempt. And when you disconnect the dongle the hcidump exit.
> >
> It's pretty easy to reproduce. I've tried with two USB dongles
> (CSR & Broadcom) and different headsets. Connect a device
> on Linux, then take the device and dongle and connect on
> Windows; when you go back with both to Linux you get this
> problem.
> 
> You are right that one can remove the bonding manually but
> this is not obvious to the uninitiated and it requires a manual
> step. Plus, the message presented to the application is
> typically "Record not found" if the first connection is an SDP
> lookup.
> 
> Perhaps in security.c in utils/hcid, the routine conn_complete
> should delete the cached entry if there's an error.

this is not an option, because it will be a security risk. We have to
keep the old key until we actually generated a new one or someone
deleted the old one. The only think that is possible it too improve the
error message.

These are also known errors and you can even switch BlueZ into a pairing
once mode. This is because device should implement a pairing mode. That
means that will never accept a pairing if they are not in that mode. So
if the link key is a wrong one, it simply rejects the connection instead
of starting a new pairing process.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
