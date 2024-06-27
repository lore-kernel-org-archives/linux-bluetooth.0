Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17C819
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478799; cv=none; b=tEUBp4xCVIwHf/iPdUn3VUY2P65+dXEgSU/roVoufwJ+zOsrysfY8Lgzkgb7ejjzFTHs1CuAuujNEu4/ISoqdi9CWDTrzuiNcNosaQTiqK0FMQGmCL04c7UlmbOLlnHhxnzscCN+c+vKlRdWfAuAnDDVkSjr0AzouTScqwEl52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478799; c=relaxed/simple;
	bh=5HDEvNVS6GHJ5Pm56+lu4u9fQ0EAraERvKhAbNDAIOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZbyZQ4WpJifdHY5F5StQzXyXaaN00c6smOf5D+J9icYNy/y9xR8EGYJRlmuca+BCpE9jMM1L9gZgqWw0agT7Pu6PkGDECGRYMS1G7YBoqpMK4yUH0iG39m0gAY7IeUUYFfAg5gB0eW4cKkY3o8GHtTW2d9ybE9FqPV/I+bw6oeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 11:59:38 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ] bass: add NULL check to bass_handle_add_src_op()
Date: Thu, 27 Jun 2024 11:56:49 +0300
Message-ID: <20240627085652.41303-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/27/2024 08:43:18
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186177 [Jun 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
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
X-KSE-Antiphishing-Bases: 06/27/2024 08:48:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2024 6:24:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

This prevents a null pointer from being dereferenced in case
queue_find() returns NULL.
---
 src/shared/bass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index c30537dee..f08799714 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -875,7 +875,8 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 					attr);
 
 		queue_remove(bass->ldb->bcast_srcs, src);
-		bass_bcast_src_free(src);
+		if (src)
+			bass_bcast_src_free(src);
 		bcast_src->attr = attr;
 	}
 
-- 
2.43.0

