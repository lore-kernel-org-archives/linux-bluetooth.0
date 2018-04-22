Return-Path: <jirislaby@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
 ML netdev <netdev@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: Bluetooth/lock_sock: false positive "WARNING: possible recursive
 locking detected"
Message-ID: <695d5172-e7f8-9e44-b6ab-0ce1a9473f34@suse.cz>
Date: Sun, 22 Apr 2018 09:57:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have just got this lockdep warning during suspend:
> [ 2891.586061] ============================================
> [ 2891.586063] WARNING: possible recursive locking detected
> [ 2891.586065] 4.16.2-10.ge881e16-default #1 Not tainted
> [ 2891.586067] --------------------------------------------
> [ 2891.586068] kworker/u9:3/873 is trying to acquire lock:
> [ 2891.586070]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<000000007b85e829>] bt_accept_enqueue+0x29/0x90 [bluetooth]
> [ 2891.586086]
>                but task is already holding lock:
> [ 2891.586088]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<0000000042f0b4a5>] l2cap_sock_new_connection_cb+0x18/0xa0 [bluetooth]
> [ 2891.586109]
>                other info that might help us debug this:
> [ 2891.586111]  Possible unsafe locking scenario:
> 
> [ 2891.586115]        CPU0
> [ 2891.586116]        ----
> [ 2891.586117]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> [ 2891.586120]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> [ 2891.586122]
>                 *** DEADLOCK ***
> 
> [ 2891.586125]  May be due to missing lock nesting notation
> 
> [ 2891.586127] 5 locks held by kworker/u9:3/873:
> [ 2891.586128]  #0:  ((wq_completion)"%s"hdev->name#2){+.+.}, at: [<000000004aa1a273>] process_one_work+0x1e3/0x6a0
> [ 2891.586135]  #1:  ((work_completion)(&hdev->rx_work)){+.+.}, at: [<000000004aa1a273>] process_one_work+0x1e3/0x6a0
> [ 2891.586140]  #2:  (&conn->chan_lock){+.+.}, at: [<00000000fbad6c82>] l2cap_connect+0x88/0x540 [bluetooth]
> [ 2891.586155]  #3:  (&chan->lock/2){+.+.}, at: [<000000007c38e27e>] l2cap_connect+0xa0/0x540 [bluetooth]
> [ 2891.586170]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<0000000042f0b4a5>] l2cap_sock_new_connection_cb+0x18/0xa0 [bluetooth]
> [ 2891.586183]
>                stack backtrace:
> [ 2891.586187] CPU: 2 PID: 873 Comm: kworker/u9:3 Not tainted 4.16.2-10.ge881e16-default #1 openSUSE Tumbleweed (unreleased)
> [ 2891.586189] Hardware name: Dell Inc. Latitude 7280/0KK5D1, BIOS 1.9.3 03/09/2018
> [ 2891.586200] Workqueue: hci0 hci_rx_work [bluetooth]
> [ 2891.586202] Call Trace:
> [ 2891.586207]  dump_stack+0x85/0xc5
> [ 2891.586211]  __lock_acquire+0x6b4/0x1370
> [ 2891.586221]  lock_acquire+0x9f/0x210
> [ 2891.586237]  lock_sock_nested+0x5a/0x80
> [ 2891.586256]  bt_accept_enqueue+0x29/0x90 [bluetooth]
> [ 2891.586268]  l2cap_sock_new_connection_cb+0x5d/0xa0 [bluetooth]
> [ 2891.586280]  l2cap_connect+0x126/0x540 [bluetooth]
> [ 2891.586315]  l2cap_sig_channel+0x443/0x13b0 [bluetooth]
> [ 2891.586330]  l2cap_recv_frame+0x1a4/0x300 [bluetooth]
> [ 2891.586341]  hci_rx_work+0x1c8/0x5c0 [bluetooth]
> [ 2891.586345]  process_one_work+0x269/0x6a0
> [ 2891.586350]  worker_thread+0x2b/0x3d0
> [ 2891.586356]  kthread+0x113/0x130
> [ 2891.586363]  ret_from_fork+0x24/0x50
> [ 4954.622809] e1000e: eth0 NIC Link is Down
> [ 4955.299532] PM: suspend entry (deep)
> [ 4955.299538] PM: Syncing filesystems ... done.

This is:
  lock_sock(sk);       in bt_accept_enqueue
nested in
  lock_sock(parent);   in l2cap_sock_new_connection_cb

So this looks like a false positive to me. So I believe this is a fix:

--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1232,7 +1232,7 @@ static struct l2cap_chan
*l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
        struct sock *sk, *parent = chan->data;

-       lock_sock(parent);
+       lock_sock_nested(parent, L2CAP_NESTING_PARENT);

        /* Check for backlog size */
        if (sk_acceptq_is_full(parent)) {


?

thanks,
-- 
js
suse labs
