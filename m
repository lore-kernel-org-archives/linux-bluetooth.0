Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964618C31
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587098; cv=none; b=DPISHXZ7GrV8YAcKAWS9rXUwXQ3x2w8a8MNu5FdOatTd9bW9UsULfkSCOMob/rc2CMVAuLvBokYYMz2OgD0/wITLc6pNjTMuWR1dJ9XEYSNQxe23Q5jxUlxGxik33KI8OwvDzWBqvRcmoOGxfAi4NVNen8D6TvzgopznjslC2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587098; c=relaxed/simple;
	bh=dwrDTtAcIH94ba3oHAsaKT2gNaI0wcYuD02Rdx13ktQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mLwDlq3RxFYKVWX9tWOg8r8C6nUJkUuwTNYsHhYyaCL+DTrLy9J8hWb6Fc9yD3kwl0Cafru7QX142m2ZznZy75hoLcU6YfY94ddDRx5x050WwEcUnwK10YCoMigxYHDxURbh8lH+01YNjzIn3G8lXsP5azRkHkfFL0gah3cOXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 18:04:44 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] avdtp: add NULL check to avdtp_has_stream()
Date: Fri, 28 Jun 2024 18:04:12 +0300
Message-ID: <20240628150418.563987-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/28/2024 14:06:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186212 [Jun 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2024 14:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2024 1:26:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Make avdtp_has_stream() safe for passing NULL pointers.

Found with the SVACE static analysis tool.
---
 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 3667e0840..913298319 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3918,6 +3918,9 @@ struct btd_device *avdtp_get_device(struct avdtp *session)
 
 gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 {
+	if (!session)
+		return FALSE;
+
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
 }
 
-- 
2.43.0

