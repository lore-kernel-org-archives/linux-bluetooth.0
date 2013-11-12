Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/7] android: Move adapter initialization to adapter.c
Date: Tue, 12 Nov 2013 00:24:12 +0000
Message-Id: <1384215857-19679-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
References: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to handle that in main.c. Also this removes mgmt
interface dependency from adapter API as all mgmt commands are handled
from adapter code.

Startup and shutdown timeouts handling is left in main.c.
---
 android/adapter.c | 196 +++++++++++++++++++++++++++++++++--
 android/adapter.h |   7 +-
 android/main.c    | 300 +++++++++---------------------------------------------
 3 files changed, 244 insertions(+), 259 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index e161f9d..0c090bf 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -58,6 +58,7 @@ static int notification_sk = -1;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
+static uint16_t option_index = MGMT_INDEX_NONE;
 static uint16_t adapter_index = MGMT_INDEX_NONE;
 static struct mgmt *mgmt_if = NULL;
 static bt_adapter_ready adapter_ready = NULL;
@@ -1140,20 +1141,201 @@ failed:
 	adapter_ready(err);
 }
 
-void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
+static void mgmt_index_added_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
 {
-	mgmt_if = mgmt_ref(mgmt);
-	adapter_index = index;
-	adapter_ready = cb;
+	DBG("index %u", index);
 
-	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, NULL, NULL) > 0)
+	if (adapter_index != MGMT_INDEX_NONE) {
+		DBG("skip event for index %u", index);
 		return;
+	}
 
-	mgmt_unref(mgmt_if);
+	if (option_index != MGMT_INDEX_NONE && option_index != index) {
+		DBG("skip event for index %u (option %u)", index, option_index);
+		return;
+	}
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
+				read_info_complete, NULL, NULL) == 0) {
+		adapter_ready(-EIO);
+		return;
+	}
+}
+
+static void mgmt_index_removed_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBG("index %u", index);
+
+	if (index != adapter_index)
+		return;
+
+	error("Adapter was removed. Exiting.");
+	raise(SIGTERM);
+}
+
+static void read_index_list_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_index_list *rp = param;
+	uint16_t num;
+	int i;
+
+	DBG("");
+
+	if (status) {
+		error("%s: Failed to read index list: %s (0x%02x)",
+					__func__, mgmt_errstr(status), status);
+		goto failed;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("%s: Wrong size of read index list response", __func__);
+		goto failed;
+	}
+
+	num = btohs(rp->num_controllers);
+
+	DBG("Number of controllers: %u", num);
+
+	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
+		error("%s: Incorrect pkt size for index list rsp", __func__);
+		goto failed;
+	}
+
+	if (adapter_index != MGMT_INDEX_NONE)
+		return;
+
+	for (i = 0; i < num; i++) {
+		uint16_t index = btohs(rp->index[i]);
+
+		if (option_index != MGMT_INDEX_NONE && option_index != index)
+			continue;
+
+		if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
+					read_info_complete, NULL, NULL) == 0)
+			goto failed;
+
+		adapter_index = index;
+		return;
+	}
+
+	return;
+
+failed:
 	adapter_ready(-EIO);
 }
 
