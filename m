Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jul 2015 12:36:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>, linux-bluetooth@vger.kernel.org,
	Joshua_Frkuska@mentor.com
Subject: Re: [PATCH v2 0/8] Avoid L2CAP ERTM shutdown hung tasks
Message-ID: <20150709093626.GA19545@t440s.ger.corp.intel.com>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
 <8070DCD7-709D-4B34-BD44-12D68DD71E21@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8070DCD7-709D-4B34-BD44-12D68DD71E21@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 09, 2015, Marcel Holtmann wrote:
> > Dean Jenkins (8):
> >  Bluetooth: L2CAP ERTM shutdown protect sk and chan
> >  Bluetooth: Make __l2cap_wait_ack more efficient
> >  Bluetooth: Unwind l2cap_sock_shutdown()
> >  Bluetooth: l2cap_sock_shutdown() remove mutex_lock calls
> >  Bluetooth: l2cap_sock_shutdown() reduce scope of chan locking
> >  Bluetooth: Add BT_DBG to l2cap_sock_shutdown()
> >  Bluetooth: __l2cap_wait_ack() use msecs_to_jiffies()
> >  Bluetooth: __l2cap_wait_ack() add defensive timeout
> > 
> > include/net/bluetooth/l2cap.h |  2 ++
> > net/bluetooth/l2cap_sock.c    | 74 +++++++++++++++++++++++++++----------------
> > 2 files changed, 49 insertions(+), 27 deletions(-)
> 
> all 8 patches have been applied to bluetooth-next tree.

I'm getting the following now when running our l2cap-tester tool:

[Jul 9 12:34] ======================================================
[  +0.000298] [ INFO: possible circular locking dependency detected ]
[  +0.000298] 4.1.0-rc4+ #1356 Not tainted
[  +0.000165] -------------------------------------------------------
[  +0.000288] l2cap-tester/10613 is trying to acquire lock:
[  +0.000000]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<f942807e>] lock_sock+0xa/0xc [bluetooth]
[  +0.000336] 
              but task is already holding lock:
[  +0.000000]  (&chan->lock/1){+.+...}, at: [<f94283b6>] l2cap_chan_lock+0x13/0x15 [bluetooth]
[  +0.000000] 
              which lock already depends on the new lock.

[  +0.000000] 
              the existing dependency chain (in reverse order) is:
[  +0.000000] 
              -> #1 (&chan->lock/1){+.+...}:
[  +0.000000]        [<c1064917>] lock_acquire+0xdd/0x14f
[  +0.000000]        [<c13ff419>] mutex_lock_nested+0x54/0x393
[  +0.000000]        [<f94283b6>] l2cap_chan_lock+0x13/0x15 [bluetooth]
[  +0.000000]        [<f9428ec1>] l2cap_sock_shutdown+0x28c/0x327 [bluetooth]
[  +0.000000]        [<f942937a>] l2cap_sock_release+0x57/0xa5 [bluetooth]
[  +0.000000]        [<c1318032>] sock_release+0x19/0x6b
[  +0.000000]        [<c1318094>] sock_close+0x10/0x14
[  +0.000000]        [<c10e808a>] __fput+0xd6/0x162
[  +0.000000]        [<c10e8146>] ____fput+0xd/0xf
[  +0.000000]        [<c1049bc8>] task_work_run+0x7e/0xa4
[  +0.000000]        [<c1001d1e>] do_notify_resume+0x3c/0x3f
[  +0.000000]        [<c1402730>] work_notifysig+0x29/0x31
[  +0.000000] 
              -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}:
