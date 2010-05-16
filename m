Return-Path: <cyrus@holtmann.org>
Date: Sun, 16 May 2010 05:31:22 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Kernel crash when krfcomm is preempted by l2cap tasklet
Message-ID: <20100516083122.GA21819@vigoh>
References: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-05-14 18:39:40 +0300]:

> Hi all,
> 
> We have a bug with race condition between l2cap tasklet and krfcomm process.
> 
> When sending following sequence:
> 
> ...
> No.     Time        Source                Destination           Protocol Info
>      89 1.951202            RFCOMM   Rcvd DISC DLCI=20
>      90 1.951324            RFCOMM   Sent UA DLCI=20
>      91 1.959381            HCI_EVT   Number of Completed Packets
>      92 1.966461            RFCOMM   Rcvd DISC DLCI=0
>      93 1.966492            L2CAP    Rcvd Disconnect Request
>      94 1.972595            L2CAP    Sent Disconnect Response
> 
> ...
> 
> krfcommd kernel thread is preempted with l2cap tasklet which remove l2cap_conn
> (L2CAP connection handler structure). Then rfcomm thread tries to send RFCOMM
> UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn crash
> happens.
> 
> ...
> [  694.175933] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [  694.184936] pgd = c0004000
> [  694.187683] [00000000] *pgd=00000000
> [  694.191711] Internal error: Oops: 5 [#1] PREEMPT
> [  694.196350] last sysfs file:
> /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
> [  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
> [  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
> [  694.270721] LR is at 0xd7017303
> ...
> [  694.525085] Backtrace:
> [  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap])
> from [<c02f2cc8>] (sock_sendmsg+0xb8
> [  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>]
> (kernel_sendmsg+0x48/0x80)
> ...
> 
> I have a patch which fixes the issue but not sure that there is no
> better way. Waiting for comments.
> 
> Currently I am investigating possibility to:
> - implement l2cap_conn reference counting

sock_owned_by_user() gives the same effect as a ref count. See comments below.

> - use socket backlog queue to process l2cap packets later when socket is not
> owned by the process.

You actually don't need a backlog queue here. You can process the signal
packet, skipping the l2cap_chan_del() call;

> From 955a821e1ee66cd6f9717ea4a2e9b3dfdafdc22a Mon Sep 17 00:00:00 2001
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> Date: Fri, 14 May 2010 17:56:39 +0300
> Subject: [PATCH] Bluetooth: Check sk is not used before freeing
> 
> Check that socket sk is not locked in user process before removing
> l2cap connection handler and sk.
> 
> rfcomm kernel thread may be preempted with l2cap tasklet which remove l2cap_conn
> (L2CAP connection handler structure). Then rfcomm thread tries to send RFCOMM
> UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn crash
> can happen.
> 
> ...
> [  694.175933] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [  694.184936] pgd = c0004000
> [  694.187683] [00000000] *pgd=00000000
> [  694.191711] Internal error: Oops: 5 [#1] PREEMPT
> [  694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
> [  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
> [  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
> [  694.270721] LR is at 0xd7017303
> 
> ...
> 
> [  694.525085] Backtrace:
> [  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) from [<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
> [  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] (kernel_sendmsg+0x48/0x80)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index bb00015..7eb9a58 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3119,6 +3119,13 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
>  	if (!sk)
>  		return 0;
>  
> +	/* sk is locked in krfcomm process */
> +	if (sock_owned_by_user(sk)) {
> +		BT_DBG("sk %p is owned by user", sk);
> +		bh_unlock_sock(sk);
> +		return 0;
> +	}

That's wrong. Use the sock_owned_by_user() only to avoid the
l2cap_chan_del() call, so you can process all the rest of the function
and send the Disconnect Response.

The same check should be added to l2cap_connect_rsp() and
l2cap_disconnect_rsp(), since they call l2cap_chan_del() under bh
context as well. ;)

>  	rsp.dcid = cpu_to_le16(l2cap_pi(sk)->scid);
>  	rsp.scid = cpu_to_le16(l2cap_pi(sk)->dcid);
>  	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
> -- 
> 1.7.0.4
> 

-- 
Gustavo F. Padovan
http://padovan.org
