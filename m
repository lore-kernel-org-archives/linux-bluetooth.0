Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] unit/test-eir: Add ad/g-tag test
Date: Mon, 13 Apr 2015 16:54:04 +0300
Message-Id: <1428933245-8289-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test for Gigaset G-tag advertisement and prints manufacturer
specific data.
---
 unit/test-eir.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 8fc7af8..4d557a8 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -33,6 +33,7 @@
 #include "lib/hci.h"
 #include "lib/sdp.h"
 #include "src/shared/tester.h"
+#include "src/shared/util.h"
 #include "src/eir.h"
 
 struct test_data {
@@ -544,6 +545,13 @@ static void test_basic(const void *data)
 	tester_test_passed();
 }
 
+static void print_debug(const char *str, void *user_data)
+{
+	char *prefix = user_data;
+
+	tester_debug("%s%s", prefix, str);
+}
+
 static void test_parsing(gconstpointer data)
 {
 	const struct test_data *test = data;
@@ -588,11 +596,39 @@ static void test_parsing(gconstpointer data)
 		g_assert(eir.services == NULL);
 	}
 
+	for (list = eir.msd_list; list; list = list->next) {
+		struct eir_msd *msd = list->data;
+
+		tester_debug("Manufacturer ID: 0x%04x", msd->company);
+		util_hexdump(' ', msd->data, msd->data_len, print_debug,
+							"Manufacturer Data:");
+	}
+
 	eir_data_free(&eir);
 
 	tester_test_passed();
 }
 
+static const unsigned char gigaset_gtag_data[] = {
+		0x02, 0x01, 0x06, 0x0d, 0xff, 0x80, 0x01, 0x02,
+		0x15, 0x12, 0x34, 0x80, 0x91, 0xd0, 0xf2, 0xbb,
+		0xc5, 0x03, 0x02, 0x0f, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const char *gigaset_gtag_uuid[] = {
+		"0000180f-0000-1000-8000-00805f9b34fb",
+		NULL
+};
+
+static const struct test_data gigaset_gtag_test = {
+	.eir_data = gigaset_gtag_data,
+	.eir_size = sizeof(gigaset_gtag_data),
+	.flags = 0x06,
+	.tx_power = 127,
+	.uuid = gigaset_gtag_uuid,
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -616,6 +652,7 @@ int main(int argc, char *argv[])
 	tester_add("/ad/citizen1", &citizen_adv_test, NULL, test_parsing, NULL);
 	tester_add("/ad/citizen2", &citizen_scan_test, NULL, test_parsing,
 									NULL);
+	tester_add("ad/g-tag", &gigaset_gtag_test, NULL, test_parsing, NULL);
 
 	return tester_run();
 }
-- 
2.1.0

