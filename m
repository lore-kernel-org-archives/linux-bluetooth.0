Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5F1AAE13
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084114; cv=none; b=Ww5OWkRzCAa7bInCA06TU277Z2VoWpZTW0U6UD4mKP2lSE10DzUAmUm5IYMOkXLtDkhl/oLVTSCHoSyfyek4K2yrXkn3SGGZbrhoHY7RqrBlyZewFJBiA42Fd88SR3B1bnDr5N3UPeJB6nTCh+IDy+uVlxe2qkRQfM68A0DiC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084114; c=relaxed/simple;
	bh=/c7CEkmFqGVQZhkNfLm+JuaS2sTOodLQ0BydY6Xak14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYNA+XmnKe55xnGwKeeMUt4UztaVhGb87Qp5ysIZYtiLukdvo9mmsi9anAvNURQzTbq7D5KlxRa+QaSlP+asuK82ir4JE0FmtzwROugWuc6RN7S8zKwkUFZgaNHNrsLX19oYRE+rSV5gGD0XDolC9AdZkMxlGCNbaycIBjqbN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 4 Jul
 2024 12:08:20 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 2/3] client/player: fix the order of args in cmd_register_endpoint()
Date: Thu, 4 Jul 2024 12:07:53 +0300
Message-ID: <20240704090756.31351-3-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704090756.31351-1-r.smirnov@omp.ru>
References: <20240704090756.31351-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/04/2024 08:52:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186322 [Jul 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.187.157 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;217.23.187.157:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.187.157
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/04/2024 08:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/4/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Based on the function prototype, ep->cid and ep->vid should be swapped.

Found with the SVACE static analysis tool.
---
 V1 -> V2: the patch header is now shorter
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 0d031e4b0..2569b38e9 100644
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

