Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Szymon Janc' <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1433155474-29992-1-git-send-email-bharat.panda@samsung.com>
 <1574967.CdNyU3mLK2@leonov>
In-reply-to: <1574967.CdNyU3mLK2@leonov>
Subject: RE: [PATCH v2] unit: Use g_memdup replacing g_malloc0+memcpy
Date: Mon, 01 Jun 2015 16:24:38 +0530
Message-id: <02e301d09c59$5ff99940$1feccbc0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Szymon Janc
> Sent: Monday, June 01, 2015 4:13 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH v2] unit: Use g_memdup replacing g_malloc0+memcpy
> 
> Hi Bharat,
> 
> On Monday 01 of June 2015 16:14:34 Bharat Panda wrote:
> > Replace use of g_malloc0+memcpy with g_memdup.
> > ---
> >  unit/test-gattrib.c | 3 +--
> >  unit/test-sdp.c     | 4 +---
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c index
> > 416e596..d9c52d7 100644
> > --- a/unit/test-gattrib.c
> > +++ b/unit/test-gattrib.c
> > @@ -224,8 +224,7 @@ static void result_canary(guint8 status, const
> > guint8 *pdu, guint16 len, struct result_data *result = data;
> >
> >  	result->status = status;
> > -	result->pdu = g_malloc0(len);
> > -	memcpy(result->pdu, pdu, len);
> > +	result->pdu = g_memdup(pdu, len);
> >  	result->len = len;
> >
> >  	if (g_test_verbose())
> > diff --git a/unit/test-sdp.c b/unit/test-sdp.c index b4ef4d1..9d716d8
> > 100644
> > --- a/unit/test-sdp.c
> > +++ b/unit/test-sdp.c
> > @@ -189,9 +189,7 @@ static gboolean send_pdu(gpointer user_data)
> >
> >  	pdu_len = req_pdu->raw_size + context->cont_size;
> >
> > -	buf = g_malloc0(pdu_len);
> > -
> > -	memcpy(buf, req_pdu->raw_data, req_pdu->raw_size);
> > +	buf = g_memdup(req_pdu->raw_data, pdu_len);
> 
> This is still not correct. If context->cont_size > 0 you will read from
invalid
> memory after req_pdu->raw_data buffer ends.
> 
> g_memdup just doesn't fit here.

Yes, thanks. It really does not fit here. 
I shall ignore this patch, or if test-gattrib part is considered, then I
shall re-submit with that change only.

> 
> >
> >  	if (context->cont_size > 0)
> >  		memcpy(buf + req_pdu->raw_size, context->cont_data,
> 
> --
> BR
> Szymon Janc

Best Regards,
Bharat


