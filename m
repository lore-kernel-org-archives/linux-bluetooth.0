Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 16:56:53 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org
cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org
Subject: ERTM known bugs/regressions (was Re: [PATCH 0/8] ...)
In-Reply-To: <1280786940.12579.57.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1008021517040.18432@linux-sea-02>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>  <1280778649.12579.50.camel@localhost.localdomain>  <alpine.DEB.2.00.1008021450290.18432@linux-sea-02> <1280786940.12579.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Marcel & Gustavo -

On Mon, 2 Aug 2010, Marcel Holtmann wrote:

> Hi Mat,

<snip>

> since 2.6.36 will be the first kernel we enable ERTM by default, I
> prefer that we have known bugs/regressions actually fixed.


Gustavo has done a lot of great work to get ERTM ready to be turned on 
by default, but there is one potential issue I see with ERTM that I'd 
like to discuss: locking.

Kernel timers are used for the ack, retransmit, and monitor timeouts. 
The handler functions for these timers use bh_lock_sock() and 
bh_unlock_sock() to protect socket state.  While this does protect 
against simultaneous timeouts, or access in tasklet context for 
incoming HCI data, it doesn't protect against access in user context.

Here's a scenario:

  * Application calls send()
  * lock_sock() is called in l2cap_sock_sendmsg()
  * L2CAP code starts to modify l2cap_pinfo(sk) state in user context
  * Timer fires, preempting l2cap_sock_sendmsg() or on another CPU
  * Timer does not spin on bh_lock_sock()
  * Timer handler changes l2cap_pinfo(sk) state
  * Timer calls bh_unlock_sock() and finishes
  * Code called by l2cap_sock_sendmsg() continues running, but
    l2cap_pinfo(sk) was changed by the timer.
  * release_sock() is called and l2cap_sock_sendmsg() returns.

It doesn't look like this would lead to a kernel panic, but can
cause data coherency problems in l2cap_pinfo(sk) (especially 
l2cap_pinfo(sk)->conn_state).  The most likely symptom would be 
spurious disconnects when the other end of the ERTM connection sees 
some odd behavior.


One solution is to use a workqueue for these timeouts, and then use 
lock_sock() and release_sock() to protect l2cap_pinfo(sk) in the 
workqueue handlers.  There's a big catch, though:  the socket might be 
locked for a while if bt_skb_send_alloc() blocks and ERTM is not 
sending data from the TX queue (it might be retransmitting frames 
instead).  As long as the lock is held, all the incoming data is put 
in the socket backlog and any ack/retrans/monitor timers that fire on 
the workqueue will block everything on that queue.  The ERTM 
connection can stall.

I think the ERTM code would need to either release the socket lock 
when calling bt_skb_send_alloc(), or another spinlock is needed to 
protect l2cap_pi(sk).  Per-socket workqueues might be a good idea too, 
so one locked socket can't block timeouts on other sockets.

This is a non-issue in basic mode, because no socket state is changed 
when data is sent or received.


Do you agree that there's an ERTM issue here to be addressed?  Any 
ideas regarding the workqueue solution?


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
