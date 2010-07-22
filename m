Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jul 2010 20:40:08 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 29/60] Fix missed state transition in MCAP
Message-ID: <20100722234008.GD2620@vigoh>
References: <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
 <20100722233722.GC2620@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100722233722.GC2620@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

* Gustavo F. Padovan <gustavo@padovan.org> [2010-07-22 20:37:22 -0300]:

> Hi Jose,
> 
> * Jose Antonio Santos Cadenas <santoscadenas@gmail.com> [2010-07-22 10:56:22 +0200]:
> 
> > From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>
> > 
> > MCL should transite to properly state when a create_mdl_req is
> > not SUCCESS
> > ---
> >  mcap/mcap.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/mcap/mcap.c b/mcap/mcap.c
> > index cf92368..1dfe083 100644
> > --- a/mcap/mcap.c
> > +++ b/mcap/mcap.c
> > @@ -1260,6 +1260,7 @@ fail:
> >  	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
> >  	g_free(mdl);
> >  	g_error_free(gerr);
> > +	update_mcl_state(mcl);
> >  	return close;
> >  }
> 
> The same should apply here. Can you merge this with the original commit
> that implemented create_mdl_req(), can't you?

There should be another patches here in the same situation, I'm not
checking all of them for this. Please check them and fix into the
original commits when possible. That can make the review easier. ;)

-- 
Gustavo F. Padovan
http://padovan.org
