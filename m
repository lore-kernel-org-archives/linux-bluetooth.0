Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FE3594C
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662681; cv=none; b=JbUEFewRfh+Z4n5gP2moZ9q+TSIvwLSR+Hh+eDANW3b6OYr2SA+/3TEWON0tuvKQcT4dhf0l1SSfJMpb07LYG58evIhaeGNqs3ruq3OT/6RaO3JVGUMKhp2F3WsNi3+4CDL/yvNunou2K+xq6/wRocokumuPs7QFD4Yvqgp2DHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662681; c=relaxed/simple;
	bh=SYnNw6DK9HJVjQofaKqHXolOgiEgmEz0c+QrkMQdXcE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JxO9dPWaHoNLHObmoA4bqJQrwz6+GUUk5sW7PC2PVdbNH12bTvCjuzFn3gnZjT/YxnxP3B/lufRvnIn4G8kMV9WIGyHB+C/0OWDCUK7n4keXF1zYx1w7iIIYpLpLWdgo2F6t5P8Ou1NsZvBN7MLAOjA5ySwQSL2EdAJIRKCwp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.204.178.115) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 28 Oct
 2025 17:44:27 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v3] battery: improve the display of the charge level
Date: Tue, 28 Oct 2025 17:43:19 +0300
Message-ID: <20251028144320.104871-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/28/2025 14:18:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 197533 [Oct 28 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 72 0.3.72
 80ff96170b649fb7ebd1aa4cb544c36c109810bd
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_repetitive_subdir_in_url}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.204.178.115 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	github.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.204.178.115
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/28/2025 14:22:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/28/2025 12:58:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The battery charge level may fluctuate due to uncalibrated
sensors. Commit smooths out such fluctuations.

The algorithm for determining uncalibrated sensors consists of
finding the number of changes in charge direction (i.e., "spikes").
If the number of spikes is zero, the device is charging or discharging.
If there is one spike, it may mean that the device has started charging
or has been disconnected from charging. If there are two or more spikes,
this is a clear indication of an uncalibrated sensor.

Check that the battery charge is fluctuating. If the battery charge
is fluctuating, use the average charge value, otherwise use the current
value.

Fixes: https://github.com/bluez/bluez/issues/1612
---
V2 -> V3: A queue is used instead of an array for the last charges,
a bug with the spikes variable increment has been fixed, and the
fluctuation check is called each time a new battery charge appears.

V1 -> V2: Smoothing is only applied to uncalibrated sensors, the
last 8 values are saved instead of 4, and the average value is used
for smoothing instead of the minimum value.

 src/battery.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/src/battery.c b/src/battery.c
index 59e4fc570..33079975c 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -33,10 +33,15 @@
 #define BATTERY_PROVIDER_MANAGER_INTERFACE "org.bluez.BatteryProviderManager1"
 
 #define BATTERY_MAX_PERCENTAGE 100
+#define LAST_CHARGES_SIZE 8
+#define MAX_CHARGE_STEP 5
 
 struct btd_battery {
 	char *path; /* D-Bus object path */
 	uint8_t percentage; /* valid between 0 to 100 inclusively */
+	struct queue *last_charges; /* last charges received */
+	float avg_charge; /* average battery charge */
+	bool is_fluctuating; /* true, if the battery sensor fluctuates */
 	char *source; /* Descriptive source of the battery info */
 	char *provider_path; /* The provider root path, if any */
 };
@@ -92,6 +97,10 @@ static struct btd_battery *battery_new(const char *path, const char *source,
 	battery = new0(struct btd_battery, 1);
 	battery->path = g_strdup(path);
 	battery->percentage = UINT8_MAX;
+	battery->last_charges = queue_new();
+	battery->avg_charge = 0;
+	battery->is_fluctuating = false;
+
 	if (source)
 		battery->source = g_strdup(source);
 	if (provider_path)
@@ -105,6 +114,9 @@ static void battery_free(struct btd_battery *battery)
 	if (battery->path)
 		g_free(battery->path);
 
+	if (battery->last_charges)
+		queue_destroy(battery->last_charges, NULL);
+
 	if (battery->source)
 		g_free(battery->source);
 
@@ -217,8 +229,49 @@ bool btd_battery_unregister(struct btd_battery *battery)
 	return true;
 }
 
+static void check_fluctuations(struct btd_battery *battery)
+{
+	const struct queue_entry *entry;
+	uint8_t spikes = 0;
+	int8_t step;
+	int8_t direction = 0;
+	int8_t prev_direction;
+	uint8_t *prev_charge;
+	uint8_t *next_charge;
+
+	for (entry = queue_get_entries(battery->last_charges); entry->next;
+	     entry = entry->next) {
+		prev_direction = direction;
+		prev_charge = entry->data;
+		next_charge = entry->next->data;
+		step = *next_charge - *prev_charge;
+
+		/*
+		 * The battery charge fluctuates too much,
+		 * which may indicate a battery problem, so
+		 * the actual value should be displayed.
+		 */
+		if (abs(step) >= MAX_CHARGE_STEP) {
+			battery->is_fluctuating = false;
+			return;
+		}
+
+		if (step > 0)
+			direction = 1;
+		else if (step < 0)
+			direction = -1;
+
+		if (direction != prev_direction && prev_direction)
+			spikes++;
+	}
+
+	battery->is_fluctuating = (spikes > 1) ? true : false;
+}
+
 bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
 {
+	uint8_t *p_percentage;
+
 	DBG("path = %s", battery->path);
 
 	if (!queue_find(batteries, NULL, battery)) {
@@ -231,6 +284,23 @@ bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
 		return false;
 	}
 
+	if (!battery->avg_charge)
+		battery->avg_charge = percentage;
+
+	/* exponential smoothing */
+	battery->avg_charge = battery->avg_charge * 0.7 + percentage * 0.3;
+	p_percentage = new0(uint8_t, 1);
+	*p_percentage = percentage;
+	queue_push_tail(battery->last_charges, p_percentage);
+
+	if (queue_length(battery->last_charges) == LAST_CHARGES_SIZE) {
+		check_fluctuations(battery);
+		queue_pop_head(battery->last_charges);
+	}
+
+	if (battery->is_fluctuating)
+		percentage = battery->avg_charge;
+
 	if (battery->percentage == percentage)
 		return true;
 
-- 
2.43.0

