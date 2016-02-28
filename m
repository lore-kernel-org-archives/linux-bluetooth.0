Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <56D35080.1010003@intel.com>
Date: Sun, 28 Feb 2016 20:54:40 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
	<jerome.debretagne@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>	<56CAD20D.4080609@broadcom.com> <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com>
In-Reply-To: <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

> It seems this BCM4324(1) rev B5 chipset is not initialized from a
> Bluetooth point of view, while working great for Wi-Fi.
I suppose this combo chip uses SDIO bus for WiFi and UART for Bluetooth.
If so, you need to attach the correct UART port to the hci_uart line 
discipline from user-space.

> I've seen recent patches adding support for some devices simply by
> adding their respective ACPI ID in hci_bcm.c (BCM2E7C for MacBook
> 2015, BCM2E65 for the Asus T100TAF, BCM2E54 for the HP Omni 10) so
> I've just taken a look at the data listed by the ACPI subsystem on
> this tablet:
>
>     $ ls /sys/bus/acpi/devices/BCM* -d1
>     /sys/bus/acpi/devices/BCM2E3C:00
>     /sys/bus/acpi/devices/BCM2E55:00

Usually, Broadcom BT controller is described in the ACPI table.
You can retrieve your ACPI table at /sys/firmware/acpi/tables/DSDT and 
decompile it with iasl.
You should have a Bluetooth node (BTHX):
Device (BTH1)
             {
                 Name (_HID, "BCM...")

With some gpio/irq resources. (0: wakeup, 1: power-, 2:host-wakeup).

> Neither of these 2 IDs (BCM2E3C, BCM2E55) is listed in hci_bcm.c. It's
> just a guess at this stage but could one of these be the missing
> element required in hci_bcm.c to initialize Bluetooth on the Lenovo
> ThinkPad 8 Tablet maybe? I don't know if the following commands might
> give a hint to filter between the two IDs:
>
>     $ cat /sys/bus/acpi/devices/BCM2E3C\:00/status
>     0
>     $ cat /sys/bus/acpi/devices/BCM2E55\:00/status
>     15

Check in your acpi table if one of them matches a bluetooth node.
Then, try to add it in the acpi device id list in hci_bcm.c.

Second step is to attach the device, but you need to find the correct 
tty to use.
If your ACPI table is correct, BCM acpi device should appear as a child 
of a tty device in sysfs.
The physical_node symlink in your device directory (sys/bus/acpi...) 
gives you the hierarchical path.

Now, you can run btattach (bluez tool):
$ btattach -B /dev/ttySX -P bcm

And check that hci0 has been created
$ hciconfig

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

