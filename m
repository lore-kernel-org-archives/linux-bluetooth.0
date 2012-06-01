Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/3] Bluetooth: Add callback cmd clear to ops->teardown
Date: Fri,  1 Jun 2012 14:44:34 +0300
Message-Id: <1338551074-7882-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338551074-7882-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338551074-7882-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

ops->teardown takes care about deleting queued callbacks for all AMP
controllers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/a2mp.c             |   16 +++++++++++++---
 net/bluetooth/hci_core.c         |    3 +--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ccf6067..33add72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1117,5 +1117,6 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
 void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
 		  struct workqueue_struct *workqueue);
+void hci_cb_clear(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 0772c68..9d9da98 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -447,9 +447,19 @@ static struct l2cap_chan *a2mp_chan_no_new_conn_cb(struct l2cap_chan *chan)
 	return NULL;
 }
 
-static void a2mp_chan_no_teardown_cb(struct l2cap_chan *chan, int err)
+static void a2mp_chan_teardown_cb(struct l2cap_chan *chan, int err)
 {
-	BT_ERR("teardown for chan %p not implemented", chan);
+	struct hci_dev *hdev;
+
+	BT_DBG("chan %p", chan);
+
+	read_lock(&hci_dev_list_lock);
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		/* Iterate through AMP controllers */
+		if (hdev->amp_type == HCI_AMP)
+			hci_cb_clear(hdev);
+	}
+	read_unlock(&hci_dev_list_lock);
 }
 
 static void a2mp_chan_no_ready(struct l2cap_chan *chan)
@@ -466,7 +476,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 
 	/* Not implemented for A2MP */
 	.new_connection = a2mp_chan_no_new_conn_cb,
-	.teardown = a2mp_chan_no_teardown_cb,
+	.teardown = a2mp_chan_teardown_cb,
 	.ready = a2mp_chan_no_ready,
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1815c33..ffcb04b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -38,7 +38,6 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
-static void hci_cb_clear(struct hci_dev *hdev);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -2217,7 +2216,7 @@ void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
 	}
 }
 
-static void hci_cb_clear(struct hci_dev *hdev)
+void hci_cb_clear(struct hci_dev *hdev)
 {
 	struct hci_cb_cmd *cmd, *tmp;
 
-- 
1.7.9.5

