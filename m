Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Expose wacom pen tablet battery and ac thru
 power_supply class
From: Przemo Firszt <przemo@firszt.eu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>, Ping <pinglinux@gmail.com>, Peter Huewe <peterhuewe@gmx.de>
In-Reply-To: <alpine.LNX.2.00.1003161149100.18642@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>
	 <1267531337.23521.14275.camel@localhost.localdomain>
	 <1267531889.23521.14301.camel@localhost.localdomain>
	 <1268161944.3632.21.camel@pldmachine> <1268162757.3632.33.camel@pldmachine>
	 <alpine.LNX.2.00.1003092220160.17799@pobox.suse.cz>
	 <1268247817.3632.41.camel@pldmachine>
	 <alpine.LNX.2.00.1003151454110.18642@pobox.suse.cz>
	 <1268690454.3452.7.camel@pldmachine>
	 <alpine.LNX.2.00.1003161149100.18642@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Mar 2010 14:09:36 +0000
Message-ID: <1268748576.4682.16.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Dnia 2010-03-16, wto o godzinie 11:49 +0100, Jiri Kosina pisze:
[..]
> I have applied it, thanks.
Thanks!
> One question still though ..
> 
> > +       case POWER_SUPPLY_PROP_CAPACITY:
> > +               /* show 100% battery capacity when charging */
> > +               if (power_state == 0)
> > +                       val->intval = 100;
> > +               else
> > +                       val->intval = power_state;
> > +               break;
> 
> Why is it not possible to show the actual percentage in the charging state 
> as well?
The device doesn't report capacity during charging as far as I can tell.
We could keep last reported value (bad idea IMHO), set it to 0 (even
worse) or set it to 100% - a bit misleading, but I can't see any other
option.

cheers,
Przemo
