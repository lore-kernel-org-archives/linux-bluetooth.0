Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/7] android/tester: Add pre-setup and post-teardown routines
Date: Tue, 10 Dec 2013 11:45:39 +0100
Message-Id: <1386672344-13438-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386672344-13438-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386672344-13438-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will add hciemu initialization and cleanup. These functions
will be called to create hci emulator and cleanup it.
---
 android/Makefile.am      |  10 ++-
 android/android-tester.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 0768985..5364c2e 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -85,7 +85,15 @@ android_haltest_LDFLAGS = -pthread
 
 noinst_PROGRAMS += android/android-tester
 
-android_android_tester_SOURCES = android/android-tester.c
+android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c \
+				android/android-tester.c
+
+android_android_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 endif
 
diff --git a/android/android-tester.c b/android/android-tester.c
index f5c42b0..48e408d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -15,7 +15,176 @@
  *
  */
 
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
+struct test_data {
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
+	struct hciemu *hciemu;
+	enum hciemu_type hciemu_type;
+	void *test_data;
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
+static void test_pre_setup(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (!tester_use_debug())
+		fclose(stderr);
+
+	data->mgmt = mgmt_new_default();
+	if (!data->mgmt) {
+		tester_warn("Failed to setup management interface");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
+				NULL, read_index_list_callback, NULL, NULL);
+}
+
+static void test_post_teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hciemu_unref(data->hciemu);
+	data->hciemu = NULL;
+}
+
+static void pass_test(const void *test_data)
+{
+	tester_test_passed();
+}
+
+#define test_bredrle(name, data, test_setup, test, test_teardown) \
+	do { \
+		struct test_data *user; \
+		user = g_malloc0(sizeof(struct test_data)); \
+		if (!user) \
+			break; \
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->test_data = data; \
+		tester_add_full(name, data, test_pre_setup, test_setup, \
+				test, test_teardown, test_post_teardown, \
+							3, user, g_free); \
+	} while (0)
+
 int main(int argc, char *argv[])
 {
-	return 0;
+	tester_init(&argc, &argv);
+
+	test_bredrle("test", NULL, NULL, pass_test, NULL);
+
+	return tester_run();
 }
-- 
1.8.3.1

