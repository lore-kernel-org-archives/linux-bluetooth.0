Return-Path: <akpm@linux-foundation.org>
Date: Sun, 4 Mar 2007 18:26:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        Sid Boyce <g3vbv@blueyonder.co.uk>, Pavel Machek <pavel@ucw.cz>,
        Marcel Holtmann <marcel@holtmann.org>, linux-pm@lists.osdl.org,
        maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
        Mark Lord <lkml@rtr.ca>, Greg KH
 <greg@kroah.com>,
        Matt Mackall <mpm@selenic.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Albert Hopkins
 <kernel@marduk.letterboxes.org>,
        Ayaz Abdulla <aabdulla@nvidia.com>, Jeff
 Garzik <jeff@garzik.org>,
        netdev@vger.kernel.org
Subject: Re: [1/6] 2.6.21-rc2: known regressions
Message-Id: <20070304182619.6110bd74.akpm@linux-foundation.org>
In-Reply-To: <20070305015031.GF3441@stusta.de>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
	<20070305015031.GF3441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 5 Mar 2007 02:50:31 +0100 Adrian Bunk <bunk@stusta.de> wrote:

> This email lists some known regressions in 2.6.21-rc2 compared to 2.6.20
> that are not yet fixed in Linus' tree.


We seem to have broken an unusually large amount of stuff this time.

partial post-mortem:

- The ACPICA merge landed in -mm super-late: basically it was in mainline
  a week afterwards and saw only a single -mm release.

  Part of the reason for this short period in -mm was that ACPICA had its
  paws all over x86_64 code and conflicted badly with significant changes
  in the x86_64 tree.

  That happens sometimes.  But when it does, the mess lands in my lap
  rather than in the laps of the perpetrators.

  Lesson: keep the code well-factored so that different subsystems don't
  soil each others' kennels.

- The hrtimers/dynticks stuff is simply hard: timekeeping, low-level x86,
  even APICs.  These are areas in which things break a lot, so churning it
  was inevitably going to cause problems.

  Lesson: none, I think.  Low-level x86 support is just hard, and
  changing it breaks things.


So that accounts for _some_ of the damage, but I wonder if there's more to
it than that.
