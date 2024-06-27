Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1579F0
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484258; cv=none; b=jfqbE4ndyB4P7vluQZSueNOyAF5or9xzcgFXWN7wr+4uir/kPoFk052P41ia4suaiEjEsV3pc/H+0eTQYPUcHrUcbDYvN00MYgJgtNcigQ906Bv4gzdP87YGx9pwwjr4+IeUjr1r5rSMgxTFEUB/jYZ0JV3w7H+k/0Ddku+/n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484258; c=relaxed/simple;
	bh=oqOg2r7uqd9Rt2yb4163h7T/gPjCyFzO5RBchnxxI2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lFWu1tBuzWFXfVJf9g6R629IN/icHzWgucSFMoxIMg9QiJcN/RJOm0tIqQACtsRnfowJrhSDvIEFFCKcBPVcqM9C3oz6a/KKiD4JrgcO91qz5iAdjO9CagiMLOnCBhGmpmpqJyixoR2BHfTLtu23aSzOigBql0dDl3t+zxgEdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 13:30:38 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ] plugins/sixaxis: add NULL check in setup_device()
Date: Thu, 27 Jun 2024 13:30:20 +0300
Message-ID: <20240627103022.51199-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/27/2024 10:12:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186179 [Jun 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 06/27/2024 10:15:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2024 6:24:00 AM
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

