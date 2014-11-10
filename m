Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 1/3] lib: add start and stop discovery
Date: Mon, 10 Nov 2014 08:33:38 -0800
Message-Id: <1415637220-11382-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds start and stop discovery definitions for new kernel
method.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 lib/mgmt.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 46766a9..e044724 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -445,6 +445,30 @@ struct mgmt_cp_set_public_address {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A
+
+#define MGMT_RANGE_NONE     0X00
+#define MGMT_RANGE_RSSI     0X01
+#define MGMT_RANGE_PATHLOSS 0X02
+
+struct mgmt_uuid_filter {
+	int8_t rssi;
+	uint8_t uuid[16];
+} __packed;
+
+struct mgmt_cp_start_service_discovery {
+	uint8_t type;
+	uint16_t filter_count;
+	struct mgmt_uuid_filter filter[0];
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

