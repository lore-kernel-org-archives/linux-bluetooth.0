Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/3] android/client/health: Change multi dimension array to struct mode
Date: Wed,  2 Jul 2014 12:32:01 +0300
Message-Id: <1404293522-7220-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404293522-7220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be hard to add extra parameters in multi dimension array.
---
 android/client/if-hl.c | 83 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 7b75575..17ba16c 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -52,13 +52,24 @@ SINTMAP(bthl_channel_state_t, -1, "(unknown)")
 	DELEMENT(BTHL_CONN_STATE_DESTROYED),
 ENDMAP
 
-#define APP_ID_SIZE 256
+#define APP_ID_SIZE 20
 #define MDEP_CFG_SIZE 10
-#define ELEMENTS_SIZE 3
+#define CHANNEL_ID_SIZE 50
+
+struct channel_info {
+	int fd;
+};
+
+struct mdep_cfg {
+	uint8_t role;
+	struct channel_info channel[CHANNEL_ID_SIZE];
+};
+
+struct {
+	struct mdep_cfg mdep[MDEP_CFG_SIZE];
+} app[APP_ID_SIZE];
 
 const bthl_interface_t *if_hl = NULL;
-/* app_id {mdep_cfg_index{role, channel_id, fd}} */
-static int app_info[APP_ID_SIZE][MDEP_CFG_SIZE][ELEMENTS_SIZE];
 
 static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 {
@@ -67,29 +78,30 @@ static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 }
 
 static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
-				int mdep_cfg_index, int channel_id,
-				bthl_channel_state_t state, int fd)
+					int index, int channel_id,
+					bthl_channel_state_t state, int fd)
 {
 	char addr[MAX_ADDR_STR_LEN];
 
 	haltest_info("%s: app_id=%d bd_addr=%s mdep_cfg_index=%d\n"
 			"channel_id=%d channel_state=%s fd=%d\n", __func__,
-			app_id, bt_bdaddr_t2str(bd_addr, addr), mdep_cfg_index,
+			app_id, bt_bdaddr_t2str(bd_addr, addr), index,
 			channel_id, bthl_channel_state_t2str(state), fd);
 
-	if (app_id >= APP_ID_SIZE || mdep_cfg_index >= MDEP_CFG_SIZE)
+	if (app_id >= APP_ID_SIZE || index >= MDEP_CFG_SIZE
+			|| channel_id >= CHANNEL_ID_SIZE) {
+		haltest_error("exceeds maximum limit");
 		return;
+	}
 
 	if (state == BTHL_CONN_STATE_CONNECTED) {
-		app_info[app_id][mdep_cfg_index][1] = channel_id;
-		app_info[app_id][mdep_cfg_index][2] = fd;
+		app[app_id].mdep[index].channel[channel_id].fd = fd;
 
 		/*
 		 * PTS expects dummy data on fd when it
 		 * connects in source role.
 		 */
-		if (app_info[app_id][mdep_cfg_index][0] ==
-				BTHL_MDEP_ROLE_SOURCE)
+		if (app[app_id].mdep[index].role == BTHL_MDEP_ROLE_SOURCE)
 			if (write(fd, "0", sizeof("0")) < 0)
 				haltest_error("writing data on fd failed\n");
 
@@ -98,9 +110,9 @@ static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
 
 	if (state == BTHL_CONN_STATE_DISCONNECTED ||
 			state == BTHL_CONN_STATE_DESTROYED) {
-		if (app_info[app_id][mdep_cfg_index][2] >= 0) {
-			close(app_info[app_id][mdep_cfg_index][2]);
-			app_info[app_id][mdep_cfg_index][2] = -1;
+		if (app[app_id].mdep[index].channel[channel_id].fd >= 0) {
+			close(app[app_id].mdep[index].channel[channel_id].fd);
+			app[app_id].mdep[index].channel[channel_id].fd = -1;
 		}
 	}
 }
@@ -117,10 +129,14 @@ static void init_p(int argc, const char **argv)
 {
 	int i, j, k;
 
-	for (i = 0; i < APP_ID_SIZE; i++)
-		for (j = 0; j < MDEP_CFG_SIZE; j++)
-			for (k = 0; k < ELEMENTS_SIZE; k++)
-				app_info[i][j][k] = -1;
+	for (i = 0; i < APP_ID_SIZE; i++) {
+		for (j = 0; j < MDEP_CFG_SIZE; j++) {
+			app[i].mdep[j].role = 0;
+			for (k = 0; k < CHANNEL_ID_SIZE; k++)
+				app[i].mdep[j].channel[k].fd = -1;
+		}
+	}
+
 
 	RETURN_IF_NULL(if_hl);
 
@@ -205,7 +221,7 @@ static void register_application_p(int argc, const char **argv)
 	EXEC(if_hl->register_application, &reg, &app_id);
 
 	for (i = 0; i < reg.number_of_mdeps; i++)
-		app_info[app_id][i][0] = reg.mdep_cfg[i].mdep_role;
+		app[app_id].mdep[i].role = reg.mdep_cfg[i].mdep_role;
 
 	free(reg.mdep_cfg);
 }
@@ -280,7 +296,8 @@ static void destroy_channel_p(int argc, const char **argv)
 static void close_channel_p(int argc, const char **argv)
 {
 	uint32_t app_id;
-	uint8_t mdep_cfg_index;
+	uint8_t index;
+	int channel_id;
 
 	RETURN_IF_NULL(if_hl);
 
@@ -294,21 +311,29 @@ static void close_channel_p(int argc, const char **argv)
 		return;
 	}
 
+	if (argc <= 4) {
+		haltest_error("No channel_id is specified");
+		return;
+	}
+
 	app_id = (uint32_t) atoi(argv[2]);
 	if (app_id >= APP_ID_SIZE) {
-		haltest_error("Wrong app_id specidied: %u\n", app_id);
+		haltest_error("Wrong app_id specified: %u\n", app_id);
 		return;
 	}
 
-	mdep_cfg_index = (uint8_t) atoi(argv[3]);
-	if (mdep_cfg_index >= MDEP_CFG_SIZE) {
-		haltest_error("Wrong mdep cgf index: %u\n", mdep_cfg_index);
+	index = (uint8_t) atoi(argv[3]);
+	if (index >= MDEP_CFG_SIZE) {
+		haltest_error("Wrong mdep cfg index: %u\n", index);
 		return;
 	}
 
-	if (app_info[app_id][mdep_cfg_index][2] >= 0) {
-		shutdown(app_info[app_id][mdep_cfg_index][2], SHUT_RDWR);
-		app_info[app_id][mdep_cfg_index][2] = -1;
+	channel_id = atoi(argv[4]);
+
+	if (app[app_id].mdep[index].channel[channel_id].fd >= 0) {
+		shutdown(app[app_id].mdep[index].channel[channel_id].fd,
+								SHUT_RDWR);
+		app[app_id].mdep[index].channel[channel_id].fd = -1;
 	}
 }
 
@@ -332,7 +357,7 @@ static struct method methods[] = {
 	STD_METHODH(unregister_application, "<app_id>"),
 	STD_METHODH(connect_channel, "<app_id> <bd_addr> <mdep_cfg_index>"),
 	STD_METHODH(destroy_channel, "<channel_id>"),
-	STD_METHODH(close_channel, "<app_id> <mdep_cfg_index>"),
+	STD_METHODH(close_channel, "<app_id> <mdep_cfg_index> <channel_id>"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.9.1

