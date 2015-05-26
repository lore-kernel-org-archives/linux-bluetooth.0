Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 09/16] Bluetooth: mgmt: multi adv for create_instance_scan_rsp_data()
Date: Tue, 26 May 2015 02:34:16 +0200
Message-Id: <1432600463-7758-10-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The create_instance_scan_rsp_data() function could not deal with
multiple advertising instances previously. This is being fixed by adding
an additional instance parameter.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 65c1e51..8913739 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -872,15 +872,22 @@ static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
-static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
+static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
+					u8 *ptr)
 {
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+	if (!adv_instance)
+		return 0;
+
 	/* TODO: Set the appropriate entries based on advertising instance flags
 	 * here once flags other than 0 are supported.
 	 */
-	memcpy(ptr, hdev->adv_instance.scan_rsp_data,
-	       hdev->adv_instance.scan_rsp_len);
+	memcpy(ptr, adv_instance->scan_rsp_data,
+	       adv_instance->scan_rsp_len);
 
-	return hdev->adv_instance.scan_rsp_len;
+	return adv_instance->scan_rsp_len;
 }
 
 static void update_scan_rsp_data_for_instance(struct hci_request *req,
@@ -896,7 +903,7 @@ static void update_scan_rsp_data_for_instance(struct hci_request *req,
 	memset(&cp, 0, sizeof(cp));
 
 	if (instance)
-		len = create_instance_scan_rsp_data(hdev, cp.data);
+		len = create_instance_scan_rsp_data(hdev, instance, cp.data);
 	else
 		len = create_default_scan_rsp_data(hdev, cp.data);
 
-- 
1.9.1

