Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 2/7] android: Implement read_info_complete callback
Date: Thu, 17 Oct 2013 11:26:41 +0300
Message-Id: <1381998406-16662-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle read info complete callback from mgmt interface.
---
 Makefile.android   |    3 +-
 android/Android.mk |    1 +
 android/adapter.c  |  108 +++++++++++++++++++++++++++++++++++++++++++++++-----
 android/main.c     |   19 +++++----
 4 files changed, 111 insertions(+), 20 deletions(-)

diff --git a/Makefile.android b/Makefile.android
index 4d7da39..11eadc2 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -7,7 +7,8 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/sdpd-database.c src/sdpd-server.c \
 				src/sdpd-service.c src/sdpd-request.c \
 				src/shared/util.h src/shared/util.c \
-				src/shared/mgmt.h src/shared/mgmt.c
+				src/shared/mgmt.h src/shared/mgmt.c \
+				android/adapter.h android/adapter.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 endif
diff --git a/android/Android.mk b/android/Android.mk
index d6bd5b8..22f8b92 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -15,6 +15,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	main.c \
 	log.c \
+	adapter.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
 	../src/sdpd-database.c \
diff --git a/android/adapter.c b/android/adapter.c
index 9763530..b384c5d 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -21,24 +21,24 @@
  *
  */
 
+#include "lib/bluetooth.h"
 #include "src/shared/mgmt.h"
+#include "lib/mgmt.h"
 #include "log.h"
 #include "adapter.h"
 
 struct bt_adapter {
 	struct mgmt *mgmt;
-};
+	bdaddr_t bdaddr;
+	uint32_t dev_class;
 
-struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
-{
-	struct bt_adapter *adapter;
+	char *name;
 
-	adapter = g_new0(struct bt_adapter, 1);
-
-	adapter->mgmt = mgmt_ref(mgmt_if);
+	uint32_t supported_settings;
+	uint32_t current_settings;
+};
 
-	return adapter;
-}
+extern struct bt_adapter *default_adapter;
 
 void bt_adapter_start(struct bt_adapter *adapter)
 {
@@ -52,3 +52,93 @@ void bt_adapter_stop(struct bt_adapter *adapter)
 {
 	DBG("");
 }
+
+static void load_link_keys_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	DBG("status %u", status);
+}
+
+static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
+{
+	struct mgmt_cp_load_link_keys *cp;
+	size_t key_len = g_slist_length(keys);
+	struct mgmt_link_key_info *key;
+	size_t len;
+
+	DBG("");
+
+	len = sizeof(*cp) + key_len * sizeof(*key);
+	cp = g_malloc0(len);
+
+	cp->debug_keys = 0;
+	cp->key_count = htobs(key_len);
+
+	mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, 0, len,
+				cp, load_link_keys_complete, adapter, NULL);
+
+	free(cp);
+}
+
+static void read_info_complete(uint8_t status, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct bt_adapter *adapter = user_data;
+	const struct mgmt_rp_read_info *rp = param;
+
+	DBG("");
+
+	if (status) {
+		error("Failed to read info for index %u: %s (0x%02x)",
+			0, mgmt_errstr(status), status);
+		goto failed;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small read info complete response");
+		goto failed;
+	}
+
+	if (!bacmp(&rp->bdaddr, BDADDR_ANY)) {
+		error("No Bluetooth address");
+		goto failed;
+	}
+
+	/* Store adapter information */
+	bacpy(&adapter->bdaddr, &rp->bdaddr);
+	adapter->dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
+						(rp->dev_class[2] << 16);
+	adapter->name = g_strdup((const char *) rp->name);
+
+	adapter->supported_settings = btohs(rp->supported_settings);
+	adapter->current_settings = btohs(rp->current_settings);
+
+	/* TODO: Register all event notification handlers */
+
+	if (adapter->current_settings & MGMT_SETTING_POWERED)
+		bt_adapter_start(adapter);
+
+	load_link_keys(adapter, NULL);
+
+	return;
+
+failed:
+	default_adapter = NULL;
+}
+
+struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
+{
+	struct bt_adapter *adapter;
+
+	adapter = g_new0(struct bt_adapter, 1);
+
+	adapter->mgmt = mgmt_ref(mgmt_if);
+
+	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
+				read_info_complete, adapter, NULL) > 0) {
+		mgmt_unref(mgmt_if);
+		return NULL;
+	}
+
+	return adapter;
+}
diff --git a/android/main.c b/android/main.c
index 2b2e4d8..cc09ecd 100644
--- a/android/main.c
+++ b/android/main.c
@@ -49,6 +49,8 @@
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
 
+#include "adapter.h"
+
 #define SHUTDOWN_GRACE_SECONDS 10
 
 static GMainLoop *event_loop;
@@ -57,6 +59,8 @@ static struct mgmt *mgmt_if = NULL;
 static uint8_t mgmt_version = 0;
 static uint8_t mgmt_revision = 0;
 
+struct bt_adapter *default_adapter = NULL;
+
 static gboolean quit_eventloop(gpointer user_data)
 {
 	g_main_loop_quit(event_loop);
@@ -84,22 +88,17 @@ static GOptionEntry options[] = {
 	{ NULL }
 };
 
-static void read_info_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	/* TODO: Store Controller information */
-
-	/* TODO: Register all event notification handlers */
-}
-
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	DBG("index %u", index);
 
-	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, NULL, NULL) > 0)
+	if (default_adapter) {
+		DBG("skip event for index %u", index);
 		return;
+	}
+
+	default_adapter = bt_adapter_new(index, mgmt_if);
 
 	error("Failed to read adapter info for index %u", index);
 }
-- 
1.7.10.4

