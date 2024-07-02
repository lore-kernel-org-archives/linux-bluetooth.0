Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA5BA2D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927692; cv=none; b=DKkBUgK17tE1KX+R+G7RjuOKXhztv4r4IZxiJpztrEioELzsj7DdB85wwTPkTyqDUDifivBX3GqIcItEVysVSKnSEKhSsv1Gdd/3Acujx2iXvBSOSrDBU1wSy6GmT464RtcZmTjukRFlN6Qr3oISGNgy3O32+83hNvqfibMiBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927692; c=relaxed/simple;
	bh=Juf2VwEoZGqB3Mlzp3Cjg2wFnTMGybwePYg/eK7FEpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WxtRDURI+ZUbFAawOf5Qd7EdeO9s381/XGPtXbFcD0iy+xSlGS9hRDlDcUTVJFbBkb9rp/mCJFS9/MzAcp8HXU21qqqMKCBZ3+siz+Jlp1g3uHcZY2S3Vsuu5B/4KW/tB7KqzuetVhchOi+jCXjZ8TsAGZlGbRcnVTJavvSSSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jul
 2024 16:41:22 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to sock_io_send()
Date: Tue, 2 Jul 2024 16:41:06 +0300
Message-ID: <20240702134106.102024-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/02/2024 13:13:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186281 [Jul 02 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	inp1wst083.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;81.22.207.138:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/02/2024 13:18:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/2/2024 10:33:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to add a return value check.

Found with the SVACE static analysis tool.
---
 src/gatt-database.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5756eb9d1..99aa6b63a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2625,6 +2625,7 @@ static int sock_io_send(struct io *io, const void *data, size_t len)
 {
 	struct msghdr msg;
 	struct iovec iov;
+	int fd;
 
 	iov.iov_base = (void *) data;
 	iov.iov_len = len;
@@ -2633,7 +2634,13 @@ static int sock_io_send(struct io *io, const void *data, size_t len)
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
2.34.1

