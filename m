Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Aug 2008 22:27:01 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-pcmcia@lists.infradead.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/39] pcmcia: use pcmcia_loop_config in bluetooth drivers
Message-ID: <20080818202701.GA31636@isilmar.linta.de>
References: <20080818185025.GA11647@comet.dominikbrodowski.net> <1219085610-12289-4-git-send-email-linux@dominikbrodowski.net> <1219089431.7591.66.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219089431.7591.66.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 18, 2008 at 09:57:11PM +0200, Marcel Holtmann wrote:
> > CC: Marcel Holtmann <marcel@holtmann.org>
> > CC: linux-bluetooth@vger.kernel.org
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> I know that the Bluetooth PCMCIA drivers are not the best examples for
> coding style, but please double check your whitespaces/tabs. We don't
> wanna make it worse.

actually, I'm pondering making a CodingStyle cleanup of the whole PCMCIA
subsystem for drivers/pcmcia/ is so unbelievable un-CodingStyle... but:

> 
> > -	return get_tuple(handle, tuple, parse);
> > +        unsigned long try = (unsigned long) priv_data;
> > +
> > +       if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
> > +               p_dev->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;

something went badly wrong here, will fix it up (probably in a follow-up
patch).

Thanks,
	Dominik
