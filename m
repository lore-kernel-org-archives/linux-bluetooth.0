Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 03/25] lib: Add set broadcaster/observer operations
Date: Fri, 21 Dec 2012 16:26:30 -0400
Message-Id: <1356121612-15172-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add opcodes for new Set Broadcaster and Set Observer commands.
---
 lib/mgmt.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index fffb0aa..44c4405 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -92,6 +92,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_BROADCASTER	0x00000400
+#define MGMT_SETTING_OBSERVER		0x00000800
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -334,6 +336,10 @@ struct mgmt_cp_unset_controller_data {
 	uint8_t type;
 } __packed;
 
+#define MGMT_OP_SET_BROADCASTER		0x002B
+
+#define MGMT_OP_SET_OBSERVER		0x002C
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -514,6 +520,8 @@ static const char *mgmt_op[] = {
 	"Set Device ID",
 	"Set Controller Data",
 	"Unset Controller Data",
+	"Set Broadcaster",
+	"Set Observer",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.7.9.5

