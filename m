Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3DC148
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561472; cv=none; b=g11Vj1KJNuGvRDCc+iM37Iny6if93zd5foxaLR6RKl/3Z7Ap90SmEF/JZyE/o7WknOgw6BB2pUKFmxERPtWcoDQyDcQQ1J0MzjtEu8INhWUbLG3+HBcMzijCJVSV0fy3lJkIUhLKt38FNwn/NilB8LKSEHTXril/q/8W9KeGV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561472; c=relaxed/simple;
	bh=1ZCWtKPi5LjD5gXdsNhew4iSKhhgGxgbgtthX3JG9GU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwv5dBTRm10pzu5MVCnxyQWPGLiVxpSgY4QeZJP5Iml/wkkganA0/5i53Ve5K5i+5eGIpbJtbH6aeoWpTyjyE+tZhCIia9KRsSLMjkGIWplAp3joJL0TCMmuZcyn5pGP3XEFWyl92Biatu86DnsrEwj9mIJgRalBcOmPMyXxr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 10:57:32 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2] gatt-server: fix memory leak in bt_gatt_server_send_notification()
Date: Fri, 28 Jun 2024 10:57:18 +0300
Message-ID: <20240628075719.42796-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/28/2024 07:43:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186203 [Jun 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 06/28/2024 07:47:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2024 4:47:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

data-pdu is allocated but not released when an error occurs.

Add data-pdu release before exiting the function in case of an error.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 src/shared/gatt-server.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0e399ceb1..3a53d5dfd 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1822,8 +1822,10 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	return result;
 
 error:
-	if (data)
+	if (data) {
+		free(data->pdu);
 		free(data);
+	}
 
 	return false;
 }
-- 
2.43.0

