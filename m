Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255513F00A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493583; cv=none; b=ZFSY9lsAAT6b5YX/T7XR36WjLbkOLPB3H8aIuCCfDNJMo82edRUjpuparxKbg41eFP/JOyqe2AoNZjy7g015GFXWHSOIQUvvxTDjSKATGSK8LwxpYlrbHkhjV3gXhY6LNMmIxquGRA3iD4gybGeAIDULfFSOPv4hYiufiCrVKPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493583; c=relaxed/simple;
	bh=ofxSREcIJyCcoyUiyU11C1zJjM0LykSeAw/y2dOwYzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GICa2rKxo218W/O40E/DqRCfv0Wd7SmakTpVrFXIRNCfjiBhY/tfo42EtuNeLm1rWSO/bC5BJt7cHHx1ev1ogZYbpA3ZdlpVa1pDuZPArZK/s8B0t/a1HRm8qawR+b4UAzk50KTTFWDK8/v8CPAbTKrFwtmopAGgzah3YYoeBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 27 Jun
 2024 16:06:05 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] media: fix memory leak in endpoint_init_pac()
Date: Thu, 27 Jun 2024 16:05:51 +0300
Message-ID: <20240627130552.80610-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/27/2024 12:55:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186188 [Jun 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 84.18.99.27 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 06/27/2024 12:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2024 11:06:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

asprintf() allocates memory in the name variable but does not
free it before exiting the function, which causes a memory leak.

Add freeing of the name variable before exiting.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 profiles/audio/media.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index b5644736a..746e538fc 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1280,6 +1280,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 	if (asprintf(&name, "%s:%s", endpoint->sender, endpoint->path) < 0) {
 		error("Could not allocate name for pac %s:%s",
 				endpoint->sender, endpoint->path);
+		free(name);
 		return false;
 	}
 
-- 
2.43.0

