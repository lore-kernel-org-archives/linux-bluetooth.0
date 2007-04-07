Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <78e398b30704070900u540b45afra1583d9802ed47d8@mail.gmail.com>
Date: Sat, 7 Apr 2007 18:00:42 +0200
From: "Doc Nielsen" <docnielsen@gmail.com>
To: bluez-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] bug doing bootup while attaching keyboard to hid-
	kernel 2.6.20.6 amd64
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

formatted as requested in reporting-bugs.html on the kernel website.


1. bug doing bootup while attaching keyboard to hid

2. using the debian supplied vmlinuz-2.6.18-4-amd64, og my own 2.6.20.
this bug does not occur.
I just compiled kernel 2.6.20.6, with full hid, full usb, full bt
support, both as modules and as in-kernel, and the bug persists either
way
When the modules hci_usb, hci_vhci, hci_uart get loaded, the kernel
bugs when i try to attach my usb bluetooth mouse and keyboard reciever
to hid.

hidd --connect 00:07:61:67:C5:00 (works fine)
hid2hci (this causes the bug)

3. modules kernel hid usb bluetooth

4. Linux version 2.6.20.6 (root@doc) (gcc version 4.1.2 20061115 (prerelease)
(Debian 4.1.1-21)) #1 SMP Sat Apr 7 14:38:19 CEST 2007

