Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] unit/test-eir: Add ad/uri-beacon test
Date: Fri, 17 Apr 2015 16:13:49 +0300
Message-Id: <1429276429-13660-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds test for uir-beacon define bellow:

https://github.com/google/uribeacon/blob/master/specification/AdvertisingMode.md
---
 unit/test-eir.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 4d557a8..421d0db 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -572,7 +572,7 @@ static void test_parsing(gconstpointer data)
 		tester_debug("UUID: %s", uuid_str);
 	}
 
-	g_assert(eir.flags == test->flags);
+	g_assert_cmpint(eir.flags, ==, test->flags);
 
 	if (test->name) {
 		g_assert_cmpstr(eir.name, ==, test->name);
@@ -604,6 +604,14 @@ static void test_parsing(gconstpointer data)
 							"Manufacturer Data:");
 	}
 
+	for (list = eir.sd_list; list; list = list->next) {
+		struct eir_sd *sd = list->data;
+
+		tester_debug("Service UUID: %s", sd->uuid);
+		util_hexdump(' ', sd->data, sd->data_len, print_debug,
+							"Service Data:");
+	}
+
 	eir_data_free(&eir);
 
 	tester_test_passed();
@@ -629,6 +637,23 @@ static const struct test_data gigaset_gtag_test = {
 	.uuid = gigaset_gtag_uuid,
 };
 
+static const char *uri_beacon_uuid[] = {
+		"0000fed8-0000-1000-8000-00805f9b34fb",
+		NULL
+};
+
+static const unsigned char uri_beacon_data[] = {
+		0x03, 0x03, 0xd8, 0xfe, 0x0c, 0x16, 0xd8, 0xfe, 0x00,
+		0x20, 0x00, 'b', 'l', 'u', 'e', 'z', 0x08
+};
+
+static const struct test_data uri_beacon_test = {
+	.eir_data = uri_beacon_data,
+	.eir_size = sizeof(uri_beacon_data),
+	.tx_power = 127,
+	.uuid = uri_beacon_uuid,
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -653,6 +678,7 @@ int main(int argc, char *argv[])
 	tester_add("/ad/citizen2", &citizen_scan_test, NULL, test_parsing,
 									NULL);
 	tester_add("ad/g-tag", &gigaset_gtag_test, NULL, test_parsing, NULL);
+	tester_add("ad/uri-beacon", &uri_beacon_test, NULL, test_parsing, NULL);
 
 	return tester_run();
 }
-- 
2.1.0

