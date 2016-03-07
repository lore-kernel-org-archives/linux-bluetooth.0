Return-Path: <loic.poulain@intel.com>
Message-ID: <56DD98EC.1060504@intel.com>
Date: Mon, 07 Mar 2016 16:06:20 +0100
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
 <jerome.debretagne@gmail.com>
CC: Ilya Faenson <ilya.faenson@broadcom.com>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com> <56CAD20D.4080609@broadcom.com> <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com> <56D35080.1010003@intel.com> <CA+kEDGHbzH9VPRUaz5-JPsU5kHTDk8UwGGmt94rGVXiG1KY-Ow@mail.gmail.com> <56D37BAC.6090907@intel.com> <CA+kEDGHz=V+BBxbnQDDKwNgLUFjj_9p85DepRSqArRJUzbyusQ@mail.gmail.com> <56DD4CEF.3070300@intel.com> <CA+kEDGF7MaWNW_8jRintsGgnfCa=rp251dtxyrvpQHp7RusYiw@mail.gmail.com>
In-Reply-To: <CA+kEDGF7MaWNW_8jRintsGgnfCa=rp251dtxyrvpQHp7RusYiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome


> What about the other ACPI ID (BCM2E3C) that I've found in the ACPI
> table of that ThinkPad 8 tablet? Is it included in its table to cover
> another HW variant of that product, using a different Broadcom
> chipset? Any value for you if I create a similar patch (without being
> able to test it)? I guess the answer will be "No" from your message
> above but just let me know.

Yes, ACPI table is often filled with different optional components so
that it can be compatible with several platform variants without impact
on the ACPI data. Then, components are enabled/disabled depending board ID.

This BCM2E3C is disabled on your platform, but seems compatible with 
hci_bcm UART driver (2GPIOs + 1IRQ). Should be only a revision of BCM2Ex.
Broadcom input is welcome here.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
