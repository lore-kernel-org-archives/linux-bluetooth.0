Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55A65C71.8010800@hanno.de>
References: <55A65C71.8010800@hanno.de>
Date: Thu, 16 Jul 2015 15:25:33 +0300
Message-ID: <CABBYNZKMYGr1+ADcDORoQ2docOg0dKePTnMqruaoF2UXio=p5g@mail.gmail.com>
Subject: Re: Motorola RZ100: How to add support for a new device?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hanno Zulla <abos@hanno.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hanno,

On Wed, Jul 15, 2015 at 4:13 PM, Hanno Zulla <abos@hanno.de> wrote:
> Hi,
>
> who can help me add support for the following device?
>
> Being fairly ignorant of Bluetooth, I'm hoping for someone to guide me
> through this, alternatively I'm willing to borrow my device to any
> competent developer wanting to tackle this.
>
>
> The "Motorola Smart Controller RZ100" is a combined telephony headset
> and HID touchpad with four Android-specific buttons. It is designed to
> work as a remote control for Motorola Android devices.
>
> <https://motorola-global-portal.custhelp.com/app/product_page/faqs/p/1422,7975,8227>
>
> <http://www.amazon.com/Motorola-Bluetooth-Smart-Controller-Android/dp/B0060EKFYG>
>
> It is possible to pair this device with non-Motorola devices, but it
> doesn't work there. When paired with a Moto G Android phone, it worked
> out of the box.
>
> <https://code.google.com/p/android/issues/detail?id=180029>
>
> You can also check out the one-star reviews at Amazon (above) for a
> bunch of non-Moto-users complaining about this.

It might be missing a HID driver, but we can't help with Android since
it doesn't use BlueZ anymore except if you are flashing with BlueZ for
Android?


-- 
Luiz Augusto von Dentz
