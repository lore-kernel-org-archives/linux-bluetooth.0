Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2720CCD3
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303730; cv=none; b=SgndOmDCRryQxruEvJeRj5y5HhkttiTAPEW00yxKTiST9QQBvCo3WDfhUt6J3hBafxKkRAd6mJkgAIGd0otEooAifKJizCKypj93pGWrEjT8CLBrd0EmXqUQ+WLD2VcwVS7oQS61dioRX++YEdXZ6AqcLLJ/bC9utNRxspzP6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303730; c=relaxed/simple;
	bh=Pj7rgoPbkOzJOD5T8bJM8D0qbYzJN/lJiBI+7Hr4SJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcaRQ6sn1VNBAVsbfoq9yqMY7G1JCxjsw1o7g5EMGBDSR8FDHv1mnAMJNyMQKzNfGEp7UrhWnO5C+hLSiDgsWmDw/i2Vc4xs2NWQZuZxfM4wrPpjOCvoY4m++vOQQezsLkAei54eb3Wc8b3cUvDKV03aUiRauMWaVFnK179ImKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 18 Mar
 2025 16:15:03 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ 2/3] client: replace validate_input() with argsisutf8()
Date: Tue, 18 Mar 2025 16:14:30 +0300
Message-ID: <20250318131431.124750-3-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318131431.124750-1-r.smirnov@omp.ru>
References: <20250318131431.124750-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/18/2025 12:50:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 191886 [Mar 18 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;inp1wst083.omp.ru:7.1.1;81.22.207.138:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/18/2025 12:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/18/2025 10:14:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

argsisutf8() does the same thing as validate_input(), but can
be used elsewhere.
---
 client/main.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/client/main.c b/client/main.c
index 1daa3d480..6039aa50c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -843,18 +843,6 @@ static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
 	return FALSE;
 }
 
-static int validate_input(int argc, char *argv[])
-{
-	for (int i = 0; i < argc; i++) {
-		if (!strisutf8(argv[i], strlen(argv[i]))) {
-			printf("Invalid character in string: %s\n", argv[i]);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static void cmd_list(int argc, char *argv[])
 {
 	GList *list;
@@ -3405,9 +3393,8 @@ int main(int argc, char *argv[])
 	int timeout;
 	unsigned int timeout_id;
 
-	status = validate_input(argc, argv);
-	if (status)
-		return status;
+	if (!argsisutf8(argc, argv))
+		return -EINVAL;
 
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
-- 
2.34.1

