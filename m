Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt on acer tm 4501
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41BCEE0C.6080002@paranoici.org>
References: <41BCEE0C.6080002@paranoici.org>
Content-Type: text/plain
Message-Id: <1102925161.8750.88.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Dec 2004 09:06:01 +0100

Hi,

> i have some problem to get my bt working on my acer travelmate 4501.
> i have a button to "activate" bt, but pressing its useless (
> Unknown key pressed (translated set 2, code 0xd6 on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e056 <keycode>' to make it known )
> 
> i am using ubuntu kernel 2.6.8.1
> i have installed bluez utils and started modprobing some modules 
> (hci_usb, bfusb (bluez),rfcomm, sco, l2cap. running
> 
>   Starting bluez-utils: hcid rfcomm sdpd.
> Switching on Bluetooth input devices.
> No devices in HCI mode found
> 
> hciconfig hci0 up:
> Can't get device info: No such device
> 
> lsusb can find only my usb mouse...
> 
> dmesg out (only a small part):
> 
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f6370
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xab88, dseg 0x400
> pnp: 00:0a: ioport range 0xfe00-0xfe01 could not be reserved
> pnp: 00:0c: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:0c: ioport range 0x1000-0x105f could not be reserved
> pnp: 00:0c: ioport range 0x1060-0x107f has been reserved
> pnp: 00:0c: ioport range 0x1180-0x11bf has been reserved
> PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
> PCI: Using ACPI for IRQ routing
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 6 (level, low) -> IRQ 6
> ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
> ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
> ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
> ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
> ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI interrupt 0000:02:06.3[A] -> GSI 10 (level, low) -> IRQ 10
> Simple Boot Flag at 0x37 set to 0x1
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Initializing Cryptographic API
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
> 
> 
> so... ttys0 is bt?? (more dmesg is needed?)
> i tryed using uart loading some modules and irattach ttys0 using any. 
> hciconfig show a down inteface... and cannot be upped (timeout occurs)

what the hell has irattach to do with Bluetooth? I actually doubt that
ttyS0 is your Bluetooth devices. Normally these things are attached to
the USB bus and must be activated. Try to include the Acer ACPI module
and check for its options to activate Bluetooth.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
