Return-Path: <cyrus@holtmann.org>
From: gene heskett <gheskett@wdtv.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix dbus reply memory leak
Date: Sat, 3 Dec 2011 16:00:26 -0500
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com> <20111202111510.GA15891@x220.ger.corp.intel.com> <4EDA85AA.3060400@gmail.com>
In-Reply-To: <4EDA85AA.3060400@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1256"
Message-Id: <201112031600.26954.gheskett@wdtv.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday, December 03, 2011 03:54:56 PM Syam Sidhardhan did opine:

> Hi Johan,
> 
> On 12/2/2011 4:45 PM, Johan Hedberg wrote:
> > Hi Syam,
> > 
> > On Thu, Nov 24, 2011, Syam Sidhardhan wrote:
> >> ---
> >> 
> >>   audio/telephony-maemo5.c |    8 ++++----
> >>   cups/main.c              |   30 +++++++++++++++++++++++++-----
> >>   test/agent.c             |    2 ++
> >>   test/mpris-player.c      |    6 +++++-
> >>   4 files changed, 36 insertions(+), 10 deletions(-)
> > 
> > Your commit message uses the word leak in singular form but there are
> > multiple fixes in this patch, i.e. the commit message is misleading.
> > In this case I'd split the patch into four separate ones:
> > 
> > telephony-maemo5: Fix D-Bus reply memory leaks
> > cups: Fix D-Bus reply memory leaks
> > agent: Fix D-Bus reply memory leaks
> > mpris-player: Fix D-Bus reply memory leaks
> > 
> > Johan
> 
> Yes, you are correct. You can split it into multiple patches.
> Thanks in advance.
> 
> Syam

Probably off topic to this patch discussion, but whats chances, while you 
folks are kicking dbus's tires, of fixing the thing so that if the target 
doesn't exist, the message sent gets thrown under the buss instead of 
blocking, which then requires a kill of both processes, and a proper 
sequentially done restart (target started first) to make it work?

Cheers, Gene
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
My web page: <http://coyoteden.dyndns-free.com:85/gene>
I am just a nice, clean-cut Mongolian boy.
	-- Yul Brynner, 1956
