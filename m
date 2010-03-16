Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Mar 2010 11:49:59 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Przemo Firszt <przemo@firszt.eu>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	marcel <marcel@holtmann.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping <pinglinux@gmail.com>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] Expose wacom pen tablet battery and ac thru power_supply
 class
In-Reply-To: <1268690454.3452.7.camel@pldmachine>
Message-ID: <alpine.LNX.2.00.1003161149100.18642@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>  <1267531337.23521.14275.camel@localhost.localdomain>  <1267531889.23521.14301.camel@localhost.localdomain>  <1268161944.3632.21.camel@pldmachine> <1268162757.3632.33.camel@pldmachine>
 <alpine.LNX.2.00.1003092220160.17799@pobox.suse.cz>  <1268247817.3632.41.camel@pldmachine>  <alpine.LNX.2.00.1003151454110.18642@pobox.suse.cz> <1268690454.3452.7.camel@pldmachine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 15 Mar 2010, Przemo Firszt wrote:

> > > Does it make sense to add a line to Kconfig to explain that
> > > CONFIG_POWER_SUPPLY/CONFIG_POWER_SUPPLY_MODULE is required to enable
> > > monitoring battery/ac state?
> > 
> > Either that, or introducing separate CONFIG sub-option for the Wacom 
> > driver might be reasonable option as well.
> Hi Jiri,
> Thanks for help - next time I'll know how to do it :-)
> I went the CONFIG sub-option way - see attached.

I have applied it, thanks.

One question still though ..

> +       case POWER_SUPPLY_PROP_CAPACITY:
> +               /* show 100% battery capacity when charging */
> +               if (power_state == 0)
> +                       val->intval = 100;
> +               else
> +                       val->intval = power_state;
> +               break;

Why is it not possible to show the actual percentage in the charging state 
as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
