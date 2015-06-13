Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 09/20] Bluetooth: mgmt: multi adv for enable_advertising()
Date: Sat, 13 Jun 2015 05:41:02 +0200
Message-Id: <1434166873-21595-10-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously enable_advertising() would rely on
get_adv_instance_scan_rsp_len() which checked for a hard coded instance
identifier. This is being changed to check for the current advertising
instance's scan response length instead. The function is renamed
accordingly.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 47fa16b..76aee8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -986,16 +986,23 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 	return adv_instance->flags;
 }
 
-static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
+static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 {
-	/* Ignore instance 0 and other unsupported instances */
-	if (instance != 0x01)
+	u8 instance = get_current_adv_instance(hdev);
+	struct adv_info *adv_instance;
+
+	/* Ignore instance 0 */
+	if (instance == 0x00)
+		return 0;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
 		return 0;
 
 	/* TODO: Take into account the "appearance" and "local-name" flags here.
 	 * These are currently being ignored as they are not supported.
 	 */
-	return hdev->adv_instance.scan_rsp_len;
+	return adv_instance->scan_rsp_len;
 }
 
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
@@ -1266,7 +1273,7 @@ static void enable_advertising(struct hci_request *req)
 
 	if (connectable)
 		cp.type = LE_ADV_IND;
-	else if (get_adv_instance_scan_rsp_len(hdev, instance))
+	else if (get_cur_adv_instance_scan_rsp_len(hdev))
 		cp.type = LE_ADV_SCAN_IND;
 	else
 		cp.type = LE_ADV_NONCONN_IND;
-- 
1.9.1

