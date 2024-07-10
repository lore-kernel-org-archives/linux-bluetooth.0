Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145D190489
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611172; cv=none; b=HbEkGhWsCVYQQgR/knICOyLB7HDmz7+rnwbhOkhOq3/iAm9tIHr1l0W5htbpUz3iVt4Sk5EbjhjG4q6Dp6L8LzZM08KgTmnMKEckGgZaIyKmhvzUmdIxOGgT3NCBbLjSjF5DsbRzBBXmcPhQmS8PzkkyX+2r2AhzTRjKXlEuheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611172; c=relaxed/simple;
	bh=bCdYLR8J8Hysl/lq5/LJ8/Q9PHPh+ksg0OuwtfWccsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYt4wYSoerHAuJVleJcgs0YqaWl2lbCeoiZmzXRZgW1qwOBNGHrLLizA3HaXK/MSen0kLma65g+Txq2dB7EA6AxE8MeGUR5ry87EEOuAS9JxcJJuh7w44OcBY9Pq7WBEWLtTku1vARFI9BDHy7yuAriyA4jj0JGE45VrvvX/OaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 14:32:22 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 resend 5/6] client/player: fix the order of args in cmd_register_endpoint()
Date: Wed, 10 Jul 2024 14:31:48 +0300
Message-ID: <20240710113151.49296-6-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186423 [Jul 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.55.202
X-KSE-AntiSpam-Info: Rate: 0
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

Based on the function prototype, ep->cid and ep->vid should be swapped.

Found with the SVACE static analysis tool.
---
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index de4491b53..2480ed64b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3388,7 +3388,7 @@ static void cmd_register_endpoint(int argc, char *argv[])
 
 	if (strrchr(argv[2], ':')) {
 		ep->codec = 0xff;
-		parse_vendor_codec(argv[2], &ep->cid, &ep->vid);
+		parse_vendor_codec(argv[2], &ep->vid, &ep->cid);
 		ep->preset = new0(struct preset, 1);
 		ep->preset->custom.name = strdup("custom");
 		ep->preset->default_preset = &ep->preset->custom;
-- 
2.43.0

