Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Apr 2010 18:05:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot Nemesio <scarot@libresoft.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] SDP
Message-ID: <20100427150516.GA11895@jh-x301>
References: <1272375265.2157.17.camel@mosquito>
 <1272375425.2157.20.camel@mosquito>
 <1272375578.2157.22.camel@mosquito>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272375578.2157.22.camel@mosquito>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 27, 2010, Santiago Carot Nemesio wrote:
> This patch add memory checks after malloc function is called.
> 
> >From 7cce3be5a1a1d506f4da71fc394ee3ccf71d8159 Mon Sep 17 00:00:00 2001
> From: Santiago Carot Nemesio <sancane@gmail.com>
> Date: Tue, 27 Apr 2010 15:19:44 +0200
> Subject: [PATCH 3/3] Added memory checks
> 
> 
> Signed-off-by: Santiago Carot Nemesio <sancane@gmail.com>

I've pushed the first two patches upstream but I did have to fix their
commit messages before that. If you try "git am" yourself for what you
sent you'll see that the summary line becomes just "SDP" for all of them
and it should be more descriptive than that (for examples see the bluez
commit history).

The third patch should also see these changes but additionally there
were a few issues I noticed in the actual code:

>  			u = malloc(sizeof(uuid_t));
> +			if (!u) {
> +				errno = ENOMEM;
> +				goto fail;
> +			}

malloc will set the errno for you on failure so you shouldn't need to do
it in your code.

>  			lang = malloc(sizeof(sdp_lang_attr_t));
> +			if (!lang) {
> +				errno = ENOMEM;
> +				goto fail;

Same here.

> -	uuid_t *uuid128 = bt_malloc(sizeof(uuid_t));
> +	uuid_t *uuid128 = malloc(sizeof(uuid_t));

This seems unrelated to the other changes in the patch. I don't know the
exact philosophy of when bt_malloc should be used and when malloc should
be used (maybe Marcel can comment on that), but I'd simply leave this
change out of the patch.

Johan
