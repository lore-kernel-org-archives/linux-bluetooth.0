Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2B16C6BD
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923264; cv=none; b=PC5YzQaqcx2jOniYOC3KXDAvOOPlH4ydKPssSyKRvmE4ObF9oS51U11IPnC3Qr7LKSrYF9P5+PFSqdleDIi07fg52bHvsnZoO8SW3V9s87/1jEzExoSA/a4Xqui3Vt9U7JQ80Tezo7TuZ2zW5/qi/un7puRWug0gb0O2AC+UaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923264; c=relaxed/simple;
	bh=7Z0V1HzokElE64Dh9UQXrgPDMoSrV+52tHoI+nH9FFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eu5DQSy/s4rSDNpNGJJNygz9AFZ/mzim1NF7ORxq4EoyEfD2PREL0P9kkcj2jCeXl6PtjkJSB/ec6LhK17hWkgJjt/C+pJPRp9JfKzbXPNweenkW8KBUq6wP7I0j7PY8fcuQx4n1kjdvenRnJ0CVdfSIvEjdO7E3OpLGYA5jspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jul
 2024 15:27:29 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] client/player: add return value check of io_get_fd() to transport_timer_read()
Date: Tue, 2 Jul 2024 15:27:17 +0300
Message-ID: <20240702122717.77746-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/02/2024 11:48:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186277 [Jul 02 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	81.22.207.138:7.1.2;127.0.0.199:7.1.2;inp1wst083.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 07/02/2024 11:53:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/2/2024 10:33:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to add a return value check.

Found with the SVACE static analysis tool.
---
 client/player.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/client/player.c b/client/player.c
index 7a7598c39..0d031e4b0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5016,6 +5016,11 @@ static bool transport_timer_read(struct io *io, void *user_data)
 		return false;
 
 	fd = io_get_fd(io);
+	if (fd < 0) {
+		bt_shell_printf("io_get_fd() returned %d\n", fd);
+		return false;
+	}
+
 	ret = read(fd, &exp, sizeof(exp));
 	if (ret < 0) {
 		bt_shell_printf("Failed to read: %s (%d)\n", strerror(errno),
-- 
2.34.1

