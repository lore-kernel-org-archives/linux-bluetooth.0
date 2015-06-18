Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 11/20] Bluetooth: mgmt: multi adv for create_instance_adv_data()
Date: Thu, 18 Jun 2015 03:16:44 +0200
Message-Id: <1434590213-26599-12-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The create_instance_adv_data() function could not deal with
multiple advertising instances previously. This is being fixed by
retrieving advertising instances from the newly introduced dynamic
advertising instance list.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc807dc..04efc56 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1014,8 +1014,18 @@ static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 {
+	struct adv_info *adv_instance = NULL;
 	u8 ad_len = 0, flags = 0;
-	u32 instance_flags = get_adv_instance_flags(hdev, instance);
+	u32 instance_flags;
+
+	/* Return 0 when the current instance identifier is invalid. */
+	if (instance) {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (!adv_instance)
+			return 0;
+	}
+
+	instance_flags = get_adv_instance_flags(hdev, instance);
 
 	/* The Add Advertising command allows userspace to set both the general
 	 * and limited discoverable flags.
@@ -1049,12 +1059,11 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 	}
 
-	if (instance) {
-		memcpy(ptr, hdev->adv_instance.adv_data,
-		       hdev->adv_instance.adv_data_len);
-
-		ad_len += hdev->adv_instance.adv_data_len;
-		ptr += hdev->adv_instance.adv_data_len;
+	if (adv_instance) {
+		memcpy(ptr, adv_instance->adv_data,
+		       adv_instance->adv_data_len);
+		ad_len += adv_instance->adv_data_len;
+		ptr += adv_instance->adv_data_len;
 	}
 
 	/* Provide Tx Power only if we can provide a valid value for it */
-- 
1.9.1

