Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1248811593.28545.227.camel@violet>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248811593.28545.227.camel@violet>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 21:12:20 +0100
Message-Id: <1248811940.23466.12248.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-07-28 at 22:06 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > The plugin allows us to restore the previous power state on
> > adapters when the killswitch on them has been unblocked.
> > 
> > Otherwise we end up with the adapter disabled when coming back from a
> > soft killswitch.
> 
> I think that having this as a plugin is overkill. I would just integrate
> this as src/rfkill.c. Especially since it has no dependencies.

It would mean it's harder to change its behaviour. Surely, it would make
more sense for this to be a plugin than for HCI operations to be.

Given that you don't use an object system with typing, it's probably one
or 2 function calls off. To me, it makes sense to have parts of the core
as plugins if it means that the core is leaner because of it.
