Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 30 Apr 2009 17:54:55 -0700
Subject: RE: BUG: sleeping function called from invalid context at
 mm/slub.c:1595 --- "hcitool cc" or "l2ping"
Message-ID: <477F20668A386D41ADCC57781B1F704301E4183626@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E3F5C7F5@SC-VEXCH1.marvell.com>
	 <1240966565.997.65.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E3F5C7FC@SC-VEXCH1.marvell.com>
	 <1241014841.997.69.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E3F5CA53@SC-VEXCH1.marvell.com>
	 <1241044716.3389.7.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301E4183334@SC-VEXCH1.marvell.com>
 <1241070186.3389.29.camel@localhost.localdomain>
In-Reply-To: <1241070186.3389.29.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Bing,
>=20
> > > > > > > > I'm getting this error whenever I use "hcitool cc" or "l2pi=
ng
> > > > > xx:xx:xx:xx:xx:xx"
> > > > > > > command.
> > > > > > > >
> > > > > > > > Kernel: version 2.6.30-rc3 from bluetooth-testing tree
> > > > > > > > HCI Tool: version 3.20
> > > > > > > > Laptop: Lenovo X61s
> > > > > > >
> > > > > > > can you rebase the bluetooth-testing.git tree from a few hour=
s ago and
> > > > > > > test again.
> > > > > >
> > > > > > "git log" shows the last commit was ad4751fcada51292bb296774866=
7b582281647d0.
> > > > > > Bluetooth: Fix errors and warnings in L2CAP reported by checkpa=
tch.pl
> > > > > >
> > > > > > Is it the latest one?
> > > > >
> > > > > yes, that one is the latest. What happens if you revert:
> > > > >
> > > > > commit d97ebf3798fb5745953230e049011f5b20b7c6d9
> > > > > Author: Roger Quadros <ext-roger.quadros@nokia.com>
> > > > > Date:   Thu Apr 23 14:50:54 2009 +0300
> > > > >
> > > > >     Bluetooth: Ensure that HCI sysfs add/del is preempt safe
> > > > >
> > > > > Does this one introduces your problem?
> > > > >
> > > > > What is your kernel config and hardware you are running this one?=
 Seems
> > > > > not everybody is seeing this one.
> > > > >
> > > > Reverting d97ebf3798fb5745953230e049011f5b20b7c6d9 doesn't help.
> > > >
> > > > Today I got a chance to test it with some old tags.
> > > >
> > > > Tags:
> > > > v2.6.29:                no issue
> > > > v2.6.30-rc1:    no issue
> > > > v2.6.30-rc2:    BUG: sleeping function called from invalid context =
at mm/slub.c:1595
> > > > v2.6.30-rc3:    BUG: sleeping function called from invalid context =
at mm/slub.c:1595
> > > >
> > > > It happens on my laptops, Lenovo X61s and Fujitsu Lifebook A6110, w=
ith both v2.6.30-rc2 and
> > > v2.6.30-rc3.
> > > >
> > > >
> > > > The followings are from my Lifebook A6110,
> > > > with blutooth-test git tag: v2.6.30-rc2 (commit 0882e8dd).
> > >
> > > so I really think this is a kernel issue and not a Bluetooth issue. C=
an
> > > clone Linus' tree from today. All the important Bluetooth fixes for
> > > 2.6.30 went in today.
> > >
> > > I did double check the flush_workqueue() and as far as I can tell we =
can
> > > sleep in that context. So for some reason we are in the wrong context=
. I
> > > really don't know why.
> >
> > OK. I'll clone Linus's tree and give it a try when I get a chance.
>=20
> I re-based bluetooth-testing.git against 2.6.30-rc4 and that is as
> recent as it gets right now.
>=20
> Regards
>=20
> Marcel
>=20

Hi Marcel,

Just tested the latest 2.6.30-rc4 code from bluetooth-testing.git
and Linus's linux-2.6.git

This error still occurs in both git trees when I do an "hcitool cc" or l2pi=
ng:

BUG: sleeping function called from invalid context at mm/slub.c:1595


Best regards,

Bing
