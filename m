Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] SDP
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Santiago Carot Nemesio <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100427150516.GA11895@jh-x301>
References: <1272375265.2157.17.camel@mosquito>
	 <1272375425.2157.20.camel@mosquito> <1272375578.2157.22.camel@mosquito>
	 <20100427150516.GA11895@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 17:50:22 +0200
Message-ID: <1272383422.22838.151.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > This patch add memory checks after malloc function is called.
> > 
> > >From 7cce3be5a1a1d506f4da71fc394ee3ccf71d8159 Mon Sep 17 00:00:00 2001
> > From: Santiago Carot Nemesio <sancane@gmail.com>
> > Date: Tue, 27 Apr 2010 15:19:44 +0200
> > Subject: [PATCH 3/3] Added memory checks
> > 
> > 
> > Signed-off-by: Santiago Carot Nemesio <sancane@gmail.com>

not signed-off-by in BlueZ please. That is a kernel requirement.

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

Since you are suppose to use bt_free to free the memory, you also should
allocate it with bt_malloc. They are simple wrappers, but important to
make sure all library allocation and freeing is done with the same
function. Not free() or malloc() from library A against another one form
library B.

In most cases this makes no difference, but there are corner cases where
is does make a difference. So please keep bt_malloc() if the memory
needs to be freed by the application.

Regards

Marcel


