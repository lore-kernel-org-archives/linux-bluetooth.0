Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetoothd does not autostart on boot
From: Bastien Nocera <hadess@hadess.net>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090818163341.60dc3fe1@stoetzler>
References: <20090818163341.60dc3fe1@stoetzler>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 22:13:56 +0100
Message-Id: <1250630036.12900.109.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-08-18 at 16:33 +0200, Stefan Seyfried wrote:
> Hi,
> 
> now with the fancy udev autostart, we have everything in place to get
> rid of the init script.
> 
> However, it does not work.
> 
> See e.g. https://bugzilla.novell.com/show_bug.cgi?id=527856
> Kay told me that in his opinion, udev is doing everything correctly and
> that using it to fix boot dependencies is not an option.
> 
> So I'm going to pack up a simple bluetooth init script that does
> nothing but 
> 
> 	udevadm trigger --subsystem-match=bluetooth
> 
> And, as Kay has found out, fedora does the same:
> http://cvs.fedora.redhat.com/viewvc/devel/bluez/bluetooth.init?view=markup&sortby=date
> 
> So the question is: how should we handle this upstream? Or should every
> distribution roll her own solution?

We do the same because what Kay told me would work doesn't actually
work. Having already spent a huge amount of time trying to make this
work, I had no option but to add the same work-around as Ubuntu.

FWIW, I already had a conversation with Kay through Harald Hoyer, where
Kay tried to deny that he ever told me that it would work (or rather,
that it would work, but that we should do it another way in the future).

You can discuss that with him.

Cheers

