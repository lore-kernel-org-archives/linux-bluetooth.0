Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56CAD20D.4080609@broadcom.com>
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>
	<56CAD20D.4080609@broadcom.com>
Date: Sun, 28 Feb 2016 19:23:11 +0100
Message-ID: <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com>
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
	<jerome.debretagne@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been able to continue my investigation and I can confirm that I
am getting the same results on both Linux kernel:
- 4.4 - linux-image-4.4.0-1-amd64 from Debian (v4.4.2-3)
- 4.5 rc4 - linux-image-4.5.0-rc4-amd64 from Debian (4.5~rc4-1~exp1)
and in both cases no error message whatsoever related to Bluetooth.

It seems this BCM4324(1) rev B5 chipset is not initialized from a
Bluetooth point of view, while working great for Wi-Fi.

I've seen recent patches adding support for some devices simply by
adding their respective ACPI ID in hci_bcm.c (BCM2E7C for MacBook
2015, BCM2E65 for the Asus T100TAF, BCM2E54 for the HP Omni 10) so
I've just taken a look at the data listed by the ACPI subsystem on
this tablet:

   $ ls /sys/bus/acpi/devices/BCM* -d1
   /sys/bus/acpi/devices/BCM2E3C:00
   /sys/bus/acpi/devices/BCM2E55:00

Neither of these 2 IDs (BCM2E3C, BCM2E55) is listed in hci_bcm.c. It's
just a guess at this stage but could one of these be the missing
element required in hci_bcm.c to initialize Bluetooth on the Lenovo
ThinkPad 8 Tablet maybe? I don't know if the following commands might
give a hint to filter between the two IDs:

   $ cat /sys/bus/acpi/devices/BCM2E3C\:00/status
   0
   $ cat /sys/bus/acpi/devices/BCM2E55\:00/status
   15

If I can provide more information that would be useful for you, feel
free to ask as I would be glad to help.

Jérôme

P.S. I don't know if I should provide a binary firmware somehow to
trigger its initialization (as I've done for the Wi-Fi part) but I
would expect to see an error message complaining not to find the
required binary file if that was the case.

2016-02-22 10:17 GMT+01:00 Arend Van Spriel <arend.vanspriel@broadcom.com>:
> + Ilya
> + bt list
>
> On 21-2-2016 15:17, Jérôme de Bretagne wrote:
>> Hi,
>>
>> Since a commit from last April, the BCM4324(1) rev B5 chipset is
>> supported in the Linux kernel and WiFi networking has been working
>> like a charm on a Lenovo ThinkPad 8 tablet (running Linux
>> 4.3.0-1-amd64 from Debian). A big "Thanks" for that.
>>
>> On the other hand, the Bluetooth part doesn't show up at all (empty
>> result with hciconfig) and doesn't seem active with that same 4.3
>> kernel. I don't even see any error message in dmesg about Bluetooth.
>>
>> bluetooth/btbcm.c mentions quite a few chipsets (UART/USB) but not the
>> 4324 rev B5 so I'm not sure of the current Bluetooth status for that
>> specific one. Is this chipset enabled for Bluetooth starting with
>> Linux 4.4 or in the coming 4.5 version maybe? I couldn't check 4.4
>> properly yet as this kernel version locks currently on my tablet (for
>> other reasons).
>>
>> If it is not fully supported yet, feel free to ask any info that could
>> help enable Bluetooth for this chipset on the ThinkPad 8 tablet!
>>
>> Thanks,
>>
>> Jérôme
>>
>>
>> P.S. I guess the following page
>> https://wireless.wiki.kernel.org/en/users/Drivers/brcm80211 could be
>> updated to show that Wireless LAN is properly working.
>
