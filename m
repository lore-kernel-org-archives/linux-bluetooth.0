Return-Path: <cyrus@holtmann.org>
Message-ID: <1437735960.2863.20.camel@hadess.net>
Subject: Re: [PATCH 2/2 v3] sixaxis: Ask user whether cable configuration
 should be allowed
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Jul 2015 13:06:00 +0200
In-Reply-To: <359424171.AW1qIKcMiD@athlon>
References: <1436278465.26954.32.camel@hadess.net>
	 <359424171.AW1qIKcMiD@athlon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2015-07-24 at 00:33 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> On Tuesday 07 July 2015 16:14:25 Bastien Nocera wrote:
> > Previously, users doing cable configuration of Sixaxis PS3 
> > controllers
> > would only get asked whether a device was allowed to connect to the
> > computer when switching it to Bluetooth mode: unplugging it, and
> > pressing the PS button.
> > 
> > Instead, we should ask the user straight away, through the agent,
> > whether the pad should be allowed to connect.
> > 
> > This makes it easier to setup those devices, while keeping 
> > security.
> 
> Wouldn't this confuse user so that he may think device is already 
> connected 
> over BT?

No, because either:
- you don't want to pair the device with your computer, which is
impossible to do right now, and you can now do if you don't have an
agent, or reject the association
- you do want to be able to use it via Bluetooth, and we can have the
association happen in one go, instead of being 2 separate actions.

>  Also what would happen if user remove this from usb before 
> confirming?

I didn't implement this, but we should cancel the existing
authentication request indeed.

>  And if PS button is pressed then, second authorization request for 
> same UUID would be send?

It wouldn't do anything, as there's already an auth request in flux.

> Since this change plugin behavior in end user visible way this needs 
> to be 
> carefully thought out. It looks like people have different 
> requirements for 
> sixaxis security...

This is actually more secure than what came before, and it's also far
more predictable. It's the same security as before, but requires an
agent to be available when the device is plugged in.

>  so maybe it should have a sort of policy settings in 
> config file? Opinions?

What would the other policy be? I don't see a difference between the
current security behaviour, and the one set out in this patch.
