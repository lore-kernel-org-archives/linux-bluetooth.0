Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 1/2] android/client/health: Write dummy data on fd
Date: Mon, 23 Jun 2014 15:46:57 +0300
Message-Id: <1403527618-8975-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS expects dummy data on fd when it connects in source role.
---
 android/client/if-hl.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 9c00a4d..92b18c5 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -53,8 +53,8 @@ SINTMAP(bthl_channel_state_t, -1, "(unknown)")
 ENDMAP
 
 const bthl_interface_t *if_hl = NULL;
-static int fd_list[256] = {-1};
-
+ /* app_id {role, channel_id, fd} */
+static int app_list[256][2][3] = { { {-1} } };
 static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 {
 	haltest_info("%s: app_id=%d app_reg_state=%s\n", __func__,
@@ -72,12 +72,23 @@ static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
 			app_id, bt_bdaddr_t2str(bd_addr, addr), mdep_cfg_index,
 			channel_id, bthl_channel_state_t2str(state), fd);
 
-	if (state == BTHL_CONN_STATE_CONNECTED)
-		fd_list[channel_id] = fd;
+	if (state == BTHL_CONN_STATE_CONNECTED) {
+		app_list[app_id][mdep_cfg_index][1] = channel_id;
+		app_list[app_id][mdep_cfg_index][2] = fd;
+
+		/*
+		 * PTS expects dummy data on fd when it
+		 * connects in source role.
+		 */
+		if (app_list[app_id][mdep_cfg_index][0] ==
+				BTHL_MDEP_ROLE_SOURCE)
+			if (write(fd, "0", sizeof("0")) < 0)
+				haltest_error("writing data on fd failed\n");
+	}
 
 	if (state == BTHL_CONN_STATE_DISCONNECTED ||
 			state == BTHL_CONN_STATE_DESTROYED)
-		close(fd_list[channel_id]);
+		close(app_list[app_id][mdep_cfg_index][2]);
 }
 
 static bthl_callbacks_t hl_cbacks = {
@@ -172,6 +183,9 @@ static void register_application_p(int argc, const char **argv)
 
 	EXEC(if_hl->register_application, &reg, &app_id);
 
+	for (i = 0; i < reg.number_of_mdeps; i++)
+		app_list[app_id][i][0] = reg.mdep_cfg[i].mdep_role;
+
 	free(reg.mdep_cfg);
 }
 
-- 
1.9.1

