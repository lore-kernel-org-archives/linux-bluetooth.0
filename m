Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9E188CDE
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033262; cv=none; b=WE7RKidDYPLa74jAeYbxx7sZICLxsGNKrKWjJw5Lb0WqTMEkYSVl4W/lNVo+EamfkOEbFNicTbVK/eixzlGG2vEiWbV/kiIKKJNOhUzcZcirZjxJEClOySTB6VkUg0KQlA1LU60O6kx+VOY2P/CkAmbP6B9RZwLramZTQinPyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033262; c=relaxed/simple;
	bh=+wtW5IniC9T4879GZDggnTQ0aE2kkfL8axL0g2O4hZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uEcL1+c3MaHVjsphVDaHpwypWlRSYpTkmGt/2PyMfF0vLLOSh+L3we7ne90mDIt7a5RdmnyN7DUtSYUHqRpZ+B7W7Gyhml2zmTVcfSypvJfLXyth1CT1xMrLDJRv55h9bj+WSEWYlhIuSOoO+EyvbDWUKWERkQozd+3wiW6CXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 15 Jul
 2024 11:47:16 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] tools/rctest: add NULL checks to main()
Date: Mon, 15 Jul 2024 11:47:01 +0300
Message-ID: <20240715084701.42478-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/15/2024 08:35:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186517 [Jul 15 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	inp1wst083.omp.ru:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 07/15/2024 08:40:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/15/2024 7:25:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to prevent dereferencing of a NULL pointer.

Found with the SVACE static analysis tool.
---
 tools/rctest.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index b72be917c..367e41e3c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -742,6 +742,9 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'a':
+			if (!optarg)
+				break;
+
 			mode = AUTO;
 
 			if (!strncasecmp(optarg, "hci", 3))
@@ -756,6 +759,9 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'i':
+			if (!optarg)
+				break;
+
 			if (!strncasecmp(optarg, "hci", 3))
 				hci_devba(atoi(optarg + 3), &bdaddr);
 			else
@@ -763,10 +769,14 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'P':
-			channel = atoi(optarg);
+			if (optarg)
+				channel = atoi(optarg);
 			break;
 
 		case 'U':
+			if (!optarg)
+				break;
+
 			if (!strcasecmp(optarg, "spp"))
 				uuid = SERIAL_PORT_SVCLASS_ID;
 			else if (!strncasecmp(optarg, "0x", 2))
@@ -792,11 +802,13 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'L':
-			linger = atoi(optarg);
+			if (optarg)
+				linger = atoi(optarg);
 			break;
 
 		case 'W':
-			defer_setup = atoi(optarg);
+			if (optarg)
+				defer_setup = atoi(optarg);
 			break;
 
 		case 'B':
@@ -808,19 +820,23 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'N':
-			num_frames = atoi(optarg);
+			if (optarg)
+				num_frames = atoi(optarg);
 			break;
 
 		case 'C':
-			count = atoi(optarg);
+			if (optarg)
+				count = atoi(optarg);
 			break;
 
 		case 'D':
-			delay = atoi(optarg) * 1000;
+			if (optarg)
+				delay = atoi(optarg) * 1000;
 			break;
 
 		case 'Y':
-			priority = atoi(optarg);
+			if (optarg)
+				priority = atoi(optarg);
 			break;
 
 		case 'T':
-- 
2.34.1

