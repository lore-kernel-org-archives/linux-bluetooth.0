Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/5] android/client/health: Write dummy data on fd
Date: Mon, 23 Jun 2014 18:06:03 +0300
Message-Id: <1403535964-32644-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS expects dummy data on fd when it connects in source role.
---
 android/client/if-hl.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index d27afcc..34e8b27 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -52,10 +52,13 @@ SINTMAP(bthl_channel_state_t, -1, "(unknown)")
 	DELEMENT(BTHL_CONN_STATE_DESTROYED),
 ENDMAP
 
-#define FD_LIST_SIZE 256
+#define APP_ID_SIZE 256
+#define MDEP_CFG_SIZE 10
+#define ELEMENTS_SIZE 3
 
 const bthl_interface_t *if_hl = NULL;
-static int fd_list[FD_LIST_SIZE];
+/* app_id {mdep_cfg_index{role, channel_id, fd}} */
+static int app_info[APP_ID_SIZE][MDEP_CFG_SIZE][ELEMENTS_SIZE];
 
 static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 {
@@ -74,19 +77,30 @@ static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
 			app_id, bt_bdaddr_t2str(bd_addr, addr), mdep_cfg_index,
 			channel_id, bthl_channel_state_t2str(state), fd);
 
-	if (channel_id >= FD_LIST_SIZE)
+	if (app_id >= APP_ID_SIZE || mdep_cfg_index >= MDEP_CFG_SIZE)
 		return;
 
 	if (state == BTHL_CONN_STATE_CONNECTED) {
-		fd_list[channel_id] = fd;
+		app_info[app_id][mdep_cfg_index][1] = channel_id;
+		app_info[app_id][mdep_cfg_index][2] = fd;
+
+		/*
+		 * PTS expects dummy data on fd when it
+		 * connects in source role.
+		 */
+		if (app_info[app_id][mdep_cfg_index][0] ==
+				BTHL_MDEP_ROLE_SOURCE)
+			if (write(fd, "0", sizeof("0")) < 0)
+				haltest_error("writing data on fd failed\n");
+
 		return;
 	}
 
 	if (state == BTHL_CONN_STATE_DISCONNECTED ||
 			state == BTHL_CONN_STATE_DESTROYED) {
-		if (fd_list[channel_id] >= 0) {
-			close(fd_list[channel_id]);
-			fd_list[channel_id] = -1;
+		if (app_info[app_id][mdep_cfg_index][2] >= 0) {
+			close(app_info[app_id][mdep_cfg_index][2]);
+			app_info[app_id][mdep_cfg_index][2] = -1;
 		}
 	}
 }
@@ -101,10 +115,12 @@ static bthl_callbacks_t hl_cbacks = {
 
 static void init_p(int argc, const char **argv)
 {
-	int i;
+	int i, j, k;
 
-	for (i = 0; i < FD_LIST_SIZE; i++)
-		fd_list[i] = -1;
+	for (i = 0; i < APP_ID_SIZE; i++)
+		for (j = 0; j < MDEP_CFG_SIZE; j++)
+			for (k = 0; k < ELEMENTS_SIZE; k++)
+				app_info[i][j][k] = -1;
 
 	RETURN_IF_NULL(if_hl);
 
@@ -188,6 +204,9 @@ static void register_application_p(int argc, const char **argv)
 
 	EXEC(if_hl->register_application, &reg, &app_id);
 
+	for (i = 0; i < reg.number_of_mdeps; i++)
+		app_info[app_id][i][0] = reg.mdep_cfg[i].mdep_role;
+
 	free(reg.mdep_cfg);
 }
 
-- 
1.9.1

