Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: simon@mungewell.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] lib: Add flag to double L2CAP IMTU size used for SDP connection
Date: Mon, 20 Jan 2014 21:00:17 +0100
Message-ID: <5584991.ragWnAIfdC@athlon>
In-Reply-To: <649bfd2b8da26f5cf4b19f59d40d26fc.squirrel@mungewell.org>
References: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com> <649bfd2b8da26f5cf4b19f59d40d26fc.squirrel@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Monday 20 January 2014 12:31:14 simon@mungewell.org wrote:

<snip>

> I also noticed a weird log at one point, although only saw this once and
> don't know what triggered it.
> --
> [bluetooth]#
> [CHG] Device 1C:66:6D:07:C3:E0 Class: 0x200404
> [CHG] Device 1C:66:6D:07:C3:E0 Icon: audio-card <--------!!
> [CHG] Device 1C:66:6D:07:C3:E0 Class: 0x002508
> [CHG] Device 1C:66:6D:07:C3:E0 Icon: input-gaming
> --

Yes, I've seen this as well. I suspect that DS4 has some extra features 
related to audio (it has jack for headphones) and it enables that for PS4 
only, possibly switching to 'gamepad mode' if not connected to PS4. Maybe 
related to connecting USB first or sth...

But this is just my suspicion... 

-- 
Szymon K. Janc
szymon.janc@gmail.com
