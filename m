Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Apr 2009 18:14:59 -0700
Subject: RE: BUG: sleeping function called from invalid context at
 mm/slub.c:1595 --- "hcitool cc" or "l2ping"
Message-ID: <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
 <1240966565.997.65.camel@localhost.localdomain>
In-Reply-To: <1240966565.997.65.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Bing,
> 
> > I'm getting this error whenever I use "hcitool cc" or "l2ping xx:xx:xx:xx:xx:xx"
> command.
> >
> > Kernel: version 2.6.30-rc3 from bluetooth-testing tree
> > HCI Tool: version 3.20
> > Laptop: Lenovo X61s
> 
> can you rebase the bluetooth-testing.git tree from a few hours ago and
> test again.
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

"git log" shows the last commit was ad4751fcada51292bb2967748667b582281647d0.
Bluetooth: Fix errors and warnings in L2CAP reported by checkpatch.pl

Is it the latest one?

Thanks,

Bing




