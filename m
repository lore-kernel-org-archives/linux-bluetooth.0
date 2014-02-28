Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add definitions for LE white list HCI commands
Date: Thu, 27 Feb 2014 20:37:28 -0800
Message-Id: <1393562251-7555-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the definitions for clearing the LE white list, adding entries to
the LE white list and removing entries from the LE white list.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4755a28ace85..0cedc92cda47 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1205,6 +1205,20 @@ struct hci_rp_le_read_white_list_size {
 	__u8	size;
 } __packed;
 
+#define HCI_OP_LE_CLEAR_WHITE_LIST	0x2010
+
+#define HCI_OP_LE_ADD_TO_WHITE_LIST	0x2011
+struct hci_cp_le_add_to_white_list {
+	__u8     bdaddr_type;
+	bdaddr_t bdaddr;
+} __packed;
+
+#define HCI_OP_LE_DEL_FROM_WHITE_LIST	0x2012
+struct hci_cp_le_del_from_white_list {
+	__u8     bdaddr_type;
+	bdaddr_t bdaddr;
+} __packed;
+
 #define HCI_OP_LE_CONN_UPDATE		0x2013
 struct hci_cp_le_conn_update {
 	__le16   handle;
-- 
1.8.5.3

