Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 1/3] lib: add start service discovery
Date: Tue, 25 Nov 2014 16:46:06 -0800
Message-Id: <1416962768-19832-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start service discovery definition for new kernel
method.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 lib/mgmt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 4cfeac0..dc4e733 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -447,6 +447,15 @@ struct mgmt_cp_set_public_address {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A
+struct mgmt_cp_start_service_discovery {
+	uint8_t type;
+	int8_t rssi_threshold;
+	uint16_t num_uuid;
+	uint8_t uuid[0][16];
+} __packed;
+#define MGMT_START_SERVICE_DISCOVERY_SIZE	4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.1.0.rc2.206.gedb03e5

