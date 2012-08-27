Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Aug 2012 16:40:54 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: linux-bluetooth@vger.kernel.org,
	Patrick Ohly <patrick.ohly@intel.com>,
	Pacho Ramos <pacho@gentoo.org>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
Message-ID: <20120827234054.GA7793@x220.sheraton.com>
References: <1343832093.2121.0.camel@belkin4>
 <20120727163853.GA11847@odin.tremily.us>
 <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
 <20120817051852.GA32453@odin.tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120817051852.GA32453@odin.tremily.us>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 17, 2012, W. Trevor King wrote:
> On Wed, Aug 01, 2012 at 04:41:33PM +0200, Pacho Ramos wrote:
> > El dom, 29-07-2012 a las 09:52 +0200, Pacho Ramos escribió:
> > > Today I got a report downstream showing that old problem:
> > > http://permalink.gmane.org/gmane.linux.bluez.kernel/22306
> > > 
> > > is still not fixed. 
> > > 
> > > Could you please commit debian patch to fix this?
> > > http://patch-tracker.debian.org/patch/series/view/bluez/4.101-1/09_fix_ftbfs_with_c99.patch
> > 
> > Any news about this? Thanks
> 
> Bump :)

The patch would need to be sent as a proper git patch to this mailing
list. Particularly, we need proper author information for the patch as
well as a commit message explaining the background to the patch and why
it is correct (including a reference to the C++ standard and/or gcc
documentation).

Johan
