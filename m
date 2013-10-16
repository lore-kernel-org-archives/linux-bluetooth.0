Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Store device name in scan response data
Date: Wed, 16 Oct 2013 00:16:49 -0700
Message-Id: <1381907811-33872-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The scan response data is a better place to store the device name
since it has more space available and is also enforcing privacy.

When the controller is advertising, the connectable setting decides
if ADV_IND or ADV_NONCONN_IND is used. In case of ADV_IND, the
remote side is allowed to request the scan response data. Same as
with BR/EDR where either EIR is used or a remote name request. In
non-connectable mode, the device name is not available since it is
not allowed to request scan response data. Same as in BR/EDR where
the device is non-discoverable and no name requests are answered.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 59bbf43..cd285d6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -538,7 +538,28 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 
 static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
-	return 0;
+	u8 ad_len = 0;
+	size_t name_len;
+
+	name_len = strlen(hdev->dev_name);
+	if (name_len > 0) {
+		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
+
+		if (name_len > max_len) {
+			name_len = max_len;
+			ptr[1] = EIR_NAME_SHORT;
+		} else
+			ptr[1] = EIR_NAME_COMPLETE;
+
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, hdev->dev_name, name_len);
+
+		ad_len += (name_len + 2);
+		ptr += (name_len + 2);
+	}
+
+	return ad_len;
 }
 
 static void update_scan_rsp_data(struct hci_request *req)
@@ -569,7 +590,6 @@ static void update_scan_rsp_data(struct hci_request *req)
 static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
-	size_t name_len;
 
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		flags |= LE_AD_GENERAL;
@@ -603,24 +623,6 @@ static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 		ptr += 3;
 	}
 
-	name_len = strlen(hdev->dev_name);
-	if (name_len > 0) {
-		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
-
-		if (name_len > max_len) {
-			name_len = max_len;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
-
-		ptr[0] = name_len + 1;
-
-		memcpy(ptr + 2, hdev->dev_name, name_len);
-
-		ad_len += (name_len + 2);
-		ptr += (name_len + 2);
-	}
-
 	return ad_len;
 }
 
@@ -2966,8 +2968,11 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		update_eir(&req);
 	}
 
+	/* The name is stored in the scan response data and so
+	 * no need to udpate the advertising data here.
+	 */
 	if (lmp_le_capable(hdev))
-		update_ad(&req);
+		update_scan_rsp_data(&req);
 
 	err = hci_req_run(&req, set_name_complete);
 	if (err < 0)
-- 
1.8.3.1

