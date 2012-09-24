Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 05/18] oob: Allow to register pairing complete callback
Date: Mon, 24 Sep 2012 13:28:51 +0200
Message-ID: <4152119.R0jHNBc7xV@uw000953>
In-Reply-To: <20120924090626.GB19184@x220>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com> <1348230995-8967-6-git-send-email-szymon.janc@tieto.com> <20120924090626.GB19184@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 24 of September 2012 12:06:26 Johan Hedberg wrote:
> Hi Szymon,

Hi Johan,

> On Fri, Sep 21, 2012, Szymon Janc wrote:
> > --- a/src/mgmt.c
> > +++ b/src/mgmt.c
> > @@ -1193,6 +1193,7 @@ static void pair_device_complete(int sk, uint16_t index, uint8_t status,
> >  	info = &controllers[index];
> >  
> >  	bonding_complete(info, &rp->addr.bdaddr, status);
> > +	oob_pairing_complete(&info->bdaddr, &rp->addr.bdaddr, status);
> >  }
> 
> Can't we be a bit smarter than always notifying the oob code. Don't we
> e.g. have the possibility to look at the IO capabilities used in the
> pairing process or some other means from which we can conclude that this
> was an OOB-based pairing that completed?

Hash and randomizer are optional tags (only address is mandatory) so there
might be only OOB discovery and in-band pairing (OOB data present flag not
set in iocapa).

I could try to make OOB callbacks registering mechanism a bit more runtime
aware (register/unregister on-demand basis) or bit-more compile time aware
(hide after a macro and enable only if one of oob plugin is build).

Not sure if this would not over-complicate that code to much... opinions?

> 
> Johan

-- 
BR
Szymon Janc
