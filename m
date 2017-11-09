Return-Path: <hadess@hadess.net>
Message-ID: <1510236840.2624.16.camel@hadess.net>
Subject: Re: Recursive lockdep warning with 4.14-rc8 kernel
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Nov 2017 15:14:00 +0100
In-Reply-To: <8E9112C5-816A-4804-9E4A-E587875CC545@holtmann.org>
References: <1510235364.2624.10.camel@hadess.net>
	 <8E9112C5-816A-4804-9E4A-E587875CC545@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-11-09 at 15:00 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > During my testing trying to pair the new XBox One S Bluetooth
> > controller, I hit a lockdep warning.
> > 
> > [   56.415138] ============================================
> > [   56.415139] WARNING: possible recursive locking detected
> > [   56.415142] 4.14.0-0.rc8.git1.1.bt2.fc28.x86_64 #1 Not tainted
> > [   56.415143] --------------------------------------------
> > [   56.415145] kworker/u9:2/579 is trying to acquire lock:
> > [   56.415147]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at:
> > [<ffffffffc08dc262>] bt_accept_enqueue+0x42/0xc0 [bluetooth]
> > [   56.415167] 
> >               but task is already holding lock:
> > [   56.415168]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at:
> > [<ffffffffc0919e5d>] l2cap_sock_new_connection_cb+0x1d/0xa0
> > [bluetooth]
> > [   56.415184] 
> >               other info that might help us debug this:
> > [   56.415186]  Possible unsafe locking scenario:
> > 
> > [   56.415187]        CPU0
> > [   56.415188]        ----
> > [   56.415189]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> > [   56.415192]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> > [   56.415194] 
> >                *** DEADLOCK ***
> > 
> > [   56.415196]  May be due to missing lock nesting notation
> > 
> > [   56.415198] 5 locks held by kworker/u9:2/579:
> > [   56.415199]  #0:  ("%s"hdev->name#2){+.+.}, at:
> > [<ffffffffae0d4e90>] process_one_work+0x1d0/0x6a0
> > [   56.415206]  #1:  ((&hdev->rx_work)){+.+.}, at:
> > [<ffffffffae0d4e90>] process_one_work+0x1d0/0x6a0
> > [   56.415211]  #2:  (&conn->chan_lock){+.+.}, at:
> > [<ffffffffc09120e3>] l2cap_connect+0x93/0x5d0 [bluetooth]
> > [   56.415226]  #3:  (&chan->lock/2){+.+.}, at:
> > [<ffffffffc09120fd>] l2cap_connect+0xad/0x5d0 [bluetooth]
> > [   56.415239]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.},
> > at: [<ffffffffc0919e5d>] l2cap_sock_new_connection_cb+0x1d/0xa0
> > [bluetooth]
> > [   56.415252] 
> >               stack backtrace:
> > [   56.415255] CPU: 0 PID: 579 Comm: kworker/u9:2 Not tainted
> > 4.14.0-0.rc8.git1.1.bt2.fc28.x86_64 #1
> > [   56.415257] Hardware name: Dell Inc. OptiPlex 9020M/0Y5DDC, BIOS
> > A07 09/10/2015
> > [   56.415267] Workqueue: hci0 hci_rx_work [bluetooth]
> > [   56.415269] Call Trace:
> > [   56.415274]  dump_stack+0x8e/0xd6
> > [   56.415279]  __lock_acquire+0x6af/0x1320
> > [   56.415288]  ? bt_accept_enqueue+0x42/0xc0 [bluetooth]
> > [   56.415291]  ? __lock_is_held+0x65/0xb0
> > [   56.415294]  ? mark_held_locks+0x5f/0x90
> > [   56.415299]  lock_acquire+0xa3/0x1f0
> > [   56.415301]  ? lock_acquire+0xa3/0x1f0
> > [   56.415310]  ? bt_accept_enqueue+0x42/0xc0 [bluetooth]
> > [   56.415314]  lock_sock_nested+0x76/0xa0
> > [   56.415323]  ? bt_accept_enqueue+0x42/0xc0 [bluetooth]
> > [   56.415332]  bt_accept_enqueue+0x42/0xc0 [bluetooth]
> > [   56.415343]  l2cap_sock_new_connection_cb+0x62/0xa0 [bluetooth]
> > [   56.415353]  l2cap_connect+0x136/0x5d0 [bluetooth]
> > [   56.415358]  ? sched_clock+0x9/0x10
> > [   56.415368]  ? l2cap_recv_frame+0x7a6/0x2900 [bluetooth]
> > [   56.415373]  ? __mutex_unlock_slowpath+0x50/0x2f0
> > [   56.415383]  l2cap_recv_frame+0x7be/0x2900 [bluetooth]
> > [   56.415393]  ? hci_rx_work+0x472/0x5f0 [bluetooth]
> > [   56.415404]  l2cap_recv_acldata+0x2ff/0x310 [bluetooth]
> > [   56.415413]  hci_rx_work+0x494/0x5f0 [bluetooth]
> > [   56.415417]  process_one_work+0x250/0x6a0
> > [   56.415421]  worker_thread+0x3d/0x3b0
> > [   56.415424]  kthread+0x133/0x150
> > [   56.415426]  ? process_one_work+0x6a0/0x6a0
> > [   56.415428]  ? kthread_create_on_node+0x70/0x70
> > [   56.415431]  ret_from_fork+0x2a/0x40
> 
> if you run mgmt-tester or smp-tester, do you get the same lockdep
> warning.

No, but I think that the lockdep warning might try to avoid repeats
(?). I do get a couple of failures with mgmt-tester.

>  And is the BR/EDR or LE connection?

BR/EDR with the aforementioned XBox One S Bluetooth controller.

The behaviour seems to be that l2cap_core.c sees that the device is
using L2CAP Basic, we send an RFC to ask what it supports, we get back
an error and the device doesn't want to hear anything anymore.

Do you need more information? This isn't easily reproduceable (I think
it was repeated attempts at pairing the device which didn't want to
hear it) but I can certainly test more stuff.

Cheers
