Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111102080259.GB12653@aemeltch-MOBL1>
References: <CAKzePapHJwC2VMpjgS_uK=NCUPCEAQt5+zDSEqRJNdPth-Aztw@mail.gmail.com>
	<20111102080259.GB12653@aemeltch-MOBL1>
Date: Wed, 2 Nov 2011 18:00:48 +0800
Message-ID: <CAKzePaq3pgktQeb9y9HzeGa-JO5aXYuo5e1WgQ+sE=FOVf5pPw@mail.gmail.com>
Subject: Re: How to add firmware uploader function to Bluez?
From: Al Cho <acho@suse.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Al Cho <acho@suse.com>, marcel@holtmann.org,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org,
	oneukum@suse.com, jlee@suse.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Nov 2, 2011 at 4:03 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi AL,
>
> On Wed, Nov 02, 2011 at 03:55:50PM +0800, Al Cho wrote:
>> Hi All,
>>
>> Broadcom BT4.0 module 0a5c:21e1 and 0a5c:21e3 need firmware
>> to setup(enable) at the first time we use.
>> We got the firmware and firmware uploader (brcm_patchram_plus_usb )
>> ( user space tool ) from Broadcom ,the Licence is GPLv2,
>> would it possible that add those to bluez package?or any idea for this?
>
> Should firmware come to linux-firmware package?
>

Yes, I think so,
but 0a5c:21e1 and 0a5c:21e3 use btusb driver,
this firmware use at the first time to enable only,
and that firmware uploader need to use the bluez hci library.
So I guess add those to bluez would be better.

> Description: Firmware for Linux kernel drivers
>  This package provides firmware used by Linux kernel drivers.
>
> Do not know about "firmware-loader", probably we need to use available tools.
>


BR,
    AL
