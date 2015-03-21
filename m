Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/6] lib: Provide data structures for Add/Remove Advertising
Date: Fri, 20 Mar 2015 19:52:53 -0700
Message-Id: <1426906378-14804-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906378-14804-1-git-send-email-armansito@chromium.org>
References: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides data structures and opcodes for the Add/Remove
Advertising commands and the Advertising Added/Removed events.
---
 lib/mgmt.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 15dee70..01d948b 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -484,6 +484,29 @@ struct mgmt_rp_read_adv_features {
 	uint8_t  instance[0];
 } __packed;
 
+#define MGMT_OP_ADD_ADVERTISING		0x003E
+struct mgmt_cp_add_advertising {
+	uint8_t  instance;
+	uint32_t flags;
+	uint16_t duration;
+	uint16_t timeout;
+	uint8_t  adv_data_len;
+	uint8_t  scan_rsp_len;
+	uint8_t  data[0];
+} __packed;
+struct mgmt_rp_add_advertising {
+	uint8_t instance;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADVERTISING	0x003F
+struct mgmt_cp_remove_advertising {
+	uint8_t instance;
+} __packed;
+#define MGMT_REMOVE_ADVERTISING_SIZE	1
+struct mgmt_rp_remove_advertising {
+	uint8_t instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -686,6 +709,16 @@ struct mgmt_ev_local_oob_data_updated {
 	uint8_t  eir[0];
 } __packed;
 
+#define MGMT_EV_ADVERTISING_ADDED	0x0023
+struct mgmt_ev_advertising_added {
+	uint8_t instance;
+} __packed;
+
+#define MGMT_EV_ADVERTISING_REMOVED	0x0024
+struct mgmt_ev_advertising_removed {
+	uint8_t instance;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
-- 
2.2.0.rc0.207.ga3a616c

