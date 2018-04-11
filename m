Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <6f9f4d38b3ebbccc7e092d1bd60c2bf431b4acbf.camel@gmail.com>
Subject: [kernel 4.16.1] After pairing any bluetooth device in kernel log
 appearing message "possible recursive locking detected"
From: mikhail.v.gavrilov@gmail.com
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 11 Apr 2018 19:31:04 +0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Please don't ignore my message.
This is not harmless problem, because when I pairing game pad system hangs for a second.
And when I pairing headset I have no sound and pulse audio has crashed when I off headset.


$ uname -r
4.16.1-300.fc28.x86_64+debug


When I pairing headset SONY MDR-XB950B1:
[ 4488.566046] ============================================
[ 4488.566047] WARNING: possible recursive locking detected
[ 4488.566049] 4.16.1-300.fc28.x86_64+debug #1 Not tainted
[ 4488.566050] --------------------------------------------
[ 4488.566052] kworker/u17:2/680 is trying to acquire lock:
[ 4488.566054]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<000000008d97dbdd>] bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 4488.566073] 
               but task is already holding lock:
[ 4488.566075]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<0000000033ac331c>] l2cap_sock_new_connection_cb+0x18/0xa0 [bluetooth]
[ 4488.566090] 
               other info that might help us debug this:
[ 4488.566092]  Possible unsafe locking scenario:

[ 4488.566093]        CPU0
[ 4488.566095]        ----
[ 4488.566096]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[ 4488.566098]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[ 4488.566100] 
                *** DEADLOCK ***

[ 4488.566102]  May be due to missing lock nesting notation

[ 4488.566104] 5 locks held by kworker/u17:2/680:
[ 4488.566105]  #0:  ((wq_completion)"%s"hdev->name#2){+.+.}, at: [<0000000087e4bbc5>] process_one_work+0x1d7/0x630
[ 4488.566112]  #1:  ((work_completion)(&hdev->rx_work)){+.+.}, at: [<0000000087e4bbc5>] process_one_work+0x1d7/0x630
[ 4488.566116]  #2:  (&conn->chan_lock){+.+.}, at: [<00000000ffc63d0c>] l2cap_connect+0x8f/0x5a0 [bluetooth]
[ 4488.566132]  #3:  (&chan->lock/2){+.+.}, at: [<00000000393c41d7>] l2cap_connect+0xa9/0x5a0 [bluetooth]
[ 4488.566155]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<0000000033ac331c>] l2cap_sock_new_connection_cb+0x18/0xa0 [bluetooth]
[ 4488.566168] 
               stack backtrace:
[ 4488.566171] CPU: 0 PID: 680 Comm: kworker/u17:2 Not tainted 4.16.1-300.fc28.x86_64+debug #1
[ 4488.566173] Hardware name: Gigabyte Technology Co., Ltd. Z87M-D3H/Z87M-D3H, BIOS F11 08/12/2014
[ 4488.566183] Workqueue: hci0 hci_rx_work [bluetooth]
[ 4488.566185] Call Trace:
[ 4488.566190]  dump_stack+0x85/0xbf
[ 4488.566193]  __lock_acquire.cold.62+0x158/0x227
[ 4488.566198]  ? mark_held_locks+0x57/0x80
[ 4488.566201]  ? lock_acquire+0x9e/0x1b0
[ 4488.566211]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 4488.566215]  ? lock_sock_nested+0x72/0xa0
[ 4488.566224]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 4488.566233]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 4488.566244]  ? l2cap_sock_new_connection_cb+0x5d/0xa0 [bluetooth]
[ 4488.566255]  ? l2cap_connect+0x110/0x5a0 [bluetooth]
[ 4488.566276]  ? l2cap_recv_frame+0x6d0/0x2cb0 [bluetooth]
[ 4488.566281]  ? __mutex_unlock_slowpath+0x4b/0x2b0
[ 4488.566291]  ? l2cap_recv_frame+0x6e8/0x2cb0 [bluetooth]
[ 4488.566295]  ? __mutex_unlock_slowpath+0x4b/0x2b0
[ 4488.566304]  ? hci_rx_work+0x1c6/0x5d0 [bluetooth]
[ 4488.566307]  ? process_one_work+0x261/0x630
[ 4488.566310]  ? worker_thread+0x3a/0x390
[ 4488.566313]  ? process_one_work+0x630/0x630
[ 4488.566315]  ? kthread+0x120/0x140
[ 4488.566318]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 4488.566320]  ? ret_from_fork+0x3a/0x50
[ 4488.626592] BUG: sleeping function called from invalid context at net/core/sock.c:2768
[ 4488.626597] in_atomic(): 1, irqs_disabled(): 0, pid: 1804, name: krfcommd
[ 4488.626599] INFO: lockdep is turned off.
[ 4488.626603] CPU: 6 PID: 1804 Comm: krfcommd Not tainted 4.16.1-300.fc28.x86_64+debug #1
[ 4488.626606] Hardware name: Gigabyte Technology Co., Ltd. Z87M-D3H/Z87M-D3H, BIOS F11 08/12/2014
[ 4488.626609] Call Trace:
[ 4488.626615]  dump_stack+0x85/0xbf
[ 4488.626621]  ___might_sleep.cold.72+0xac/0xbc
[ 4488.626626]  ? lock_sock_nested+0x29/0xa0
[ 4488.626642]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 4488.626648]  ? rfcomm_connect_ind+0x21b/0x260 [rfcomm]
[ 4488.626652]  ? rfcomm_run+0x1620/0x1830 [rfcomm]
[ 4488.626657]  ? do_wait_intr_irq+0xb0/0xb0
[ 4488.626664]  ? rfcomm_check_accept+0x90/0x90 [rfcomm]
[ 4488.626667]  ? kthread+0x120/0x140
[ 4488.626670]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 4488.626676]  ? ret_from_fork+0x3a/0x50


