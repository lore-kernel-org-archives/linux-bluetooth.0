Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@gmail.com>
Subject: [PATCH 3/4] unit/eir: Add WahooHRM test
Date: Thu, 30 Apr 2015 13:26:17 +0200
Message-Id: <1430393178-29983-3-git-send-email-mariusz.skamra@gmail.com>
In-Reply-To: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
References: <1430393178-29983-1-git-send-email-mariusz.skamra@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-eir.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/unit/test-eir.c b/unit/test-eir.c
index 09d9865..0a8d0ce 100644
--- a/unit/test-eir.c
+++ b/unit/test-eir.c
@@ -660,6 +660,28 @@ static const struct test_data uri_beacon_test = {
 	.uuid = uri_beacon_uuid,
 };
 
+static const char *wahoo_hrm_uuid[] = {
+		"0000180d-0000-1000-8000-00805f9b34fb",
+		NULL
+};
+
+static const unsigned char wahoo_hrm_data[] = {
+		0x02, 0x01, 0x06, 0x03, 0x02, 0x0d, 0x18, 0x0f, 0x09,
+		0x57, 0x61, 0x68, 0x6f, 0x6f, 0x20, 0x48, 0x52, 0x4d,
+		0x20, 0x76, 0x32, 0x2e, 0x31
+};
+
+static const struct test_data wahoo_hrm_test = {
+	.eir_data = wahoo_hrm_data,
+	.eir_size = sizeof(wahoo_hrm_data),
+	.flags = 0x06,
+	.tx_power = 127,
+	.uuid = wahoo_hrm_uuid,
+	.name = "Wahoo HRM v2.1",
+	.name_complete = true,
+	.bdaddr_type = BDADDR_LE_RANDOM,
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -685,6 +707,7 @@ int main(int argc, char *argv[])
 									NULL);
 	tester_add("ad/g-tag", &gigaset_gtag_test, NULL, test_parsing, NULL);
 	tester_add("ad/uri-beacon", &uri_beacon_test, NULL, test_parsing, NULL);
+	tester_add("ad/wahoo-hrm", &wahoo_hrm_test, NULL, test_parsing, NULL);
 
 	return tester_run();
 }
-- 
1.9.1

