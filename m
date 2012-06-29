Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 06/19] Bluetooth: Add callback clear to ops->teardown
Date: Fri, 29 Jun 2012 17:46:39 +0300
Message-Id: <1340981212-21709-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

ops->teardown takes care about deleting queued callbacks for all AMP
controllers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/a2mp.c             |   17 ++++++++++++++++-
 net/bluetooth/hci_core.c         |    3 +--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a3146c..d52e86b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1118,5 +1118,6 @@ void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
 void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
 		  struct workqueue_struct *workqueue);
 void hci_process_cb(struct hci_dev *hdev, __u16 opcode, u8 status);
+void hci_cb_clear(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 20cbbec..2ea3dcf 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -444,16 +444,31 @@ static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
 	return bt_skb_alloc(len, GFP_KERNEL);
 }
 
+static void a2mp_chan_teardown_cb(struct l2cap_chan *chan, int err)
+{
+	struct hci_dev *hdev, *tmp;
+
+	BT_DBG("chan %p", chan);
+
+	list_for_each_entry_safe(hdev, tmp, &hci_dev_list, list) {
+		hci_dev_hold(hdev);
+		/* Iterate through AMP controllers */
+		if (hdev->amp_type == HCI_AMP)
+			hci_cb_clear(hdev);
+		hci_dev_put(hdev);
+	}
+}
+
 static struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
 	.recv = a2mp_chan_recv_cb,
 	.close = a2mp_chan_close_cb,
 	.state_change = a2mp_chan_state_change_cb,
 	.alloc_skb = a2mp_chan_alloc_skb_cb,
+	.teardown = a2mp_chan_teardown_cb,
 
 	/* Not implemented for A2MP */
 	.new_connection = l2cap_chan_no_new_connection,
-	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9b721ea..a36e08f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -36,7 +36,6 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
-static void hci_cb_clear(struct hci_dev *hdev);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -2220,7 +2219,7 @@ void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
 	}
 }
 
-static void hci_cb_clear(struct hci_dev *hdev)
+void hci_cb_clear(struct hci_dev *hdev)
 {
 	struct hci_cb_cmd *cmd, *tmp;
 
-- 
1.7.9.5

