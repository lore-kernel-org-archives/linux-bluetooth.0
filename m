Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: Fix l2cap_sock_teardown_cb lockdep warning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415776550-32392-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 12 Nov 2014 18:07:42 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <37C8EF50-8AC7-42C9-81BA-51A6F1F0685F@holtmann.org>
References: <1415776550-32392-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Any code calling bt_accept_dequeue() to get a new child socket from a
> server socket should use lock_sock_nested to avoid lockdep warnings due
> to the parent and child sockets being locked at the same time. The
> l2cap_sock_accept() function is already doing this correctly but a
> second place calling bt_accept_dequeue() is the code path from
> l2cap_sock_teardown_cb() that calls l2cap_sock_cleanup_listen().
> 
> This patch fixes the proper nested locking annotation and thereby avoids
> the following style of lockdep warning.
> 
> [  +0.000224] [ INFO: possible recursive locking detected ]
> [  +0.000222] 3.17.0+ #1153 Not tainted
> [  +0.000130] ---------------------------------------------
> [  +0.000227] l2cap-tester/562 is trying to acquire lock:
> [  +0.000210]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<c1393f47>] bt_accept_dequeue+0x68/0x11b
> [  +0.000467]
> but task is already holding lock:
> [  +0.000186]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<c13b949a>] lock_sock+0xa/0xc
> [  +0.000421]
> other info that might help us debug this:
> [  +0.000199]  Possible unsafe locking scenario:
> 
> [  +0.000117]        CPU0
> [  +0.000000]        ----
> [  +0.000000]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> [  +0.000000]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> [  +0.000000]
> *** DEADLOCK ***
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

