Return-Path: <cyrus@holtmann.org>
Subject: RE: BUG: sleeping function called from invalid context at
 mm/slub.c:1595 --- "hcitool cc" or "l2ping"
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
	 <1240966565.997.65.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 07:20:41 -0700
Message-Id: <1241014841.997.69.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> > > I'm getting this error whenever I use "hcitool cc" or "l2ping xx:xx:xx:xx:xx:xx"
> > command.
> > >
> > > Kernel: version 2.6.30-rc3 from bluetooth-testing tree
> > > HCI Tool: version 3.20
> > > Laptop: Lenovo X61s
> > 
> > can you rebase the bluetooth-testing.git tree from a few hours ago and
> > test again.
> 
> "git log" shows the last commit was ad4751fcada51292bb2967748667b582281647d0.
> Bluetooth: Fix errors and warnings in L2CAP reported by checkpatch.pl
> 
> Is it the latest one?

yes, that one is the latest. What happens if you revert:

commit d97ebf3798fb5745953230e049011f5b20b7c6d9
Author: Roger Quadros <ext-roger.quadros@nokia.com>
Date:   Thu Apr 23 14:50:54 2009 +0300

    Bluetooth: Ensure that HCI sysfs add/del is preempt safe

Does this one introduces your problem?

What is your kernel config and hardware you are running this one? Seems
not everybody is seeing this one.

Regards

Marcel


