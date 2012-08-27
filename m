Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 05/33] btmgmt: Add set broadcaster support
Date: Mon, 27 Aug 2012 13:02:57 -0400
Message-Id: <1346087005-24693-6-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add new broadcaster command for running the Set Broadcaster operation
from MGMT API.
---
 tools/btmgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f06f0bf..adfab83 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1099,6 +1099,11 @@ static void cmd_le(int mgmt_sk, uint16_t index, int argc, char **argv)
 	cmd_setting(mgmt_sk, index, MGMT_OP_SET_LE, argc, argv);
 }
 
+static void cmd_broadcaster(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	cmd_setting(mgmt_sk, index, MGMT_OP_SET_BROADCASTER, argc, argv);
+}
+
 static void class_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
 				void *rsp, uint16_t len, void *user_data)
 {
@@ -1834,6 +1839,7 @@ static struct {
 	{ "rm-uuid",	cmd_add_uuid,	"Remove UUID"			},
 	{ "clr-uuids",	cmd_clr_uuids,	"Clear UUIDs",			},
 	{ "did",	cmd_did,	"Set Device ID",		},
+	{ "broadcaster",cmd_broadcaster,"Toggle Broadcaster Mode",	},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.9.5

