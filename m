Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFAD1EEF8
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841583; cv=none; b=IzwPtZ4J8bUoHUf0VvMPMQ7VGs+y1S/6DWOKyKvXf+4wGl9GTlGI4zbDit18vv76NmBXYjirbY4MKyWv7Sw6ytcy9vX+D5YCGwTBp9R7Z/k6VTQt+0qegVEae0JUw5mdv+PF7MPytjKEOSFJi11gmFblbmx9UhJ6OdMWXGXIUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841583; c=relaxed/simple;
	bh=MJoWyrFP4p4vwY7z7tmq87iUFxiltsAq8UuB6jk2D4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fla/0ALseo1ccEOK8XO1vyISV4cbiqYqURDZtZodP0JznbCIXZqjgDI7t6Xyen5+lPvkXweoKR3P4BY8AQlo26IYJe5lLp+mgcU94Pw4YxOANnm+UFLiC2dcC9+0S+2443RCaqmtmpHiHXDo6d+V+A0rjRam0POJYFUiwzGQiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 1 Jul
 2024 16:46:02 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] shared/shell: add a check for NULL in bt_shell_init()
Date: Mon, 1 Jul 2024 16:44:01 +0300
Message-ID: <20240701134401.205121-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/01/2024 13:28:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186242 [Jul 01 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;inp1wst083.omp.ru:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/01/2024 13:33:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/1/2024 11:16:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The opt variable is checked for NULL at the beginning of
the function. It is necessary to add a check to prevent null
pointer dereferencing.

Found with the SVACE static analysis tool.
---
 src/shared/shell.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f3f7bab9a..2ecc41bf3 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1328,13 +1328,15 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 				}
 			}
 
-			if (c != opt->options[index - offset].val) {
-				usage(argc, argv, opt);
-				exit(EXIT_SUCCESS);
-				return;
-			}
+			if (opt) {
+				if (c != opt->options[index - offset].val) {
+					usage(argc, argv, opt);
+					exit(EXIT_SUCCESS);
+					return;
+				}
 
-			*opt->optarg[index - offset] = optarg ? : "";
+				*opt->optarg[index - offset] = optarg ? : "";
+			}
 		}
 
 		index = -1;
-- 
2.34.1

