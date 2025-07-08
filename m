Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676322D8DAA
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973091; cv=none; b=H2lkTfCJb+rDE0v8etgGu9rF2R2zVv+mV0rsxrdMTgUrreCI9bV8HDV5MARbWhiiLYtAd0E01PUkWa0dNOvA0p3MeCqOYO2WZ4MHH2fdlFBTNKrngIY78JN1kVfOZm83cggnTP5S/BZSdV6hWS3GV/+16x1amwYycdT7vtb5ZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973091; c=relaxed/simple;
	bh=vii4Bx7f7q+RMKyTaKqaL7WF6V6Hk8j/GYxR3TtM6pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBYbnw2klFVZgMA4a1HTvgHDCwSNzTIR6hLGW28VfRru5w6bzC0k6ZNw4VdB3gAVQVKQFmdo9QZnR1wrZH4Ssx/Sqrnx9qDo+0oOdlQpoItLegnYDGdgjbJtlSGmO6/OccolUb/+jX8ERD5CyB24v1e606l8TjZnfmG5BUSdjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 8 Jul
 2025 14:11:16 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v2 07/11] src/shared: fix memleak
Date: Tue, 8 Jul 2025 14:09:05 +0300
Message-ID: <20250708110909.2626286-8-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194611 [Jul 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst013.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
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

---
 src/shared/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a866f4cdc..96fca595b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6910,14 +6910,15 @@ static void add_new_subgroup(struct bt_base *base,
 			struct bt_bap_stream *stream)
 {
 	struct bt_bap_pac *lpac = stream->lpac;
-	struct bt_subgroup *sgrp = new0(
-				struct bt_subgroup, 1);
+	struct bt_subgroup *sgrp;
 	uint16_t cid = 0;
 	uint16_t vid = 0;
 
 	if (!lpac)
 		return;
 
+	sgrp = new0(struct bt_subgroup, 1);
+
 	bt_bap_pac_get_vendor_codec(lpac, &sgrp->codec.id, &cid,
 			&vid, NULL, NULL);
 	sgrp->codec.cid = cid;
-- 
2.34.1

