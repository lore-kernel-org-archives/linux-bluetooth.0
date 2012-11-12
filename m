Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Nov 2012 21:26:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 0/7] Manager/Adapter transition to ObjectManager
Message-ID: <20121112192607.GA6300@x220.P-661HNU-F1>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
 <20121112172346.GA6267@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121112172346.GA6267@x220.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> > Mikel Astiz (7):
> >   manager: Expose default adapter using property
> >   manager: Remove redundant D-Bus signals
> >   manager: Remove redundant Adapters property
> >   adapter: Remove redundant D-Bus signals
> >   adapter: Remove DevicesFound signal
> >   adapter: Remove redundant Devices property
> >   adapter: Remove FindDevice method from D-Bus API
> > 
> >  doc/adapter-api.txt |  32 +--------
> >  doc/manager-api.txt |  28 +-------
> >  src/adapter.c       | 187 +---------------------------------------------------
> >  src/manager.c       | 103 +++++++----------------------
> >  4 files changed, 29 insertions(+), 321 deletions(-)
> 
> All patches except 5/7 (which needs a bit more discussion) have been
> applied. Thanks.

I had to revert all of these since I didn't realize you hadn't updated
the test scripts (all of which broke with these patches). Also, it seems
the DefaultAdapter patch is also broken since I never saw that property
(e.g. with test/get-managed-objects). Please send a new patch set once
you've got the scripts converted and the DefaultAdapter patch fixed.
Thanks.

Johan
