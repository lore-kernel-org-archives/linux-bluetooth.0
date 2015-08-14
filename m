Return-Path: <cyrus@holtmann.org>
From: Ben YoungTae Kim <ytkim@qca.qualcomm.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1] Bluetooth: hciuart: Fix to use boolean flag with u32 type
Message-ID: <55CD7816.8090305@qualcomm.com>
Date: Thu, 13 Aug 2015 22:09:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

debugfs_create_bool is asking to put u32 type pointer instead of bool
so that passing bool type with u32* cast will cause memory corruption
to read that value since it is handled by 4 bytes instead of 1 byte
inside.

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 62e45ff..6b9b912 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -80,8 +80,8 @@ struct qca_data {
 	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
 	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
 	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
-	bool tx_vote;		/* Clock must be on for TX */
-	bool rx_vote;		/* Clock must be on for RX */
+	u32 tx_vote;		/* Clock must be on for TX */
+	u32 rx_vote;		/* Clock must be on for RX */
 	struct timer_list tx_idle_timer;
 	u32 tx_idle_delay;
 	struct timer_list wake_retrans_timer;
@@ -482,10 +482,10 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 			   &qca->ibs_recv_wakes);
 	debugfs_create_u64("ibs_recv_wake_acks", mode, ibs_dir,
 			   &qca->ibs_recv_wacks);
-	debugfs_create_bool("tx_vote", mode, ibs_dir, (u32 *)&qca->tx_vote);
+	debugfs_create_bool("tx_vote", mode, ibs_dir, &qca->tx_vote);
 	debugfs_create_u64("tx_votes_on", mode, ibs_dir, &qca->tx_votes_on);
 	debugfs_create_u64("tx_votes_off", mode, ibs_dir, &qca->tx_votes_off);
-	debugfs_create_bool("rx_vote", mode, ibs_dir, (u32 *)&qca->rx_vote);
+	debugfs_create_bool("rx_vote", mode, ibs_dir, &qca->rx_vote);
 	debugfs_create_u64("rx_votes_on", mode, ibs_dir, &qca->rx_votes_on);
 	debugfs_create_u64("rx_votes_off", mode, ibs_dir, &qca->rx_votes_off);
 	debugfs_create_u64("votes_on", mode, ibs_dir, &qca->votes_on);
-- 
2.0.5


