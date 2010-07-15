Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jul 2010 16:42:56 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Dan Tian <Dan.Tian@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3
 team.
Message-ID: <20100715194256.GA4307@vigoh>
References: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
 <20100715150921.GA3188@vigoh>
 <20100715184308.GF1166@tux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100715184308.GF1166@tux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

* Luis R. Rodriguez <lrodriguez@atheros.com> [2010-07-15 11:43:08 -0700]:

> On Thu, Jul 15, 2010 at 08:09:21AM -0700, Gustavo F. Padovan wrote:
> > Hi Dan,
> > 
> > * Dan Tian <Dan.Tian@Atheros.com> [2010-07-15 15:37:32 +0800]:
> > 
> > > From 40cbfbf5c1bc9109364970956d9b6f74f5846c70 Mon Sep 17 00:00:00 2001
> > > From: Haijun.Liu <Haijun.Liu@Atheros.com>
> > > Date: Wed, 14 Jul 2010 22:50:56 +0800
> > > Subject: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3 team.
> > > 
> > > 
> > > Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
> > > ---
> > >  include/net/bluetooth/hci.h      |  342 +++++++++++++++++++-
> > >  include/net/bluetooth/hci_core.h |  264 ++++++++++++++-
> > >  net/bluetooth/cmtp/core.c        |    1 +
> > >  net/bluetooth/hci_conn.c         |  201 +++++++++++-
> > >  net/bluetooth/hci_core.c         |  349 ++++++++++++++++++--
> > >  net/bluetooth/hci_event.c        |  698 +++++++++++++++++++++++++++++++++++++-
> > >  6 files changed, 1822 insertions(+), 33 deletions(-)
> > 
> > 
> > Could you split all your patches in little chunks? +1882 is very hard to
> > review. And please be more verbose on the commit message, it can help us
> > figure out what's happening.
> 
> This used to be 1 large patch, it was recently split up to 3, I havent't
> had a chance yet to review further but my understanding is this this was
> split up as much as possible in the last try. If you can provide suggestions
> how to split it up more that might be useful, but agreed, if possible more
> splitup would help.

But it is still too big. I looked to patch 3/3, it does a lot different
things in the same patch that make the patch impossible to be tracked.
We need atomic patches for at least each change in the ERTM code, each
new state added in the L2CAP state machine, each new HS feature, etc,
i.e., we need proper patches with proper commit messages explaining
what's happening. The same should apply to 1/3 and 2/3, I didn't looked
to them.

> 
> Dan, can you also please drop the "by Atheros Linux BT3 team." on the subject
> of the patches. This is already implied by the From and the Signed-off-by.

Dan, your patches don't apply cleanly upstream, please rebase them
against Marcel's bluetooth-next tree and do the proper split of the
patches.

-- 
Gustavo F. Padovan
http://padovan.org
