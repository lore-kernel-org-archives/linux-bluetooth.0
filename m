Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/13] Bluetooth: Remove LE scan helpers
Date: Tue, 30 Apr 2013 02:45:01 -0300
Message-Id: <1367300704-703-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the LE scan helpers hci_le_scan and hci_cancel_
le_scan and all code related to it. We now use the HCI request
framework in device discovery functionality and these helpers are
no longer needed.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  13 -----
 net/bluetooth/hci_core.c         | 113 ---------------------------------------
 2 files changed, 126 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 99dded9..7cc8857 100644
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
@@ -283,9 +276,6 @@ struct hci_dev {
 
 	struct delayed_work	le_scan_disable;
 
-	struct work_struct	le_scan;
-	struct le_scan_params	le_scan_params;
-
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
@@ -1223,9 +1213,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
-int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
-		int timeout);
-int hci_cancel_le_scan(struct hci_dev *hdev);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d2b96bd..dcfe639 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1196,8 +1196,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	cancel_work_sync(&hdev->le_scan);
-
 	cancel_delayed_work(&hdev->power_off);
 
 	hci_req_cancel(hdev, ENODEV);
@@ -1982,82 +1980,6 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
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
-	cp.enable = LE_SCAN_ENABLE;
-	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
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
-			   timeout);
-
-	return 0;
-}
-
-int hci_cancel_le_scan(struct hci_dev *hdev)
-{
-	BT_DBG("%s", hdev->name);
-
-	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-		return -EALREADY;
-
-	if (cancel_delayed_work(&hdev->le_scan_disable)) {
-		struct hci_cp_le_set_scan_enable cp;
-
-		/* Send HCI command to disable LE Scan */
-		memset(&cp, 0, sizeof(cp));
-		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-	}
-
-	return 0;
-}
-
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
@@ -2134,40 +2056,6 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
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
-int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
-		int timeout)
-{
-	struct le_scan_params *param = &hdev->le_scan_params;
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
-		return -ENOTSUPP;
-
-	if (work_busy(&hdev->le_scan))
-		return -EINPROGRESS;
-
-	param->type = type;
-	param->interval = interval;
-	param->window = window;
-	param->timeout = timeout;
-
-	queue_work(system_long_wq, &hdev->le_scan);
-
-	return 0;
-}
-
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
 {
@@ -2202,7 +2090,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
 	INIT_WORK(&hdev->power_on, hci_power_on);
-	INIT_WORK(&hdev->le_scan, le_scan_work);
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
-- 
1.8.2.1

