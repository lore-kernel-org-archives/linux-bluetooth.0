Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB715533B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924746; cv=none; b=IwhiWRdCyoiAoI8tGYHI6ezoX/Z2zn/52GTGmzMChnpuR0HNRlq/Qm4T2ZCib+/JjsbyRxNrrIsyH4gMnJxATLZwliA6+3rZi/VtrvM+kyayZ8W7mBvDvD0+ckWW2wI6Ug09Vb4W7KbsF7xqMcP7ld96zGzJr3RhpjQNThpkHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924746; c=relaxed/simple;
	bh=Jhx5fWFpqveJHTIACqPpFaywHxXI4yl3xco9skaErbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egc2JJr6pYE/0kR/6yVVauKmsayoMMS+JDWX8Zees2fElTXslKR/fAgv2SLBaxC+oX0KVzwvkPtOZZ9A+ZfYS3O97ewjsPyIuBkVMeUJwGBUVhKyB2SMVTO19GjpWG2jw53gvIZbM8YieDYgIAmWLnQmW/SD0DdyC+g00bOmGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jul
 2024 15:52:11 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] core/gatt: add return value check of io_get_fd() to sock_read()
Date: Tue, 2 Jul 2024 15:51:57 +0300
Message-ID: <20240702125157.87719-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/02/2024 12:13:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186278 [Jul 02 2024]
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
	81.22.207.138:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst083.omp.ru:7.1.1;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 07/02/2024 12:17:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/2/2024 10:33:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to add a return value check.

Found with the SVACE static analysis tool.
---
 src/gatt-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 60a21e3f6..8d83a9577 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1127,6 +1127,11 @@ static bool sock_read(struct io *io, void *user_data)
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
 
+	if (fd < 0) {
+		error("io_get_fd() returned %d\n", fd);
+		return false;
+	}
+
 	bytes_read = recvmsg(fd, &msg, MSG_DONTWAIT);
 	if (bytes_read < 0) {
 		error("recvmsg: %s", strerror(errno));
-- 
2.34.1

