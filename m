Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 02/25] lib: Add set/uset controller data operations
Date: Fri, 21 Dec 2012 16:26:29 -0400
Message-Id: <1356121612-15172-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add structure for new commands: Set Controller Data and Unset Controller
Data. Add new defines for flags that will be used in Set/Unset
Controller Data operation.
---
 lib/mgmt.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6c7e44a..fffb0aa 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -318,6 +318,22 @@ struct mgmt_cp_set_device_id {
 	uint16_t version;
 } __packed;
 
+#define MGMT_DATA_NORMAL_PRIORITY	0x00
+#define MGMT_DATA_HIGH_PRIORITY		0x01
+
+#define MGMT_OP_SET_CONTROLLER_DATA	0x0029
+struct mgmt_cp_set_controller_data {
+	uint8_t flags;
+	uint8_t type;
+	uint8_t length;
+	uint8_t data[0];
+} __packed;
+
+#define MGMT_OP_UNSET_CONTROLLER_DATA	0x002A
+struct mgmt_cp_unset_controller_data {
+	uint8_t type;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -496,6 +512,8 @@ static const char *mgmt_op[] = {
 	"Block Device",
 	"Unblock Device",
 	"Set Device ID",
+	"Set Controller Data",
+	"Unset Controller Data",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.7.9.5

