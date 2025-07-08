Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711F2D9780
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973073; cv=none; b=QGVRtJityPrO3o1wtVhtNPhDBB/H8+QRDs3+NnBxPLmgQKfc9cLVKhErWGDmuJndX1JkgcUjTV3AIQm3lH7Eo4n1QP2Hv/W1pg2aPL5KVcj1SwoacGVmNHgpZ3JPCro57PtjFL7CvVCIOKcbA8ocoKXQlunRJvcyMlSS9OmDL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973073; c=relaxed/simple;
	bh=h1Qli64YpS/amOApOqlajp0J4QB81dZVUvdDrOR8fWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbSPjavXZhD278o7i2vJUdNaqlTbu1Frln2WXQXbnsqoajp+zHYchLyq6V5ZTaQPkrEjEanYq307lYK3aRuPjxKXaEPj8aDADB5FawgA+CdLJ/9Q6e+rW++NDOWynRqUq+0zRGqPrte3x7FzSN0QQdOUwRftIW/5noOxtldWCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 8 Jul
 2025 14:10:59 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v2 01/11] btio: fix range validation of security level
Date: Tue, 8 Jul 2025 14:08:59 +0300
Message-ID: <20250708110909.2626286-2-i.iskakov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708110909.2626286-1-i.iskakov@omp.ru>
References: <20250708110909.2626286-1-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/08/2025 10:58:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194611 [Jul 08 2025]
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
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst013.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;81.22.207.138:7.1.2
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
X-KSE-Antiphishing-Bases: 07/08/2025 10:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2025 7:58:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Arrays inside l2cap_set_lm/rfcomm_set_lm functions are of size 4,
but the bounds check allows the value 4 for 'level'.
---
 btio/btio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index b8afe0580..14f2b700e 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -455,7 +455,7 @@ static gboolean set_sec_level(int sock, BtIOType type, int level, GError **err)
 	struct bt_security sec;
 	int ret;
 
-	if (level < BT_SECURITY_LOW || level > BT_SECURITY_FIPS) {
+	if (level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH) {
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Valid security level range is %d-%d",
 				BT_SECURITY_LOW, BT_SECURITY_HIGH);
-- 
2.34.1

