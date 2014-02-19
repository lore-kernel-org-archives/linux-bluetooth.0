Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/2] android/hal-handsfree: Use fixed size buffers for commands
Date: Wed, 19 Feb 2014 21:49:38 +0100
Message-Id: <1392842978-29373-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1392842978-29373-1-git-send-email-szymon.janc@gmail.com>
References: <1392842978-29373-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This make code follow same conventions for all commands and simplify
code.
---
 android/hal-handsfree.c | 90 +++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 63 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 601c14f..7964c7d 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -360,9 +360,9 @@ static bt_status_t device_status_notification(bthf_network_state_t state,
 
 static bt_status_t cops_response(const char *cops)
 {
-	struct hal_cmd_handsfree_cops_response *cmd;
-	bt_status_t status;
-	int len;
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_handsfree_cops_response *cmd = (void *) buf;
+	size_t len;
 
 	DBG("");
 
@@ -372,22 +372,14 @@ static bt_status_t cops_response(const char *cops)
 	if (!cops)
 		return BT_STATUS_PARM_INVALID;
 
-	len = sizeof(*cmd) + strlen(cops);
-
-	cmd = malloc(len);
-	if (!cmd)
-		return BT_STATUS_NOMEM;
-
 	cmd->len = strlen(cops);
 	memcpy(cmd->buf, cops, cmd->len);
 
-	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
-				HAL_OP_HANDSFREE_COPS_RESPONSE, len, cmd, 0,
-				NULL, NULL);
-
-	free(cmd);
+	len = sizeof(*cmd) + cmd->len;
 
-	return status;
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+						HAL_OP_HANDSFREE_COPS_RESPONSE,
+						len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t cind_response(int svc, int num_active, int num_held,
@@ -416,9 +408,9 @@ static bt_status_t cind_response(int svc, int num_active, int num_held,
 
 static bt_status_t formatted_at_response(const char *rsp)
 {
-	struct hal_cmd_handsfree_formatted_at_response *cmd;
-	bt_status_t status;
-	int len;
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_handsfree_formatted_at_response *cmd = (void *) buf;
+	size_t len;
 
 	DBG("");
 
@@ -428,22 +420,14 @@ static bt_status_t formatted_at_response(const char *rsp)
 	if (!rsp)
 		return BT_STATUS_PARM_INVALID;
 
-	len = sizeof(*cmd) + strlen(rsp);
-
-	cmd = malloc(len);
-	if (!cmd)
-		return BT_STATUS_NOMEM;
-
 	cmd->len = strlen(rsp);
 	memcpy(cmd->buf, rsp, cmd->len);
 
-	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
-				HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE, len,
-				cmd, 0, NULL, NULL);
-
-	free(cmd);
+	len = sizeof(*cmd) + cmd->len;
 
-	return status;
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
+					len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t at_response(bthf_at_response_t response, int error)
@@ -470,23 +454,15 @@ static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 					const char *number,
 					bthf_call_addrtype_t type)
 {
-	struct hal_cmd_handsfree_clcc_response *cmd;
-	bt_status_t status;
-	int len;
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_handsfree_clcc_response *cmd = (void *) buf;
+	size_t len;
 
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	len = sizeof(*cmd);
-	if (number)
-		len += strlen(number);
-
-	cmd = malloc(len);
-	if (!cmd)
-		return BT_STATUS_NOMEM;
-
 	cmd->index = index;
 	cmd->dir = dir;
 	cmd->state = state;
@@ -501,13 +477,11 @@ static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 		cmd->number_len = 0;
 	}
 
-	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
-					HAL_OP_HANDSFREE_CLCC_RESPONSE, len,
-					cmd, 0, NULL, NULL);
-
-	free(cmd);
+	len = sizeof(*cmd) + cmd->number_len;
 
-	return status;
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+						HAL_OP_HANDSFREE_CLCC_RESPONSE,
+						len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t phone_state_change(int num_active, int num_held,
@@ -515,23 +489,15 @@ static bt_status_t phone_state_change(int num_active, int num_held,
 					const char *number,
 					bthf_call_addrtype_t type)
 {
-	struct hal_cmd_handsfree_phone_state_change *cmd;
-	bt_status_t status;
-	int len;
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_handsfree_phone_state_change *cmd = (void *) buf;
+	size_t len;
 
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	len = sizeof(*cmd);
-	if (number)
-		len += strlen(number);
-
-	cmd = malloc(len);
-	if (!cmd)
-		return BT_STATUS_NOMEM;
-
 	cmd->num_active = num_active;
 	cmd->num_held = num_held;
 	cmd->state = state;
@@ -544,13 +510,11 @@ static bt_status_t phone_state_change(int num_active, int num_held,
 		cmd->number_len = 0;
 	}
 
-	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+	len = sizeof(*cmd) + cmd->number_len;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
 					len, cmd, 0, NULL, NULL);
-
-	free(cmd);
-
-	return status;
 }
 
 static void cleanup(void)
-- 
1.9.0

