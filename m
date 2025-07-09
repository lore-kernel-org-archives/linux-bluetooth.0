Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9692DA747
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063669; cv=none; b=HD1EiaMY8tzz2VjPXAX/AC49X9Bl0H8UY7240Ia0upPV31GGXvko1ia98J1FoRv2460VlOhxcyTYlHcYfbhe4tfgSE4KaeOn7CqmiY+H6g8lsdaKoSVQsA6YFabIRd3TVLSEuOZAku604+y3V/Lbj3H+AMRZucLEzDoMCpWC6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063669; c=relaxed/simple;
	bh=D5EUCKt2Bvf5eiaGBbyMqM+CBiV5xqjtrexw2B3AJD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raEDpRS+r0gjuqgQQOIkcfxAIOshuAuTj6iqzl/8JqLyIAhZ9TkTOYBW4h0QPVL6+ed3bQglcrYRG7wkTZ9/8v+43UA54IPkDrvtnIAEFrLp+Xy5cJNIM9AvtVJQeQohFVf6qx1JwmOeEk+zn1s1don3/C2OSfo40xJp+7N40js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 9 Jul
 2025 15:21:00 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v3 4/4] obexd/client: fix err condition causing memleak
Date: Wed, 9 Jul 2025 15:18:52 +0300
Message-ID: <20250709121852.2811885-5-i.iskakov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709121852.2811885-1-i.iskakov@omp.ru>
References: <20250709121852.2811885-1-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/09/2025 12:13:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194672 [Jul 09 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;omp.ru:7.1.1;127.0.0.199:7.1.2;inp1wst013.omp.ru:7.1.1
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/09/2025 12:15:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2025 11:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

transfer_open returns 0 if an error occurs, condition corrected.
---
 obexd/client/transfer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index a7d00896f..d8ecb60d3 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -556,7 +556,7 @@ struct obc_transfer *obc_transfer_get(const char *type, const char *name,
 	transfer = obc_transfer_create(G_OBEX_OP_GET, filename, name, type);
 
 	perr = transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600, err);
-	if (perr < 0) {
+	if (!perr) {
 		obc_transfer_free(transfer);
 		return NULL;
 	}
-- 
2.34.1

