Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE07344C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116523; cv=none; b=H3/UPM1M2X18gTzbMHEK4EvbVwRFX4cXrm9vuYLJ/NOSixyhlOl5O3O6Ua/gcizLoiYCtZTCAxfq4wqM1blKgjApAIiuTcn5aNlUa27r0sQefhaDoZ1NkDIoHudkPe+LMw2c2uxd2mPBqYatZsQhVO9YCwbz645XbV76lh4A0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116523; c=relaxed/simple;
	bh=igZrh4u9vdQ4zqYiM4MmlT4dMcCok9XZiK/MgRjMLZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvOa+Hqtp9dyconC/uEg/gBGpmR2IHaSsoZuSxtDWO5ifXDwoPegpMG6T2+NlVNcYfJ21Lgj6SYgJqWOxFoLoDQphOfRjehTP8R9tfUwq6OE4siw1mmFKwk7dK4mA5gnFHRQ+AewFCuZYZ0n65w5GBKEk5sthPB8z3sRNpi86qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 4 Jul
 2024 21:08:27 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 4/5] tools/rctest: limit the maximum possible data_size
Date: Thu, 4 Jul 2024 21:07:49 +0300
Message-ID: <20240704180752.94264-5-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704180752.94264-1-r.smirnov@omp.ru>
References: <20240704180752.94264-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/04/2024 17:50:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186337 [Jul 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.187.157 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.187.157 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;217.23.187.157:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.187.157
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/04/2024 17:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/4/2024 4:47:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to prevent the possibility of allocating
a large amount of memory.

Found with the SVACE static analysis tool.
---
 tools/rctest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index e39d313eb..b72be917c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -41,6 +41,8 @@
 #define SIOCGSTAMP_OLD SIOCGSTAMP
 #endif
 
+#define MAX_DATA_SIZE 0x40000000
+
 /* Test modes */
 enum {
 	SEND,
@@ -749,7 +751,8 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'b':
-			data_size = atoi(optarg);
+			if (optarg && atoi(optarg) < MAX_DATA_SIZE)
+				data_size = atoi(optarg);
 			break;
 
 		case 'i':
-- 
2.43.0

