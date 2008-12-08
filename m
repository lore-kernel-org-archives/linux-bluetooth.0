Return-Path: <cyrus@holtmann.org>
Subject: Re: Apple Mighty Mouse and aluminum keyboard woes
From: Bastien Nocera <hadess@hadess.net>
To: "J.R. Mauro" <jrm8005@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081208015213.GA11816@tuxbook-pro>
References: <20081208015213.GA11816@tuxbook-pro>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 09:27:29 +0000
Message-Id: <1228728449.8307.8526.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2008-12-07 at 20:52 -0500, J.R. Mauro wrote:
> Hello,
> 
> I recently purchased an Apple Bluetooth Mighty Mouse and it's been giving me
> some grief. Both the mouse and the aluminum bluetooth keyboard I own fail to
> show up with hcitool or hidd, but both of them seem to be registering with the
> input subsystem as they both work. I can only imagine this is because I paired
> them with OS X (since I couldn't pair them with Linux).

You couldn't pair them in Linux because you forgot to enable the
Bluetooth adapter, eg. hciconfig's output is empty.

Start the hid2hci daemon, and you will have Bluetooth.

>  Despite those hiccups,
> both of the devices *work* but the mouse is not sending scroll or squeeze
> events. I don't really care about the squeeze events, but the lack of scrolling
> is quite aggravating.

It doesn't have scrolling because you're currently using the device in
"boot mode". Set it up properly using Bluetooth, and it'll work just
fine.

Cheers

