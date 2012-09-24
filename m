Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 02/18] eir: Add support for parsing SSP hash and randomizer
Date: Mon, 24 Sep 2012 12:20:20 +0200
Message-ID: <1547583.CpXLWu3Fx2@uw000953>
In-Reply-To: <20120924080845.GA19184@x220>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com> <1348230995-8967-3-git-send-email-szymon.janc@tieto.com> <20120924080845.GA19184@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 24 of September 2012 11:08:45 Johan Hedberg wrote:
> Hi Szymon,

Hi Johan,
 
> On Fri, Sep 21, 2012, Szymon Janc wrote:
> > +		case EIR_SSP_HASH:
> > +			if (data_len < 16)
> > +				break;
> > +			eir->hash = g_malloc(16);
> > +			memcpy(eir->hash, data, 16);
> > +			break;
> > +
> > +		case EIR_SSP_RANDOMIZER:
> > +			if (data_len < 16)
> > +				break;
> > +			eir->randomizer = g_malloc(16);
> > +			memcpy(eir->randomizer, data, 16);
> > +			break;
> 
> I suppose using g_memdup would be simpler than g_malloc + memcpy.

Yeap that looks simpler, will use g_memdup in next version.


-- 
BR
Szymon Janc
