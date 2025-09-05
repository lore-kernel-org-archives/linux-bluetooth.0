Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E03451BE
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080223; cv=none; b=FXz0aZ9QN5YhnhbTqENaViTkp1Pf6/PQfhzFEDi0TexWC62mVReEGGU0LZiSOyoAYsTeyKVYZ8x3rlZrStVsuF2IE4q/HUAIjFYVMI+En40YXfKJa43bhicMRC3yrVRZUZywP5RqK9NBdveutOh8Q7NkLkJfgoczCIXXl/egomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080223; c=relaxed/simple;
	bh=nnQDGO2kNt4qSYe1uMEEajL7Ng/HAs0c1QUb/asteKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ChyE1MKmOlIUv0IP7quZRa+8CXdKc4wZZHt+BEHz4qWMGBRPlYKKyGn6ohjj+dT5CKXKPitLwbZ0xzX28Ne6XdfPMSMWTq4cyknl5i4ojFR+DmIvirXXfdhrS/MgZ565MpJCTktKLFQwZfuoqPFtUdwOvakS4gPmXpt6eTN53S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.54.119) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Sep
 2025 16:49:56 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ] client/assistant: Use strnlen() instead of strlen()
Date: Fri, 5 Sep 2025 16:49:39 +0300
Message-ID: <20250905134942.80833-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/05/2025 13:28:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 196071 [Sep 05 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 66 0.3.66
 fc5dda3b6b70d34b3701db39319eece2aeb510fb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.205.54.119 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.205.54.119 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.54.119
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/05/2025 13:30:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/5/2025 10:15:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Using strlen() can lead to undefined behavior.
---
 client/assistant.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/assistant.c b/client/assistant.c
index 5850b5827..3551aaad8 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -261,7 +261,7 @@ static void assistant_set_bcode_cfg(const char *input, void *user_data)
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
 		memset(cfg->qos.bcast.bcode, 0, BCODE_LEN);
 	} else {
-		if (strlen(input) > BCODE_LEN) {
+		if (strnlen(input, BCODE_LEN + 1) > BCODE_LEN) {
 			bt_shell_printf("Input string too long %s\n", input);
 			goto fail;
 		}
-- 
2.43.0

