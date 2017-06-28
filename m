Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 28 Jun 2017 14:44:06 -0400
From: Tejun Heo <tj@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: remove WQ_MEM_RECLAIM from hci workqueues
Message-ID: <20170628184406.GB27833@htj.duckdns.org>
References: <20170625182149.GA18000@light.dominikbrodowski.net>
 <20170627152032.GA2289@htj.duckdns.org>
 <83EA7A09-DDFB-4CEB-8F45-52BFDCE3C6DF@holtmann.org>
 <20170627173946.GE2289@htj.duckdns.org>
 <20170628100357.GA5675@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628100357.GA5675@light.dominikbrodowski.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth hci uses ordered HIGHPRI, MEM_RECLAIM workqueues.  It's
likely that the flags came from mechanical conversion from
create_singlethread_workqueue().  Bluetooth shouldn't be depended upon
for memory reclaim and the spurious MEM_RECLAIM flag can trigger the
following warning.  Remove WQ_MEM_RECLAIM and convert to
alloc_ordered_workqueue() while at it.

  workqueue: WQ_MEM_RECLAIM hci0:hci_power_off is flushing !WQ_MEM_RECLAIM events:btusb_work
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 14231 at /home/brodo/local/kernel/git/linux/kernel/workqueue.c:2423 check_flush_dependency+0xb3/0x100
  Modules linked in:
  CPU: 2 PID: 14231 Comm: kworker/u9:4 Not tainted 4.12.0-rc6+ #3
  Hardware name: Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016
  Workqueue: hci0 hci_power_off
  task: ffff9432dad58000 task.stack: ffff986d43790000
  RIP: 0010:check_flush_dependency+0xb3/0x100
  RSP: 0018:ffff986d43793c90 EFLAGS: 00010086
  RAX: 000000000000005a RBX: ffff943316810820 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
  RBP: ffff986d43793cb0 R08: 0000000000000775 R09: ffffffff85bdd5c0
  R10: 0000000000000040 R11: 0000000000000000 R12: ffffffff84d596e0
  R13: ffff9432dad58000 R14: ffff94321c640320 R15: ffff9432dad58000
  FS:  0000000000000000(0000) GS:ffff94331f500000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007b8bca242000 CR3: 000000014f60a000 CR4: 00000000003406e0
  Call Trace:
   flush_work+0x8a/0x1c0
   ? flush_work+0x184/0x1c0
   ? skb_free_head+0x21/0x30
   __cancel_work_timer+0x124/0x1b0
   ? hci_dev_do_close+0x2a4/0x4d0
   cancel_work_sync+0x10/0x20
   btusb_close+0x23/0x100
   hci_dev_do_close+0x2ca/0x4d0
   hci_power_off+0x1e/0x50
   process_one_work+0x184/0x3e0
   worker_thread+0x4a/0x3a0
   ? preempt_count_sub+0x9b/0x100
   ? preempt_count_sub+0x9b/0x100
   kthread+0x125/0x140
   ? process_one_work+0x3e0/0x3e0
   ? __kthread_create_on_node+0x1a0/0x1a0
   ? do_syscall_64+0x58/0xd0
   ret_from_fork+0x27/0x40
  Code: 00 75 bf 49 8b 56 18 48 8d 8b b0 00 00 00 48 81 c6 b0 00 00 00 4d 89 e0 48 c7 c7 20 23 6b 85 c6 05 83 cd 31 01 01 e8 bf c4 0c 00 <0f> ff eb 93 80 3d 74 cd 31 01 00 75 a5 65 48 8b 04 25 00 c5 00 
  ---[ end trace b88fd2f77754bfec ]---

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
Hello,

Marcel, as this isn't urgent and there is slight chance that this
might trigger another warning if these work items get flushed from a
different MEM_RECLAIM work item from e.g. nfs over network over
bluetooth.  Can you please try applying the patch after the 4.13-rc1
closes and see whether it turns up anything else?

Thanks.

 net/bluetooth/hci_core.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05686776a5fb..85ec6f7afbf7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3047,15 +3047,14 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
-	hdev->workqueue = alloc_workqueue("%s", WQ_HIGHPRI | WQ_UNBOUND |
-					  WQ_MEM_RECLAIM, 1, hdev->name);
+	hdev->workqueue = alloc_ordered_workqueue("%s", WQ_HIGHPRI, hdev->name);
 	if (!hdev->workqueue) {
 		error = -ENOMEM;
 		goto err;
 	}
 
-	hdev->req_workqueue = alloc_workqueue("%s", WQ_HIGHPRI | WQ_UNBOUND |
-					      WQ_MEM_RECLAIM, 1, hdev->name);
+	hdev->req_workqueue = alloc_ordered_workqueue("%s", WQ_HIGHPRI,
+						      hdev->name);
 	if (!hdev->req_workqueue) {
 		destroy_workqueue(hdev->workqueue);
 		error = -ENOMEM;
