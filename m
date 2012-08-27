Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 04/33] lib: Add set observer operation
Date: Mon, 27 Aug 2012 13:02:56 -0400
Message-Id: <1346087005-24693-5-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add opcodes for Set Observer command.
---
 lib/mgmt.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6ecad43..1e6bb32 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -93,6 +93,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
 #define MGMT_SETTING_BROADCASTER	0x00000400
+#define MGMT_SETTING_OBSERVER		0x00000800
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -337,6 +338,8 @@ struct mgmt_cp_unset_controller_data {
 
 #define MGMT_OP_SET_BROADCASTER		0x002B
 
+#define MGMT_OP_SET_OBSERVER		0x002C
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -511,6 +514,7 @@ static const char *mgmt_op[] = {
 	"Set Controller Data",
 	"Unset Controller Data",
 	"Set Broadcaster",
+	"Set Observer",
 };
 
 static const char *mgmt_ev[] = {
-- 
1.7.9.5

