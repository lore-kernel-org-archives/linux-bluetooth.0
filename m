Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34515688D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492194; cv=none; b=q0POznqbgxkB5l4WfyjErmUQB6pmQ4j9vkmTCvsjC0pnpDctA3zy19rRPkkY9jGYB6ZaO8Ufl9I8bwiQEbYYHjrTgwppBpWSNZsVTb7aMBYIYFyscz960GTteYLLZxZbNJOSXC+vskIIAuo/z1lWk/d4e8qPA5VzSeYa+Y+Hu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492194; c=relaxed/simple;
	bh=+nJk9AskrUM/xWoXuKPnNKth7awwK3+00TL/kDvs0wM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNl5YnrFuB7BWe5mIRj68HAsImpbJmZL5NillcGyboJyYFv73bMYSJvJsIDiNU/dSsMd+C7THuVe2u2+k2ZEa4J6Be0MmR740QN4qM9hqyFtDmCOY1z7nFIBrQyI0JKaVY93QO3vrYtJmLz5rM6EPEZBbjmCQ6Jp3pGSCm1OCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 15:39:49 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2] plugins/sixaxis: add NULL check in setup_device()
Date: Thu, 27 Jun 2024 15:39:02 +0300
Message-ID: <20240627123935.67784-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/27/2024 12:17:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186185 [Jun 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 84.18.99.27 in (user) dbl.spamhaus.org}
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
X-KSE-Antiphishing-Bases: 06/27/2024 12:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2024 11:06:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

btd_adapter_get_device() may return NULL on the next call stack:

btd_adapter_get_device()
    adapter_create_device()
        device_create()
            device_new()
                g_try_malloc0()

It is necessary to prevent this to avoid dereferencing a null
pointer further.
---
 plugins/sixaxis.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 544ab399a..3e69f1dd2 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -346,6 +346,11 @@ static bool setup_device(int fd, const char *sysfs_path,
 
 	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
 
+	if (!device) {
+		error("sixaxis: unable to set up a new device");
+		return false;
+	}
+
 	info("sixaxis: setting up new device");
 
 	btd_device_device_set_name(device, cp->name);
-- 
2.43.0

