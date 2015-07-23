Return-Path: <cyrus@holtmann.org>
Message-ID: <55B0BC2D.6050202@hanno.de>
Date: Thu, 23 Jul 2015 12:04:29 +0200
From: Hanno Zulla <abos@hanno.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Motorola RZ100: How to add support for a new device?
References: <55A65C71.8010800@hanno.de>	 <CABBYNZKMYGr1+ADcDORoQ2docOg0dKePTnMqruaoF2UXio=p5g@mail.gmail.com>	 <55A7A70C.5030909@hanno.de> <1437051905.20249.82.camel@hadess.net>
In-Reply-To: <1437051905.20249.82.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> If it's handled through the "normal" HIDP stack on Android, it should
> at least create a hidraw device in stock Linux (which you can check for
> in the dmesg output).
> 
> You can then use hid-recorder to get the information from the device:
> http://bentiss.github.io/hid-replay-docs/
> 
> And start a discussion on the linux-input list about adding support for
> it.

Thanks a lot, that helped!

hid-recorder does indeed catch events for it.

I'll go to linux-input with it.

Regards,

Hanno
