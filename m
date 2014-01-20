Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 01/11] android/ipc-tester: Skeleton for ipc negative tester
Date: Mon, 20 Jan 2014 10:36:00 +0100
Message-Id: <1390210570-28260-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1390210570-28260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add skeleton for ipc negative testing.
---
 .gitignore           |   1 +
 android/Makefile.am  |  17 +++++
 android/ipc-tester.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 android/ipc-tester.c

diff --git a/.gitignore b/.gitignore
index 2c8e033..67e9850 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,4 +114,5 @@ android/system-emulator
 android/bluetoothd
 android/haltest
 android/android-tester
+android/ipc-tester
 android/bluetoothd-snoop
diff --git a/android/Makefile.am b/android/Makefile.am
index f24b754..e027cff 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -120,6 +120,23 @@ android_android_tester_LDFLAGS = -pthread -ldl
 
 plugin_LTLIBRARIES += android/audio.a2dp.default.la
 
+noinst_PROGRAMS += android/ipc-tester
+
+android_ipc_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c \
+				android/hal-utils.h android/hal-utils.c \
+				android/ipc-tester.c
+
+android_ipc_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+
+android_ipc_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hal-msg.h \
 					android/hal-audio.c \
diff --git a/android/ipc-tester.c b/android/ipc-tester.c
new file mode 100644
index 0000000..021919e
--- /dev/null
+++ b/android/ipc-tester.c
@@ -0,0 +1,207 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
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
+	if (test_data->hciemu) {
+		hciemu_unref(test_data->hciemu);
+		test_data->hciemu = NULL;
+	}
+}
+
+static void setup(const void *data)
+{
+	tester_setup_failed();
+	test_post_teardown(data);
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
+#define test_generic(name, data, test_setup, test, test_teardown) \
+	do {								\
+		struct test_data *user;					\
+		user = g_malloc0(sizeof(struct test_data));		\
+		if (!user)						\
+			break;						\
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE;		\
+		tester_add_full(name, data, test_pre_setup, test_setup,	\
+				test, test_teardown, test_post_teardown,\
+				3, user, g_free);			\
+	} while (0)
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	test_generic("Test Dummy", NULL, setup, ipc_send_tc, teardown);
+
+	return tester_run();
+}
-- 
1.8.5.2

