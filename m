Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Set the scan response data when needed
Date: Wed, 16 Oct 2013 00:16:48 -0700
Message-Id: <1381907811-33872-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On controller power on and when enabling LE functionality,
make sure that also the scan response data is correctly set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/mgmt.c        | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8b8c3e2..aca8944 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1094,6 +1094,12 @@ struct hci_cp_le_set_adv_data {
 	__u8	data[HCI_MAX_AD_LENGTH];
 } __packed;
 
+#define HCI_OP_LE_SET_SCAN_RSP_DATA	0x2009
+struct hci_cp_le_set_scan_rsp_data {
+	__u8	length;
+	__u8	data[HCI_MAX_AD_LENGTH];
+} __packed;
+
 #define HCI_OP_LE_SET_ADV_ENABLE	0x200a
 
 #define LE_SCAN_PASSIVE			0x00
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54f1454..59bbf43 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -536,6 +536,36 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
+static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+{
+	return 0;
+}
+
+static void update_scan_rsp_data(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_rsp_data cp;
+	u8 len;
+
+	if (!lmp_le_capable(hdev))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = create_scan_rsp_data(hdev, cp.data);
+
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
+}
+
 static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
@@ -1715,6 +1745,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 
 		hci_req_init(&req, hdev);
 		update_ad(&req);
+		update_scan_rsp_data(&req);
 		hci_req_run(&req, NULL);
 
 		hci_dev_unlock(hdev);
@@ -3898,6 +3929,9 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		set_bredr_scan(&req);
 
+	/* Since only the advertising data flags will change, there
+	 * is no need to update the scan response data.
+	 */
 	update_ad(&req);
 
 	err = hci_req_run(&req, set_bredr_complete);
@@ -4211,8 +4245,10 @@ static int powered_update_hci(struct hci_dev *hdev)
 		 * advertising data. This also applies to the case
 		 * where BR/EDR was toggled during the AUTO_OFF phase.
 		 */
-		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 			update_ad(&req);
+			update_scan_rsp_data(&req);
+		}
 
 		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 			enable_advertising(&req);
-- 
1.8.3.1

