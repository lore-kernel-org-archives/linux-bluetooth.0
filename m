Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Add missing response structure for HCI Delete Stored Link Key
Date: Sun, 11 Jan 2015 13:44:24 -0800
Message-Id: <1421012665-4842-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds this missing structure for processing the result of the
HCI Delete Stored Link Key command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 91cd9d302cd0..8e54f825153c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -871,6 +871,10 @@ struct hci_cp_delete_stored_link_key {
 	bdaddr_t bdaddr;
 	__u8     delete_all;
 } __packed;
+struct hci_rp_delete_stored_link_key {
+	__u8     status;
+	__u8     num_keys;
+} __packed;
 
 #define HCI_MAX_NAME_LENGTH		248
 
-- 
2.1.0

