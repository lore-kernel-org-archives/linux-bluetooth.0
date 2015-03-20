Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Bharat Panda <bharat.panda@samsung.com>,
	linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH ] monitor: Add AVDTP support to btmon
Date: Fri, 20 Mar 2015 13:17:46 +0100
Message-ID: <4447842.jsmiU4PHsP@leonov>
In-Reply-To: <20150320120459.GA20347@t440s.ger.corp.intel.com>
References: <1426851395-29076-1-git-send-email-bharat.panda@samsung.com> <20150320120459.GA20347@t440s.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Friday 20 of March 2015 14:04:59 Johan Hedberg wrote:
> Hi Bharat,
> 
> On Fri, Mar 20, 2015, Bharat Panda wrote:
> > +static char *pt2str(uint8_t hdr)
> 
> This should be static const char *
> 
> > +static char *mt2str(uint8_t hdr)
> 
> Same here.
> 
> > +static char *sig2str(uint8_t tsid)
> 
> And here.
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

While on this it would be really nice to have option for filtering out AVDTP 
from btmon output (ideally that would be for A2DP data traffic but we are not 
there yet).

-- 
BR
Szymon Janc
