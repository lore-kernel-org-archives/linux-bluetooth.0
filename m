Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 03/15] Bluetooth: Add HCI command definition for extended OOB data
Date: Fri, 10 Jan 2014 02:07:18 -0800
Message-Id: <1389348450-23303-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Secure Connections feature introduces the support for P-256 strength
pairings (compared to P-192 with Secure Simple Pairing). This however
means that for out-of-band pairing the hash and randomizer needs to be
differentiated. Two new commands are introduced to handle the possible
combinations of P-192 and P-256. This add the HCI command definition
for both.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2a35d273de2c..e4e94bfc5232 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -664,6 +664,15 @@ struct hci_rp_set_csb {
 
 #define HCI_OP_START_SYNC_TRAIN		0x0443
 
+#define HCI_OP_REMOTE_OOB_EXT_DATA_REPLY	0x0445
+struct hci_cp_remote_oob_ext_data_reply {
+	bdaddr_t bdaddr;
+	__u8     hash192[16];
+	__u8     randomizer192[16];
+	__u8     hash256[16];
+	__u8     randomizer256[16];
+} __packed;
+
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
 	__le16   handle;
@@ -948,6 +957,15 @@ struct hci_cp_write_sc_support {
 	__u8	support;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
+struct hci_rp_read_local_oob_ext_data {
+	__u8     status;
+	__u8     hash192[16];
+	__u8     randomizer192[16];
+	__u8     hash256[16];
+	__u8     randomizer256[16];
+} __packed;
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
-- 
1.8.4.2

