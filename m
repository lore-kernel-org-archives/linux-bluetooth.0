Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E201991B9
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220615; cv=none; b=uDYIzbIC4dHhCyv0j7RBYeYilKF/ItiUBwxoOf0PiXASx8RIfV5/NE4BbsnTSpm7WoB8AFt5wh9N6KCgnHGIRFlhU35ROYQtFB/F9qkHJHtLiHgapoUMleigtCpuPHmz1cXgRl/O7qtDr2FODLGieoGhU0LQDgTyw9BkZqrylm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220615; c=relaxed/simple;
	bh=tAn8KcDWKi/HaXKYargqnpBpgd+bpu/ghQBoF6wcm+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGrWEM9lWgsmVJf3MeS/7spkBnawgg8Uew4uP27LUcFzx7M/5xJM5tbL9mqcd8hBX7006A39iI0MvbkjKLQFliFo+O0h1yEUwwRHMg/cYB3By4EGz+nP9EZ5dOpCS03RrsRy9DLUKR7AfRITWtAavKcqG4AP9V0hj+wwKD0kmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.186.16) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 9 Aug
 2024 19:23:13 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 3/3] android/avdtp: fix leak in avdtp_new()
Date: Fri, 9 Aug 2024 19:22:29 +0300
Message-ID: <20240809162252.50098-4-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809162252.50098-1-r.smirnov@omp.ru>
References: <20240809162252.50098-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/09/2024 16:04:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186979 [Aug 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.186.16
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2024 16:08:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/9/2024 2:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to close the file descriptor in case of an error.

Found with the SVACE static analysis tool.
---
 android/avdtp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index a261a8e5f..e0466853b 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2130,8 +2130,10 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version,
 		return NULL;
 	}
 
-	if (set_priority(new_fd, 6) < 0)
+	if (set_priority(new_fd, 6) < 0) {
+		close(new_fd);
 		return NULL;
+	}
 
 	session = g_new0(struct avdtp, 1);
 	session->io = g_io_channel_unix_new(new_fd);
-- 
2.43.0

