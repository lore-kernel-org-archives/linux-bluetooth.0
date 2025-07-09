Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838352D3EFF
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068318; cv=none; b=QPFINVK4NnwG9BBysrGD+V0S6JWJ7+ellYy4bfpev+6fvOkz1+qwYjEsyFKmNOw7+dSKmcZ96ju31hsIaSy335Du1WFDKwwMg8or7Q15gV9WPGYlHDVBwn11V9U3g81B3V12O1r8k5aybO7zq9OCb7JcQ06Hf4Fp3/Djc5HkFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068318; c=relaxed/simple;
	bh=bcgJprEhdVrumqPpPJ2OFaadHUsNJo2wNxE9u0lnS10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhkVbphD7aV2LNVlu/AXBo1wxlNyI88hnwKITTj726V1Lhb+mxnZz4sntP0J3LIJW9hZOzSOC734tK2AaqFhJOdm2or3+oF9CllSqVAhW3PlI5QPIx2W5eIJrRCjP3qq5Q0Qwp21OJ/vL+piGJnf8fPiLuKjT14EBBn3b1kqJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 9 Jul
 2025 16:38:22 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v4 3/4] src/shared: add nullity checks
Date: Wed, 9 Jul 2025 16:36:21 +0300
Message-ID: <20250709133622.2819849-4-i.iskakov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709133622.2819849-1-i.iskakov@omp.ru>
References: <20250709133622.2819849-1-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/09/2025 13:27:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194682 [Jul 09 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;inp1wst013.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;81.22.207.138:7.1.2
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
X-KSE-Antiphishing-Bases: 07/09/2025 13:29:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2025 11:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Check util_iov_pull_mem where iov len is not verified
beforehand. Check vcp_get_vcs for NULL.
These changes are based on other usages where those
checks exist.
---
 src/shared/bap.c | 23 +++++++++++++++++++++++
 src/shared/vcp.c |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ba6f75ff2..8c186e6f1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -7568,6 +7568,11 @@ bool bt_bap_parse_base(uint8_t sid, struct iovec *iov,
 
 		codec = util_iov_pull_mem(iov, sizeof(*codec));
 
+		if (!codec) {
+			ret = false;
+			goto done;
+		}
+
 		util_debug(func, NULL, "Codec: ID %d CID 0x%2.2x VID 0x%2.2x",
 				codec->id, codec->cid, codec->vid);
 
@@ -7579,6 +7584,12 @@ bool bt_bap_parse_base(uint8_t sid, struct iovec *iov,
 		}
 
 		l2_cc.iov_base = util_iov_pull_mem(iov, l2_cc_len);
+
+		if (!l2_cc.iov_base) {
+			ret = false;
+			goto done;
+		}
+
 		l2_cc.iov_len = l2_cc_len;
 
 		/* Print Codec Specific Configuration */
@@ -7593,6 +7604,12 @@ bool bt_bap_parse_base(uint8_t sid, struct iovec *iov,
 		}
 
 		meta.iov_base = util_iov_pull_mem(iov, meta_len);
+
+		if (!meta.iov_base) {
+			ret = false;
+			goto done;
+		}
+
 		meta.iov_len = meta_len;
 
 		/* Print Metadata */
@@ -7623,6 +7640,12 @@ bool bt_bap_parse_base(uint8_t sid, struct iovec *iov,
 
 			l3_cc.iov_base = util_iov_pull_mem(iov,
 							l3_cc_len);
+
+			if (!l3_cc.iov_base) {
+				ret = false;
+				goto done;
+			}
+
 			l3_cc.iov_len = l3_cc_len;
 
 			/* Print Codec Specific Configuration */
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index e614ff61f..be002ad4c 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2934,6 +2934,9 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
 	struct bt_vcp *vcp = user_data;
 	struct bt_vcs *vcs = vcp_get_vcs(vcp);
 
+	if (!vcs)
+		return;
+
 	vcs->service = attr;
 
 	gatt_db_service_set_claimed(attr, true);
-- 
2.34.1

