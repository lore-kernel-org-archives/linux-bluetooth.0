Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 01/33] lib: Add set controller data operation
Date: Mon, 27 Aug 2012 13:02:53 -0400
Message-Id: <1346087005-24693-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add structure for new command: Set Controller Data. Add new defines for
flags that will be used in Set Controller Data operation.
---
 lib/mgmt.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a2648bc..99243b1 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -318,6 +318,17 @@ struct mgmt_cp_set_device_id {
 	uint16_t version;
 } __packed;
 
+#define MGMT_DATA_NORMAL_PRIORITY	0x00
+#define MGMT_DATA_HIGH_PRIORITY		0x01
+
+#define MGMT_OP_SET_CONTROLLER_DATA	0x0029
+struct mgmt_cp_set_controller_data {
+	uint8_t flags;
+	uint8_t data_type;
+	uint8_t data_length;
+	uint8_t data[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -489,6 +500,7 @@ static const char *mgmt_op[] = {
 	"Block Device",
 	"Unblock Device",
 	"Set Device ID",
+	"Set Controller Data",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.7.9.5

