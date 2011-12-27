Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 27 Dec 2011 18:32:29 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BUG: Reordering of L2CAP connection pending/accesspted replies
Message-ID: <20111227203229.GB13870@joana>
References: <A7CD2DBA66569F478A0C1ECFC39E1C520A654C79@DLEE74.ent.ti.com>
 <20111226125012.GA16370@joana>
 <A7CD2DBA66569F478A0C1ECFC39E1C520A654D61@DLEE74.ent.ti.com>
 <1324928592.1965.267.camel@aeonflux>
 <A7CD2DBA66569F478A0C1ECFC39E1C520A654F6D@DLEE74.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A7CD2DBA66569F478A0C1ECFC39E1C520A654F6D@DLEE74.ent.ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

* Ilia, Kolominsky <iliak@ti.com> [2011-12-27 11:58:54 +0000]:

> Hi Marcel
>  
> > Hi Ilia,
> > 
> > > > > I have encountered an incorrect behavior of l2cap connection
> > > > > establishment mechanism when handling an incoming connection
> > > > > request:
> > > > >
> > > > > > ACL data: handle 1 flags 0x02 dlen 12
> > > > >     L2CAP(s): Connect req: psm 23 scid 0x0083
> > > > > < ACL data: handle 1 flags 0x00 dlen 16
> > > > >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 0
> > status 0
> > > > >       Connection successful
> > > > > < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
> > > > >     handle 1
> > > > > < ACL data: handle 1 flags 0x00 dlen 12
> > > > >     L2CAP(s): Config req: dcid 0x0083 flags 0x00 clen 0
> > > > > > HCI Event: Mode Change (0x14) plen 6
> > > > >     status 0x00 handle 1 mode 0x00 interval 0
> > > > >     Mode: Active
> > > > > < ACL data: handle 1 flags 0x00 dlen 16
> > > > >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 1
> > status 2
> > > > >       Connection pending - Authorization pending
> > > > >
> > > > > After analyzing the code, it seems to me that there is indeed a
> > > > > clear possibility that replies will egress out of order on
> > > > > multicore systems:
> > > > >
> > > > > CPU0 (Tasklet: hci_rx_task)          CPU1 (user process)
> > > >
> > > > Can you check if this also happens after the move to workqueue
> > > > processing?
> > > > The workqueue handling is quite different, then this problem might
> > not
> > > > be
> > > > there anymore.
> > >
> > > Firstly, I think workqueue should only make the matters worse -
> > > since it can be preempted ( unlike tasklets ) this can
> > > happen even on single CPU. ) e.g. resched just before send_resp
> > label).
> > > Secondly, as with any race situations, this bug is difficult to
> > reproduce,
> > > I saw it only a couple of times, thus I call for theoretical
> > analysis.
> > 
> > we are actually using a CPU unbound workqueue where the kernel ensures
> > that only one will be active across the set of CPUs. Both RX and TX are
> > executed from that same workqueue. So the only way this can happen is
> > if
> > one work is scheduled from the other. However since the event
> > processing
> > is now also run from that same workqueue, I fail to see how that could
> > happen.
> 
> I am putting back the original diagram because I feel that it is
> quite relevant to the discussion:
> 
> CPU0 (Tasklet: hci_rx_task)          CPU1 (user process)
> ...                                  sk = sys_accept()
> ...                                    l2cap_sock_accept()
> ...                                    add_wait_queue_exclusive()
> l2cap_connect_req()                  ...
>   result = L2CAP_CR_PEND;            ... 
>   status = L2CAP_CS_AUTHOR_PEND;     ...
>   parent->sk_data_ready(parent, 0)   ...

Move to the workqueue based code and add a call schedule() here, before send
L2CAP_CR_PEND. Let's see if this issue is real.

	Gustavo
