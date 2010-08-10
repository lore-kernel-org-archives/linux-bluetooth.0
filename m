Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Process HCI events in a workqueue instead
 of a tasklet
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C6161D7.7070507@csr.com>
References: <1281323213-30907-1-git-send-email-marcel@holtmann.org>
	 <1281442519.12579.209.camel@localhost.localdomain>
	 <4C614B01.6030000@csr.com>
	 <1281446085.12579.212.camel@localhost.localdomain>
	 <4C6161D7.7070507@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:41:35 -0400
Message-ID: <1281476495.12579.232.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>> ---
> >>>>  include/net/bluetooth/hci_core.h |    2 +
> >>>>  net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++++-----
> >>>>  2 files changed, 52 insertions(+), 8 deletions(-)
> >>> so I stuffed this now into bluetooth-testing tree and would like to see
> >>> some extra testing exposure. So far this has only been tested by myself.
> >>>
> >>> If there are no regression then this should make a lot of HCI and L2CAP
> >>> handling a lot simple.
> >> This may result in packets being processed in a different order to that 
> >> which they were received in.
> >>
> >> e.g., what happens to an ACL packet processed before the connection 
> >> complete event for that connection?
> > 
> > good point. So we would either a) need to disable the RX tasklet when we
> > receive an event and schedule it for processing or b) process the ACL
> > data also in a workqueue.
> 
> I think my preferred solution would be for the rx function called by the 
> HCI transport drivers to be called in a thread context.  There should be 
> a helper function that is callable in atomic context that queues the 
> packets to be processed in a workqueue.
> 
> Our UWB drivers already process packets in a thread so would prefer to 
> avoid another thread context switch.
> 
> Shall I prepare a patch?

yes please. I need something to make the event handling simpler.
Otherwise every single subcomponent creates "hundreds" of workqueues to
solve exactly the same problem.

Regards

Marcel


