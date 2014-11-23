Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 1/3] lib: add start and stop discovery
Date: Sat, 22 Nov 2014 23:50:36 -0800
Message-Id: <1416729038-4486-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start and stop discovery definitions for new kernel
method.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 lib/mgmt.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 4cfeac0..3f69365 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -447,6 +447,21 @@ struct mgmt_cp_set_public_address {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A
+struct mgmt_cp_start_service_discovery {
+	uint8_t type;
+	int8_t rssi_threshold;
+	uint16_t num_uuid;
+	uint8_t uuid[0][16];
+} __packed;
+#define MGMT_START_SERVICE_DISCOVERY_SIZE	1
+
+#define MGMT_OP_STOP_SERVICE_DISCOVERY		0x003B
+struct mgmt_cp_stop_service_discovery {
+	uint8_t type;
+} __packed;
+#define MGMT_STOP_SERVICE_DISCOVERY_SIZE	1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.1.0.rc2.206.gedb03e5

