Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 06/15] android: Add basic mgmt initialization sequence
Date: Tue,  8 Oct 2013 17:51:14 +0300
Message-Id: <1381243883-2745-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Initialize bluetooth controller via mgmt interface.
---
 Makefile.android   |    4 +-
 android/Android.mk |   11 +++
 android/main.c     |  189 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/Makefile.android b/Makefile.android
index e161e6d..9a2c486 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -1,7 +1,9 @@
 if ANDROID
 noinst_PROGRAMS += android/bluetoothd
 
-android_bluetoothd_SOURCES = android/main.c src/log.c
+android_bluetoothd_SOURCES = android/main.c src/log.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c
 android_bluetoothd_LDADD = @GLIB_LIBS@
 endif
 
diff --git a/android/Android.mk b/android/Android.mk
index 2cabff4..f5fd863 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -15,10 +15,15 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	main.c \
 	log.c \
+	../src/shared/mgmt.c \
+	../src/shared/util.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
 	$(call include-path-for, glib)/glib \
+
+LOCAL_C_INCLUDES += \
+	$(LOCAL_PATH)/../ \
 	$(LOCAL_PATH)/../src \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
@@ -26,6 +31,12 @@ LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 # to suppress the "warning: missing initializer near initialization.." warning
 LOCAL_CFLAGS += -Wno-missing-field-initializers
 
+# to suppress the "pointer of type 'void *' used in arithmetic" warning
+LOCAL_CFLAGS += -Wno-pointer-arith
+
+# Define missing flags for Android 4.2
+LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
+
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
 
diff --git a/android/main.c b/android/main.c
index f75b0a8..3580ac7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <stdbool.h>
 #include <signal.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -36,9 +37,17 @@
 
 #include "log.h"
 
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
+
 #define SHUTDOWN_GRACE_SECONDS 10
 
 static GMainLoop *event_loop;
+static struct mgmt *mgmt_if = NULL;
+
+static uint8_t mgmt_version = 0;
+static uint8_t mgmt_revision = 0;
 
 static gboolean quit_eventloop(gpointer user_data)
 {
@@ -67,6 +76,183 @@ static GOptionEntry options[] = {
 	{ NULL }
 };
 
+static void read_info_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	/* TODO: Store Controller information */
+
+	/**
+	 * Register all event notification handlers for controller.
+	 *
+	 * The handlers are registered after a succcesful read of the
+	 * controller info. From now on they can track updates and
+	 * notifications.
+	 */
+}
+
+
+static void mgmt_index_added_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	info("%s: index %u", __func__, index);
+
+	DBG("sending read info command for index %u", index);
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
+					read_info_complete, NULL, NULL) > 0)
+		return;
+
+	error("Failed to read adapter info for index %u", index);
+
+}
+
+static void mgmt_index_removed_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	info("%s: index %u", __func__, index);
+}
+
+static void read_index_list_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_index_list *rp = param;
+	uint16_t num;
+	int i;
+
+	info(__func__);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("%s: Failed to read index list: %s (0x%02x)",
+					__func__, mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("%s: Wrong size of read index list response", __func__);
+		return;
+	}
+
+	num = btohs(rp->num_controllers);
+
+	DBG("%s: Number of controllers: %d", __func__, num);
+
+	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
+		error("%s: Incorrect pkt size for index list rsp", __func__);
+		return;
+	}
+
+	for (i = 0; i < num; i++) {
+		uint16_t index;
+
+		index = btohs(rp->index[i]);
+
+		DBG("%s: Found index %u", __func__, index);
+
+		/**
+		 * Use index added event notification.
+		 */
+		mgmt_index_added_event(index, 0, NULL, NULL);
+	}
+}
+
+
+static void read_commands_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_commands *rp = param;
+	uint16_t num_commands, num_events;
+
+	info(__func__);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to read supported commands: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of read commands response");
+		return;
+	}
+
+	num_commands = btohs(rp->num_commands);
+	num_events = btohs(rp->num_events);
+
+	DBG("Number of commands: %d", num_commands);
+	DBG("Number of events: %d", num_events);
+}
+
+static void read_version_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_version *rp = param;
+
+	info(__func__);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to read version information: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size response");
+		return;
+	}
+
+	mgmt_version = rp->version;
+	mgmt_revision = btohs(rp->revision);
+
+	info("Bluetooth management interface %u.%u initialized",
+						mgmt_version, mgmt_revision);
+
+	if (mgmt_version < 1) {
+		error("Version 1.0 or later of management interface required");
+		abort();
+	}
+
+	DBG("sending read supported commands command");
+
+	mgmt_send(mgmt_if, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0, NULL,
+					read_commands_complete, NULL, NULL);
+
+	mgmt_register(mgmt_if, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+					mgmt_index_added_event, NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+					mgmt_index_removed_event, NULL, NULL);
+
+	DBG("sending read index list command");
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
+			NULL, read_index_list_complete, NULL, NULL) > 0)
+		return;
+
+	error("Failed to read controller index list");
+}
+
+static bool init_mgmt_interface(void)
+{
+	mgmt_if = mgmt_new_default();
+	if (mgmt_if == NULL) {
+		error("Failed to access management interface");
+		return false;
+	}
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
+				read_version_complete, NULL, NULL) == 0) {
+		error("Error sending READ_VERSION mgmt command");
+		return false;
+	}
+
+	return true;
+}
+
+static void cleanup_mgmt_interface(void)
+{
+	mgmt_unref(mgmt_if);
+	mgmt_if = NULL;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -100,10 +286,13 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGTERM, &sa, NULL);
 
+	init_mgmt_interface();
+
 	DBG("Entering main loop");
 
 	g_main_loop_run(event_loop);
 
+	cleanup_mgmt_interface();
 	g_main_loop_unref(event_loop);
 
 	info("Exit");
-- 
1.7.10.4

