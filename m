Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49161A2FD2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926129; cv=none; b=av93sP0za/KU/6qVGr17Fv6E8kN9Uhz2Tw37IAoAuTVmp8IZkkLnnH5QKqHNVz3j8c8jhnQAPaFSEuIEZxp7iGsoQuv5CcaYMNMEMe0nFmHiIcKRmjuzCz72BNYkxfk+K7Hgm5fAXtiznFwo+x1efAgyPpBHN09M6Lxcj9H6/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926129; c=relaxed/simple;
	bh=ggh4RevLOD+nVjLXmTNSL+zFMZCLecP+8WUt0Xi9iZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVy/58qYgO5//NL+76EDOggjnyACkeZkOKrv/yaySiYxf1CqDfXXvn2GarHHRAj0SMFyNW3OJxJwX3d0ipNcOhloN7zHgA98LrVNBeOwxjCSA/6gr0tgBLl39+vp8AYPyI6NeNUshSEU2nwRR0Xy0mCXqhzQQLy8ZqPFGv0Bf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jul
 2024 16:15:20 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to sock_io_read()
Date: Tue, 2 Jul 2024 16:15:06 +0300
Message-ID: <20240702131506.91493-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186278 [Jul 02 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	81.22.207.138:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst083.omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
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
 src/gatt-database.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5756eb9d1..8472aac59 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2598,6 +2598,11 @@ static bool sock_io_read(struct io *io, void *user_data)
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
 
+	if (fd < 0) {
+		error("io_get_fd() returned %d\n", fd);
+		return false;
+	}
+
 	bytes_read = read(fd, buf, sizeof(buf));
 	if (bytes_read <= 0)
 		return false;
-- 
2.34.1

