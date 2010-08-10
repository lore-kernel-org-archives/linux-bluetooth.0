Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Process HCI events in a workqueue instead
 of a tasklet
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C614B01.6030000@csr.com>
References: <1281323213-30907-1-git-send-email-marcel@holtmann.org>
	 <1281442519.12579.209.camel@localhost.localdomain>
	 <4C614B01.6030000@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 09:14:45 -0400
Message-ID: <1281446085.12579.212.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >>  include/net/bluetooth/hci_core.h |    2 +
> >>  net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++++-----
> >>  2 files changed, 52 insertions(+), 8 deletions(-)
> > 
> > so I stuffed this now into bluetooth-testing tree and would like to see
> > some extra testing exposure. So far this has only been tested by myself.
> > 
> > If there are no regression then this should make a lot of HCI and L2CAP
> > handling a lot simple.
> 
> This may result in packets being processed in a different order to that 
> which they were received in.
> 
> e.g., what happens to an ACL packet processed before the connection 
> complete event for that connection?

good point. So we would either a) need to disable the RX tasklet when we
receive an event and schedule it for processing or b) process the ACL
data also in a workqueue.

Regards

Marcel