When I pairing dualshock 4 game pad:
[ 1448.267449] ============================================
[ 1448.267450] WARNING: possible recursive locking detected
[ 1448.267452] 4.16.1-300.fc28.x86_64+debug #1 Not tainted
[ 1448.267453] --------------------------------------------
[ 1448.267455] kworker/u17:2/668 is trying to acquire lock:
[ 1448.267457]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<000000008dfc4ec7>] bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 1448.267477] 
               but task is already holding lock:
[ 1448.267478]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<00000000b2d78b70>] l2cap_sock_new_connection_cb+0x18/0xa0 [bluetooth]
[ 1448.267491] 
               other info that might help us debug this:
[ 1448.267493]  Possible unsafe locking scenario:

[ 1448.267494]        CPU0
[ 1448.267495]        ----
[ 1448.267496]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[ 1448.267498]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[ 1448.267500] 
                *** DEADLOCK ***

[ 1448.267501]  May be due to missing lock nesting notation

[ 1448.267503] 5 locks held by kworker/u17:2/668:
[ 1448.267504]  #0:  ((wq_completion)"%s"hdev->name#2){+.+.}, at: [<000000003908f3cc>] process_one_work+0x1d7/0x630
[ 1448.267510]  #1:  ((work_completion)(&hdev->rx_work)){+.+.}, at: [<000000003908f3cc>] process_one_work+0x1d7/0x630
[ 1448.267514]  #2:  (&conn->chan_lock){+.+.}, at: [<0000000082009ad9>] l2cap_connect+0x8f/0x5a0 [bluetooth]
[ 1448.267527]  #3:  (&chan->lock/2){+.+.}, at: [<0000000006821ecb>] l2cap_connect+0xa9/0x5a0 [bluetooth]
[ 1448.267543]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<00000000b2d78b70>] l2cap_sock_new_connection_cb+0x18/0xa0 [bluetooth]
[ 1448.267557] 
               stack backtrace:
[ 1448.267560] CPU: 6 PID: 668 Comm: kworker/u17:2 Not tainted 4.16.1-300.fc28.x86_64+debug #1
[ 1448.267561] Hardware name: Gigabyte Technology Co., Ltd. Z87M-D3H/Z87M-D3H, BIOS F11 08/12/2014
[ 1448.267571] Workqueue: hci0 hci_rx_work [bluetooth]
[ 1448.267573] Call Trace:
[ 1448.267579]  dump_stack+0x85/0xbf
[ 1448.267582]  __lock_acquire.cold.62+0x158/0x227
[ 1448.267586]  ? mark_held_locks+0x57/0x80
[ 1448.267589]  ? lock_acquire+0x9e/0x1b0
[ 1448.267598]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 1448.267602]  ? lock_sock_nested+0x72/0xa0
[ 1448.267611]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 1448.267621]  ? bt_accept_enqueue+0x3c/0xb0 [bluetooth]
[ 1448.267634]  ? l2cap_sock_new_connection_cb+0x5d/0xa0 [bluetooth]
[ 1448.267644]  ? l2cap_connect+0x110/0x5a0 [bluetooth]
[ 1448.267655]  ? l2cap_recv_frame+0x6d0/0x2cb0 [bluetooth]
[ 1448.267659]  ? __mutex_unlock_slowpath+0x4b/0x2b0
[ 1448.267671]  ? l2cap_recv_frame+0x6e8/0x2cb0 [bluetooth]
[ 1448.267674]  ? __mutex_unlock_slowpath+0x4b/0x2b0
[ 1448.267684]  ? hci_rx_work+0x1c6/0x5d0 [bluetooth]
[ 1448.267687]  ? process_one_work+0x261/0x630
[ 1448.267690]  ? worker_thread+0x3a/0x390
[ 1448.267693]  ? process_one_work+0x630/0x630
[ 1448.267695]  ? kthread+0x120/0x140
[ 1448.267698]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 1448.267700]  ? ret_from_fork+0x3a/0x50
[ 1448.378725] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[ 1448.378734] Bluetooth: HIDP socket layer initialized
[ 1448.397524] sony 0005:054C:09CC.0009: unknown main item tag 0x0
[ 1448.407894] input: Wireless Controller Touchpad as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.1/1-9.1.7/1-9.1.7:1.0/bluetooth/hci0/hci0:71/0005:054C:09CC.0009/input/input23
[ 1448.408413] input: Wireless Controller Motion Sensors as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.1/1-9.1.7/1-9.1.7:1.0/bluetooth/hci0/hci0:71/0005:054C:09CC.0009/input/input24
[ 1448.409153] input: Wireless Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.1/1-9.1.7/1-9.1.7:1.0/bluetooth/hci0/hci0:71/0005:054C:09CC.0009/input/input22
[ 1448.409597] sony 0005:054C:09CC.0009: input,hidraw6: BLUETOOTH HID v81.00 Gamepad [Wireless Controller] on 00:1a:7d:da:71:0a



