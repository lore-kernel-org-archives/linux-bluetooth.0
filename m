Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063613E41F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495193; cv=none; b=JHSpGb6FXf/EeVif6wMHfDjTg1+bjqH5k4cN9m/5fPVJOqtHxZNu07ODQEZUZQ3R0mgrXt01SzkpEwsZClINItmTmiolAKw6MHK31sKSf9BvlGK+9iOHX7B/Bsui+u59BuRQHuxB1rSdlyrP/8UnlQOvM5Sfdi+/nBRWHTp2lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495193; c=relaxed/simple;
	bh=7G2hrrPMMw5bbR7AzoVcHXPv53oWserdCVFaNHcsEUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tFKxKKZgiIUyTHgYjNk4tC4Nt/O5ETyFWSzZPMoU4aZPMqLQDE/CQEHUkw7BtzFOHzAUZDxKazSrD2udkgBKY+dVCJzHUWZtVm2BsK6VixaJuFCDI/2ltCffutvEAIkOm6AudFwNwgHllRmmpDFmZchT4HV0+2sRstfZLUuVlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 16:32:37 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] health/mcap: fix memory leak in mcap_create_mcl()
Date: Thu, 27 Jun 2024 16:32:21 +0300
Message-ID: <20240627133222.82707-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/27/2024 13:21:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186190 [Jun 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/27/2024 13:25:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2024 11:06:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

set_default_cb() can allocate memory for mcl->cb but it does
not free mcl->cb before exiting the function.

Add freeing mcl->cb before exiting the function.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 profiles/health/mcap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 5d2bac3d9..b544b9a0a 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -1907,6 +1907,7 @@ gboolean mcap_create_mcl(struct mcap_instance *mi,
 		set_default_cb(mcl);
 		if (util_getrandom(&val, sizeof(val), 0) < 0) {
 			mcap_instance_unref(mcl->mi);
+			g_free(mcl->cb);
 			g_free(mcl);
 			return FALSE;
 		}
-- 
2.43.0

