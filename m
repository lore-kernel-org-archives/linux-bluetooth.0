Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F6156F57
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526489; cv=none; b=MrRZgNZEHVu6jAXvXvoH/3ZVhn2I/9d9Lek2aDJioN5zXo99DOrceN9PrgBuTChoHPuykrwp6NOA6m8JJERaaarJM6TJgT7Hu46iJML8GFjb/p3llMy3ne3ZpvY/MFwc396ZfIC7ABBuM/xy4BtfVsqiH2b6cYGr4tSvDu/Zz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526489; c=relaxed/simple;
	bh=HUEy3qOqz91dePXjcyS+BmDbgbNbaqYucwriaoy8zBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN/Pm7C169S7JTjytZBxJmQ12OCG0yTwuaOd4qAQAZFcmssRNz22Cm+oFG4eETKMxipGzuHuPvkk75i/CTGhTH1Yl/mAJjfn9eaXCkuBdZuGqSsFgNv3qMPe1mIYbr2sUNl39HSj83DFwaYWJ8LYvbWidFSllGyNIkTSunLDxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 9 Jul
 2024 15:01:02 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 3/4] settings: limit the string size in load_service()
Date: Tue, 9 Jul 2024 15:00:30 +0300
Message-ID: <20240709120031.105038-4-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709120031.105038-1-r.smirnov@omp.ru>
References: <20240709120031.105038-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/09/2024 11:45:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186390 [Jul 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 23 0.3.23
 8881c50ebb08f9085352475be251cf18bb0fcfdd
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	81.22.207.138:7.1.2;inp1wst083.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/09/2024 11:49:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2024 11:26:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Calculate the length of the first string and use it to create
a pattern. The pattern will limit the maximum length of the
string, which will prevent the buffer from overflowing.

Found with the SVACE static analysis tool.
---
 src/settings.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/settings.c b/src/settings.c
index b61e694f1..4eccf0b4e 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -187,13 +187,30 @@ static int load_service(struct gatt_db *db, char *handle, char *value)
 	char type[MAX_LEN_UUID_STR], uuid_str[MAX_LEN_UUID_STR];
 	bt_uuid_t uuid;
 	bool primary;
+	char pattern[16];
+	char *colon_pos;
+	size_t len;
 
 	if (sscanf(handle, "%04hx", &start) != 1) {
 		DBG("Failed to parse handle: %s", handle);
 		return -EIO;
 	}
 
-	if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) != 3) {
+	colon_pos = memchr(value, ':', MAX_LEN_UUID_STR);
+	if (!colon_pos) {
+		DBG("Failed to parse value: %s", value);
+		return -EIO;
+	}
+
+	len = colon_pos - value;
+	if (!len) {
+		DBG("Failed to parse value: %s", value);
+		return -EIO;
+	}
+
+	snprintf(pattern, sizeof(pattern), "%%%lds:%%04hx:%%36s", len);
+
+	if (sscanf(value, pattern, type, &end, uuid_str) != 3) {
 		DBG("Failed to parse value: %s", value);
 		return -EIO;
 	}
-- 
2.34.1

