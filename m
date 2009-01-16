Return-Path: <cyrus@holtmann.org>
Message-ID: <b3f4dcd00901161441n6e2d98e6l193bcc8372fd2bc8@mail.gmail.com>
Date: Sat, 17 Jan 2009 11:41:23 +1300
From: "Matthew Grant" <matthewgrant5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Dell Wireless 360 Bluetooth HID devices not being remembered over suspend/reboot
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I know that this is a developers list, but I have dug pretty deeply
here and got to the bottom of what the built-in USB bluetooth dongle
is.  I have found that its CSR based.   Under Windows Vista my Apple
keyboard and Logitech MX 900 work and are remembered across boots.
>From what I have heard, this device should just work.  System is a
Dell Vostro 1510 with Intel Core2Duo running Ubuntu Intrepid Ibex,
bluez 4.22.  I also have an Intel 3945 ABG PCI mini wireless card in
it as well.

I am willing to do the hacking to get this going - I used to submit
patches to the Linux kernel and develop/patch network drivers for
Frame Relay WAN, as well as making the 2.2x ehternet bridge accessible
via a virtual ethernet interface - my email address was
grantma@anathoth.gen.nz.

Should I be using the module flags for a straight CSR modem?  Is the
kernel module btusb ths only place the bluez stack looks hard at the
hardware?

>From what I have found looking at posts to the list, the CSR dongle,
once it is set up properly - I don't mind running a CSR DFU firmware
on it - it should just work.

I am going to test software by using my old Logitech dongle in the MX
900 base station-charger.

Getting the mouse going reliably and keyboard is going to help with my
frustrations with the small sized keys on the laptop keyboard when
essay writing - currently  I am rebinding the OOo.org keys into an
emacs type of keymap.

lsusb and hciconfig -a output follow.  Is there anything else that may
be helpful?

I gather that solving this will help out a lot of Ubuntu Dell laptop users.

Thank you for your time. Marcel - comments will be welcome - :-)

Matthew Grant

en-gedi: -grantma- [~]
$ lsusb
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 003: ID 0c45:63e0 Microdia
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 002: ID 046d:0a01 Logitech, Inc. USB Headset
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 002: ID 413c:8140 Dell Computer Corp. Wireless 360 Bluetooth
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

en-gedi: -grantma- [~]
$ hciconfig -a
hci0:	Type: USB
	BD Address: 00:21:86:D0:37:F0 ACL MTU: 310:10 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN
	RX bytes:1104 acl:0 sco:0 events:45 errors:0
	TX bytes:440 acl:0 sco:0 commands:44 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'en-gedi-0'
	Class: 0x0a210c
	Service Classes: Networking, Capturing
	Device Class: Computer, Laptop
	HCI Ver: 2.0 (0x3) HCI Rev: 0x10db LMP Ver: 2.0 (0x3) LMP Subver: 0x10db
	Manufacturer: Cambridge Silicon Radio (10)
