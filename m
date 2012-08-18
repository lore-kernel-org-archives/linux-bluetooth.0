Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 17 Aug 2012 17:17:56 -0700
Message-ID: <CACUGKYNdpzLA3F-YwJ4KyM44=EEXDTVPVb_pGawh=Qx=o++FWQ@mail.gmail.com>
Subject: Kernel Bug - Bluetooth
From: John Tobias <john.tobias.ph@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Guys,

I am not sure if this mailing list is the right to post the bug.
I just ran "hciconfig hci1 leadv" then when I connect my iPhone apps,
it dumps the error messages below:

john

[  260.111724] ======================================================
[  260.118194] [ INFO: possible circular locking dependency detected ]
[  260.124755] 3.5.2 #4 Not tainted
[  260.128143] -------------------------------------------------------
[  260.134704] kworker/u:0/5 is trying to acquire lock:

[  260.139892]  ([  260.141662]
sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<bf03b7ec>]
l2cap_chan_ready+0x1c/0xbc [bluetooth]

[  260.152435] but task is already holding lock:
[  260.157196]  (&chan->lock){+.+...}, at: [<bf043474>]
l2cap_connect_cfm+0xf4/0x388 [bluetooth]
[  260.166198]
[  260.166198] which lock already depends on the new lock.
[  260.166198]
[  260.174774]
[  260.174774] the existing dependency chain (in reverse order) is:
[  260.182617]
-> #2 (&chan->lock){+.+...}:
[  260.186950]        [<c0090dc4>] lock_acquire+0x98/0x100
[  260.192413]        [<c0568290>] mutex_lock_nested+0x3c/0x2f4
[  260.198364]        [<bf043474>] l2cap_connect_cfm+0xf4/0x388 [bluetooth]
[  260.205444]        [<bf030388>] hci_event_packet+0x5304/0x6d9c [bluetooth]
[  260.212707]        [<bf026498>] hci_rx_work+0x288/0x358 [bluetooth]
[  260.219299]        [<c005ab38>] process_one_work+0x19c/0x4f4
[  260.225250]        [<c005d6f8>] worker_thread+0x170/0x378
[  260.230926]        [<c00623e4>] kthread+0x90/0x9c
[  260.235870]        [<c0014eb4>] kernel_thread_exit+0x0/0x8
[  260.241638]
-> #1 (&conn->chan_lock){+.+...}:
[  260.246429]        [<c0090dc4>] lock_acquire+0x98/0x100
[  260.251922]        [<c0568290>] mutex_lock_nested+0x3c/0x2f4
[  260.257843]        [<bf04365c>] l2cap_connect_cfm+0x2dc/0x388 [bluetooth]
[  260.265045]        [<bf030388>] hci_event_packet+0x5304/0x6d9c [bluetooth]
[  260.272308]        [<bf026498>] hci_rx_work+0x288/0x358 [bluetooth]
[  260.278900]        [<c005ab38>] process_one_work+0x19c/0x4f4
[  260.284851]        [<c005d6f8>] worker_thread+0x170/0x378
[  260.290527]        [<c00623e4>] kthread+0x90/0x9c
[  260.295471]        [<c0014eb4>] kernel_thread_exit+0x0/0x8
[  260.301239]
-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}:
[  260.307647]        [<c00906ec>] __lock_acquire+0x1cf8/0x1d88
[  260.313598]        [<c0090dc4>] lock_acquire+0x98/0x100
[  260.319061]        [<c043a454>] lock_sock_nested+0x6c/0x78
[  260.324829]        [<bf03b7ec>] l2cap_chan_ready+0x1c/0xbc [bluetooth]
[  260.331756]        [<bf043580>] l2cap_connect_cfm+0x200/0x388 [bluetooth]
[  260.338928]        [<bf030388>] hci_event_packet+0x5304/0x6d9c [bluetooth]
[  260.346160]        [<bf026498>] hci_rx_work+0x288/0x358 [bluetooth]
[  260.352783]        [<c005ab38>] process_one_work+0x19c/0x4f4
[  260.358734]        [<c005d6f8>] worker_thread+0x170/0x378
[  260.364410]        [<c00623e4>] kthread+0x90/0x9c
[  260.369323]        [<c0014eb4>] kernel_thread_exit+0x0/0x8
[  260.375091]
[  260.375091] other info that might help us debug this:
[  260.375091]
[  260.383483] Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP --> &conn->chan_lock --> &chan->lock

