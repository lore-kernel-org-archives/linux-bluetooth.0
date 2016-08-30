Return-Path: <bhaktipriya96@gmail.com>
Date: Tue, 30 Aug 2016 22:42:53 +0530
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove deprecated create_singlethread_workqueue
Message-ID: <20160830171252.GA32272@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

The workqueue "workqueue" queues multiple work items viz &qca->ws_awake_rx
&qca->ws_rx_vote_off, &qca->ws_awake_device, &qca->ws_tx_vote_off which
require strict execution ordering. Hence, an ordered dedicated workqueue
has been used to replace the deprecated create_singlethread_workqueue
instance.

WQ_MEM_RECLAIM has not been set since the driver is not being used on a
memory reclaim path.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 683c2b6..6c867fb 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -397,7 +397,7 @@ static int qca_open(struct hci_uart *hu)
 	skb_queue_head_init(&qca->txq);
 	skb_queue_head_init(&qca->tx_wait_q);
 	spin_lock_init(&qca->hci_ibs_lock);
-	qca->workqueue = create_singlethread_workqueue("qca_wq");
+	qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
 	if (!qca->workqueue) {
 		BT_ERR("QCA Workqueue not initialized properly");
 		kfree(qca);
--
2.1.4