+static void read_version_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_version *rp = param;
+	uint8_t mgmt_version, mgmt_revision;
+
+	DBG("");
+
+	if (status) {
+		error("Failed to read version information: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		goto failed;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size response");
+		goto failed;
+	}
+
+	mgmt_version = rp->version;
+	mgmt_revision = btohs(rp->revision);
+
+	info("Bluetooth management interface %u.%u initialized",
+						mgmt_version, mgmt_revision);
+
+	if (MGMT_VERSION(mgmt_version, mgmt_revision) < MGMT_VERSION(1, 3)) {
+		error("Version 1.3 or later of management interface required");
+		goto failed;
+	}
+
+	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+					mgmt_index_added_event, NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+					mgmt_index_removed_event, NULL, NULL);
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
+			NULL, read_index_list_complete, NULL, NULL) > 0)
+		return;
+
+	error("Failed to read controller index list");
+
+failed:
+	adapter_ready(-EIO);
+}
+
+bool bt_adapter_start(int index, bt_adapter_ready cb)
+{
+	DBG("index %d", index);
+
+	mgmt_if = mgmt_new_default();
+	if (!mgmt_if) {
+		error("Failed to access management interface");
+		return false;
+	}
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
+				read_version_complete, NULL, NULL) == 0) {
+		error("Error sending READ_VERSION mgmt command");
+
+		mgmt_unref(mgmt_if);
+		mgmt_if = NULL;
+
+		return false;
+	}
+
+	if (index >= 0)
+		option_index = index;
+
+	adapter_ready = cb;
+
+	return true;
+}
+
+static void shutdown_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	bt_adapter_stopped cb = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS)
+		error("Clean controller shutdown failed");
+
+	cb();
+}
+
+bool bt_adapter_stop(bt_adapter_stopped cb)
+{
+	struct mgmt_mode cp;
+
+	if (adapter_index == MGMT_INDEX_NONE)
+		return false;
+
+	info("Switching controller off");
+
+	memset(&cp, 0, sizeof(cp));
+
+	return mgmt_send(mgmt_if, MGMT_OP_SET_POWERED, adapter_index,
+				sizeof(cp), &cp, shutdown_complete, (void *)cb,
+				NULL) > 0;
+}
+
+void bt_adapter_cleanup(void)
+{
+	g_free(adapter_name);
+	adapter_name = NULL;
+
+	mgmt_unref(mgmt_if);
+	mgmt_if = NULL;
+}
+
 static bool set_discoverable(uint8_t mode, uint16_t timeout)
 {
 	struct mgmt_cp_set_discoverable cp;
diff --git a/android/adapter.h b/android/adapter.h
index c62b859..c9f0083 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -22,9 +22,12 @@
  */
 
 typedef void (*bt_adapter_ready)(int err);
+bool bt_adapter_start(int index, bt_adapter_ready cb);
 
-void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
-							bt_adapter_ready cb);
+typedef void (*bt_adapter_stopped)(void);
+bool bt_adapter_stop(bt_adapter_stopped cb);
+
+void bt_adapter_cleanup(void);
 
 void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
diff --git a/android/main.c b/android/main.c
index 36cc8aa..f82e6d8 100644
--- a/android/main.c
+++ b/android/main.c
@@ -45,8 +45,6 @@
 #include "src/sdpd.h"
 
 #include "lib/bluetooth.h"
-#include "lib/mgmt.h"
-#include "src/shared/mgmt.h"
 
 #include "adapter.h"
 #include "socket.h"
@@ -65,11 +63,9 @@
 #define STARTUP_GRACE_SECONDS 5
 #define SHUTDOWN_GRACE_SECONDS 10
 
-static GMainLoop *event_loop;
-static struct mgmt *mgmt_if = NULL;
+static guint bluetooth_start_timeout = 0;
 
-static uint16_t adapter_index = MGMT_INDEX_NONE;
-static guint adapter_timeout = 0;
+static GMainLoop *event_loop;
 
 static GIOChannel *hal_cmd_io = NULL;
 static GIOChannel *hal_notif_io = NULL;
@@ -186,35 +182,32 @@ static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
 	}
 }
 
-static void shutdown_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
+static void bluetooth_stopped(void)
 {
-	if (status != MGMT_STATUS_SUCCESS)
-		error("Clean controller shutdown failed");
+	g_main_loop_quit(event_loop);
+}
 
+static gboolean quit_eventloop(gpointer user_data)
+{
 	g_main_loop_quit(event_loop);
+	return FALSE;
 }
 
-static void shutdown_controller(void)
+static void stop_bluetooth(void)
 {
-	static bool __shutdown = false;
-	struct mgmt_mode cp;
+	static bool __stop = false;
 
-	if (__shutdown)
+	if (__stop)
 		return;
 
-	__shutdown = true;
-
-	info("Switching controller off");
+	__stop = true;
 
-	memset(&cp, 0, sizeof(cp));
-	cp.val = 0x00;
-
-	if (mgmt_send(mgmt_if, MGMT_OP_SET_POWERED, adapter_index,
-			sizeof(cp), &cp, shutdown_complete, NULL, NULL) > 0)
+	if (!bt_adapter_stop(bluetooth_stopped)) {
+		g_main_loop_quit(event_loop);
 		return;
+	}
 
-	g_main_loop_quit(event_loop);
+	g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS, quit_eventloop, NULL);
 }
 
 static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
@@ -279,7 +272,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 
 fail:
-	shutdown_controller();
+	stop_bluetooth();
 	return FALSE;
 }
 
