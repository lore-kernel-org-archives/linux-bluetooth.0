Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC32571D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148736; cv=none; b=rYZ3noVAkcNGbdyNCIXQoN5aiImoTJOtNbRR9UTBDcntcbxWj4+kbhATfsfF6gIQ3PulE5s3RjYYG0j0dsxMAAewO3N4QGawqQvbMM5bDsSIbXngQtj96Z6kfLfMmvYNZF4tzYDwIW5XFXu5acfsg9tzqOogFZHX9YVBWmSfGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148736; c=relaxed/simple;
	bh=ZZjlm71EiN6Qt2PV3rC61f3uy9qDQJTnpQWQF/li71k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBKWQ5haCz7huTZciB5TDpW4LXkSHMRFTUvs5NDE72r3+ASCkRjv1Z5E4Tj5AF/yn4AiFX86KzSh+9/e9CU1ihLpLddMYRLIpGnpnPOVgnMH2Qup/6f5fDQjUPN4ntyl33EOp648NFKqEOxus25UTsiLAwh1REcR2Z1RCnp/1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.3.178) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 22 Oct
 2025 18:58:39 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ] battery: improve the display of the charge level
Date: Wed, 22 Oct 2025 18:58:21 +0300
Message-ID: <20251022155822.88438-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/22/2025 15:29:18
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 197340 [Oct 22 2025]
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
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.205.3.178 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;github.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.3.178
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/22/2025 15:30:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/22/2025 12:59:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

At the moment, the charge level of the connected devices can
fluctuate in the range of several values. This is due to changes
in the conditions in which the battery is located (for example,
heating or cooling).

Save the last 4 charge levels. Choose the lowest one.

Fixes: https://github.com/bluez/bluez/issues/1612
---
 src/battery.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/src/battery.c b/src/battery.c
index 59e4fc570..370a5c1d0 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -33,10 +33,13 @@
 #define BATTERY_PROVIDER_MANAGER_INTERFACE "org.bluez.BatteryProviderManager1"
 
 #define BATTERY_MAX_PERCENTAGE 100
+#define LAST_CHARGES_SIZE 4
 
 struct btd_battery {
 	char *path; /* D-Bus object path */
 	uint8_t percentage; /* valid between 0 to 100 inclusively */
+	uint8_t *last_charges; /* last received charge percentages */
+	uint8_t lru_charge_id; /* oldest received charge id */
 	char *source; /* Descriptive source of the battery info */
 	char *provider_path; /* The provider root path, if any */
 };
@@ -92,6 +95,12 @@ static struct btd_battery *battery_new(const char *path, const char *source,
 	battery = new0(struct btd_battery, 1);
 	battery->path = g_strdup(path);
 	battery->percentage = UINT8_MAX;
+	battery->last_charges = new0(uint8_t, LAST_CHARGES_SIZE);
+	battery->lru_charge_id = 0;
+
+	for (uint8_t id = 0; id < LAST_CHARGES_SIZE; id++)
+		battery->last_charges[id] = UINT8_MAX;
+
 	if (source)
 		battery->source = g_strdup(source);
 	if (provider_path)
@@ -105,6 +114,9 @@ static void battery_free(struct btd_battery *battery)
 	if (battery->path)
 		g_free(battery->path);
 
+	if (battery->last_charges)
+		g_free(battery->last_charges);
+
 	if (battery->source)
 		g_free(battery->source);
 
@@ -219,6 +231,8 @@ bool btd_battery_unregister(struct btd_battery *battery)
 
 bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
 {
+	uint8_t min_charge = BATTERY_MAX_PERCENTAGE;
+
 	DBG("path = %s", battery->path);
 
 	if (!queue_find(batteries, NULL, battery)) {
@@ -231,10 +245,18 @@ bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
 		return false;
 	}
 
-	if (battery->percentage == percentage)
+	battery->last_charges[battery->lru_charge_id] = percentage;
+	battery->lru_charge_id = (battery->lru_charge_id + 1) % LAST_CHARGES_SIZE;
+
+	for (uint8_t id = 0; id < LAST_CHARGES_SIZE; id++) {
+		if (battery->last_charges[id] < min_charge)
+			min_charge = battery->last_charges[id];
+	}
+
+	if (battery->percentage == min_charge)
 		return true;
 
-	battery->percentage = percentage;
+	battery->percentage = min_charge;
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), battery->path,
 				     BATTERY_INTERFACE, "Percentage");
 
-- 
2.43.0

