Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Rename update_ad into update_adv_data
Date: Wed, 16 Oct 2013 00:16:50 -0700
Message-Id: <1381907811-33872-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since there is update_scan_rsp_data, it is also better to use the
clear name update_adv_data instead of update_ad.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cd285d6..0bf823b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -626,7 +626,7 @@ static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
-static void update_ad(struct hci_request *req)
+static void update_adv_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_adv_data cp;
@@ -1746,7 +1746,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 		hci_dev_lock(hdev);
 
 		hci_req_init(&req, hdev);
-		update_ad(&req);
+		update_adv_data(&req);
 		update_scan_rsp_data(&req);
 		hci_req_run(&req, NULL);
 
@@ -3924,7 +3924,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	/* We need to flip the bit already here so that update_ad
+	/* We need to flip the bit already here so that update_adv_data
 	 * generates the correct flags.
 	 */
 	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
@@ -3937,7 +3937,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	/* Since only the advertising data flags will change, there
 	 * is no need to update the scan response data.
 	 */
-	update_ad(&req);
+	update_adv_data(&req);
 
 	err = hci_req_run(&req, set_bredr_complete);
 	if (err < 0)
@@ -4251,7 +4251,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 		 * where BR/EDR was toggled during the AUTO_OFF phase.
 		 */
 		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
-			update_ad(&req);
+			update_adv_data(&req);
 			update_scan_rsp_data(&req);
 		}
 
-- 
1.8.3.1

