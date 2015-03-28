Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 2/3] Bluetooth: Use ADV_SCAN_IND for adv. instances
Date: Sat, 28 Mar 2015 12:38:59 -0700
Message-Id: <1427571540-29166-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427571540-29166-1-git-send-email-armansito@chromium.org>
References: <1427571540-29166-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, ADV_SCAN_IND will be used for advertising instances
that have non-zero scan response data while the global "connectable"
setting is "off".

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d998ec3..2d84fc1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -994,6 +994,18 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 	return flags;
 }
 
+static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
+{
+	/* Ignore instance 0 and other unsupported instances */
+	if (instance != 0x01)
+		return 0;
+
+	/* TODO: Take into account the "appearance" and "local-name" flags here.
+	 * These are currently being ignored as they are not supported.
+	 */
+	return hdev->adv_instance.scan_rsp_len;
+}
+
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
@@ -1260,7 +1272,14 @@ static void enable_advertising(struct hci_request *req)
 	memset(&cp, 0, sizeof(cp));
 	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
 	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
-	cp.type = connectable ? LE_ADV_IND : LE_ADV_NONCONN_IND;
+
+	if (connectable)
+		cp.type = LE_ADV_IND;
+	else if (get_adv_instance_scan_rsp_len(hdev, instance))
+		cp.type = LE_ADV_SCAN_IND;
+	else
+		cp.type = LE_ADV_NONCONN_IND;
+
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
-- 
2.2.0.rc0.207.ga3a616c

