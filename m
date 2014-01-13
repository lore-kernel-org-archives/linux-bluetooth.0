Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] android/ipc-tester: Skeleton for ipc negative tester
Date: Mon, 13 Jan 2014 11:36:56 +0100
Message-Id: <1389609422-21200-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389609422-21200-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add skeleton for ipc negative testing.

---
 .gitignore                    |   1 +
 android/Makefile.am           |  17 ++++
 android/ipc-negative-tester.c | 198 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 android/ipc-negative-tester.c

diff --git a/.gitignore b/.gitignore
index 077b1c9..89406f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -112,4 +112,5 @@ android/system-emulator
 android/bluetoothd
 android/haltest
 android/android-tester
+android/ipc-negative-tester
 android/bluetoothd-snoop
diff --git a/android/Makefile.am b/android/Makefile.am
index 356f932..c89c7e3 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -121,6 +121,23 @@ android_android_tester_LDFLAGS = -pthread -ldl
 
 plugin_LTLIBRARIES += android/audio.a2dp.default.la
 
+noinst_PROGRAMS += android/ipc-negative-tester
+
+android_ipc_negative_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c \
+				android/hal-utils.h android/hal-utils.c \
+				android/ipc-negative-tester.c
+
+android_ipc_negative_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+
+android_ipc_negative_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hal-audio.c \
 					android/hardware/audio.h \
diff --git a/android/ipc-negative-tester.c b/android/ipc-negative-tester.c
new file mode 100644
index 0000000..0c2edda
--- /dev/null
+++ b/android/ipc-negative-tester.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
+#include "src/shared/tester.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/hciemu.h"
+
+
+struct test_data {
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
+	struct hciemu *hciemu;
+	enum hciemu_type hciemu_type;
+};
+
+static void read_info_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct mgmt_rp_read_info *rp = param;
+	char addr[18];
+	uint16_t manufacturer;
+	uint32_t supported_settings, current_settings;
+
+	tester_print("Read Info callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	ba2str(&rp->bdaddr, addr);
+	manufacturer = btohs(rp->manufacturer);
+	supported_settings = btohl(rp->supported_settings);
+	current_settings = btohl(rp->current_settings);
+
+	tester_print("  Address: %s", addr);
+	tester_print("  Version: 0x%02x", rp->version);
+	tester_print("  Manufacturer: 0x%04x", manufacturer);
+	tester_print("  Supported settings: 0x%08x", supported_settings);
+	tester_print("  Current settings: 0x%08x", current_settings);
+	tester_print("  Class: 0x%02x%02x%02x",
+			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
+	tester_print("  Name: %s", rp->name);
+	tester_print("  Short name: %s", rp->short_name);
+
+	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_pre_setup_complete();
+}
+
+static void index_added_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Index Added callback");
+	tester_print("  Index: 0x%04x", index);
+
+	data->mgmt_index = index;
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
+					read_info_callback, NULL, NULL);
+}
+
+static void index_removed_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Index Removed callback");
+	tester_print("  Index: 0x%04x", index);
+
+	if (index != data->mgmt_index)
+		return;
+
+	mgmt_unregister_index(data->mgmt, data->mgmt_index);
+
+	mgmt_unref(data->mgmt);
+	data->mgmt = NULL;
+
+	tester_post_teardown_complete();
+}
+
+static void read_index_list_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Read Index List callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+					index_added_callback, NULL, NULL);
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+					index_removed_callback, NULL, NULL);
+
+	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu) {
+		tester_warn("Failed to setup HCI emulation");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_print("New hciemu instance created");
+}
+
+static void test_pre_setup(const void *data)
+{
+	struct test_data *test_data = tester_get_data();
+
+	if (!tester_use_debug())
+		fclose(stderr);
+
+	test_data->mgmt = mgmt_new_default();
+	if (!test_data->mgmt) {
+		tester_warn("Failed to setup management interface");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_send(test_data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
+				NULL, read_index_list_callback, NULL, NULL);
+}
+
+static void test_post_teardown(const void *data)
+{
+	struct test_data *test_data = tester_get_data();
+
+	hciemu_unref(test_data->hciemu);
+	test_data->hciemu = NULL;
+}
+
+static void setup(const void *data)
+{
+	tester_setup_failed();
+}
+
+static void teardown(const void *data)
+{
+	tester_teardown_complete();
+}
+
+static void ipc_send_tc(const void *data)
+{
+}
+
+#define test_bredrle(name, data, test_setup, test, test_teardown) \
+	do { \
+		struct test_data *user; \
+		user = g_malloc0(sizeof(struct test_data)); \
+		if (!user) \
+			break; \
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		tester_add_full(name, data, test_pre_setup, test_setup, \
+				test, test_teardown, test_post_teardown, \
+							3, user, g_free); \
+	} while (0)
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	test_bredrle("Test Dummy", NULL, setup, ipc_send_tc, teardown);
+
+	return tester_run();
+}
-- 
1.8.5

