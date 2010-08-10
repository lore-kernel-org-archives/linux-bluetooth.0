Return-Path: <cyrus@holtmann.org>
Message-ID: <4C6161D7.7070507@csr.com>
Date: Tue, 10 Aug 2010 15:27:35 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Process HCI events in a workqueue instead
 of a tasklet
References: <1281323213-30907-1-git-send-email-marcel@holtmann.org>	 <1281442519.12579.209.camel@localhost.localdomain>	 <4C614B01.6030000@csr.com> <1281446085.12579.212.camel@localhost.localdomain>
In-Reply-To: <1281446085.12579.212.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
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

I think my preferred solution would be for the rx function called by the 
HCI transport drivers to be called in a thread context.  There should be 
a helper function that is callable in atomic context that queues the 
packets to be processed in a workqueue.

Our UWB drivers already process packets in a thread so would prefer to 
avoid another thread context switch.

Shall I prepare a patch?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
