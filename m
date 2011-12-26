Return-Path: <cyrus@holtmann.org>
Message-ID: <1324928592.1965.267.camel@aeonflux>
Subject: RE: BUG: Reordering of L2CAP connection pending/accesspted replies
From: Marcel Holtmann <marcel@holtmann.org>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 26 Dec 2011 11:43:12 -0800
In-Reply-To: <A7CD2DBA66569F478A0C1ECFC39E1C520A654D61@DLEE74.ent.ti.com>
References: <A7CD2DBA66569F478A0C1ECFC39E1C520A654C79@DLEE74.ent.ti.com>
	 <20111226125012.GA16370@joana>
	 <A7CD2DBA66569F478A0C1ECFC39E1C520A654D61@DLEE74.ent.ti.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

> > > I have encountered an incorrect behavior of l2cap connection
> > > establishment mechanism when handling an incoming connection
> > > request:
> > >
> > > > ACL data: handle 1 flags 0x02 dlen 12
> > >     L2CAP(s): Connect req: psm 23 scid 0x0083
> > > < ACL data: handle 1 flags 0x00 dlen 16
> > >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 0 status 0
> > >       Connection successful
> > > < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
> > >     handle 1
> > > < ACL data: handle 1 flags 0x00 dlen 12
> > >     L2CAP(s): Config req: dcid 0x0083 flags 0x00 clen 0
> > > > HCI Event: Mode Change (0x14) plen 6
> > >     status 0x00 handle 1 mode 0x00 interval 0
> > >     Mode: Active
> > > < ACL data: handle 1 flags 0x00 dlen 16
> > >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 1 status 2
> > >       Connection pending - Authorization pending
> > >
> > > After analyzing the code, it seems to me that there is indeed a
> > > clear possibility that replies will egress out of order on
> > > multicore systems:
> > >
> > > CPU0 (Tasklet: hci_rx_task)          CPU1 (user process)
> > 
> > Can you check if this also happens after the move to workqueue
> > processing?
> > The workqueue handling is quite different, then this problem might not
> > be
> > there anymore.
> 
> Firstly, I think workqueue should only make the matters worse - 
> since it can be preempted ( unlike tasklets ) this can 
> happen even on single CPU. ) e.g. resched just before send_resp label).
> Secondly, as with any race situations, this bug is difficult to reproduce,
> I saw it only a couple of times, thus I call for theoretical analysis.

we are actually using a CPU unbound workqueue where the kernel ensures
that only one will be active across the set of CPUs. Both RX and TX are
executed from that same workqueue. So the only way this can happen is if
one work is scheduled from the other. However since the event processing
is now also run from that same workqueue, I fail to see how that could
happen.

Regards

Marcel


