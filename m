Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/14] android/hal-avrcp: Add .list_player_app_attr_rsp implementation
Date: Wed, 19 Feb 2014 18:58:49 +0200
Message-Id: <1392829138-10346-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 9937a11..9735c22 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -74,6 +75,33 @@ static bt_status_t get_play_status_rsp(btrc_play_status_t status,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
+static bt_status_t list_player_app_attr_rsp(int num_attr,
+						btrc_player_attr_t *p_attrs)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_list_player_attrs *cmd = (void *) buf;
+	size_t len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (num_attr < 0)
+		return BT_STATUS_PARM_INVALID;
+
+	len = sizeof(*cmd) + num_attr;
+	if (len > BLUEZ_HAL_MTU)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd->number = num_attr;
+	memcpy(cmd->attrs, p_attrs, num_attr);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_LIST_PLAYER_ATTRS,
+					len, cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -97,6 +125,7 @@ static btrc_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
 	.get_play_status_rsp = get_play_status_rsp,
+	.list_player_app_attr_rsp = list_player_app_attr_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

