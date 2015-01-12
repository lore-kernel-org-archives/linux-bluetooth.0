Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Add defintions for HCI Read Stored Link Key command
Date: Mon, 12 Jan 2015 09:21:24 -0800
Message-Id: <1421083288-22345-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the missing commmand structure and command complete
structure for the HCI Read Store Link Key command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d0bca316b43b..91cd9d302cd0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -855,6 +855,17 @@ struct hci_cp_set_event_flt {
 #define HCI_CONN_SETUP_AUTO_OFF	0x01
 #define HCI_CONN_SETUP_AUTO_ON	0x02
 
+#define HCI_OP_READ_STORED_LINK_KEY	0x0c0d
+struct hci_cp_read_stored_link_key {
+	bdaddr_t bdaddr;
+	__u8     read_all;
+} __packed;
+struct hci_rp_read_stored_link_key {
+	__u8     status;
+	__u8     max_keys;
+	__u8     num_keys;
+} __packed;
+
 #define HCI_OP_DELETE_STORED_LINK_KEY	0x0c12
 struct hci_cp_delete_stored_link_key {
 	bdaddr_t bdaddr;
-- 
2.1.0

