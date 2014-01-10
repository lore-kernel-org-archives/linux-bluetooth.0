Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/15] Bluetooth: Add HCI command definition for Secure Connections enabling
Date: Fri, 10 Jan 2014 01:29:29 -0800
Message-Id: <1389346182-12387-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Secure Connections feature is optional and host stacks have to
manually enable it. This add the HCI command definiton for reading
and writing this setting.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cd40219d32aa..2a35d273de2c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -937,6 +937,17 @@ struct hci_rp_write_sync_train_params {
 	__le16	sync_train_int;
 } __packed;
 
+#define HCI_OP_READ_SC_SUPPORT		0x0c79
+struct hci_rp_read_sc_support {
+	__u8	status;
+	__u8	support;
+} __packed;
+
+#define HCI_OP_WRITE_SC_SUPPORT		0x0c7a
+struct hci_cp_write_sc_support {
+	__u8	support;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
-- 
1.8.4.2

