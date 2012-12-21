Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 04/25] btmgmt: Add set broadcaster and set observer support
Date: Fri, 21 Dec 2012 16:26:31 -0400
Message-Id: <1356121612-15172-5-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Add new broadcaster command for running the Set Broadcaster operation
from MGMT API. Also, add new observer command for running the Set
Observer operation from MGMT API.
---
 tools/btmgmt.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b89bcac..4d9eab6 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -235,6 +235,8 @@ static const char *settings_str[] = {
 				"br/edr",
 				"hs",
 				"le" ,
+				"broadcaster",
+				"observer",
 };
 
 static void print_settings(uint32_t settings)
@@ -1111,6 +1113,16 @@ static void cmd_le(int mgmt_sk, uint16_t index, int argc, char **argv)
 	cmd_setting(mgmt_sk, index, MGMT_OP_SET_LE, argc, argv);
 }
 
+static void cmd_broadcaster(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	cmd_setting(mgmt_sk, index, MGMT_OP_SET_BROADCASTER, argc, argv);
+}
+
+static void cmd_observer(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	cmd_setting(mgmt_sk, index, MGMT_OP_SET_OBSERVER, argc, argv);
+}
+
 static void class_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
 				void *rsp, uint16_t len, void *user_data)
 {
@@ -1848,6 +1860,8 @@ static struct {
 	{ "rm-uuid",	cmd_remove_uuid, "Remove UUID"			},
 	{ "clr-uuids",	cmd_clr_uuids,	"Clear UUIDs",			},
 	{ "did",	cmd_did,	"Set Device ID",		},
+	{ "broadcaster",cmd_broadcaster,"Toggle Broadcaster Mode",	},
+	{ "observer",	cmd_observer,	"Toggle Observer Mode",		},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.9.5

