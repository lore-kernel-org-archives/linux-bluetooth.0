Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4D35CBAF
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122347; cv=none; b=IbM+Ad1EfiaDa19T30eiY5EywHZW/DngBVYSBOz8nZfdTJxdKvp3TZacvB63IlfP1aLBb16b9+mQzb9FX6F73ZKdUBu6MWXULuZ5S1wyhqCnkd0WdoKJFf75HIZXztNNJYUGvdVtyzvlBUYSF9R4eY+SYMY5mTJNINarZv4pz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122347; c=relaxed/simple;
	bh=330tTDO90zS1h+W/CmHGPO7RGh6z1buHm9rBP764Yo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZQBcIn/1j59BenTqoKWY5o5CePgeiLp6vnVlCm1bH6Afmjvq1/ZaRQmLr8UFB2HSUb91aw/t46YLumrvBDmDPh030sCCZv84ab+Xj96MWZsrAHxrTzHn8+6SwZl01DDsJHDvy2obIWgpZ8thaFiTVzPNW026dsDUFiQBL5PGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (188.225.51.187) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 14 Nov
 2025 15:12:12 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v7 2/2] unit: Add basic unit tests for battery charge handling
Date: Fri, 14 Nov 2025 15:11:37 +0300
Message-ID: <20251114121140.102190-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114121140.102190-1-r.smirnov@omp.ru>
References: <20251114121140.102190-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/14/2025 11:58:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 198092 [Nov 14 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 188.225.51.187 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 188.225.51.187
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/14/2025 12:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/14/2025 11:13:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

---
V5 -> V6: Add stdlib.h header file.

 .gitignore            |   1 +
 Makefile.am           |   6 ++
 doc/test-coverage.txt |   3 +-
 unit/test-battery.c   | 224 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-battery.c

diff --git a/.gitignore b/.gitignore
index d23a06af4..784fc77db 100644
--- a/.gitignore
+++ b/.gitignore
@@ -117,6 +117,7 @@ unit/test-ecc
 unit/test-hog
 unit/test-bap
 unit/test-bass
+unit/test-battery
 tools/mgmt-tester
 tools/smp-tester
 tools/gap-tester
diff --git a/Makefile.am b/Makefile.am
index 4bf859685..deb59fad3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -701,6 +701,12 @@ unit_test_vcp_SOURCES = unit/test-vcp.c $(btio_sources)
 unit_test_vcp_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-battery
+
+unit_test_battery_SOURCES = unit/test-battery.c
+unit_test_battery_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 if MIDI
 unit_tests += unit/test-midi
 unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 741492a3e..b92a2ae59 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -30,8 +30,9 @@ test-gobex-transfer	  36	OBEX transfer handling
 test-gdbus-client	  13	D-Bus client handling
 test-gatt		 180	GATT qualification test cases
 test-hog		   6	HID Over GATT qualification test cases
+test-battery		  10	Battery charge test cases
 			-----
-			 761
+			 771
 
 
 Automated end-to-end testing
diff --git a/unit/test-battery.c b/unit/test-battery.c
new file mode 100644
index 000000000..eab1ebdd7
--- /dev/null
+++ b/unit/test-battery.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Open Mobile Platform LLC <community@omp.ru>
+ *
+ *
+ */
+
+#include <glib.h>
+#include <stdlib.h>
+
+#include "src/shared/battery.h"
+#include "src/shared/tester.h"
+
+#define DATA_SIZE 10
+
+static uint8_t calculate_average(const uint8_t *charges)
+{
+	uint16_t average = 0;
+
+	for (int i = DATA_SIZE - LAST_CHARGES_SIZE; i < DATA_SIZE; i++)
+		average += charges[i];
+
+	return average / LAST_CHARGES_SIZE;
+}
+
+static uint8_t process_data(struct bt_battery *battery, uint8_t *charges)
+{
+	uint8_t battery_avg;
+
+	for (int i = 0; i < DATA_SIZE; i++)
+		battery_avg = bt_battery_charge(battery, charges[i]);
+
+	return battery_avg;
+}
+
+static void test_discharging(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 84, 83, 83, 81, 80, 80, 80, 79, 79, 78 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_charging(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 48, 48, 48, 49, 49, 50, 51, 51, 51, 53 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_discharge_started(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 48, 48, 49, 50, 51, 51, 49, 48, 47, 45 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_charge_started(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 57, 57, 56, 56, 55, 54, 55, 57, 57, 58 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_fluctuations(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 74, 73, 75, 72, 74, 72, 73, 71, 75, 73 };
+	uint8_t processed_charge, average;
+
+	average = calculate_average(charges);
+	processed_charge = process_data(battery, charges);
+
+	g_assert(processed_charge == average);
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_fluctuations_with_anomaly(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 33, 33, 34, 32, 94, 33, 31, 33, 34, 32 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_fluctuations_with_old_anomaly(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 94, 22, 22, 21, 21, 20, 21, 20, 21, 20 };
+	uint8_t processed_charge, average;
+
+	average = calculate_average(charges);
+	processed_charge = process_data(battery, charges);
+
+	g_assert(processed_charge == average);
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_bad_battery(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 28, 38, 92, 34, 85, 34, 45, 41, 29, 40 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_device_report_5_percent(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 55, 55, 50, 50, 50, 55, 55, 55, 60, 60 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+static void test_device_report_10_percent(const void *data)
+{
+	struct bt_battery *battery = bt_battery_new();
+	uint8_t charges[DATA_SIZE] = { 30, 30, 30, 40, 40, 50, 50, 50, 50, 60 };
+	uint8_t processed_charge;
+
+	for (int i = 0; i < DATA_SIZE; i++) {
+		processed_charge = bt_battery_charge(battery, charges[i]);
+		g_assert(processed_charge == charges[i]);
+	}
+
+	bt_battery_free(battery);
+	free(battery);
+	tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/battery/test_discharging", NULL, NULL,
+			test_discharging, NULL);
+	tester_add("/battery/test_charging", NULL, NULL,
+			test_charging, NULL);
+	tester_add("/battery/test_discharge_started", NULL, NULL,
+			test_discharge_started, NULL);
+	tester_add("/battery/test_charge_started", NULL, NULL,
+			test_charge_started, NULL);
+	tester_add("/battery/test_fluctuations", NULL, NULL,
+			test_fluctuations, NULL);
+	tester_add("/battery/test_fluctuations_with_anomaly", NULL, NULL,
+			test_fluctuations_with_anomaly, NULL);
+	tester_add("/battery/test_fluctuations_with_old_anomaly", NULL, NULL,
+			test_fluctuations_with_old_anomaly, NULL);
+	tester_add("/battery/test_bad_battery", NULL, NULL, test_bad_battery, NULL);
+	tester_add("/battery/test_device_report_5_percent", NULL, NULL,
+			test_device_report_5_percent, NULL);
+	tester_add("/battery/test_device_report_10_percent", NULL, NULL,
+			test_device_report_10_percent, NULL);
+
+	return tester_run();
+}
-- 
2.43.0

