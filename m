Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/4] lib: Add definitions for Get Connection Information command
Date: Fri, 16 May 2014 17:19:11 +0200
Message-ID: <1400253554-31574-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index ab45735..bab0f99 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -365,6 +365,17 @@ struct mgmt_cp_load_irks {
 	struct mgmt_irk_info irks[0];
 } __packed;
 
+#define MGMT_OP_GET_CONN_INFO		0x0031
+struct mgmt_cp_get_conn_info {
+	struct mgmt_addr_info addr;
+} __packed;
+struct mgmt_rp_get_conn_info {
+	struct mgmt_addr_info addr;
+	int8_t rssi;
+	int8_t tx_power;
+	int8_t max_tx_power;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -570,6 +581,7 @@ static const char *mgmt_op[] = {
 	"Set Debug Keys",
 	"Set Privacy",
 	"Load Identity Resolving Keys",
+	"Get Connection Information",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.9.3

