Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/6] Bluetooth: Add hci_do_le_scan()
Date: Wed,  1 Feb 2012 19:34:49 -0300
Message-Id: <1328135692-24255-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
References: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hci_core the hci_do_le_scan function which
should be used to scan LE devices.

In order to enable LE scan, hci_do_le_scan() sends commands (Set
LE Scan Parameters and Set LE Scan Enable) to the controller and
waits for its results. If commands were executed successfully a
delayed work is scheduled to disable the ongoing scanning after
some amount of time. This function blocks.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    8 ++++
 net/bluetooth/hci_core.c         |   79 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   13 +++++-
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eab98d3..47111df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -126,6 +126,12 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+struct le_scan_params {
+	u8 type;
+	u16 interval;
+	u16 window;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -263,6 +269,8 @@ struct hci_dev {
 
 	unsigned long		dev_flags;
 
+	struct delayed_work	le_scan_disable;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 35843f1..2f5d1ae 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -759,6 +759,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
+	cancel_delayed_work_sync(&hdev->le_scan_disable);
+
 	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -1573,6 +1575,81 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
+{
+	struct le_scan_params *param =  (struct le_scan_params *) opt;
+	struct hci_cp_le_set_scan_param cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = param->type;
+	cp.interval = cpu_to_le16(param->interval);
+	cp.window = cpu_to_le16(param->window);
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
+}
+
+static void le_scan_enable_req(struct hci_dev *hdev, unsigned long opt)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 1;
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
+						u16 window, int timeout)
+{
+	long timeo = msecs_to_jiffies(3000);
+	struct le_scan_params param;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EINPROGRESS;
+
+	param.type = type;
+	param.interval = interval;
+	param.window = window;
+
+	hci_req_lock(hdev);
+
+	err = __hci_request(hdev, le_scan_param_req, (unsigned long) &param,
+									timeo);
+	if (err < 0)
+		goto failed;
+
+	err = __hci_request(hdev, le_scan_enable_req, 0, timeo);
+	if (err < 0)
+		goto failed;
+
+	hci_req_unlock(hdev);
+
+	schedule_delayed_work(&hdev->le_scan_disable,
+						msecs_to_jiffies(timeout));
+
+	return 0;
+
+failed:
+	hci_req_unlock(hdev);
+	return err;
+}
+
+static void le_scan_disable_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+						le_scan_disable.work);
+	struct hci_cp_le_set_scan_enable cp;
+
+	BT_DBG("%s", hdev->name);
+
+	memset(&cp, 0, sizeof(cp));
+
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1658,6 +1735,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
+	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+
 	write_unlock(&hci_dev_list_lock);
 
 	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI | WQ_UNBOUND |
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dd8056c..0bcfeca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1030,6 +1030,8 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_PARAM, status);
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -1040,15 +1042,17 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
 
 	switch (cp->enable) {
 	case LE_SCANNING_ENABLED:
+		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
+
+		if (status)
+			return;
+
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		cancel_delayed_work_sync(&hdev->adv_work);
@@ -1060,6 +1064,9 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCANNING_DISABLED:
+		if (status)
+			return;
+
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		hci_dev_lock(hdev);
-- 
1.7.9

