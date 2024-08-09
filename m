Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B8198E7A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220609; cv=none; b=Lk4YgeBZ8vpQ9JbE6RyU2xTrm4JCFB2iLAdPMy4eGxa4vrOMuhYgVA2thMW/T4reouSveNu6ifjyxurgYbxQU++DLz24R5g3PLqYeXxq75ivPVUg51u+gNPSbLjY3ngI43202WKM6Gxlr/mofW0PSpmy0JJE6GHqfdwORtUhKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220609; c=relaxed/simple;
	bh=unmtuWTjHyPR3KhVftLMF8SQYxmm2OQiL8d5NZmh410=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPRL1g+uilvRB1WpWnJ95yHqcctNK10a3L94aUoBGT4q9/7cZKip2aguf9hl6RGpq4/0znk2soA/dLZHFNTlwd4LxoIo+zVvdp4XoC9ytntrNtIHZZ7AVoOuyHvATSvFu2ktFS2Ivt8Y1qnMVyM2XlqYKv1DRDwdxWlV+S1uuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.186.16) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 9 Aug
 2024 19:23:12 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 2/3] android/avctp: remove check in session_browsing_cb()
Date: Fri, 9 Aug 2024 19:22:28 +0300
Message-ID: <20240809162252.50098-3-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809162252.50098-1-r.smirnov@omp.ru>
References: <20240809162252.50098-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/09/2024 16:04:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186979 [Aug 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.186.16
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2024 16:08:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/9/2024 2:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

session->browsing is dereferenced at the beginning of the function, so
the check can be removed.

Found with the SVACE static analysis tool.
---
 android/avctp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index 37b4cec4f..d8104a7c2 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -905,10 +905,8 @@ send:
 failed:
 	DBG("AVCTP Browsing: disconnected");
 
-	if (session->browsing) {
-		avctp_channel_destroy(session->browsing);
-		session->browsing = NULL;
-	}
+	avctp_channel_destroy(session->browsing);
+	session->browsing = NULL;
 
 	return FALSE;
 }
-- 
2.43.0