5. (dmesg dump)usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:13.3: EHCI Host Controller
ehci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.3: debug port 1
ehci_hcd 0000:00:13.3: irq 23, io mem 0xdbfef800
ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 17, io mem 0xdbfee000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usb 1-5: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 18, io mem 0xdbfed000
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 1-5: configuration #1 chosen from 1 choice
hub 1-5:1.0: USB hub found
hub 1-5:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 19, io mem 0xdbfec000
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
gameport: EMU10K1 is pci0000:05:0c.1/gameport0, io 0xc800, speed 926kHz
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 20 (level, low) -> IRQ 20
eth0: ULi M5263 at pci0000:00:12.0, 00:16:17:91:54:e4, irq 20.
ali1535_smbus 0000:00:15.1: ALI1535_smb region uninitialized - upgrade BIOS?
ali1535_smbus 0000:00:15.1: ALI1535 not detected, module not inserted.
ali15x3_smbus 0000:00:15.1: ALI15X3_smb region uninitialized - upgrade
BIOS or use force_addr=0xaddr
ali15x3_smbus 0000:00:15.1: ALI15X3 not detected, module not inserted.
ACPI: PCI Interrupt 0000:00:14.0[C] -> GSI 22 (level, low) -> IRQ 22
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ACPI: PCI Interrupt 0000:05:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
usb 3-3: new full speed USB device using ohci_hcd and address 2
usb 3-3: configuration #1 chosen from 1 choice
hub 3-3:1.0: USB hub found
hub 3-3:1.0: 3 ports detected
usb 1-5.2: new low speed USB device using ehci_hcd and address 5
usb 1-5.2: configuration #1 chosen from 1 choice
usb 1-5.3: new full speed USB device using ehci_hcd and address 6
usb 1-5.3: configuration #1 chosen from 1 choice
usb 1-5.4: new high speed USB device using ehci_hcd and address 7
usb 1-5.4: configuration #1 chosen from 1 choice
hub 1-5.4:1.0: USB hub found
hub 1-5.4:1.0: 4 ports detected
Adding 506008k swap on /dev/hda6.  Priority:-1 extents:1 across:506008k
usb 4-2: new low speed USB device using ohci_hcd and address 2
EXT3 FS on hda2, internal journal
usb 4-2: configuration #1 chosen from 1 choice
usb 3-3.2: new full speed USB device using ohci_hcd and address 3
usb 3-3.2: configuration #1 chosen from 1 choice
loop: loaded (max 8 devices)
usb 3-3.3: new full speed USB device using ohci_hcd and address 4
usb 3-3.3: configuration #1 chosen from 1 choice
usb 1-5.4.1: new full speed USB device using ehci_hcd and address 8
usb 1-5.4.1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 25 (level, low) -> IRQ 25
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  1.0-9755  Mon Feb 26
23:16:31 PST 2007
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
drivers/usb/input/hid-core.c: timeout initializing reports
input: PI Engineering RailDriver Modern Desktop as /class/input/input3
input: USB HID v1.00 Device [PI Engineering RailDriver Modern Desktop]
on usb-0000:00:13.3-5.2
usb 4-2: USB disconnect, address 2
usb 4-2: new low speed USB device using ohci_hcd and address 3
usb 4-2: configuration #1 chosen from 1 choice
input: Logitech Logitech BT Mini-Receiver as /class/input/input4
input: USB HID v1.11 Keyboard [Logitech Logitech BT Mini-Receiver] on
usb-0000:00:13.1-3.2
input: Logitech Logitech BT Mini-Receiver as /class/input/input5
input,hiddev96: USB HID v1.11 Mouse [Logitech Logitech BT
Mini-Receiver] on usb-0000:00:13.1-3.3
input: Logitech USB Receiver as /class/input/input6
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:13.2-2
input: Logitech USB Receiver as /class/input/input7
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:13.2-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new interface driver hci_usb
Bluetooth: Virtual HCI driver ver 1.2
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.28 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs error (device hdf1): load_system_files(): Volume is dirty.
Mounting read-only.  Run chkdsk and mount in Windows.
NTFS volume version 3.1.
NTFS volume version 3.1.
NTFS volume version 3.1.
NTFS-fs error (device sdc7): load_system_files(): Volume is dirty.
Mounting read-only.  Run chkdsk and mount in Windows.
NTFS volume version 3.1.
ACPI: duty_cycle spans bit 4
input: Power Button (FF) as /class/input/input8
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input9
ACPI: Power Button (CM) [PWRB]
uli526x: eth0 NIC Link is Up 100 Mbps Full duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
usb 3-3.1: new full speed USB device using ohci_hcd and address 5
usb 3-3.1: configuration #1 chosen from 1 choice
/dev/vmmon[3389]: CrossTalk: Driver initialized.
/dev/vmmon[3389]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[3389]: Module vmmon: initialized
/dev/vmnet: open called by PID 3468 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
/dev/vmnet: open called by PID 3484 (vmnet-dhcpd)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 3495 (vmnet-dhcpd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 3500 (vmnet-natd)
/dev/vmnet: port on hub 8 successfully opened
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
input: Bluetooth HID Boot Protocol Device as /class/input/input10
eth0: no IPv6 routers present
/dev/vmnet: open called by PID 3554 (vmnet-netifup)
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 3555 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
input: Bluetooth HID Boot Protocol Device as /class/input/input11
BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

BUG: at drivers/hid/hid-core.c:780 implement()

Call Trace:
 [<ffffffff80396af0>] hid_output_report+0x100/0x16c
 [<ffffffff88197430>] :usbhid:hid_submit_ctrl+0x60/0x203
 [<ffffffff88197742>] :usbhid:usbhid_submit_report+0x16f/0x1a4
 [<ffffffff8819942a>] :usbhid:hiddev_ioctl+0x368/0x91e
 [<ffffffff80220d4d>] __up_read+0x13/0x8a
 [<ffffffff8020a5c5>] do_page_fault+0x45e/0x7ad
 [<ffffffff8021d544>] __dentry_open+0x101/0x1a7
 [<ffffffff8023d19e>] do_ioctl+0x55/0x6b
 [<ffffffff8022d91a>] vfs_ioctl+0x258/0x271
 [<ffffffff80247129>] sys_ioctl+0x3c/0x5c
 [<ffffffff8025811e>] system_call+0x7e/0x83

vmnet1: no IPv6 routers present
vmnet8: no IPv6 routers present

nvidia: module license 'NVIDIA' taints kernel.

6. rebooting triggers it. module-init-tools loads the modules, for
usb, usb loads the bt modules for the device, and hid tries to attach
the keyboard or mouse to hid-input, but im guessing here.

7.1
sh scripts/ver_linux
Linux doc 2.6.20.6 #1 SMP Sat Apr 7 14:38:19 CEST 2007 x86_64 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   105
wireless-tools         28
Modules Loaded         snd_intel8x0 vmnet parport_pc parport vmblock
vmmon nvidia nls_cp865 vfat fat nls_iso8859_1 ntfs hidp rfcomm l2cap
joydev ipv6 thermal fan button processor ac battery snd_emu10k1x
snd_virmidi snd_rtctimer hci_uart hci_vhci hci_usb bluetooth w83627ehf
i2c_isa loop usbhid snd_emu10k1_synth snd_emux_synth snd_seq_virmidi
snd_seq_midi_emul snd_emu10k1 i2c_ali15x3 snd_seq_dummy snd_seq_oss
snd_seq_midi snd_seq_midi_event snd_hda_intel snd_hda_codec snd_seq
snd_pcm_oss snd_mixer_oss snd_rawmidi snd_ac97_codec ac97_bus
snd_seq_device snd_util_mem snd_pcm snd_hwdep snd_timer emu10k1_gp snd
gameport i2c_ali1535 k8temp ohci_hcd ehci_hcd soundcore snd_page_alloc
i2c_core usbcore uli526x pcspkr sd_mod

7.2
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 75
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2
cpu MHz         : 2010.085
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt rdtscp lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm
cr8_legacy
bogomips        : 4022.90
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 75
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2
cpu MHz         : 2010.085
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt rdtscp lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm
cr8_legacy
bogomips        : 4020.38
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

7.3
snd_intel8x0 38312 0 - Live 0xffffffff88ab5000
vmnet 49536 13 - Live 0xffffffff88aa7000 (P)
parport_pc 43816 0 - Live 0xffffffff88a9b000
parport 42636 1 parport_pc, Live 0xffffffff8808a000
vmblock 18696 3 - Live 0xffffffff8806c000 (P)
vmmon 494380 0 - Live 0xffffffff88a21000 (P)
nvidia 7762456 22 - Live 0xffffffff882b8000 (P)
nls_cp865 9472 4 - Live 0xffffffff882b4000
vfat 16128 4 - Live 0xffffffff882af000
fat 55728 1 vfat, Live 0xffffffff882a0000
nls_iso8859_1 7744 9 - Live 0xffffffff8829d000
ntfs 195400 5 - Live 0xffffffff8826c000
hidp 21696 1 - Live 0xffffffff88265000
rfcomm 44584 7 - Live 0xffffffff88259000
l2cap 28736 10 hidp,rfcomm, Live 0xffffffff88250000
joydev 12800 0 - Live 0xffffffff8824b000
ipv6 288256 12 - Live 0xffffffff88203000
thermal 18064 0 - Live 0xffffffff881fd000
fan 7816 0 - Live 0xffffffff881fa000
button 11296 0 - Live 0xffffffff881f6000
processor 37032 1 thermal, Live 0xffffffff881eb000
ac 8200 0 - Live 0xffffffff881e7000
battery 13256 0 - Live 0xffffffff881e2000
snd_emu10k1x 22916 0 - Live 0xffffffff881db000
snd_virmidi 8256 0 - Live 0xffffffff881d7000
snd_rtctimer 6560 0 - Live 0xffffffff881d4000
hci_uart 20512 0 - Live 0xffffffff881cd000
hci_vhci 10624 0 - Live 0xffffffff881c9000
hci_usb 20956 7 - Live 0xffffffff881c2000
bluetooth 59908 18 hidp,rfcomm,l2cap,hci_uart,hci_vhci,hci_usb, Live
0xffffffff881b2000
w83627ehf 23948 0 - Live 0xffffffff881ab000
i2c_isa 8832 1 w83627ehf, Live 0xffffffff881a7000
loop 19088 0 - Live 0xffffffff881a1000
usbhid 27808 0 - Live 0xffffffff88199000
snd_emu10k1_synth 9984 0 - Live 0xffffffff88195000
snd_emux_synth 37632 1 snd_emu10k1_synth, Live 0xffffffff8818a000
snd_seq_virmidi 10112 2 snd_virmidi,snd_emux_synth, Live 0xffffffff88186000
snd_seq_midi_emul 9024 1 snd_emux_synth, Live 0xffffffff88182000
snd_emu10k1 122976 2 snd_emu10k1_synth, Live 0xffffffff88162000
i2c_ali15x3 11012 0 - Live 0xffffffff8815e000
snd_seq_dummy 6532 0 - Live 0xffffffff8815b000
snd_seq_oss 34944 0 - Live 0xffffffff88151000
snd_seq_midi 11584 0 - Live 0xffffffff8814d000
snd_seq_midi_event 10496 3 snd_seq_virmidi,snd_seq_oss,snd_seq_midi,
Live 0xffffffff88149000
snd_hda_intel 24224 1 - Live 0xffffffff88142000
snd_hda_codec 198080 1 snd_hda_intel, Live 0xffffffff88110000
snd_seq 55808 9
snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event,
Live 0xffffffff88101000
snd_pcm_oss 46816 0 - Live 0xffffffff880f4000
snd_mixer_oss 19712 1 snd_pcm_oss, Live 0xffffffff880ee000
snd_rawmidi 28000 4
snd_emu10k1x,snd_seq_virmidi,snd_emu10k1,snd_seq_midi, Live
0xffffffff880e6000
snd_ac97_codec 110808 3 snd_intel8x0,snd_emu10k1x,snd_emu10k1, Live
0xffffffff880c9000
ac97_bus 5184 1 snd_ac97_codec, Live 0xffffffff880c6000
snd_seq_device 10964 8
snd_emu10k1_synth,snd_emux_synth,snd_emu10k1,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi,
Live 0xffffffff880c2000
snd_util_mem 7616 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff880bf000
snd_pcm 83144 7
snd_intel8x0,snd_emu10k1x,snd_emu10k1,snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_ac97_codec,
Live 0xffffffff880a9000
snd_hwdep 12040 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff880a5000
snd_timer 26120 4 snd_rtctimer,snd_emu10k1,snd_seq,snd_pcm, Live
0xffffffff8809d000
emu10k1_gp 6720 0 - Live 0xffffffff88098000
snd 60520 22 snd_intel8x0,snd_emu10k1x,snd_virmidi,snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_seq_oss,snd_hda_intel,snd_hda_codec,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_rawmidi,snd_ac97_codec,snd_seq_device,snd_pcm,snd_hwdep,snd_timer,
Live 0xffffffff8807a000
gameport 19536 2 emu10k1_gp, Live 0xffffffff88066000
i2c_ali1535 10116 0 - Live 0xffffffff88060000
k8temp 8704 0 - Live 0xffffffff8805a000
ohci_hcd 23044 0 - Live 0xffffffff88051000
ehci_hcd 34636 0 - Live 0xffffffff88047000
soundcore 11296 1 snd, Live 0xffffffff88043000
snd_page_alloc 12752 5
snd_intel8x0,snd_emu10k1x,snd_emu10k1,snd_hda_intel,snd_pcm, Live
0xffffffff8803e000
i2c_core 26432 5 nvidia,w83627ehf,i2c_isa,i2c_ali15x3,i2c_ali1535,
Live 0xffffffff88036000
usbcore 142256 5 hci_usb,usbhid,ohci_hcd,ehci_hcd, Live 0xffffffff88012000
uli526x 20052 0 - Live 0xffffffff8800c000
pcspkr 5824 0 - Live 0xffffffff88009000
sd_mod 22784 12 - Live 0xffffffff88000000

7.4
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:16.0
  0170-0177 : ide1
01f0-01f7 : 0000:00:16.0
  01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : 0000:00:16.0
  0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : 0000:00:16.0
  03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0a00-0a0f : pnp 00:0c
0a10-0a1f : pnp 00:0c
  0a15-0a16 : w83627ehf
0cf8-0cff : PCI conf1
4000-403f : 0000:00:15.1
  4000-4003 : ACPI PM1a_EVT_BLK
  4004-4005 : ACPI PM1a_CNT_BLK
  4008-400b : ACPI PM_TMR
  4010-4015 : ACPI CPU throttle
  4018-4027 : ACPI GPE0_BLK
  4030-4030 : ACPI PM2_CNT_BLK
4050-4057 : ACPI GPE1_BLK
40c0-40df : motherboard
a000-a00f : 0000:00:16.1
  a000-a00f : ahci
a400-a403 : 0000:00:16.1
  a400-a403 : ahci
a800-a807 : 0000:00:16.1
  a800-a807 : ahci
b000-b003 : 0000:00:16.1
  b000-b003 : ahci
b400-b407 : 0000:00:16.1
  b400-b407 : ahci
b800-b8ff : 0000:00:12.0
  b800-b8ff : uli526x
c000-efff : PCI Bus #05
  c800-c807 : 0000:05:0c.1
    c800-c807 : emu10k1-gp
  d000-d01f : 0000:05:0c.0
    d000-d01f : EMU10K1
  d400-d40f : 0000:05:0b.0
    d400-d407 : ide2
    d408-d40f : ide3
  d800-d803 : 0000:05:0b.0
    d802-d802 : ide3
  e000-e007 : 0000:05:0b.0
    e000-e007 : ide3
  e400-e403 : 0000:05:0b.0
    e402-e402 : ide2
  e800-e807 : 0000:05:0b.0
    e800-e807 : ide2
ff00-ff0f : 0000:00:16.0
  ff00-ff07 : ide0
  ff08-ff0f : ide1
---
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000cf000-000d17ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffcffff : System RAM
  00200000-003e3c77 : Kernel code
  003e3c78-004bf52f : Kernel data
3ffd0000-3ffddfff : ACPI Tables
3ffde000-3fffffff : ACPI Non-volatile Storage
c0000000-cfffffff : PCI Bus #01
  c0000000-cfffffff : 0000:01:00.0
dbfd4000-dbfd7fff : 0000:00:14.0
  dbfd4000-dbfd7fff : ICH HD audio
dbfec000-dbfecfff : 0000:00:13.2
  dbfec000-dbfecfff : ohci_hcd
dbfed000-dbfedfff : 0000:00:13.1
  dbfed000-dbfedfff : ohci_hcd
dbfee000-dbfeefff : 0000:00:13.0
  dbfee000-dbfeefff : ohci_hcd
dbfef400-dbfef7ff : 0000:00:16.1
  dbfef400-dbfef7ff : ahci
dbfef800-dbfef8ff : 0000:00:13.3
  dbfef800-dbfef8ff : ehci_hcd
dbfefc00-dbfefcff : 0000:00:12.0
  dbfefc00-dbfefcff : uli526x
dc000000-deefffff : PCI Bus #01
  dc000000-dcffffff : 0000:01:00.0
  dd000000-ddffffff : 0000:01:00.0
    dd000000-ddffffff : nvidia
  deee0000-deefffff : 0000:01:00.0
def00000-deffffff : PCI Bus #05
  defe0000-defe3fff : 0000:05:0b.0
  deffc000-deffffff : 0000:05:0b.0
fec00000-fec00fff : IOAPIC 0
fec10000-fec10fff : IOAPIC 1
fee00000-fee00fff : Local APIC
ff780000-ffffffff : reserved

7.5
00:00.0 Host bridge: ALi Corporation M1697 HTT Host Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=5 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit
DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO- <CRCErr=0
IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit
DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.05
		Link Frequency 0: 800MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+
800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz-
800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF-
RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [5c] HyperTransport: MSI Mapping
	Capabilities: [68] HyperTransport: UnitID Clumping
	Capabilities: [74] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [7c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 00000000fee00000  Data: 0000

00:01.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-deefffff
	Prefetchable memory behind bridge: c0000000-cfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 4059
	Capabilities: [58] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <2us, L1 <32us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [7c] HyperTransport: MSI Mapping
	Capabilities: [88] HyperTransport: Revision ID: 1.05

00:02.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 4061
	Capabilities: [58] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x2, ASPM L0s L1, Port 0
		Link: Latency L0s <2us, L1 <32us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed unknown, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [7c] HyperTransport: MSI Mapping
	Capabilities: [88] HyperTransport: Revision ID: 1.05

00:03.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 4069
	Capabilities: [58] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <2us, L1 <32us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed unknown, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [7c] HyperTransport: MSI Mapping
	Capabilities: [88] HyperTransport: Revision ID: 1.05

00:04.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 4071
	Capabilities: [58] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <2us, L1 <32us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed unknown, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [7c] HyperTransport: MSI Mapping
	Capabilities: [88] HyperTransport: Revision ID: 1.05

00:11.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 0000c000-0000efff
	Memory behind bridge: def00000-deffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:12.0 Ethernet controller: ALi Corporation ULi 1689,1573 integrated
ethernet. (rev 60)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at dbfefc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at dbfee000 (32-bit, non-prefetchable) [size=4K]

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 18
	Region 0: Memory at dbfed000 (32-bit, non-prefetchable) [size=4K]

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 19
	Region 0: Memory at dbfec000 (32-bit, non-prefetchable) [size=4K]

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
(prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at dbfef800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:14.0 Audio device: ALi Corporation High Definition Audio/AC'97 Host
Controller (rev 01)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 20000ns max)
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at dbfd4000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:15.0 ISA bridge: ALi Corporation PCI to LPC Controller (rev 10)
	Subsystem: ALi Corporation PCI to LPC Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 6000ns max)

00:15.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: ALi Corporation M7101 Power Management Controller [PMU]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:16.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a
[Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 21
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
[disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
[disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable)
[disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
[disabled] [size=1]
	Region 4: I/O ports at ff00 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:16.1 IDE interface: ALi Corporation ULi M5288 SATA (prog-if 85
[Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 7270
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at dbfef400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [f0] #0f [0010]

01:00.0 VGA compatible controller: nVidia Corporation GeForce 7300 GS
(rev a1) (prog-if 00 [VGA])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at dc000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at deee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <1us, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 213
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16

05:0b.0 Mass storage controller: Promise Technology, Inc. PDC20268
(Ultra100 TX2) (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at e800 [size=8]
	Region 1: I/O ports at e400 [size=4]
	Region 2: I/O ports at e000 [size=8]
	Region 3: I/O ports at d800 [size=4]
	Region 4: I/O ports at d400 [size=16]
	Region 5: Memory at deffc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at defe0000 [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
	Subsystem: Creative Labs CT4760 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at d000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:0c.1 Input device controller: Creative Labs SB Live! Game Port (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at c800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


7.6
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6L200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3250823AS      Rev: 3.03
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6L200M0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05





-- 
No trees were killed in the sending of this message.
However, a large number of electrons were terribly inconvenienced

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
