Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+55aFz=9pmC5gBY11Lcwizro1KzSt1ms6iUkOLUNJovHu4k4A@mail.gmail.com>
Date: Fri, 17 Apr 2015 14:26:04 -0700
Cc: =?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <BD15FF48-C4C3-4FE6-BF24-7BB6B461AE07@holtmann.org>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com> <CA+55aFz3hLbESYbzeMWtyMLbYnCUr-Tx56DA_C=39wxhVGJd6g@mail.gmail.com> <CADDKRnCsTgDfAZ+rbzKvEXh2ut2=sMKBfS7a7YR+5Rxi02557g@mail.gmail.com> <CADDKRnBiB+z2iMc+04ZzntRkGhVW5isNQ+sLt-UVPg3mo+Q7jg@mail.gmail.com> <300602D8-9DB7-4F8D-AC97-B60924554093@holtmann.org> <CADDKRnB0ioBM+EQcNfuk4=BRw=CCxi4aFfZVpSXzJWmBPSNy+g@mail.gmail.com> <38429B86-0E46-4C6A-9954-3260D864B10C@holtmann.org> <CA+55aFx+NrXEtd4bveFbZqw0r9UHxkrQ7rzdZBbfBiGdvEX3zw@mail.gmail.com> <024FA95B-C70F-42ED-BDBF-69D09AA58203@holtmann.org> <CA+55aFz=9pmC5gBY11Lcwizro1KzSt1ms6iUkOLUNJovHu4k4A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Linus,

>> accepting all flags regardless was an oversight on my part in the first place. What this patch tried to do is to limit it to what userspace is currently actually using. My mistake was to look only at BlueZ 5.x userspace and not at BlueZ 4.x userspace.
> 
> So what about anybody else? Android doesn't use BlueZ, afaik. Any
> other direct accesses?

this interface is for bluetoothd (Bluetooth userspace daemon) since you need to do a lot of initial setup before you can hand this over to the kernel to drive HID. On Android this was never used. And even BlueZ for Android (replacement for Bluedroid) is not using it today either.

Google Fiber (their set-top boxes) actually moved this all over to /dev/uhid now since it gives them better re-connect experience for their remotes.

> If we already know that BlueZ 4.x did something else, what makes you
> so sure that this now covers all cases?

I am certain since nothing else than bluetoothd ever used this interface.

> The thing is, the bluetooth code has clearly never cared about these
> bits before. Is there any real reason to think that people haven't
> passed in garbage? Do we even know that those flags were *initialized*
> at all by user space in all use cases?
> 
> So I'm ok with trying to fix things up, but I have to say that if the
> fixed-up case also causes problems (because there was some other case
> that you didn't think of), I'm going to be pissed off, and I'm going
> to expect you to *jump* on it, and revert the whole thing.

The reason why I starting cleaning this up is because there is an overlay with internal and external flags mixed together. This is clearly a bug, but sadly that also can open up security issues since we clearly do not want userspace allowing messing with internal flags. That is actually worse.

My viewpoint is the reverting the whole patch is actually not helping here either. So either we take the patch that I just send around to fix the breakage that I caused with BlueZ 4.x userspace. Or an as alternative we keep allowing userspace to provide whatever flags it wants, but clear all unknown ones before using them in the HIDP logic. My intent was to make this old code less vulnerable.

Is one of these options acceptable for you compared to reverting the whole patch?

Regards

Marcel

