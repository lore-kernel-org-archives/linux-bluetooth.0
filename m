Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 7/7] unit/test-eir: Added tests for connection interval
Date: Thu, 16 Feb 2017 18:03:15 +0000
Message-Id: <20170216180315.30531-8-eu@felipetonello.com>
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch incorporates some unit-tests for the Slave Connection
Interval Range AD and also does some minor cleanups.
---
 unit/test-eir.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 421d0db13a41..e9d0d60fdd39 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -44,6 +44,7 @@ struct test_data {
 	bool name_complete;
 	int8_t tx_power;
 	const char **uuid;
+	uint16_t min_interval, max_interval;
 };
 
 static const unsigned char macbookair_data[] = {
@@ -508,6 +509,8 @@ static const struct test_data citizen_adv_test = {
 	.name = "Eco-Drive Proximity",
 	.name_complete = true,
 	.tx_power = 127,
+	.min_interval = 383,
+	.max_interval = 399,
 };
 
 static const unsigned char citizen_scan_data[] = {
@@ -565,6 +568,8 @@ static void test_parsing(gconstpointer data)
 	tester_debug("Flags: %d", eir.flags);
 	tester_debug("Name: %s", eir.name);
 	tester_debug("TX power: %d", eir.tx_power);
+	tester_debug("Min/Max connection interval: %u/%u",
+		eir.le_min_conn_interval, eir.le_max_conn_interval);
 
 	for (list = eir.services; list; list = list->next) {
 		char *uuid_str = list->data;
@@ -581,7 +586,9 @@ static void test_parsing(gconstpointer data)
 		g_assert(eir.name == NULL);
 	}
 
-	g_assert(eir.tx_power == test->tx_power);
+	g_assert_cmpint(eir.tx_power, == ,test->tx_power);
+	g_assert_cmpuint(eir.le_min_conn_interval, ==, test->min_interval);
+	g_assert_cmpuint(eir.le_max_conn_interval, ==, test->max_interval);
 
 	if (test->uuid) {
 		GSList *list;
@@ -654,6 +661,18 @@ static const struct test_data uri_beacon_test = {
 	.uuid = uri_beacon_uuid,
 };
 
+static const unsigned char conn_interval_data[] = {
+	0x05, 0x12, 0x03, 0x00, 0x0f, 0x00
+};
+
+static const struct test_data conn_interval_test = {
+	.eir_data = conn_interval_data,
+	.eir_size = sizeof(conn_interval_data),
+	.tx_power = 127,
+	.min_interval = 3,
+	.max_interval = 15,
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -677,8 +696,9 @@ int main(int argc, char *argv[])
 	tester_add("/ad/citizen1", &citizen_adv_test, NULL, test_parsing, NULL);
 	tester_add("/ad/citizen2", &citizen_scan_test, NULL, test_parsing,
 									NULL);
-	tester_add("ad/g-tag", &gigaset_gtag_test, NULL, test_parsing, NULL);
-	tester_add("ad/uri-beacon", &uri_beacon_test, NULL, test_parsing, NULL);
+	tester_add("/ad/g-tag", &gigaset_gtag_test, NULL, test_parsing, NULL);
+	tester_add("/ad/uri-beacon", &uri_beacon_test, NULL, test_parsing, NULL);
+	tester_add("/ad/conn-interval", &conn_interval_test, NULL, test_parsing, NULL);
 
 	return tester_run();
 }
-- 
2.11.1

