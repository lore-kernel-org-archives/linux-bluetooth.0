Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 03/33] lib: Add set broadcaster operation
Date: Mon, 27 Aug 2012 13:02:55 -0400
Message-Id: <1346087005-24693-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add opcodes for new Set Broadcaster command.
---
 lib/mgmt.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index e65b7fb..6ecad43 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -92,6 +92,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_BROADCASTER	0x00000400
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -334,6 +335,8 @@ struct mgmt_cp_unset_controller_data {
 	uint8_t data_type;
 } __packed;
 
+#define MGMT_OP_SET_BROADCASTER		0x002B
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -507,6 +510,7 @@ static const char *mgmt_op[] = {
 	"Set Device ID",
 	"Set Controller Data",
 	"Unset Controller Data",
+	"Set Broadcaster",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.7.9.5

