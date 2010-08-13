Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Process HCI events in a workqueue instead
 of a tasklet
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C647391.2090607@csr.com>
References: <1281323213-30907-1-git-send-email-marcel@holtmann.org>
	 <1281442519.12579.209.camel@localhost.localdomain>
	 <4C614B01.6030000@csr.com>
	 <1281446085.12579.212.camel@localhost.localdomain>
	 <4C647391.2090607@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Aug 2010 10:35:04 +0200
Message-ID: <1281688504.12579.436.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

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
> I've thought some more about this and I'm not sure disabling the tasklet
> is sufficient to prevent packets being reordered.  Consider a transport
> that submits (in the same interrupt handler call) an ACL packet and an
> HCI event.  The tasklet will be scheduled and then disabled until the
> event is processed in the workqueue.
> 
> On the other hand, USB transports do not ensure any ordering between HCI
> event and ACL packets because they're received on different USB
> endpoints which could be processed in any order.

so lets see here. We expect that hci_recv_frame receives the events and
data packets in proper order. If it happens that the USB controller does
a different order, then it is the USB controllers problem. We just can't
fix that in the Bluetooth core since we don't know the expected order.
So we must assume whatever gets received via hci_recv_frame is the
correct order.

        switch (bt_cb(skb)->pkt_type) {
        case HCI_EVENT_PKT:
                /* Queue frame for event processing */
                skb_queue_tail(&hdev->evt_q, skb);
                queue_work(hdev->workqueue, &hdev->evt_work);
                break;

        default:
                /* Queue frame for rx task */
                skb_queue_tail(&hdev->rx_q, skb);
                tasklet_schedule(&hdev->rx_task);
                break;
        }

If we now disable the rx_task before scheduling the evt_work, then the
rx_task gets scheduled, but only run after we enable rx_task again. And
we enable the rx_task after hci_event_packet. So after we have created
any structure to handle the ACL and SCO data packets correctly.

I am not seeing your concern. At least not in the Bluetooth core. There
might be a few driver issues when the controller doesn't send us things
in order, but that is really a controller or driver issue at that point.

Coming to think about this, we might even go one step further here and
only enable the rx_task when we have an ACL link. That way if the
controller sends us an ACL packet before the Connection Complete event
we just queue it up. That would potentially solve issues that we have
seen with Broadcom controllers where the first ACL packet arrives too
early and BlueZ is just too fast.

We could even go one step further with this and only enable the RX task
when we have switched on encryption (for 2.1 with SSP). This might fix
some issues with the stupid controllers sending ACL packets before
notifying us that the link has switched on encryption.

Anyway, I am really open for suggestions here. I just think that moving
all RX and TX processing into a workqueue might be a bit overkill. And
keep processing events in a tasklet will create code complexity in the
future when adding AMP support.

Regards

Marcel


