Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Oct 2010 14:35:53 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: >net-wireless/bluez-4.63 unable to connect audio streams due
	commit
Message-ID: <20101004123552.GC11737@pengutronix.de>
References: <20100920184943.GA22968@jh-x301> <1286027890.12944.1.camel@localhost.localdomain> <AANLkTikFrvyeoXV0uLYcvD4GCj2s3ML2-q8f5GhXMxAK@mail.gmail.com> <1286187946.7898.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1286187946.7898.0.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Pacho,

On Mon, Oct 04, 2010 at 12:25:46PM +0200, Pacho Ramos wrote:
> > I would say this was because of double authentication request, but it
> > seems it is not the case, actually ssp doesn't seems to be used at all
> > here so this must be something else, maybe you should try this:
> > 
> > http://thread.gmane.org/gmane.linux.bluez.kernel/7256
> > 
> 
> Thanks but, how should I try to apply that patch? Looks like
> net/bluetooth/rfcomm/core.c is not present on bluez-4.72 sources
I guess this is a patch to apply to your kernel, not bluez.

Best regards
Uwe



-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
