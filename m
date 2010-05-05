Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] MCAP implementation for BlueZ
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100504200657.GC26732@vigoh>
References: <1272962595-4108-1-git-send-email-sancane@gmail.com>
	 <20100504200657.GC26732@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 May 2010 09:45:41 +0200
Message-ID: <1273045541.2105.27.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

El mar, 04-05-2010 a las 17:06 -0300, Gustavo F. Padovan escribió:
> Hi Santiago,
> 
> * Santiago Carot-Nemesio <sancane@gmail.com> [2010-05-04 10:43:15 +0200]:
> 
> > This patch enables MCAP in BlueZ.
> > Current implementation provides support for standard op. codes. Clock
> > Synchronization protocol is not yet supported.
> > ---
> >  Makefile.am     |   11 +-
> >  acinclude.m4    |    6 +
> >  mcap/mcap.c     | 2146 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mcap/mcap.h     |  176 +++++
> >  mcap/mcap_lib.h |  162 +++++
> >  5 files changed, 2500 insertions(+), 1 deletions(-)
> >  create mode 100644 mcap/mcap.c
> >  create mode 100644 mcap/mcap.h
> >  create mode 100644 mcap/mcap_lib.h
> 
> 2500+ lines is too big for review. MCAP is way complicated to
> understand completely. I suggest you to split this patch and send
> smaller ones for each feature of MCAP you implement, then we can review
> each piece and not at once.

You are rigth, I know it, but please, remember that it is a new
specification implemented from scratch, there were not any similar
profile in BlueZ wich i could take as reference point. I have done a lot
of changes in the architecture, interfaces, etc. until I found what IMHO
is a presentable implementation.
Sending patches with a non definitive implementation could have full of
noise the mailing list, I think that its better to have a base
implementation to discuss about.

I'm thinking that it may be interesting put my git in public to
everybody can see all development process, commit-by-commit. I have not
problem in doing that.

> 
> Also a MCAP test tool would be interesting to help on the
> review/merge/qualification process. Do you guys have one? Or are you
> planning to do one?

We have some home-made tools and scripts for testing MCAP, if you are
interested i'll put them in plubic git too.

Thanks in advance for your feedback.

Best regards.

