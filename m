Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Mar 2010 14:54:56 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Przemo Firszt <przemo@firszt.eu>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	marcel <marcel@holtmann.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping <pinglinux@gmail.com>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] Expose wacom pen tablet battery and ac thru power_supply
 class
In-Reply-To: <1268247817.3632.41.camel@pldmachine>
Message-ID: <alpine.LNX.2.00.1003151454110.18642@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>  <1267531337.23521.14275.camel@localhost.localdomain>  <1267531889.23521.14301.camel@localhost.localdomain>  <1268161944.3632.21.camel@pldmachine> <1268162757.3632.33.camel@pldmachine>
 <alpine.LNX.2.00.1003092220160.17799@pobox.suse.cz> <1268247817.3632.41.camel@pldmachine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 10 Mar 2010, Przemo Firszt wrote:

> > Anyway, you'll have to sort out the new dependency on CONFIG_POWER_SUPPLY 
> > somehow (compiling the battery code out from the driver if 
> > CONFIG_POWER_SUPPLY is unset, or selecting it directly from Kconfig).
> Thanks for checking the patch.
> See attached updated version - is it OK?
> Does it make sense to add a line to Kconfig to explain that
> CONFIG_POWER_SUPPLY/CONFIG_POWER_SUPPLY_MODULE is required to enable
> monitoring battery/ac state?

Either that, or introducing separate CONFIG sub-option for the Wacom 
driver might be reasonable option as well.

Otherwise the patch looks good.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
