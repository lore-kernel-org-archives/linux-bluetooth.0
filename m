Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1426851395-29076-1-git-send-email-bharat.panda@samsung.com>
 <20150320120459.GA20347@t440s.ger.corp.intel.com>
In-reply-to: <20150320120459.GA20347@t440s.ger.corp.intel.com>
Subject: RE: [PATCH ] monitor: Add AVDTP support to btmon
Date: Fri, 20 Mar 2015 19:02:23 +0530
Message-id: <020f01d06312$5e137900$1a3a6b00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Johan Hedberg
> Sent: Friday, March 20, 2015 5:35 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] monitor: Add AVDTP support to btmon
> 
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

I have incorporated above review comments and submitted v2 for the same.

> Johan

Thanks
Best Regards,
Bharat

