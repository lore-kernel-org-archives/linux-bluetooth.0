Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42532B653
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580580; cv=none; b=AjLYqu1wvv2afGfp2nqc+sAJRZarWCbgSlbNMXx6DSYoWuZfDlxPgSjh2nIM3RGcd6bUf5UxpOsbuC+XKTeiuTgp37Y+S0pBqfNAGOuSVsjv+QSHfsqlUTeTMrjGkJdQoJYpHnUcN1fUH6xnMe0PlkbmYMfSHNWuCXrwj1zhi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580580; c=relaxed/simple;
	bh=/JTBww3FKtOBoKCfUWHXoH/cBXyWaqX4iFp/SZ/L3Qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LegZDP1HU2+eyfwllg8Ms+z5cCcQsLOOYBmeyPnC3joKUPog3eYkRMrnbOBAI/Dn7qDaJo5saLOA7Sbg1XP7Nlh0qK/eIXKXhooMe0rDBKlRF6kdkTfwVZpErUySgW81F1OVhH03bbUYVLMS312f7UmAPmmyRtw4TTD+vaXWd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 16:16:13 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] rctest: replace sprintf() with snprintf() in recv_mode()
Date: Fri, 28 Jun 2024 16:15:30 +0300
Message-ID: <20240628131531.551699-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/28/2024 12:58:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186210 [Jun 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2024 13:02:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2024 11:03:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Use snprintf() instead of sprintf() to avoid buffer overflow.

Found with the SVACE static analysis tool.
---
 tools/rctest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index ff91eb2f1..e39d313eb 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -500,7 +500,7 @@ static void recv_mode(int sk)
 					timestamp = 0;
 					memset(ts, 0, sizeof(ts));
 				} else {
-					sprintf(ts, "[%lld.%lld] ",
+					snprintf(ts, sizeof(ts), "[%lld.%lld] ",
 							(long long)tv.tv_sec,
 							(long long)tv.tv_usec);
 				}
-- 
2.43.0

