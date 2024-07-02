Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D675145B09
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921163; cv=none; b=g3wE9xWeb5jRhMQfnt4r7FTLFN8QvbF5hiktjUvcCthyHVuoBn9UcV5ydt20tpve6tTq2CIjamGIYrZMHIs+q9gBDNggzt+zBhcFKk/lIYEIjSy5QdxPaY/g4rpncEHokRbjrUAqiTvtyl1qwjqCssZUmBwi1sUS/Zec5DK2R90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921163; c=relaxed/simple;
	bh=2qnaxq74AAuSrxRHx5PRVfYWbemzV6gJFviaLVeBbRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vp0OK0zPG2DWCRhvwmRk/7eBUVifHxIdQXYtL9Iiz9GPiW+woa8yUnX1lCJzmV2lPXqoQ6DYxkD5mJyB1zpjtCU3EmkN38N4HWHRq3CilO5sWodTJ4Cobgu3V34Fuk0knXxIzf7mqzxp7IFD/MqJc14BTPHsB4yw2JNslnAYSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jul
 2024 14:52:26 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] client/player: add return value check of io_get_fd() to transport_recv()
Date: Tue, 2 Jul 2024 14:51:38 +0300
Message-ID: <20240702115138.70500-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/02/2024 10:58:38
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186275 [Jul 02 2024]
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
	127.0.0.199:7.1.2;inp1wst083.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 07/02/2024 11:03:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/2/2024 8:44:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to add return value check as in sock_send().

Found with the SVACE static analysis tool.
---
 client/player.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 7a7598c39..b1ebcaa37 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4514,7 +4514,13 @@ static bool transport_recv(struct io *io, void *user_data)
 	uint8_t buf[1024];
 	int ret, len;
 
-	ret = read(io_get_fd(io), buf, sizeof(buf));
+	ret = io_get_fd(io);
+	if (ret < 0) {
+		bt_shell_printf("io_get_fd() returned %d\n", ret);
+		return true;
+	}
+
+	ret = read(ret, buf, sizeof(buf));
 	if (ret < 0) {
 		bt_shell_printf("Failed to read: %s (%d)\n", strerror(errno),
 								-errno);
-- 
2.34.1

