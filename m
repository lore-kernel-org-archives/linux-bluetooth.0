Return-Path: <jerome.debretagne@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56DD4CEF.3070300@intel.com>
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>
 <56CAD20D.4080609@broadcom.com> <CA+kEDGFX31qxxDsFYR-vdcb1UhH65xoZ0sxKcY9xFxC_J=GNfQ@mail.gmail.com>
 <56D35080.1010003@intel.com> <CA+kEDGHbzH9VPRUaz5-JPsU5kHTDk8UwGGmt94rGVXiG1KY-Ow@mail.gmail.com>
 <56D37BAC.6090907@intel.com> <CA+kEDGHz=V+BBxbnQDDKwNgLUFjj_9p85DepRSqArRJUzbyusQ@mail.gmail.com>
 <56DD4CEF.3070300@intel.com>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Mon, 7 Mar 2016 11:48:13 +0100
Message-ID: <CA+kEDGF7MaWNW_8jRintsGgnfCa=rp251dtxyrvpQHp7RusYiw@mail.gmail.com>
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
To: Loic Poulain <loic.poulain@intel.com>
Cc: Ilya Faenson <ilya.faenson@broadcom.com>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> New ACPI ID means that this is a different hardware. So it needs to be
> tested before being added into the driver supported list. An already
> supported hardware should keep the same ACPI ID, making it work out-of
> the-box.

That makes sense.

What about the other ACPI ID (BCM2E3C) that I've found in the ACPI
table of that ThinkPad 8 tablet? Is it included in its table to cover
another HW variant of that product, using a different Broadcom
chipset? Any value for you if I create a similar patch (without being
able to test it)? I guess the answer will be "No" from your message
above but just let me know.


>> Finally, is btattach the only command recommended and supported moving
>> forward
>
>
> Absolutely, think btattach is the only recommended way.
> Even if you can make it work with hciattach by adding device entry with
> correct protocol ID, it is not recommended since hciattach is dedicated
> to user-space initialisation (old-way) and code is pretty deprecated.

That's what I thought, thanks for the confirmation.

Regards,
J=C3=A9r=C3=B4me
