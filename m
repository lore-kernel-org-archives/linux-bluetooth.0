Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 17:55:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/12] Varios fixes
Message-ID: <20140704145559.GA12719@t440s.P-661HNU-F1>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <10484533.kHJZOD5Lcv@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10484533.kHJZOD5Lcv@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 04, 2014, Szymon Janc wrote:
> On Friday 04 of July 2014 16:43:49 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Fixes hanging in my tree for some time
> > 
> > Andrei Emeltchenko (12):
> >   android/gatt: Change DBG() to error()
> >   android/gatt: Fix memory leak
> >   android/hal-msg: trivial: Correct coding style
> >   android/gatt: Fix warning by rearranging allocation
> >   android/haltest: Auto-accept pairing
> >   android/hal-gatt: Remove unneeded never read initialization
> >   android/gatt: Add missing error check
> >   android/haltest: Add check for valid channel
> >   android/tester: Remove unused assignment
> >   android/gatt: Fix length check
> >   cups: Remove dead code
> >   core: Remove dead code
> > 
> >  android/android-tester.c |  2 +-
> >  android/client/if-bt.c   | 16 +++++++++++++++-
> >  android/client/if-hl.c   |  4 ++++
> >  android/gatt.c           | 17 +++++++++++------
> >  android/hal-gatt.c       |  4 +---
> >  android/hal-msg.h        |  8 ++++----
> >  profiles/cups/main.c     |  7 +------
> >  src/profile.c            |  4 ----
> >  8 files changed, 37 insertions(+), 25 deletions(-)
> 
> Patches 1-10 are now applied, thanks. 

And I applied the remaining two.

Johan
