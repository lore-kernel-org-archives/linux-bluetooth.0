Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] SDP
From: Santiago Carot Nemesio <scarot@libresoft.es>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100427150516.GA11895@jh-x301>
References: <1272375265.2157.17.camel@mosquito>
	 <1272375425.2157.20.camel@mosquito> <1272375578.2157.22.camel@mosquito>
	 <20100427150516.GA11895@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 17:59:08 +0200
Message-ID: <1272383948.6354.2.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El mar, 27-04-2010 a las 18:05 +0300, Johan Hedberg escribió:
> Hi,
> 
> On Tue, Apr 27, 2010, Santiago Carot Nemesio wrote:
> > This patch add memory checks after malloc function is called.
> > 
> > >From 7cce3be5a1a1d506f4da71fc394ee3ccf71d8159 Mon Sep 17 00:00:00 2001
> > From: Santiago Carot Nemesio <sancane@gmail.com>
> > Date: Tue, 27 Apr 2010 15:19:44 +0200
> > Subject: [PATCH 3/3] Added memory checks
> > 
> > 
> > Signed-off-by: Santiago Carot Nemesio <sancane@gmail.com>
> 
> I've pushed the first two patches upstream but I did have to fix their
> commit messages before that. If you try "git am" yourself for what you
> sent you'll see that the summary line becomes just "SDP" for all of them
> and it should be more descriptive than that (for examples see the bluez
> commit history).
> 
> The third patch should also see these changes but additionally there
> were a few issues I noticed in the actual code:
> 
> >  			u = malloc(sizeof(uuid_t));
> > +			if (!u) {
> > +				errno = ENOMEM;
> > +				goto fail;
> > +			}
> 

I known it, but much parts in sdp.c code still set errno to ENOMEM value
when malloc fails, it is the reason which i set it to ENOMEM too.

> malloc will set the errno for you on failure so you shouldn't need to do
> it in your code.
> 
> >  			lang = malloc(sizeof(sdp_lang_attr_t));
> > +			if (!lang) {
> > +				errno = ENOMEM;
> > +				goto fail;
> 
> Same here.
> 
> > -	uuid_t *uuid128 = bt_malloc(sizeof(uuid_t));
> > +	uuid_t *uuid128 = malloc(sizeof(uuid_t));
> 
> This seems unrelated to the other changes in the patch. I don't know the
> exact philosophy of when bt_malloc should be used and when malloc should
> be used (maybe Marcel can comment on that), but I'd simply leave this
> change out of the patch.
> 
> Johan


