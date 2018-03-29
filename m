Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 29 Mar 2018 22:16:03 +0500
Message-ID: <CABXGCsPabgiUdUMw2rbU7S-g1PCLOLPDLttuvrZdJd4pEV64oQ@mail.gmail.com>
Subject: Kernel 4.16.0-rc7 possible recursive locking detected in bluetooth driver
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guy's
Who can look into my issue?

[ 3878.237243] ============================================
[ 3878.237245] WARNING: possible recursive locking detected
[ 3878.237247] 4.16.0-rc7 #1 Not tainted
[ 3878.237248] --------------------------------------------
[ 3878.237250] kworker/u17:1/654 is trying to acquire lock:
[ 3878.237251]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at:
[<0000000010b8e917>] bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 3878.237271]
               but task is already holding lock:
[ 3878.237272]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at:
[<00000000cda391be>] l2cap_sock_new_connection_cb+0x18/0xa0
[bluetooth]
[ 3878.237288]
               other info that might help us debug this:
[ 3878.237289]  Possible unsafe locking scenario:

[ 3878.237291]        CPU0
[ 3878.237292]        ----
[ 3878.237293]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[ 3878.237295]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[ 3878.237297]
                *** DEADLOCK ***

[ 3878.237299]  May be due to missing lock nesting notation

[ 3878.237301] 5 locks held by kworker/u17:1/654:
[ 3878.237303]  #0:  ((wq_completion)"%s"hdev->name#2){+.+.}, at:
[<00000000ff0a9cc9>] process_one_work+0x1da/0x6b0
[ 3878.237308]  #1:  ((work_completion)(&hdev->rx_work)){+.+.}, at:
[<00000000ff0a9cc9>] process_one_work+0x1da/0x6b0
[ 3878.237312]  #2:  (&conn->chan_lock){+.+.}, at:
[<00000000b41e2708>] l2cap_connect+0x88/0x540 [bluetooth]
[ 3878.237326]  #3:  (&chan->lock#2/2){+.+.}, at: [<00000000fce56415>]
l2cap_connect+0xa0/0x540 [bluetooth]
[ 3878.237341]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at:
[<00000000cda391be>] l2cap_sock_new_connection_cb+0x18/0xa0
[bluetooth]
[ 3878.237354]
               stack backtrace:
[ 3878.237357] CPU: 4 PID: 654 Comm: kworker/u17:1 Not tainted 4.16.0-rc7 #1
[ 3878.237358] Hardware name: Gigabyte Technology Co., Ltd.
Z87M-D3H/Z87M-D3H, BIOS F11 08/12/2014
[ 3878.237368] Workqueue: hci0 hci_rx_work [bluetooth]
[ 3878.237370] Call Trace:
[ 3878.237376]  dump_stack+0x85/0xbf
[ 3878.237380]  __lock_acquire+0x694/0x1340
[ 3878.237389]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 3878.237394]  ? lock_acquire+0x9f/0x200
[ 3878.237397]  lock_acquire+0x9f/0x200
[ 3878.237406]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 3878.237410]  lock_sock_nested+0x72/0xa0
[ 3878.237419]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 3878.237427]  bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 3878.237439]  l2cap_sock_new_connection_cb+0x5d/0xa0 [bluetooth]
[ 3878.237459]  l2cap_connect+0x126/0x540 [bluetooth]
[ 3878.237471]  ? l2cap_recv_frame+0x86b/0x2940 [bluetooth]
[ 3878.237475]  ? __mutex_unlock_slowpath+0x4b/0x2b0
[ 3878.237485]  l2cap_recv_frame+0x883/0x2940 [bluetooth]
[ 3878.237489]  ? __mutex_unlock_slowpath+0x4b/0x2b0
[ 3878.237499]  hci_rx_work+0x1cc/0x5d0 [bluetooth]
[ 3878.237503]  process_one_work+0x266/0x6b0
[ 3878.237507]  worker_thread+0x3a/0x390
[ 3878.237510]  ? process_one_work+0x6b0/0x6b0
[ 3878.237513]  kthread+0x121/0x140
[ 3878.237516]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 3878.237519]  ret_from_fork+0x3a/0x50
[ 3878.375526] sony 0005:054C:09CC.0009: unknown main item tag 0x0
[ 3878.389388] input: Wireless Controller Touchpad as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.1/1-9.1.7/1-9.1.7:1.0/bluetooth/hci0/hci0:68/0005:054C:09CC.0009/input/input24
[ 3878.389865] input: Wireless Controller Motion Sensors as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.1/1-9.1.7/1-9.1.7:1.0/bluetooth/hci0/hci0:68/0005:054C:09CC.0009/input/input25
[ 3878.390211] input: Wireless Controller as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.1/1-9.1.7/1-9.1.7:1.0/bluetooth/hci0/hci0:68/0005:054C:09CC.0009/input/input23
[ 3878.390714] sony 0005:054C:09CC.0009: input,hidraw6: BLUETOOTH HID
v81.00 Gamepad [Wireless Controller] on 00:1a:7d:da:71:0a
[ 3884.045970] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 3900.046984] Bluetooth: hci0: last event is not cmd complete (0x0f)
[ 3916.045076] Bluetooth: hci0: last event is not cmd complete (0x0f)




--
Best Regards,
Mike Gavrilov.
