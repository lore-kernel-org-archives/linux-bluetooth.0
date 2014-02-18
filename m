Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/13] android/hal-avrcp: Add .list_player_app_attr_rsp implementation
Date: Tue, 18 Feb 2014 16:24:21 +0200
Message-Id: <1392733470-22736-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 9937a11..244f77a 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -74,6 +75,36 @@ static bt_status_t get_play_status_rsp(btrc_play_status_t status,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
+static bt_status_t list_player_app_attr_rsp(int num_attr,
+						btrc_player_attr_t *p_attrs)
+{
+	struct hal_cmd_avrcp_list_player_attrs *cmd;
+	bt_status_t status;
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
+	cmd = malloc(len);
+
+	cmd->number = num_attr;
+	memcpy(cmd->attrs, p_attrs, num_attr);
+
+	status =  hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_LIST_PLAYER_ATTRS,
+					len, cmd, 0, NULL, NULL);
+
+	free(cmd);
+
+	return status;
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -97,6 +128,7 @@ static btrc_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
 	.get_play_status_rsp = get_play_status_rsp,
+	.list_player_app_attr_rsp = list_player_app_attr_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

