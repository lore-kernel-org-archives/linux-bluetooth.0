Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: "quozl@laptop.org" <quozl@laptop.org>
CC: Ben Hutchings <ben@decadent.org.uk>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Frank Huang <frankh@marvell.com>
Date: Mon, 20 Jan 2014 12:25:12 -0800
Subject: RE: linux-firmware: pull-request Marvell mwifiex-firmware 2014-01-09
Message-ID: <477F20668A386D41ADCC57781B1F70430F53691FC5@SC-VEXCH1.marvell.com>
References: <1389325691-21371-1-git-send-email-bzhao@marvell.com>
 <1390174797.3651.7.camel@deadeye.wl.decadent.org.uk>
 <477F20668A386D41ADCC57781B1F70430F53691E15@SC-VEXCH1.marvell.com>
 <20140120022223.GI17658@us.netrek.org>
In-Reply-To: <20140120022223.GI17658@us.netrek.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

> On Sun, Jan 19, 2014 at 06:10:03PM -0800, Bing Zhao wrote:
> > The 2nd (69 or 68) and 3rd (11 or 29) numbers in the version string
> > do not necessarily mean the version increasing or decreasing. Only
> > when first 3 numbers are fixed, a smaller 4th number will mean that
> > the version is rolling backward.
> 
> Ah, light dawns.  I've been dealing with these version numbers for
> years now, for 8388, 8686 and 8787, and I didn't know that.  Is this
> documented anywhere else?  Have the 2nd and 3rd numbers any meaning or
> are they random?

They're not random. They represent firmware branch and features built in.

Thanks,
Bing
