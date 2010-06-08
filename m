Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] sbc: Fix redundant null check on calling free()
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100608062116.GA16634@jh-x301>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
	 <1275732870-15889-2-git-send-email-gustavo@padovan.org>
	 <20100608062116.GA16634@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Jun 2010 00:13:20 -0700
Message-ID: <1275981200.2182.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Issues found by smatch static check: http://smatch.sourceforge.net/
> > ---
> >  sbc/sbc.c    |    3 +--
> >  sbc/sbcdec.c |    9 +++------
> >  2 files changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/sbc/sbc.c b/sbc/sbc.c
> > index edd152f..86399dd 100644
> > --- a/sbc/sbc.c
> > +++ b/sbc/sbc.c
> > @@ -1138,8 +1138,7 @@ void sbc_finish(sbc_t *sbc)
> >  	if (!sbc)
> >  		return;
> >  
> > -	if (sbc->priv_alloc_base)
> > -		free(sbc->priv_alloc_base);
> > +	free(sbc->priv_alloc_base);
> 
> I'm a bit hesitant at removing these NULL checks since older libc
> versions might need them. Any comments from Marcel?

this is just fine. If you have such an old libc version that doesn't do
it, then you have a problem anyway. I am also not sure that this is a
problem with any libc version at all.

The only argument that might hold this is if you wanna compile this for
a non GNU platform. I don't even know if that is possible since I
actually don't care about non Linux platforms.

Regards

Marcel


