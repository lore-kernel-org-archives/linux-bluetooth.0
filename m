Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 1/7] Bluetooth: Add definitions for Add/Remove Advertising API
Date: Mon, 23 Mar 2015 15:57:09 -0700
Message-Id: <1427151435-24958-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427151435-24958-1-git-send-email-armansito@chromium.org>
References: <1427151435-24958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds definitions for the Add Advertising and Remove
Advertising MGMT commands and events.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 include/net/bluetooth/mgmt.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a1a6867..68abd4b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -539,6 +539,30 @@ struct mgmt_rp_read_adv_features {
 	__u8   instance[0];
 } __packed;
 
+#define MGMT_OP_ADD_ADVERTISING		0x003E
+struct mgmt_cp_add_advertising {
+	__u8	instance;
+	__le32	flags;
+	__le16	duration;
+	__le16	timeout;
+	__u8	adv_data_len;
+	__u8	scan_rsp_len;
+	__u8	data[0];
+} __packed;
+#define MGMT_ADD_ADVERTISING_SIZE	11
+struct mgmt_rp_add_advertising {
+	__u8	instance;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADVERTISING	0x003F
+struct mgmt_cp_remove_advertising {
+	__u8	instance;
+} __packed;
+#define MGMT_REMOVE_ADVERTISING_SIZE	1
+struct mgmt_rp_remove_advertising {
+	__u8	instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -742,3 +766,13 @@ struct mgmt_ev_local_oob_data_updated {
 	__le16	eir_len;
 	__u8	eir[0];
 } __packed;
+
+#define MGMT_EV_ADVERTISING_ADDED	0x0023
+struct mgmt_ev_advertising_added {
+	__u8    instance;
+} __packed;
+
+#define MGMT_EV_ADVERTISING_REMOVED	0x0024
+struct mgmt_ev_advertising_removed {
+	__u8    instance;
+} __packed;
-- 
2.2.0.rc0.207.ga3a616c