@@ -287,7 +280,7 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	info("HAL notification socket closed, terminating");
-	shutdown_controller();
+	stop_bluetooth();
 
 	return FALSE;
 }
@@ -336,7 +329,7 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_main_loop_quit(event_loop);
+		stop_bluetooth();
 		return FALSE;
 	}
 
@@ -359,23 +352,38 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_main_loop_quit(event_loop);
+		stop_bluetooth();
 		return FALSE;
 	}
 
 	hal_notif_io = connect_hal(notif_connect_cb);
 	if (!hal_notif_io) {
 		error("Cannot connect to HAL, terminating");
-		g_main_loop_quit(event_loop);
+		stop_bluetooth();
 	}
 
 	return FALSE;
 }
 
-static gboolean quit_eventloop(gpointer user_data)
+static void adapter_ready(int err)
 {
-	g_main_loop_quit(event_loop);
-	return FALSE;
+	if (err < 0) {
+		error("Adapter initialization failed: %s", strerror(-err));
+		exit(EXIT_FAILURE);
+	}
+
+	if (bluetooth_start_timeout > 0) {
+		g_source_remove(bluetooth_start_timeout);
+		bluetooth_start_timeout = 0;
+	}
+
+	info("Adapter initialized");
+
+	hal_cmd_io = connect_hal(cmd_connect_cb);
+	if (!hal_cmd_io) {
+		error("Cannot connect to HAL, terminating");
+		stop_bluetooth();
+	}
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
@@ -400,12 +408,7 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 	case SIGTERM:
 		if (!__terminated) {
 			info("Terminating");
-			if (adapter_index != MGMT_INDEX_NONE) {
-				g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
-							quit_eventloop, NULL);
-				shutdown_controller();
-			} else
-				g_main_loop_quit(event_loop);
+			stop_bluetooth();
 		}
 
 		__terminated = true;
@@ -453,7 +456,7 @@ static guint setup_signalfd(void)
 }
 
 static gboolean option_version = FALSE;
-static gint option_index = MGMT_INDEX_NONE;
+static gint option_index = -1;
 
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
@@ -463,216 +466,6 @@ static GOptionEntry options[] = {
 	{ NULL }
 };
 