[  260.393585]  Possible unsafe locking scenario:
[  260.393585]
[  260.399780]        CPU0                    CPU1
[  260.404510]        ----                    ----
[  260.409271]   lock(&chan->lock);
[  260.412658]                                lock(&conn->chan_lock);
[  260.419158]                                lock(&chan->lock);
[  260.425201]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[  260.430664]
[  260.430664]  *** DEADLOCK ***
[  260.430664]
[  260.436889] 5 locks held by kworker/u:0/5:
[  260.441192]  #0:  (hdev->name){.+.+.+}, at: [<c005aab8>]
process_one_work+0x11c/0x4f4
[  260.449432]  #1:  ((&hdev->rx_work)){+.+.+.}, at: [<c005aab8>]
process_one_work+0x11c/0x4f4
[  260.458221]  #2:  (&hdev->lock){+.+.+.}, at: [<bf02cf6c>]
hci_event_packet+0x1ee8/0x6d9c [bluetooth]
[  260.467895]  #3:  (&conn->chan_lock){+.+...}, at: [<bf0433e4>]
l2cap_connect_cfm+0x64/0x388 [bluetooth]
[  260.477844]  #4:  (&chan->lock){+.+...}, at: [<bf043474>]
l2cap_connect_cfm+0xf4/0x388 [bluetooth]
[  260.487304]
[  260.487304] stack backtrace:
[  260.491912] [<c001b624>] (unwind_backtrace+0x0/0xf0) from
[<c008cf28>] (print_circular_bug+0x1c8/0x2d4)
[  260.501770] [<c008cf28>] (print_circular_bug+0x1c8/0x2d4) from
[<c00906ec>] (__lock_acquire+0x1cf8/0x1d88)
[  260.511901] [<c00906ec>] (__lock_acquire+0x1cf8/0x1d88) from
[<c0090dc4>] (lock_acquire+0x98/0x100)
[  260.521392] [<c0090dc4>] (lock_acquire+0x98/0x100) from
[<c043a454>] (lock_sock_nested+0x6c/0x78)
[  260.530761] [<c043a454>] (lock_sock_nested+0x6c/0x78) from
[<bf03b7ec>] (l2cap_chan_ready+0x1c/0xbc [bluetooth])
[  260.541534] [<bf03b7ec>] (l2cap_chan_ready+0x1c/0xbc [bluetooth])
from [<bf043580>] (l2cap_connect_cfm+0x200/0x388 [bluetooth])
[  260.553649] [<bf043580>] (l2cap_connect_cfm+0x200/0x388
[bluetooth]) from [<bf030388>] (hci_event_packet+0x5304/0x6d9c
[bluetooth])
[  260.566131] [<bf030388>] (hci_event_packet+0x5304/0x6d9c
[bluetooth]) from [<bf026498>] (hci_rx_work+0x288/0x358 [bluetooth])
[  260.578033] [<bf026498>] (hci_rx_work+0x288/0x358 [bluetooth]) from
[<c005ab38>] (process_one_work+0x19c/0x4f4)
[  260.588623] [<c005ab38>] (process_one_work+0x19c/0x4f4) from
[<c005d6f8>] (worker_thread+0x170/0x378)
[  260.598297] [<c005d6f8>] (worker_thread+0x170/0x378) from
[<c00623e4>] (kthread+0x90/0x9c)
[  260.606964] [<c00623e4>] (kthread+0x90/0x9c) from [<c0014eb4>]
(kernel_thread_exit+0x0/0x8)
