Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Szymon Janc' <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1432900090-20152-1-git-send-email-bharat.panda@samsung.com>
 <2675140.GJPQpNdFbz@leonov> <02bd01d09a1f$ad982f40$08c88dc0$@samsung.com>
 <3694875.L2X9fu69MS@leonov>
In-reply-to: <3694875.L2X9fu69MS@leonov>
Subject: RE: [PATCH ] unit: Use g_memdup replacing g_malloc0+memcpy
Date: Mon, 01 Jun 2015 16:09:00 +0530
Message-id: <02e101d09c57$3040b820$90c22860$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Szymon Janc
> Sent: Friday, May 29, 2015 8:56 PM
> To: Bharat Bhusan Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] unit: Use g_memdup replacing g_malloc0+memcpy
> 
> Hi Bharat,
> 
> On Friday 29 of May 2015 20:26:40 Bharat Bhusan Panda wrote:
> > Hi Szymon,
> >
> > > -----Original Message-----
> > > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > > owner@vger.kernel.org] On Behalf Of Szymon Janc
> > > Sent: Friday, May 29, 2015 8:10 PM
> > > To: Bharat Panda
> > > Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> > > Subject: Re: [PATCH ] unit: Use g_memdup replacing g_malloc0+memcpy
> > >
> > > Hi Bharat,
> > >
> > > On Friday 29 of May 2015 17:18:10 Bharat Panda wrote:
> > > > Replace use of g_malloc0+memcpy with g_memdup.
> > > > ---
> > > >
> > > >  unit/test-gattrib.c | 3 +--
> > > >  unit/test-sdp.c     | 4 +---
> > > >  2 files changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c index
> > > > 416e596..d9c52d7 100644
> > > > --- a/unit/test-gattrib.c
> > > > +++ b/unit/test-gattrib.c
> > > > @@ -224,8 +224,7 @@ static void result_canary(guint8 status, const
> > > > guint8 *pdu, guint16 len, struct result_data *result = data;
> > > >
> > > >  	result->status = status;
> > > >
> > > > -	result->pdu = g_malloc0(len);
> > > > -	memcpy(result->pdu, pdu, len);
> > > > +	result->pdu = g_memdup(pdu, len);
> > > >
> > > >  	result->len = len;
> > > >
> > > >  	if (g_test_verbose())
> > > >
> > > > diff --git a/unit/test-sdp.c b/unit/test-sdp.c index
> > > > b4ef4d1..58d90f8
> > > > 100644
> > > > --- a/unit/test-sdp.c
> > > > +++ b/unit/test-sdp.c
> > > > @@ -189,9 +189,7 @@ static gboolean send_pdu(gpointer user_data)
> > > >
> > > >  	pdu_len = req_pdu->raw_size + context->cont_size;
> > > >
> > > > -	buf = g_malloc0(pdu_len);
> > > > -
> > > > -	memcpy(buf, req_pdu->raw_data, req_pdu->raw_size);
> > > > +	buf = g_memdup(req_pdu->raw_data, req_pdu->raw_size);
> > >
> > > This is not correct. If context->cont_size > 0 then you write after
> >
> > allocated
> >
> > > memory (see line below).
> >
> > Below line is to copy the context->cont_data after req_pdu->raw_size
> > length of req_pdu->raw_data.
> > But in above lines, it was allocating pdu_len size then doing memcpy
> > of req_pdu->raw_data, which was replaced by the g_memdup.
> 
> Yes. So instead of allocating pdu_len bytes you allocate only req_pdu-
> >raw_size bytes. This is not enough if context->cont_size is greater than
> zero. You have second memcpy just line below.
> 
> > > >  	if (context->cont_size > 0)
> > > >
> > > >  		memcpy(buf + req_pdu->raw_size, context->cont_data,
> 
> This will write after allocated memory.

Yes correct. I have submitted v2 incorporating your comments.

Thanks,
Best Regards
Bharat


