Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9319149A
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621022; cv=none; b=CNVeKa6EIUDpEnOABOtohOJaaZdpYMwQWgOV/HX+b0VReQeuGbc80YXBX9z+5wBDdeYMryVzPTpOMdeaLr0UUAySoeJzqWUo9YQD4dpJPILu4d/X9kAC6h4ZX+mH9TVYo4yuOA5/Kss+NeC5Pj8sl4jtF3nXf3ngRj09FPvXk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621022; c=relaxed/simple;
	bh=X2qylBZT9BN9u2EfJAE1ZxkzNPzM0HpM48nU9tgCGco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arfMH1tGrhROAHDqghxnD3SAZFaHpEM9bDi2ECm7tuYTvO408UI6bgTJI9OrCQTLqEZyoYP9vGCdT7i50x8acsDZctt8AVKorXsDQPRVE/LzAOhESK4zKsXcJ/zWwVYBzeKjrCdnuHRlI9qLP4CUFnyIoZmKiWJ1q8T9w+mtyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 17:16:36 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v3 resend 1/6] gatt: add a check to sock_io_send()
Date: Wed, 10 Jul 2024 17:16:14 +0300
Message-ID: <20240710141621.64394-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710141621.64394-1-r.smirnov@omp.ru>
References: <20240710141621.64394-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/10/2024 13:54:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186438 [Jul 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.55.202
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/10/2024 14:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/10/2024 12:34:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to add a return value check.

Found with the SVACE static analysis tool.
---
 V1 -> V3: the patch name has been shortened
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

