Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: simon@mungewell.org
Cc: linux-bluetooth@vger.kernel.org,
	Veseli Veseljko <veseljko75@gmail.com>,
	Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>
Subject: Re: [PATCH 1/5] sixaxis: Fix PID for Navigation Controller
Date: Mon, 15 Jun 2015 22:02:17 +0200
Message-ID: <1593424.6SLvHIYhAG@athlon>
In-Reply-To: <1690931.rDxa1ayEBf@athlon>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com> <467bb868b4b5b8120da0818a969eb054.squirrel@mungewell.org> <1690931.rDxa1ayEBf@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 15 June 2015 21:47:24 Szymon Janc wrote:
> Hi Simon,
> 
> On Monday 15 June 2015 14:45:39 simon@mungewell.org wrote:
> > > Navigation Controller is using PID 0x042f over USB but PID 0x0268
> > > (same as Dualshock 3) over BT.
> > 
> > Hi,
> > I'm in the process of fixing the hid-sony driver to support the
> > Navigation, and I'm seeing that it connects with 0x042f over BT. I did see
> > at least once when it used the 0x0268, so it must be switching into an
> > emulation mode at some times.
> 
> I did some more testing and you are right, it seems to be connecting using
> both PIDs, but I couldn't figure out a pattern.
> 
> > I don't have a good way on initiating the pairing, instead used a
> > hacked-up 'psmovepair' from PSMoveAPI guys. Followed by some hand editing
> > of '/var/lib/bluetooth/<my-mac>/*' files.
> 
> Sixaxis plugin should work for setting up Navigation.
> 
> > Happy to share files/info with you,
> 
> So, I'm not sure how to handle this. At least for me it looks like
> Navigation works just fine if setup as 0x0268 even if connects as 0x042f.
> The opposite doesn't work.
> 
> Any thoughts?

OK, so we could left this as is now and allow to query SDP for Navigation 
regardless of PID used over BT. This way it will always provide updated PNP 
info to a driver. And SDP record would be provided only for devices 
identifying as DS3 over USB.

That way Navigation should work in same way it is working now and DS3 clones 
without SDP would also work.

-- 
Szymon K. Janc
szymon.janc@gmail.com
