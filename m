Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] adapter: Set default adapter id sooner
Date: Wed, 06 Feb 2013 20:54:23 +0100
Message-ID: <1400835.sPdLnLEf1A@athlon>
In-Reply-To: <1360137464.15783.7.camel@aeonflux>
References: <1360098656-12488-1-git-send-email-szymon@janc.net.pl> <1360098656-12488-2-git-send-email-szymon@janc.net.pl> <1360137464.15783.7.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 06 February 2013 09:57:44 Marcel Holtmann wrote:

Hi Marcel,
 
> > When first adapter is registered set it as default before probing
> > drivers or profiles as those might depend on that e.g. hostname.
> > 
> > This fix hostname plugin setting default adapter name to 'foo #1'
> > instead of 'foo' if pretty hostname was received before probing
> > adapter drivers.
> 
> you find an issue that I meant to fix, but never got around so far. So I
> do not like the magic default_adapter_id global variable.
> 
> I would prefer if we add a is_default or similar variable to btd_adapter
> and make it change if one adapter goes away.

OK, will send v2 which address that.

-- 
Szymon K. Janc
szymon@janc.net.pl
