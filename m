Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE928DB53
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427591; cv=none; b=aKhzRhQSvKefJWSVcNpw6NbNVqvhseyQQXcBzDlKmMDYA3ZmBxeK0k6wq0WspZvAcQDJ38f+YRBxtMghf71CRo6kN93kDJGcAs823vIlqnwr0LgRzFndc9xdJeYz/O1/VrUlzJ2Nmd2FNToZVAKwpIO1hotJ0EQDNDmp8Vza3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427591; c=relaxed/simple;
	bh=V8zxYI7eYS3imxzFqbwBMBqW1QzL629MWsiTQxd6AyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJGVNgO6U/gEmHbsnzNMUkou8zdwhHBP921nTolJrF+bY+sRjeU6gPejBCou8I0/NnAqJZH3qxmFJlMTFpDfqbl1a0TVvbDMRu8UnHE3L4nympQPrj13fz0VFhC0dMgPyZFaT4oHAo2TYZ2F3rY1pZwKnSeivgTUJlbZlKaV1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst087.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 20 Jun
 2025 16:52:49 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ v2 1/4] shared/bap: ignore NULL attach/detach callbacks
Date: Fri, 20 Jun 2025 16:51:43 +0300
Message-ID: <20250620135146.243585-2-k.samburskiy@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620135146.243585-1-k.samburskiy@omp.ru>
References: <20250620135146.243585-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/20/2025 13:44:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194234 [Jun 20 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	inp1wst087.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/20/2025 13:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/20/2025 9:37:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Allow registering NULL attach/detach callbacks with bt_bap_register
for cases when one of callbacks is not needed, e.g. in tests.
---
 src/shared/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f0c6f6485..76340d565 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4415,6 +4415,9 @@ static void bap_detached(void *data, void *user_data)
 	struct bt_bap_cb *cb = data;
 	struct bt_bap *bap = user_data;
 
+	if (!cb->detached)
+		return;
+
 	cb->detached(bap, cb->user_data);
 }
 
@@ -4499,6 +4502,9 @@ static void bap_attached(void *data, void *user_data)
 	struct bt_bap_cb *cb = data;
 	struct bt_bap *bap = user_data;
 
+	if (!cb->attached)
+		return;
+
 	cb->attached(bap, cb->user_data);
 }
 
-- 
2.34.1

