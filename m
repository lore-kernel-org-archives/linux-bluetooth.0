Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C8193447
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621037; cv=none; b=rSt2Y/+YdwPPvA4xatHI3qiGE4Au74o0Zy5yyiUXkwWGjQPzL8GmS7ORKWVj+Vn0yw7Vf2ZRPcqL/fIf8Drrd9WryA7RRG01P8EthstUEknUWWjQSfShfxSPCmbcrdP7EUOY4e3AusL0VU3Rh5tCtXwT4d06GHrJdnHhLZkqhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621037; c=relaxed/simple;
	bh=4V8zzM1uHfw+qm4QGRcGo2DbbLVhNLdCl+fuGevsxj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNPqzy/4EbowB/hyaju6oGqqwMa1T3WbfRjyHRzIGfrc+IcYuRchhnp61Jj6fg6ter5YKVpmtWwE5zxfh8IbIWbfrU62zsdU7AbEks94e0gp6rxX4oJ0hAWctYsDn9tKev5MBLaRVvhplc3yCIjawmvER+DWbF2a96RDfZiYDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 17:16:38 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v3 resend 3/6] client/player: add error code handling to transport_recv()
Date: Wed, 10 Jul 2024 17:16:16 +0300
Message-ID: <20240710141621.64394-4-r.smirnov@omp.ru>
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

It is necessary to add return value check as in sock_send().

Found with the SVACE static analysis tool.
---
 V1 -> V2: the name of the patch has been shortened
 client/player.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 584fc5e81..de4491b53 100644
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
2.43.0

