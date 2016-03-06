Return-Path: <jerome.debretagne@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56D37BAC.6090907@intel.com>
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>
 <56CAD20D.4080609@broadcom.com> <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com>
 <56D35080.1010003@intel.com> <CA+kEDGHbzH9VPRUaz5-JPsU5kHTDk8UwGGmt94rGVXiG1KY-Ow@mail.gmail.com>
 <56D37BAC.6090907@intel.com>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Sun, 6 Mar 2016 14:22:44 +0100
Message-ID: <CA+kEDGHz=V+BBxbnQDDKwNgLUFjj_9p85DepRSqArRJUzbyusQ@mail.gmail.com>
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
To: Loic Poulain <loic.poulain@intel.com>, Ilya Faenson <ilya.faenson@broadcom.com>,
	linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> So your BT controller is BTH1 (BCM2E55).
> The ACPI table for this BTH1 looks good (1 irq + 2 gpios ) so it should b=
e
> compatible with hci_bcm.

I can confirm that it is compatible with hci_bcm; Bluetooth is indeed
fully working using the bluetooth-next tree on the ThinkPad Tablet 8.
Thanks again Marcel to have applied the patch and Loic to have helped
me find the right ACPI ID.

Maybe this is a naive question about ACPI ID, and not specific to
Broadcom by the way: could there be a more generic way to gather ACPI
IDs used by new devices and add them to the kernel on a regular basis?
They seem to be added almost one by one mainly upon user reports when
looking at the mailing list. So Bluetooth doesn't work out-of-the-box
on some systems which would be compatible otherwise, especially the
less popular ones. Is there no existing driver list to re-use perhaps?


> Now, you can run btattach (bluez tool):
> $ btattach -B /dev/ttySX -P bcm

Indeed, it is working fine with ttyS1 and the correct binary firmware
stored at /lib/firmware/brcm/BCM.hcd:

   # btattach -B /dev/ttyS1 -P bcm
   Attaching BR/EDR controller to /dev/ttyS1
   Switched line discipline from 0 to 15
   Device index 0 attached

Finally, is btattach the only command recommended and supported moving
forward, or should hciattach work as well with that specific
chipset/tablet (as a transition until most Linux distros switch to
btattach)?

Regards,
J=C3=A9r=C3=B4me


P.S. for information if it can be useful to someone else:

> And check that hci0 has been created
> $ hciconfig

$ hciconfig -a
hci0:    Type: BR/EDR  Bus: UART
    BD Address: B0:10:41:B8:16:6C  ACL MTU: 1021:8  SCO MTU: 64:1
    UP RUNNING
    RX bytes:110596 acl:4422 sco:0 events:328 errors:0
    TX bytes:35333 acl:36 sco:0 commands:273 errors:0
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH SNIFF
    Link mode: SLAVE ACCEPT
    Name: 'thinkpad8'
    Class: 0x10011c
    Service Classes: Object Transfer
    Device Class: Computer, Unknown (reserved) minor device class
    HCI Version: 4.0 (0x6)  Revision: 0x3492
    LMP Version: 4.0 (0x6)  Subversion: 0x4606
    Manufacturer: Broadcom Corporation (15)
