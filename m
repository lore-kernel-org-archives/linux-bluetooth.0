Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Apr 2012 09:05:17 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Manoj <manojkr.sharma@stericsson.com>
cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix L2CAP ERTM packet queue corruption
In-Reply-To: <20120425084641.GC23023@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1204250834310.20357@mathewm-linux>
References: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com> <20120425084641.GC23023@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Manoj -

On Wed, 25 Apr 2012, Andrei Emeltchenko wrote:

> Hi Manoj,
>
> On Wed, Apr 25, 2012 at 01:59:03PM +0530, Manoj wrote:
>> While running in L2CAP ERTM mode, sometimes ERTM packet queue
>> gets corrupted because though method l2cap_ertm_send() is not
>> thread-safe, it is called simultaneously from multiple
>> threads.
>
> Could you give examples how queue is corrupted?
>
> Best regards
> Andrei Emeltchenko

Around the time that bluetooth-next made the switch to workqueues, I 
saw some issues where the packet sent in l2cap_ertm_send could be 
acked in tasklet context before l2cap_ertm_send finished running. 
This would cause the packet to be removed from the tx_q before 
skb_queue_is_last() was called, which would in turn result in a 
corrupt tx_send_head pointer.

With workqueues and proper locking, this should not be a problem. 
The lock that needs to be held when changing tx_q is acquired using 
l2cap_chan_lock(), *not* the mutex_lock() used in this patch.  Callers 
of l2cap_ertm_send() should already hold l2cap_chan_lock(), which will 
provide thread safety.  It looks like l2cap_chan_lock() is not held 
when l2cap_ertm_send() is called by l2cap_chan_send().

(Also keep in mind that l2cap_chan_lock() cannot be held when 
l2cap_create_iframe_pdu() is called, because it's possible to block 
while allocating iframe skbs)

>>
>> Signed-off-by: Manoj <manojkr.sharma@stericsson.com>
>> ---
>>  net/bluetooth/l2cap_core.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 19807c9..a9319e2 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1713,6 +1713,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>>  	if (chan->state != BT_CONNECTED)
>>  		return -ENOTCONN;
>>
>> +	mutex_lock(&chan->conn->chan_lock);
>>  	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {
>>
>>  		if (chan->remote_max_tx &&
>> @@ -1765,7 +1766,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>>  		else
>>  			chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
>>  	}
>> -
>> +	mutex_unlock(&chan->conn->chan_lock);
>>  	return nsent;
>>  }
>>
>> --
>> 1.6.6.1

Regards,
--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
