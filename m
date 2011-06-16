Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 15:38:34 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Limit depth of the HCI TX queue with ERTM
 mode
In-Reply-To: <20110614235313.GE2613@joana>
Message-ID: <alpine.DEB.2.02.1106161012550.25757@mathewm-linux>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org> <1307143270-2655-3-git-send-email-mathewm@codeaurora.org> <20110609021648.GA2776@joana> <alpine.DEB.2.02.1106091610040.18748@mathewm-linux> <20110614235313.GE2613@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Tue, 14 Jun 2011, Gustavo F. Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2011-06-09 16:36:29 -0700]:
>
...
>> So, I think we have two options:
>>
>>  * Use the skb_destructor mechanism to pull data for ERTM (which is
>> what my patch does), and leave queuing for other modes alone
>>  * Rearchitect HCI & L2CAP so that data is pulled from the L2CAP
>> layer as num_comp_pkts events are received
>
> I prefer the rearchitect HCI and L2CAP approach, but I still don't have too
> much idea on how to do this. I'm open to suggestions here.

My suggestion would be:

  * Run HCI tx on a workqueue
  * Remove the hci_conn data_q
  * Use a tx queue in each l2cap_chan for all L2CAP modes
  * L2CAP sends put data in the l2cap_chan tx queue and hci_send_acl 
informs the hci layer that there's a channel to pull from
  * When the HCI device can accept ACL frames (packets are available or 
num_completed_packets is received), instead of having the hci 
scheduler pull data from hci_conn queues, it calls back to L2CAP to 
pull from l2cap_chan tx queues.  ACL data goes directly from the L2CAP 
tx queue to the HCI device.

Pulling data for ERTM would require locking (while the control bits 
are set), but basic mode and streaming mode probably would not need 
locking in the L2CAP callback.

There are several benefits: fewer layers of queuing, improved fairness 
between L2CAP channels on the same ACL, and just one workqueue instead 
of a workqueue and a tasklet.


> Another idea is to delay in setting the control bits until the moment we
> actually send the frame. If we do that, we can have priority for REJ/SREJ.
> Before send, hci calls a l2cap function to fill the control bit. These are
> just ideas.

This very similar to what my patch does :).  When frames can be sent, 
a job runs on the workqueue to set the control bits and push the 
frames to the hci_conn data_q.  However, there is not a callback for 
every frame in my patch.  Several frames are sent during each callback 
to reduce overhead.


> I just think that use an workqueue and a tasklet to send packet is just too
> much.

It seems to work very well with AMP on mobile devices.  Keep in mind 
that there are more dropped packets on AMP than on BR/EDR, so quick 
handling of REJ/SREJ becomes important for maintaining throughput. 
ERTM flow control (local busy) works a lot better too.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

