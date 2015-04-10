Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/9] unit/test-eir: Use tester framework
Date: Fri, 10 Apr 2015 17:05:56 +0300
Message-Id: <1428674761-24609-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am     |  3 ++-
 unit/test-eir.c | 78 +++++++++++++++++++++++++++++++--------------------------
 2 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f9f26aa..b0292e7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -267,7 +267,8 @@ AM_CPPFLAGS = -I$(builddir)/lib
 unit_tests += unit/test-eir
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
-unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+unit_test_eir_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
+								@GLIB_LIBS@
 
 unit_tests += unit/test-uuid
 
diff --git a/unit/test-eir.c b/unit/test-eir.c
index 043634b..d5216f6 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -33,6 +33,8 @@
 #include "lib/hci.h"
 #include "lib/sdp.h"
 
+#include <src/shared/tester.h>
+
 #include "src/eir.h"
 
 struct test_data {
@@ -527,41 +529,41 @@ static const struct test_data citizen_scan_test = {
 	.uuid = citizen_scan_uuid,
 };
 
-static void test_basic(void)
+static void test_basic(const void *data)
 {
-	struct eir_data data;
+	struct eir_data eir;
 	unsigned char buf[HCI_MAX_EIR_LENGTH];
 
 	memset(buf, 0, sizeof(buf));
-	memset(&data, 0, sizeof(data));
+	memset(&eir, 0, sizeof(eir));
 
-	eir_parse(&data, buf, HCI_MAX_EIR_LENGTH);
-	g_assert(data.services == NULL);
-	g_assert(data.name == NULL);
+	eir_parse(&eir, buf, HCI_MAX_EIR_LENGTH);
+	g_assert(eir.services == NULL);
+	g_assert(eir.name == NULL);
+
+	eir_data_free(&eir);
 
-	eir_data_free(&data);
+	tester_test_passed();
 }
 
 static void test_parsing(gconstpointer data)
 {
 	const struct test_data *test = data;
 	struct eir_data eir;
+	GSList *list;
 
 	memset(&eir, 0, sizeof(eir));
 
 	eir_parse(&eir, test->eir_data, test->eir_size);
 
-	if (g_test_verbose() == TRUE) {
-		GSList *list;
+	tester_debug("Flags: %d", eir.flags);
+	tester_debug("Name: %s", eir.name);
+	tester_debug("TX power: %d", eir.tx_power);
 
-		g_print("Flags: %d\n", eir.flags);
-		g_print("Name: %s\n", eir.name);
-		g_print("TX power: %d\n", eir.tx_power);
+	for (list = eir.services; list; list = list->next) {
+		char *uuid_str = list->data;
 
-		for (list = eir.services; list; list = list->next) {
-			char *uuid_str = list->data;
-			g_print("UUID: %s\n", uuid_str);
-		}
+		tester_debug("UUID: %s", uuid_str);
 	}
 
 	g_assert(eir.flags == test->flags);
@@ -589,27 +591,33 @@ static void test_parsing(gconstpointer data)
 	}
 
 	eir_data_free(&eir);
+
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
-
-	g_test_add_func("/eir/basic", test_basic);
-
-	g_test_add_data_func("/eir/macbookair", &macbookair_test, test_parsing);
-	g_test_add_data_func("/eir/iphone5", &iphone5_test, test_parsing);
-	g_test_add_data_func("/eir/ipadmini", &ipadmini_test, test_parsing);
-	g_test_add_data_func("/eir/sl400h", &gigaset_sl400h_test, test_parsing);
-	g_test_add_data_func("/eir/sl910", &gigaset_sl910_test, test_parsing);
-	g_test_add_data_func("/eir/bh907", &nokia_bh907_test, test_parsing);
-	g_test_add_data_func("/eir/fuelband", &fuelband_test, test_parsing);
-	g_test_add_data_func("/ad/bluesc", &bluesc_test, test_parsing);
-	g_test_add_data_func("/ad/wahooscale", &wahoo_scale_test, test_parsing);
-	g_test_add_data_func("/ad/mioalpha", &mio_alpha_test, test_parsing);
-	g_test_add_data_func("/ad/cookoo", &cookoo_test, test_parsing);
-	g_test_add_data_func("/ad/citizen1", &citizen_adv_test, test_parsing);
-	g_test_add_data_func("/ad/citizen2", &citizen_scan_test, test_parsing);
-
-	return g_test_run();
+	tester_init(&argc, &argv);
+
+	tester_add("/eir/basic", NULL, NULL, test_basic, NULL);
+
+	tester_add("/eir/macbookair", &macbookair_test, NULL, test_parsing,
+									NULL);
+	tester_add("/eir/iphone5", &iphone5_test, NULL, test_parsing, NULL);
+	tester_add("/eir/ipadmini", &ipadmini_test, NULL, test_parsing, NULL);
+	tester_add("/eir/sl400h", &gigaset_sl400h_test, NULL, test_parsing,
+									NULL);
+	tester_add("/eir/sl910", &gigaset_sl910_test, NULL, test_parsing, NULL);
+	tester_add("/eir/bh907", &nokia_bh907_test, NULL, test_parsing, NULL);
+	tester_add("/eir/fuelband", &fuelband_test, NULL, test_parsing, NULL);
+	tester_add("/ad/bluesc", &bluesc_test, NULL, test_parsing, NULL);
+	tester_add("/ad/wahooscale", &wahoo_scale_test, NULL, test_parsing,
+									NULL);
+	tester_add("/ad/mioalpha", &mio_alpha_test, NULL, test_parsing, NULL);
+	tester_add("/ad/cookoo", &cookoo_test, NULL, test_parsing, NULL);
+	tester_add("/ad/citizen1", &citizen_adv_test, NULL, test_parsing, NULL);
+	tester_add("/ad/citizen2", &citizen_scan_test, NULL, test_parsing,
+									NULL);
+
+	return tester_run();
 }
-- 
2.1.0

