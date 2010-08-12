Return-Path: <cyrus@holtmann.org>
Message-ID: <4C647391.2090607@csr.com>
Date: Thu, 12 Aug 2010 23:20:01 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Process HCI events in a workqueue instead
 of a tasklet
References: <1281323213-30907-1-git-send-email-marcel@holtmann.org>	 <1281442519.12579.209.camel@localhost.localdomain>	 <4C614B01.6030000@csr.com> <1281446085.12579.212.camel@localhost.localdomain>
In-Reply-To: <1281446085.12579.212.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi David,
> 
>>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>> ---
>>>>  include/net/bluetooth/hci_core.h |    2 +
>>>>  net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++++-----
>>>>  2 files changed, 52 insertions(+), 8 deletions(-)
>>> so I stuffed this now into bluetooth-testing tree and would like to see
>>> some extra testing exposure. So far this has only been tested by myself.
>>>
>>> If there are no regression then this should make a lot of HCI and L2CAP
>>> handling a lot simple.
>> This may result in packets being processed in a different order to that 
>> which they were received in.
>>
>> e.g., what happens to an ACL packet processed before the connection 
>> complete event for that connection?
> 
> good point. So we would either a) need to disable the RX tasklet when we
> receive an event and schedule it for processing or b) process the ACL
> data also in a workqueue.

I've thought some more about this and I'm not sure disabling the tasklet
is sufficient to prevent packets being reordered.  Consider a transport
that submits (in the same interrupt handler call) an ACL packet and an
HCI event.  The tasklet will be scheduled and then disabled until the
event is processed in the workqueue.

On the other hand, USB transports do not ensure any ordering between HCI
event and ACL packets because they're received on different USB
endpoints which could be processed in any order.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
