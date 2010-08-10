Return-Path: <cyrus@holtmann.org>
Message-ID: <4C614B01.6030000@csr.com>
Date: Tue, 10 Aug 2010 13:50:09 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Process HCI events in a workqueue instead
 of a tasklet
References: <1281323213-30907-1-git-send-email-marcel@holtmann.org> <1281442519.12579.209.camel@localhost.localdomain>
In-Reply-To: <1281442519.12579.209.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi everybody,
> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  include/net/bluetooth/hci_core.h |    2 +
>>  net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++++-----
>>  2 files changed, 52 insertions(+), 8 deletions(-)
> 
> so I stuffed this now into bluetooth-testing tree and would like to see
> some extra testing exposure. So far this has only been tested by myself.
> 
> If there are no regression then this should make a lot of HCI and L2CAP
> handling a lot simple.

This may result in packets being processed in a different order to that 
which they were received in.

e.g., what happens to an ACL packet processed before the connection 
complete event for that connection?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
