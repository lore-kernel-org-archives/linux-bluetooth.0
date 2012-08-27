Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 02/33] lib: Add unset controller data operation
Date: Mon, 27 Aug 2012 13:02:54 -0400
Message-Id: <1346087005-24693-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add structure for new command: Unset Controller Data.
---
 lib/mgmt.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 99243b1..e65b7fb 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -329,6 +329,11 @@ struct mgmt_cp_set_controller_data {
 	uint8_t data[0];
 } __packed;
 
+#define MGMT_OP_UNSET_CONTROLLER_DATA	0x002A
+struct mgmt_cp_unset_controller_data {
+	uint8_t data_type;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -501,6 +506,7 @@ static const char *mgmt_op[] = {
 	"Unblock Device",
 	"Set Device ID",
 	"Set Controller Data",
+	"Unset Controller Data",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.7.9.5

