Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA729CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479817; cv=none; b=Z52gDA90jme3k2Ejc82ehHSGxsY83BT0P95CM5ji4kvDjtBhGJd1qmp57heUIk4dXp1JqS/I+Hmujkq9bcwv3NVIJEJdGitzeRbA3Rs0IXvkGnpscE7KtHrO1zQv6Zu1W7wx1t+QLeAonMHUrULilwKXBsfHcFsIbKMi+6UsFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479817; c=relaxed/simple;
	bh=L4XElQY5TntQslYdUBtRoV4FpdigYwYmiEEN4rGR7sY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kqe4A1Gv3DMSvXMRA0uD7Kx+Jl0SNylMWaF3tZV/SXUU2rgKqiRgWeXWN4sI2ku7kbsjrNUKKrb+CHkjL597PcL9Fbj+MzDmVjZgOHeaPhE+Szn/KZDJCo6moZfIUlNgE2CyU63HW0Eu90ckUbQVWbJFYZBKePCAj/bmLopUMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 12:16:44 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ] profile: add NULL check to ext_remove_records()
Date: Thu, 27 Jun 2024 12:16:26 +0300
Message-ID: <20240627091628.46304-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/27/2024 08:56:05
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186177 [Jun 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/27/2024 08:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2024 6:24:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Add a NULL check to prevent dereferencing a null pointer in
case the adapter is NULL
---
 src/profile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index c62224af9..bb988e8cb 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1507,7 +1507,8 @@ static void ext_remove_records(struct ext_profile *ext,
 
 		ext->records = g_slist_remove(ext->records, r);
 
-		adapter_service_remove(adapter, r->handle);
+		if (adapter)
+			adapter_service_remove(adapter, r->handle);
 		btd_adapter_unref(r->adapter);
 		g_free(r);
 	}
-- 
2.43.0

