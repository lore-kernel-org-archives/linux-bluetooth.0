Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 30/30] Bluetooth: Process HCI callbacks in a workqueue
Date: Thu, 15 Mar 2012 14:30:21 +0200
Message-Id: <1331814621-13905-31-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Conflicts:

	include/net/bluetooth/hci_core.h
	net/bluetooth/hci_core.c

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9dd93d2..a774712 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1105,5 +1105,7 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 	void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd), void *opt,
 		void (*destructor)(struct hci_cb_cmd *cmd), gfp_t flags);
 void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
+					struct workqueue_struct *workqueue);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d8b443b..438486e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2278,6 +2278,47 @@ struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
 	return NULL;
 }
 
+struct hci_cb_work {
+	struct work_struct work;
+	struct hci_dev *hdev;
+	struct hci_cb_cmd *cmd;
+};
+
+static void hci_cb_worker(struct work_struct *w)
+{
+	struct hci_cb_work *work = (struct hci_cb_work *) w;
+	struct hci_cb_cmd *cmd = work->cmd;
+	struct hci_dev *hdev = work->hdev;
+
+	cmd->cb(hdev, cmd);
+
+	hci_remove_cb(hdev, cmd);
+	kfree(w);
+	hci_dev_put(hdev);
+}
+
+void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
+					struct workqueue_struct *workqueue)
+{
+	struct hci_cb_work *work;
+
+	BT_DBG("Queue cmd %p opt %p", cmd, cmd->opt);
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return;
+
+	INIT_WORK(&work->work, hci_cb_worker);
+	work->hdev = hdev;
+	work->cmd = cmd;
+	hci_dev_hold(hdev);
+
+	if (!queue_work(workqueue, &work->work)) {
+		kfree(work);
+		hci_dev_put(hdev);
+	}
+}
+
 void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
 {
 	mutex_lock(&hdev->cb_list_lock);
-- 
1.7.9.1

