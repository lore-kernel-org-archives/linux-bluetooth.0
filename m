Return-Path: <cyrus@holtmann.org>
Message-ID: <3aaafc130812080809xb2d1be8o22e004c55a62b07b@mail.gmail.com>
Date: Mon, 8 Dec 2008 11:09:19 -0500
From: "J.R. Mauro" <jrm8005@gmail.com>
To: "Bastien Nocera" <hadess@hadess.net>
Subject: Re: Apple Mighty Mouse and aluminum keyboard woes
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1228728449.8307.8526.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081208015213.GA11816@tuxbook-pro>
	 <1228728449.8307.8526.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 8, 2008 at 4:27 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Sun, 2008-12-07 at 20:52 -0500, J.R. Mauro wrote:
>> Hello,
>>
>> I recently purchased an Apple Bluetooth Mighty Mouse and it's been giving me
>> some grief. Both the mouse and the aluminum bluetooth keyboard I own fail to
>> show up with hcitool or hidd, but both of them seem to be registering with the
>> input subsystem as they both work. I can only imagine this is because I paired
>> them with OS X (since I couldn't pair them with Linux).
>
> You couldn't pair them in Linux because you forgot to enable the
> Bluetooth adapter, eg. hciconfig's output is empty.

No, it's been on the whole time.

>
> Start the hid2hci daemon, and you will have Bluetooth.

I get "No devices in [HID, HCI] mode found" no matter what I run.

>
>>  Despite those hiccups,
>> both of the devices *work* but the mouse is not sending scroll or squeeze
>> events. I don't really care about the squeeze events, but the lack of scrolling
>> is quite aggravating.
>
> It doesn't have scrolling because you're currently using the device in
> "boot mode". Set it up properly using Bluetooth, and it'll work just
> fine.

That's a bit of a chicken and egg problem, because things like hcitool
scan literally can't find the devices. I put both devices in
/etc/bluetooth/hcid.conf, is there something else I have to do to set
them up? The guides on the web were pretty vague.

Sorry if I'm asking newbie questions here. If there's a particular
guide I should look at, I'd appreciate an "RTFM" with a link :)

>
> Cheers
>
>
