Return-Path: <cyrus@holtmann.org>
Message-ID: <1437051905.20249.82.camel@hadess.net>
Subject: Re: Motorola RZ100: How to add support for a new device?
From: Bastien Nocera <hadess@hadess.net>
To: Hanno Zulla <abos@hanno.de>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 16 Jul 2015 15:05:05 +0200
In-Reply-To: <55A7A70C.5030909@hanno.de>
References: <55A65C71.8010800@hanno.de>
	 <CABBYNZKMYGr1+ADcDORoQ2docOg0dKePTnMqruaoF2UXio=p5g@mail.gmail.com>
	 <55A7A70C.5030909@hanno.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2015-07-16 at 14:43 +0200, Hanno Zulla wrote:
> Hi,
> 
> > It might be missing a HID driver, but we can't help with Android 
> > since
> > it doesn't use BlueZ anymore except if you are flashing with BlueZ 
> > for
> > Android?
> 
> I don't mind. While it'd be nice to nudge Google towards adding this
> driver to Android, I want to make it work with Linux desktop 
> machines,
> as well.

If it's handled through the "normal" HIDP stack on Android, it should
at least create a hidraw device in stock Linux (which you can check for
in the dmesg output).

You can then use hid-recorder to get the information from the device:
http://bentiss.github.io/hid-replay-docs/

And start a discussion on the linux-input list about adding support for
it. Given the price of the device, you could always offer to buy one of
the linux-input developers one of them, I found that it's usually a
pretty good incentive :)

Cheers

