Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FC2E64A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578241; cv=none; b=jotZVytILvbeB102llJ7WFgd6Wp3uW90EoAjyFC/Ehvu13wxZQFEKh0BIvFfqKzCsXNcwStrFYyR7kQPiQ70ui9v4i+SHT+zUmeLA8H8AqvlXWEDyDOi9FdP90QPTvmwkcXqDhTh1gl9FEnHyG5cu2Qp6eVIQwL8tDJW76s0b8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578241; c=relaxed/simple;
	bh=FFH2+X6LvC0Ta3p3MOvwGEfVKeutVYssnhwPnIsXPn4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HryWWTxuWHNrNEjsRCy8hICOnT6wSgkECZdVAj7TOD4VcEVRqfrVxp21XZU49MSITdhhGNJ81h+kJahGyeKMUWDzpvwqczUecYUYuvZ29SEMLFykAanFDvtfXlgUxJNyAAoqqaf9a0ua4YwP/x0RFkRCZbXcmcckEKXx15Q2SLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 15:37:02 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] mcp: replace sprintf() with snprintf() in cb_track_duration()
Date: Fri, 28 Jun 2024 15:36:46 +0300
Message-ID: <20240628123647.547516-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/28/2024 12:24:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186209 [Jun 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2024 12:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2024 11:03:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Use snprintf() instead of sprintf() to avoid buffer overflow.

Found with the SVACE static analysis tool
---
 profiles/audio/mcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 8d1b7588e..0a2991f20 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -169,7 +169,7 @@ static void cb_track_duration(struct bt_mcp *mcp, int32_t duration)
 	unsigned char buf[10];
 
 	/* MCP defines duration is int32 but api takes it as uint32 */
-	sprintf((char *)buf, "%d", duration);
+	snprintf((char *)buf, 10, "%d", duration);
 	media_player_set_metadata(mp, NULL, "Duration", buf, sizeof(buf));
 	media_player_metadata_changed(mp);
 }
-- 
2.43.0

