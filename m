Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bug in sdp_set_supp_features solved
Date: Thu, 29 Apr 2010 00:28:05 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201004281208.35923.jcaden@libresoft.es> <20100428195127.GA24058@jh-x301>
In-Reply-To: <20100428195127.GA24058@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004290028.06125.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Wednesday 28 April 2010 21:51:27 Johan Hedberg escribió:
> Hi,
> 
> On Wed, Apr 28, 2010, José Antonio Santos Cadenas wrote:
> > From 567522ed4ac5912d967fef3017bf905591b5c24e Mon Sep 17 00:00:00 2001
> > From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
> > Date: Wed, 28 Apr 2010 12:02:31 +0200
> > Subject: [PATCH] Bug in sdp_set_supp_features solved
> > 
> > When the data is a string or a sequence, it is not ok to dereference
> > data->val because it is already a pointer.
> > ---
> >  lib/sdp.c |   33 +++++++++++++++++++++++++++++++--
> >  1 files changed, 31 insertions(+), 2 deletions(-)
> 
> The patch has been pushed upstream with some minor changes. I had to
> edit the commit message again (try "git am" on your mail yourself and
> you'll see the diffeqrence to what got pushed upstream)

I see, sorry I sent copiying to the mail reader the patch generated with
git format-patch. I'll take it in count in the future and use git mail

> and I named the
> new variable lengths instead of sizes since the function it gets passed
> to is called sdp_seq_alloc_with_length.
> 
> Since there's no code in the bluez tree that calls this
> sdp_set_supp_features function do you perhaps have some simple code
> snippet/use case that the fixed functionality could be tested with?

I'll try to do some simple program, but we are working on HDP profile that will 
use this code.

Regards

Jose.

> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
