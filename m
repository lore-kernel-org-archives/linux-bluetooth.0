Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] move tools/l2ping.1 to man section 8
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090703144328.GA18534@jh-x301>
References: <1246445925-14815-1-git-send-email-filippo@esaurito.net>
	 <20090703144328.GA18534@jh-x301>
Content-Type: text/plain
Date: Sun, 05 Jul 2009 09:44:53 -0700
Message-Id: <1246812293.12994.218.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > usually only root is able to invoke l2ping thus move to man section 8
> > ---
> >  tools/Makefile.am |    2 +-
> >  tools/l2ping.1    |   76 -----------------------------------------------------
> >  tools/l2ping.8    |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 77 insertions(+), 77 deletions(-)
> 
> This one is now pushed upstream. Thanks.

and it seems nobody checked with make distcheck that it still works. I
fixed that now.

Regards

Marcel