-static void adapter_ready(int err)
-{
-	if (err < 0) {
-		error("Adapter initialization failed: %s", strerror(-err));
-		exit(EXIT_FAILURE);
-	}
-
-	info("Adapter initialized");
-
-	hal_cmd_io = connect_hal(cmd_connect_cb);
-	if (!hal_cmd_io) {
-		error("Cannot connect to HAL, terminating");
-		g_main_loop_quit(event_loop);
-	}
-}
-
-static void mgmt_index_added_event(uint16_t index, uint16_t length,
-					const void *param, void *user_data)
-{
-	uint16_t opt_index = option_index;
-
-	DBG("index %u", index);
-
-	if (adapter_index != MGMT_INDEX_NONE) {
-		DBG("skip event for index %u", index);
-		return;
-	}
-
-	if (opt_index != MGMT_INDEX_NONE && opt_index != index) {
-		DBG("skip event for index %u (option %u)", index, opt_index);
-		return;
-	}
-
-	if (adapter_timeout > 0) {
-		g_source_remove(adapter_timeout);
-		adapter_timeout = 0;
-	}
-
-	adapter_index = index;
-	bt_adapter_init(index, mgmt_if, adapter_ready);
-}
-
-static void mgmt_index_removed_event(uint16_t index, uint16_t length,
-					const void *param, void *user_data)
-{
-	DBG("index %u", index);
-
-	if (index != adapter_index)
-		return;
-
-	error("Adapter was removed. Exiting.");
-	g_main_loop_quit(event_loop);
-}
-
-static gboolean adapter_timeout_handler(gpointer user_data)
-{
-	adapter_timeout = 0;
-	g_main_loop_quit(event_loop);
-
-	return FALSE;
-}
-
-static void read_index_list_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	const struct mgmt_rp_read_index_list *rp = param;
-	uint16_t opt_index = option_index;
-	uint16_t num;
-	int i;
-
-	DBG("");
-
-	if (status) {
-		error("%s: Failed to read index list: %s (0x%02x)",
-					__func__, mgmt_errstr(status), status);
-		goto failed;
-	}
-
-	if (length < sizeof(*rp)) {
-		error("%s: Wrong size of read index list response", __func__);
-		goto failed;
-	}
-
-	num = btohs(rp->num_controllers);
-
-	DBG("Number of controllers: %u", num);
-
-	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
-		error("%s: Incorrect pkt size for index list rsp", __func__);
-		goto failed;
-	}
-
-	if (adapter_index != MGMT_INDEX_NONE)
-		return;
-
-	for (i = 0; i < num; i++) {
-		uint16_t index = btohs(rp->index[i]);
-
-		if (opt_index != MGMT_INDEX_NONE && opt_index != index)
-			continue;
-
-		adapter_index = index;
-		bt_adapter_init(adapter_index, mgmt_if, adapter_ready);
-		return;
-	}
-
-	if (adapter_index != MGMT_INDEX_NONE)
-		return;
-
-	adapter_timeout = g_timeout_add_seconds(STARTUP_GRACE_SECONDS,
-					adapter_timeout_handler, NULL);
-	if (adapter_timeout > 0)
-		return;
-
-	error("%s: Failed init timeout", __func__);
-
-failed:
-	g_main_loop_quit(event_loop);
-}
-
-static void read_commands_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	const struct mgmt_rp_read_commands *rp = param;
-
-	DBG("");
-
-	if (status) {
-		error("Failed to read supported commands: %s (0x%02x)",
-						mgmt_errstr(status), status);
-		return;
-	}
-
-	if (length < sizeof(*rp)) {
-		error("Wrong size response");
-		return;
-	}
-}
-
-static void read_version_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	const struct mgmt_rp_read_version *rp = param;
-	uint8_t mgmt_version, mgmt_revision;
-
-	DBG("");
-
-	if (status) {
-		error("Failed to read version information: %s (0x%02x)",
-						mgmt_errstr(status), status);
-		goto failed;
-	}
-
-	if (length < sizeof(*rp)) {
-		error("Wrong size response");
-		goto failed;
-	}
-
-	mgmt_version = rp->version;
-	mgmt_revision = btohs(rp->revision);
-
-	info("Bluetooth management interface %u.%u initialized",
-						mgmt_version, mgmt_revision);
-
-	if (MGMT_VERSION(mgmt_version, mgmt_revision) < MGMT_VERSION(1, 3)) {
-		error("Version 1.3 or later of management interface required");
-		goto failed;
-	}
-
-	mgmt_send(mgmt_if, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0, NULL,
-					read_commands_complete, NULL, NULL);
-
-	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
-					mgmt_index_added_event, NULL, NULL);
-	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
-					mgmt_index_removed_event, NULL, NULL);
-
-	if (mgmt_send(mgmt_if, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
-			NULL, read_index_list_complete, NULL, NULL) > 0)
-		return;
-
-	error("Failed to read controller index list");
-
-failed:
-	g_main_loop_quit(event_loop);
-}
-
-static bool init_mgmt_interface(void)
-{
-	mgmt_if = mgmt_new_default();
-	if (!mgmt_if) {
-		error("Failed to access management interface");
-		return false;
-	}
-
-	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
-				read_version_complete, NULL, NULL) == 0) {
-		error("Error sending READ_VERSION mgmt command");
-		return false;
-	}
-
-	return true;
-}
-
-static void cleanup_mgmt_interface(void)
-{
-	mgmt_unref(mgmt_if);
-	mgmt_if = NULL;
-}
-
 static void cleanup_hal_connection(void)
 {
 	if (hal_cmd_io) {
@@ -757,7 +550,14 @@ int main(int argc, char *argv[])
 	if (!set_capabilities())
 		return EXIT_FAILURE;
 
-	if (!init_mgmt_interface())
+	bluetooth_start_timeout = g_timeout_add_seconds(STARTUP_GRACE_SECONDS,
+							quit_eventloop, NULL);
+	if (bluetooth_start_timeout == 0) {
+		error("Failed to init startup timeout");
+		return EXIT_FAILURE;
+	}
+
+	if (!bt_adapter_start(option_index, adapter_ready))
 		return EXIT_FAILURE;
 
 	/* Use params: mtu = 0, flags = 0 */
@@ -771,7 +571,7 @@ int main(int argc, char *argv[])
 
 	cleanup_hal_connection();
 	stop_sdp_server();
-	cleanup_mgmt_interface();
+	bt_adapter_cleanup();
 	g_main_loop_unref(event_loop);
 
 	info("Exit");
-- 
1.8.4.2

