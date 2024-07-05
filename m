Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEE1459F3
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166323; cv=none; b=qM0Ur47zwk1IwE0+E9UgD54Sk3gsmkYtPunmyvsmeDNH5U4MU146CLgzWLemBK8F1FPMJNAkJaJC5ZsJPzgId/FIYpf0U16nfYbWrPE/aS8snZl+Dzb9+D9A8ReE6hWGQigpOcxCVd0J2GeQZwgwYB8NXrX6/r/5p3NtVD3MSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166323; c=relaxed/simple;
	bh=3hgKPuZroGIk/19JjsZQZp88S/OU/j51aTYzL9tF2RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lopw6FP8Olza9caKBNGI6GciGVyZnGda1tECM6wZknhWJoO5yETupdu98YAVHxmip4I7JH8jaUFpTrA0f21ifVJOXgppuc2PWiOqiei+PBPLjKJ/HDFb5fIq0kng9jX6JRwsbmgPiOh1vaIYWC+bTLmBtSOlFzEuoCeNRno0W8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Jul
 2024 10:58:07 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 5/5] settings: add NULL checks to gatt_db_load()
Date: Fri, 5 Jul 2024 10:57:07 +0300
Message-ID: <20240705075709.26809-6-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705075709.26809-1-r.smirnov@omp.ru>
References: <20240705075709.26809-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/05/2024 07:27:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186342 [Jul 05 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	217.23.187.157:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.187.157
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/05/2024 07:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/5/2024 4:11:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to prevent dereferencing of null pointers.

Found with the SVACE static analysis tool.
---
 src/settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/settings.c b/src/settings.c
index 996eaacd3..b61e694f1 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -232,7 +232,7 @@ static int gatt_db_load(struct gatt_db *db, GKeyFile *key_file, char **keys)
 		value = g_key_file_get_string(key_file, "Attributes", *handle,
 									NULL);
 
-		if (sscanf(value, "%[^:]:", type) != 1) {
+		if (!value || sscanf(value, "%[^:]:", type) != 1) {
 			g_free(value);
 			return -EIO;
 		}
@@ -255,7 +255,7 @@ static int gatt_db_load(struct gatt_db *db, GKeyFile *key_file, char **keys)
 		value = g_key_file_get_string(key_file, "Attributes", *handle,
 									NULL);
 
-		if (sscanf(value, "%[^:]:", type) != 1) {
+		if (!value || sscanf(value, "%[^:]:", type) != 1) {
 			g_free(value);
 			return -EIO;
 		}
-- 
2.43.0

