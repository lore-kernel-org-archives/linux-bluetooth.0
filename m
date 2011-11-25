Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/9] Bluetooth: LE scan infra-structure
Date: Fri, 25 Nov 2011 20:53:42 -0300
Message-Id: <1322265226-6404-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does the proper init of the structs required to carry
out LE scan and implement the LE scan work.

The LE scan work sends the commands (Set LE Scan Parameters and Set
LE Scan Enable) to the controller in order to start LE scanning. If
commands were executed successfully the le_scan_timer is set to
disable the ongoing scanning after some amount of time.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_core.c    |   38 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c   |    5 +++++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b7c6452..6e2b88f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -130,6 +130,7 @@ enum {
 #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
 #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
 #define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
+#define HCI_LE_SCAN_TIMEOUT	(3000)	/* 3 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28ef2ac..8e96e3b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -981,6 +981,33 @@ static void hci_power_on(struct work_struct *work)
 		mgmt_index_added(hdev);
 }
 
+static void le_scan_req(struct hci_dev *hdev, unsigned long opt)
+{
+	struct le_scan_params *params = (void *) opt;
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return;
+
+	send_le_scan_param_cmd(hdev, params->type, params->interval,
+							params->window);
+	send_le_scan_enable_cmd(hdev, 1);
+}
+
+static void hci_le_scan(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, le_scan);
+	struct le_scan_params *params = &hdev->le_scan_params;
+	int err;
+
+	err = hci_request(hdev, le_scan_req, (unsigned long) params,
+					msecs_to_jiffies(HCI_LE_SCAN_TIMEOUT));
+	if (err < 0)
+		return;
+
+	mod_timer(&hdev->le_scan_timer, jiffies +
+					msecs_to_jiffies(params->timeout));
+}
+
 static void hci_power_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1447,6 +1474,13 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+static void le_scan_timeout(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	send_le_scan_enable_cmd(hdev, 0);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1500,6 +1534,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	skb_queue_head_init(&hdev->raw_q);
 
 	setup_timer(&hdev->cmd_timer, hci_cmd_timer, (unsigned long) hdev);
+	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
+							(unsigned long) hdev);
 
 	for (i = 0; i < NUM_REASSEMBLY; i++)
 		hdev->reassembly[i] = NULL;
@@ -1526,6 +1562,7 @@ int hci_register_dev(struct hci_dev *hdev)
 						(unsigned long) hdev);
 
 	INIT_WORK(&hdev->power_on, hci_power_on);
+	INIT_WORK(&hdev->le_scan, hci_le_scan);
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
@@ -1611,6 +1648,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_del_sysfs(hdev);
 
 	del_timer(&hdev->adv_timer);
+	del_timer(&hdev->le_scan_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 845b26b..ea09c11 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -951,6 +951,9 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	if (status)
+		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_PARAM, status);
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -969,6 +972,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		return;
 
 	if (cp->enable == 0x01) {
+		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
+
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		del_timer(&hdev->adv_timer);
-- 
1.7.7.1

