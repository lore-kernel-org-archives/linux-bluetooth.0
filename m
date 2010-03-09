Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Mar 2010 22:22:00 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Przemo Firszt <przemo@firszt.eu>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	marcel <marcel@holtmann.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping <pinglinux@gmail.com>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] Expose wacom pen tablet battery and ac thru power_supply
 class
In-Reply-To: <1268162757.3632.33.camel@pldmachine>
Message-ID: <alpine.LNX.2.00.1003092220160.17799@pobox.suse.cz>
References: <1267389553.24791.22.camel@pldmachine>  <1267531337.23521.14275.camel@localhost.localdomain>  <1267531889.23521.14301.camel@localhost.localdomain>  <1268161944.3632.21.camel@pldmachine> <1268162757.3632.33.camel@pldmachine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 9 Mar 2010, Przemo Firszt wrote:

> Please ignore previous patch

Hi Prezemo,

thanks for basing the patch on power_supply infrastructure.

Anyway, you'll have to sort out the new dependency on CONFIG_POWER_SUPPLY 
somehow (compiling the battery code out from the driver if 
CONFIG_POWER_SUPPLY is unset, or selecting it directly from Kconfig).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
