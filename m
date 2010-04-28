Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Added memory checks whenever memory is allocated in SDP
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100428074642.GA30577@jh-x301>
References: <1272439009.2203.3.camel@mosquito>
	 <20100428074642.GA30577@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 09:53:05 +0200
Message-ID: <1272441185.2203.4.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

El mié, 28-04-2010 a las 10:46 +0300, Johan Hedberg escribió:
> Hi,
> 
> On Wed, Apr 28, 2010, Santiago Carot-Nemesio wrote:
> > This patch checks memory allocated with malloc and removes uneccessary (**void) castings.
> > 
> > >From d80347d56e730388d1eca190e60c3c09ac62db27 Mon Sep 17 00:00:00 2001
> > From: Santiago Carot-Nemesio <sancane@gmail.com>
> > Date: Wed, 28 Apr 2010 09:10:24 +0200
> > Subject: [PATCH] Added memory checks whenever memory is allocated in SDP
> > 
> > ---
> >  lib/sdp.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 files changed, 77 insertions(+), 10 deletions(-)
> 
> Thanks. This one is now pushed upstream after (still) some manual
> editing of the commit message for it to not contain longer lines than 74
> characters (the lines should be short enough for them to fit into a
> 80-character wide terminal when doing "git log").
> 

Ok, I'll keep it in mind for next time.

> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


