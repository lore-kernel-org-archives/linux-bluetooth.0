Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix freeing l2cap_chan while it's locked
Date: Sat, 25 Jan 2014 17:10:08 -0500
Message-Id: <1390687809-14408-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
References: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's a race condition where it's possible that user space closes the
socket right at the moment that the kernel is inside some L2CAP
signaling channel handler with the lock held for the l2cap_chan tied to
the socket. When the race occurs it can look as follows:

 WARNING: CPU: 1 PID: 2395 at kernel/locking/mutex.c:565 __mutex_lock_slowpath+0x1ff/0x26a()
 DEBUG_LOCKS_WARN_ON(l->magic != l)
 CPU: 1 PID: 2395 Comm: kworker/u5:1 Not tainted 3.12.0+ #224
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 Workqueue: hci0 hci_rx_work
  00000007 00000000 ed74dcd0 c1344099 ed74dcf8 ed74dce8 c1028b29 c1346891
  ed5e0b80 00000246 f61d7600 ed74dd00 c1028b88 00000009 ed74dcf8 c13fd4cc
  ed74dd14 ed74dd50 c1346891 c13fd4e4 00000235 c13fd4cc c13fd50a 5a5a5a5a
 Call Trace:
  [<c1344099>] dump_stack+0x48/0x60
  [<c1028b29>] warn_slowpath_common+0x57/0x6e
  [<c1346891>] ? __mutex_lock_slowpath+0x1ff/0x26a
  [<c1028b88>] warn_slowpath_fmt+0x26/0x2a
  [<c1346891>] __mutex_lock_slowpath+0x1ff/0x26a
  [<c134691f>] mutex_lock+0x23/0x2f
  [<c130e79a>] l2cap_get_chan_by_scid+0x32/0x40
  [<c13143cb>] l2cap_config_req+0x6d/0x78f
  [<c1009486>] ? save_stack_trace+0x1d/0x3b
  [<c10915c2>] ? set_track+0x48/0xa7
  [<c134312b>] ? free_debug_processing+0x134/0x16b
  [<c1006019>] ? native_sched_clock+0x37/0x3a
  [<c1315107>] l2cap_recv_frame+0x2f2/0x1a85
  [<c1315107>] ? l2cap_recv_frame+0x2f2/0x1a85
  [<c1317913>] l2cap_recv_acldata+0xe8/0x239
  [<c1317913>] ? l2cap_recv_acldata+0xe8/0x239
  [<c12fa470>] hci_rx_work+0x1b0/0x295
  [<c13465d9>] ? mutex_unlock+0x8/0xa
  [<c12fa470>] ? hci_rx_work+0x1b0/0x295
  [<c103592c>] ? pwq_activate_delayed_work+0x1c/0x27
  [<c1036d25>] process_one_work+0x128/0x1df
  [<c1347401>] ? _raw_spin_unlock_irq+0x8/0x12
  [<c1036d25>] ? process_one_work+0x128/0x1df
  [<c103713a>] worker_thread+0x127/0x1c4
  [<c1037013>] ? rescuer_thread+0x216/0x216
  [<c103aec6>] kthread+0x88/0x8d
  [<c1040000>] ? task_rq_lock+0x37/0x6e
  [<c1347e77>] ret_from_kernel_thread+0x1b/0x28
  [<c103ae3e>] ? __kthread_parkme+0x50/0x50
 ---[ end trace 81d41a8e15d9559e ]---
 =============================================================================
 BUG kmalloc-1024 (Tainted: G        W   ): Poison overwritten
 -----------------------------------------------------------------------------
 INFO: 0xed5e0b80-0xed5e0b85. First byte 0xff instead of 0x6b
 INFO: Allocated in l2cap_chan_create+0x1f/0xf9 age=9986 cpu=1 pid=2395
 	__slab_alloc.constprop.66+0x1c5/0x36e
 	kmem_cache_alloc+0x54/0xb4
 	l2cap_chan_create+0x1f/0xf9
 	l2cap_sock_alloc.constprop.5+0x73/0x9b
 	l2cap_sock_new_connection_cb+0x5d/0x95
 	l2cap_connect+0x112/0x3a0
 	l2cap_recv_frame+0x534/0x1a85
 	process_pending_rx+0x48/0x56
 	process_one_work+0x128/0x1df
 	worker_thread+0x127/0x1c4
 	kthread+0x88/0x8d
 	ret_from_kernel_thread+0x1b/0x28
 INFO: Freed in l2cap_chan_destroy+0x59/0x65 age=9986 cpu=0 pid=2363
 	__slab_free+0x3c/0x260
 	kfree+0xb3/0xbc
 	l2cap_chan_destroy+0x59/0x65
 	kref_put+0x2a/0x33
 	l2cap_chan_put+0x3f/0x4a
 	l2cap_sock_destruct+0x3d/0x77
 	__sk_free+0x20/0x116
 	sk_free+0x1c/0x1f
 	l2cap_sock_kill+0x6f/0x74
 	l2cap_sock_teardown_cb+0xc1/0x119
 	l2cap_chan_close+0x186/0x192
 	l2cap_sock_shutdown+0x1af/0x214
 	l2cap_sock_release+0x56/0xa2
 	sock_release+0x10/0x55
 	sock_close+0xb/0xf
 	__fput+0xd3/0x175

This patch fixes the race by acquiring the l2cap_chan lock in
l2cap_chan_destroy before removing the channel from the global list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e5c5c7427c41..3a9917be6c6e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -442,10 +442,14 @@ static void l2cap_chan_destroy(struct kref *kref)
 
 	BT_DBG("chan %p", chan);
 
+	l2cap_chan_lock(chan);
+
 	write_lock(&chan_list_lock);
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	l2cap_chan_unlock(chan);
+
 	kfree(chan);
 }
 
-- 
1.8.5.3

