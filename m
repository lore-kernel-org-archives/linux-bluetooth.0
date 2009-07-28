Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1248811940.23466.12248.camel@localhost.localdomain>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248811593.28545.227.camel@violet>
	 <1248811940.23466.12248.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 22:21:42 +0200
Message-Id: <1248812502.28545.229.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > The plugin allows us to restore the previous power state on
> > > adapters when the killswitch on them has been unblocked.
> > > 
> > > Otherwise we end up with the adapter disabled when coming back from a
> > > soft killswitch.
> > 
> > I think that having this as a plugin is overkill. I would just integrate
> > this as src/rfkill.c. Especially since it has no dependencies.
> 
> It would mean it's harder to change its behaviour. Surely, it would make
> more sense for this to be a plugin than for HCI operations to be.

the HCI operation are becoming/are a plugin, because we wanna switch to
netlink in the long term. However to do this, we need to separate them
first.

> Given that you don't use an object system with typing, it's probably one
> or 2 function calls off. To me, it makes sense to have parts of the core
> as plugins if it means that the core is leaner because of it.

Okay. Since we have built-in plugins, it makes no big difference.

Regards

Marcel


