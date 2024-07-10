Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C3190664
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611154; cv=none; b=mEiZYJ6q9nXQq5Z/B+czuJjbrdNuPR3URBDHBEy1G8eh9WtsOV+oCZf7waNSRshKN/KvgogvvYsc/PI02oRZk0p4CFUED3PBSSv9j181zQ6Iv0DvBDzenTELMmKtTtALM5Wv/5z/30bY/wk0XpD6CPHTgSxaI6hkqmat8U5VrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611154; c=relaxed/simple;
	bh=ZUal7Dmru+8BeMaCZge5OT7C7i3k3y28LrIIn8kyn+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shYPrTOlhheSkHMUcia99Jyqy8f2NpvQ8xnZOmafBrJkmIQLiAmjR4IGkfeMMtTOHCyU8czMtrFiR45Yk/mfxJEzviS/ettZHILWEfItSarG0MnpzELuJfvKvUXXV2Nic1UGLlGjygM6ZhMQJWDrNJAYI1bjMCdI8PdscUlMZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 14:32:16 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 resend 1/6] gatt: add return value check of io_get_fd() to sock_io_send()
Date: Wed, 10 Jul 2024 14:31:44 +0300
Message-ID: <20240710113151.49296-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710113151.49296-1-r.smirnov@omp.ru>
References: <20240710113151.49296-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/10/2024 11:06:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186423 [Jul 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.205.55.202 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.55.202
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/10/2024 11:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/10/2024 9:01:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to add a return value check.

Found with the SVACE static analysis tool.
---
 src/gatt-database.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 8472aac59..6c84b085c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2630,6 +2630,7 @@ static int sock_io_send(struct io *io, const void *data, size_t len)
 {
 	struct msghdr msg;
 	struct iovec iov;
+	int fd;
 
 	iov.iov_base = (void *) data;
 	iov.iov_len = len;
@@ -2638,7 +2639,13 @@ static int sock_io_send(struct io *io, const void *data, size_t len)
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
 
-	return sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
+	fd = io_get_fd(io);
+	if (fd < 0) {
+		error("io_get_fd() returned %d\n", fd);
+		return fd;
+	}
+
+	return sendmsg(fd, &msg, MSG_NOSIGNAL);
 }
 
 static void att_disconnect_cb(int err, void *user_data)
-- 
2.43.0

