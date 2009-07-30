Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jul 2009 13:23:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	David.Weinehall@nokia.com
Subject: Re: [PATCH] Add rfkill plugin
Message-ID: <20090730102321.GB6082@jh-x301>
References: <1248798884.23466.12024.camel@localhost.localdomain> <1248880408.28327.906.camel@localhost.localdomain> <1248896967.28545.236.camel@violet> <1248898544.28327.1539.camel@localhost.localdomain> <1248899010.28545.241.camel@violet> <20090729214412.GA24031@jh-x301> <1248921041.28545.248.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248921041.28545.248.camel@violet>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 30, 2009, Marcel Holtmann wrote:
> > So having a btd_adapter_set_powered exported to plugins (which is what
> > Bastien's patch seems to do) makes sense to me in this case. I might
> > actually need something similar for maemo in order to handle our offline
> > mode better (maemo specific plugin to catch the MCE offline mode signal
> > and then call btd_adapter_set_powered).
> 
> then I leave this with you to export that function correctly. It should
> be a separate patch anyway.

Ok. Maybe Bastien can split this out from his original patch? Note that
the function should probably have the btd_ prefix since the idea has been
that only functions like that get exported to plugins (not sure if it's
actually enforced yet though).

> I would disagree with the MCE offline handling as a plugin. First off
> all, why is it not integrated into RFKILL. Second off all, it could just
> use RFKILL or RememberPowered=false and change Powered by itself. The
> listening to offline signal is the wrong design.

You're probably right, however this is what I have to live with in the
current maemo version. I've added David to CC so he can comment on the
possibility of replacing MCE offline/normal mode signals with rfkill in
the future.

Johan
