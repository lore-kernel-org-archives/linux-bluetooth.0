Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <56D37BAC.6090907@intel.com>
Date: Sun, 28 Feb 2016 23:58:52 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: =?windows-1252?Q?J=E9r=F4me_de_Bretagne?=
	<jerome.debretagne@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>	<56CAD20D.4080609@broadcom.com>	<CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com>	<56D35080.1010003@intel.com> <CA+kEDGHbzH9VPRUaz5-JPsU5kHTDk8UwGGmt94rGVXiG1KY-Ow@mail.gmail.com>
In-Reply-To: <CA+kEDGHbzH9VPRUaz5-JPsU5kHTDk8UwGGmt94rGVXiG1KY-Ow@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jerome,

>>> I've just taken a look at the data listed by the ACPI subsystem on
>>> this tablet:
>>>
>>>      $ ls /sys/bus/acpi/devices/BCM* -d1
>>>      /sys/bus/acpi/devices/BCM2E3C:00
>>>      /sys/bus/acpi/devices/BCM2E55:00
>>
>> Usually, Broadcom BT controller is described in the ACPI table.
>> You can retrieve your ACPI table at /sys/firmware/acpi/tables/DSDT and
>> decompile it with iasl.
>> You should have a Bluetooth node (BTHX):
>> Device (BTH1)
>>              {
>>                  Name (_HID, "BCM...")
>>
>> With some gpio/irq resources. (0: wakeup, 1: power-, 2:host-wakeup).
>>
>> Check in your acpi table if one of them matches a bluetooth node.
> Both of them are matching a Bluetooth node it seems to me, with BTH0
> and BTH1 entries respectively. I've attached the original DSDT ACPI
> table (dsdt.dat) and the decompiled version (dsdt.dsl). Any useful
> information in there?

from your DSDT:
BTH0 _STA  (status) method returns 0x00 meaning that this device is not 
present.
BTH1 _STA method returns 0x0F meaning that this device is present.

So your BT controller is BTH1 (BCM2E55).

The ACPI table for this BTH1 looks good (1 irq + 2 gpios ) so it should 
be compatible with hci_bcm.

>> Second step is to attach the device, but you need to find the correct tty to
>> use.
>> If your ACPI table is correct, BCM acpi device should appear as a child of a
>> tty device in sysfs.
>> The physical_node symlink in your device directory (sys/bus/acpi...) gives
>> you the hierarchical path.
> Before applying any patches to hci_bcm.c , BCM2E55 has already the
> following hierarchical path:
>
>     /sys/bus/acpi/devices/BCM2E55:00$ ls -l physical_node
>     lrwxrwxrwx 1 root root 0 févr. 28 21:45 physical_node ->
> ../../../../platform/80860F0A:00/BCM2E55:00
80860F0A is the UART controller (8250_dw), looks good.
So you should also find BCM2E55 id into:
/sys/class/ttyS*/device/

> while BCM2E3C has none:
>
>     sys/bus/acpi/devices/BCM2E3C:00$ ls
>     hid  modalias  path  power  status  subsystem  uevent

Yes because BCM2E3C is not enabled.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