[  +0.000000]        [<c1064396>] __lock_acquire+0x98c/0xbfb
[  +0.000000]        [<c1064917>] lock_acquire+0xdd/0x14f
[  +0.000000]        [<c131cb86>] lock_sock_nested+0x63/0x7d
[  +0.000000]        [<f942807e>] lock_sock+0xa/0xc [bluetooth]
[  +0.000000]        [<f9428ed9>] l2cap_sock_shutdown+0x2a4/0x327 [bluetooth]
[  +0.000000]        [<f942937a>] l2cap_sock_release+0x57/0xa5 [bluetooth]
[  +0.000000]        [<c1318032>] sock_release+0x19/0x6b
[  +0.000000]        [<c1318094>] sock_close+0x10/0x14
[  +0.000000]        [<c10e808a>] __fput+0xd6/0x162
[  +0.000000]        [<c10e8146>] ____fput+0xd/0xf
[  +0.000000]        [<c1049bc8>] task_work_run+0x7e/0xa4
[  +0.000000]        [<c1001d1e>] do_notify_resume+0x3c/0x3f
[  +0.000000]        [<c1402730>] work_notifysig+0x29/0x31
[  +0.000000] 
              other info that might help us debug this:

[  +0.000000]  Possible unsafe locking scenario:

[  +0.000000]        CPU0                    CPU1
[  +0.000000]        ----                    ----
[  +0.000000]   lock(&chan->lock/1);
[  +0.000000]                                lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  +0.000000]                                lock(&chan->lock/1);
[  +0.000000]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  +0.000000] 
               *** DEADLOCK ***

[  +0.000000] 1 lock held by l2cap-tester/10613:
[  +0.000000]  #0:  (&chan->lock/1){+.+...}, at: [<f94283b6>] l2cap_chan_lock+0x13/0x15 [bluetooth]
[  +0.000000] 
              stack backtrace:
[  +0.000000] CPU: 1 PID: 10613 Comm: l2cap-tester Not tainted 4.1.0-rc4+ #1356
[  +0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.1-20150318_183358- 04/01/2014
[  +0.000000]  00000000 00000000 f1acbde4 c13fd7f8 c1c2d760 f1acbe14 c1062c61 c15f5534
[  +0.000000]  c15f5427 c15f53ef c15f5410 c15f53ef f1acbe48 f537f380 f537f7fc f537f380
[  +0.000000]  f537f814 f1acbe78 c1064396 f537f7fc 00000000 00000000 c1c2ffc0 00000000
[  +0.000000] Call Trace:
[  +0.000000]  [<c13fd7f8>] dump_stack+0x49/0x73
[  +0.000000]  [<c1062c61>] print_circular_bug+0x190/0x19d
[  +0.000000]  [<c1064396>] __lock_acquire+0x98c/0xbfb
[  +0.000000]  [<c1064917>] lock_acquire+0xdd/0x14f
[  +0.000000]  [<f942807e>] ? lock_sock+0xa/0xc [bluetooth]
[  +0.000000]  [<c131cb86>] lock_sock_nested+0x63/0x7d
[  +0.000000]  [<f942807e>] ? lock_sock+0xa/0xc [bluetooth]
[  +0.000000]  [<f942807e>] lock_sock+0xa/0xc [bluetooth]
[  +0.000000]  [<f9428ed9>] l2cap_sock_shutdown+0x2a4/0x327 [bluetooth]
[  +0.000000]  [<f9401112>] ? bt_sock_unlink+0x16/0x54 [bluetooth]
[  +0.000000]  [<c1402276>] ? _raw_write_unlock+0x2c/0x3e
[  +0.000000]  [<f942937a>] l2cap_sock_release+0x57/0xa5 [bluetooth]
[  +0.000000]  [<f942937a>] ? l2cap_sock_release+0x57/0xa5 [bluetooth]
[  +0.000000]  [<c1318032>] sock_release+0x19/0x6b
[  +0.000000]  [<c1318032>] ? sock_release+0x19/0x6b
[  +0.000000]  [<c1318094>] sock_close+0x10/0x14
[  +0.000000]  [<c10e808a>] __fput+0xd6/0x162
[  +0.000000]  [<c10e8146>] ____fput+0xd/0xf
[  +0.000000]  [<c1049bc8>] task_work_run+0x7e/0xa4
[  +0.000000]  [<c1001d1e>] do_notify_resume+0x3c/0x3f
[  +0.000000]  [<c1402730>] work_notifysig+0x29/0x31

Johan
