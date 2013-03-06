Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Remove LE scan work
Date: Wed,  6 Mar 2013 16:10:57 -0300
Message-Id: <1362597059-4102-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
References: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the LE scan work and all code related to it. We
now use the HCI request framework to enable LE scanning so the LE
scan work is no longer needed.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 10 ------
 net/bluetooth/hci_core.c         | 72 ----------------------------------------
 2 files changed, 82 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9efb571..2f95e4d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -117,13 +117,6 @@ struct oob_data {
 	u8 randomizer[16];
 };
 
-struct le_scan_params {
-	u8 type;
-	u16 interval;
-	u16 window;
-	int timeout;
-};
-
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -278,9 +271,6 @@ struct hci_dev {
 
 	struct delayed_work	le_scan_disable;
 
-	struct work_struct	le_scan;
-	struct le_scan_params	le_scan_params;
-
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 73487f0..6bdab9b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1061,8 +1061,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	cancel_work_sync(&hdev->le_scan);
-
 	cancel_delayed_work(&hdev->power_off);
 
 	hci_req_cancel(hdev, ENODEV);
@@ -1843,64 +1841,6 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
-static void le_scan_param_req(struct hci_request *req, unsigned long opt)
-{
-	struct le_scan_params *param =  (struct le_scan_params *) opt;
-	struct hci_cp_le_set_scan_param cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.type = param->type;
-	cp.interval = cpu_to_le16(param->interval);
-	cp.window = cpu_to_le16(param->window);
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
-}
-
-static void le_scan_enable_req(struct hci_request *req, unsigned long opt)
-{
-	struct hci_cp_le_set_scan_enable cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = 1;
-	cp.filter_dup = 1;
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-}
-
-static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
-			  u16 window, int timeout)
-{
-	long timeo = msecs_to_jiffies(3000);
-	struct le_scan_params param;
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-		return -EINPROGRESS;
-
-	param.type = type;
-	param.interval = interval;
-	param.window = window;
-
-	hci_req_lock(hdev);
-
-	err = __hci_req_sync(hdev, le_scan_param_req, (unsigned long) &param,
-			     timeo);
-	if (!err)
-		err = __hci_req_sync(hdev, le_scan_enable_req, 0, timeo);
-
-	hci_req_unlock(hdev);
-
-	if (err < 0)
-		return err;
-
-	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-			   msecs_to_jiffies(timeout));
-
-	return 0;
-}
-
 int hci_cancel_le_scan(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_scan_enable cp;
@@ -1928,17 +1868,6 @@ static void le_scan_disable_work(struct work_struct *work)
 	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
-static void le_scan_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev, le_scan);
-	struct le_scan_params *param = &hdev->le_scan_params;
-
-	BT_DBG("%s", hdev->name);
-
-	hci_do_le_scan(hdev, param->type, param->interval, param->window,
-		       param->timeout);
-}
-
 static int set_le_scan_param(struct hci_request *req, u8 type, u16 interval,
 			     u16 window)
 {
@@ -2017,7 +1946,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
 	INIT_WORK(&hdev->power_on, hci_power_on);
-	INIT_WORK(&hdev->le_scan, le_scan_work);
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
-- 
1.8.1.2

