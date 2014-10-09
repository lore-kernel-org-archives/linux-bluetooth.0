Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Oct 2014 10:57:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Subject: Re: [PATCH bluetooth-next] bluetooth: 6lowpan: fix skb_unshare
 behaviour
Message-ID: <20141009075736.GA6565@t440s.lan>
References: <1412756693-19410-1-git-send-email-alex.aring@gmail.com>
 <20141008083706.GA13231@t440s.lan>
 <20141008084736.GA19532@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141008084736.GA19532@omega>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Oct 08, 2014, Alexander Aring wrote:
> On Wed, Oct 08, 2014 at 11:37:06AM +0300, Johan Hedberg wrote:
> > Hi Alex,
> > 
> > On Wed, Oct 08, 2014, Alexander Aring wrote:
> > > This patch reverts commit:
> > > 
> > > a7807d73 ("Bluetooth: 6lowpan: Avoid memory leak if memory allocation
> > > fails")
> > > 
> > > which was wrong suggested by Alexander Aring. The function skb_unshare
> > > run also kfree_skb on failure.
> > > 
> > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > ---
> > > compile tested only.
> > > 
> > >  net/bluetooth/6lowpan.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > This doesn't look like something that should only go to bluetooth-next
> > (which you've tagged it for). The bluetooth-next tree (since 3.17 has
> > been released) has moved to catering 3.19 patches whereas this patch
> > seems to be something that's fixing an issue heading to 3.18-rc1. So it
> > seems to me this patch should in fact be going to the bluetooth.git tree
> > instead of bluetooth-next.git. Am I right?
> > 
> 
> yes, but commit a7807d73 isn't inside of bluetooth.git right now. Should
> I rebase it to some other repository or cc stable here?

No, you shouldn't need to do anything. We'll take care of rebasing
bluetooth.git appropriately, applying the patch and eventually making a
pull request for it. My only concern was with the "PATCH bluetooth-next"
annotation in the subject.

Johan
