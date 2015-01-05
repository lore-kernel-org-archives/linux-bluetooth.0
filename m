Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Keeping hci interface powered
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <m3zj9wkfsw.fsf@carbon.jhcloos.org>
Date: Mon, 5 Jan 2015 15:29:03 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FFFB52BA-6CC2-4E9E-ACA3-C3D2099BAA9B@holtmann.org>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org> <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org> <m361cklxwo.fsf@carbon.jhcloos.org> <C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org> <m3zj9wkfsw.fsf@carbon.jhcloos.org>
To: James Cloos <cloos@jhcloos.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

> MH> this looks like a recent kernel
> 
> Yeah.  Linus' master at tag v3.18.
> 
> MH> since it cleanly handles the page scan. However Page Scan enabled
> MH> means that you are again connectable. So once the keyboard
> MH> disconnects, the kernel will accept new connections.
> 
> OK.  In retrospect, it is possible that I had suspended to ram before
> the times when, in bluetoothctl, I needed power on before connect worked.
> 
>>> As you can see, there are a couple of Connection refused - security
>>> block errors.  Is there a permission issue which I miss?
> 
> MH> So it is clearly that the actual connection attempt from the keyboard
> MH> arrives and is allowed to continue by the lower layers. However when
> MH> opening the L2CAP channels from the HID control and interrupt
> MH> endpoints, it refuses to let you connect.
> 
> MH> Can you check /sys/kernel/debug/bluetooth/hci0/link_keys that you
> MH> indeed have the keys available.
> 
> link_keys has the line:
> 
>  90:7f:xx:xx:xx:xx 4 eaxxxxxxxxxxxxxxxxxxxxxxxxxxxx1e 0

this is an unauthenticated link key from SSP. Surprising to me that you do not have an authenticated link key. That is odd.

Can you capture a pairing procedure with your keyboard with btmon? Then I can tell what is actually going on between these two devices.

> MH> However I have the fear that your keyboard is violating the Bluetooth
> MH> spec. Please check /sys/kernel/debug/bluetooth/hci0/features or btmgmt
> MH> info. I assume your local controller supports Secure Simple Pairing
> MH> (every 2.1 or later controller does) and your keyboard does as well.
> 
> ,----< debug/bluetooth/hci0/features >
> |  0: 0xff 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
> |  1: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> | LE: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> `----

The features page 1 should list at least 0x01 to indicate Secure Simple Pairing support. Can you run hciconfig hci0 features and btmgmt info to check this. Make sure the controller is powered on. The page 1 changes when powered on. If it does not reflect in debugfs, then we have a bug in debugfs.

> MH> What this means is that the initiator device (in this case your
> MH> keyboard) has to enable encryption. And BlueZ refuses the L2CAP
> MH> connection if the ACL link is not encrypted (as mandated by the spec).
> 
> OK.  So it seems that the keyboard is OK with encryption if the box
> intitiates, but not when it (the keyboard) initiates?

That is the whole point behind Secure Simple Pairing. The initiator of the connection is responsible for encrypting the link. And the acceptor is required to reject the connection if the link is not encrypted.

So when BlueZ initiates the connection, we of course encrypt the link first. Seems the keyboard does not do that.

> MH> Can you run a hcitool info <bdaddr> against your keyboard and see
> MH> who is the chip/module manufacturer on that keyboard.
> 
> Requesting information ...
> 	BD Address:  90:7f:61:xx:xx:xx
> 	OUI Company: Chicony Electronics Co., Ltd. (90-7F-61)
> 	Device Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
> 	LMP Version: 3.0 (0x5) LMP Subversion: 0x2211
> 	Manufacturer: Broadcom Corporation (15)
> 	Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
> 		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
> 		<timing accuracy> <role switch> <sniff mode> <RSSI> 
> 		<channel quality> <paging scheme> <power control> 
> 		<broadcast encrypt> <enhanced iscan> <interlaced iscan> 
> 		<interlaced pscan> <inquiry with RSSI> <AFH cap. slave> 
> 		<AFH class. slave> <sniff subrating> <pause encryption> 
> 		<AFH cap. master> <AFH class. master> <extended inquiry> 
> 		<simple pairing> <encapsulated PDU> <non-flush flag> <LSTO> 
> 		<inquiry TX power> <EPC> <extended features> 

This is odd. It should show also features page 1. Run btmon while executing this command and I can tell you what is going on.

> MH> The LegacyPairing: no is not a 100% indication, but I assume your
> MH> keyboard is actually a Bluetooth 2.1 keyboard with Secure Simple
> MH> Pairing.
> 
> MH> Do you have an exact model number or link? We might have to buy one
> MH> of these keyboards.
> 
> Lenovo's pages are:
> 
> http://shop.lenovo.com/us/en/itemdetails/0B47189/460/60AC6A0372B14F5BA7B12F1FF88E33C7
> http://support.lenovo.com/en/documents/pd026744
> 
> I got that one to support my trackpoint addiction. :^/
> 
> Are there any good tech specs for bt available w/o cost?

The Bluetooth specs are available for fee. Just go to bluetooth.org.

Regards

Marcel

