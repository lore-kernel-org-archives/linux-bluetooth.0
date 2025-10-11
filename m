Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020013F9D2
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760208369; cv=pass; b=Aiev/Z0mMsHw9/4kymeezhUsr03mLI016ldzS+G3JHzAYBVAQObAD+2d40Cx8ChaHCoZ3VuycngYsFbPxJKivtMLMe0rkTQgCT+LKz3qPhy5+bINOvdDHB/YXt4s+V6ftGjT8yAQ76NJ7rTkrVARDgSh998rDD2HzhyCjAsfKK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760208369; c=relaxed/simple;
	bh=53pF6S9AmCFFJAy0i2PFnZVrgEtSg8R8owqgHny5YYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnvnaL6+LCLVB+iST5bs8PieEqf4WRtS6dZDyHMNi2VKq58OdBo4+u+xVjfpMEiCZd5cIGkSOgHeu/OSlEkE4ae9/osM6aUBZSCw4Qaz6aZVwxBdK19rBQ4LmKhE5O3pTvDeuyFVkxy8QHoEytFKakVq3zmquxp5BldWZhIr7B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=H3e1Nraw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="H3e1Nraw"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ckXcZ0fTkzyS6;
	Sat, 11 Oct 2025 21:45:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760208350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yORy6aYtnGioqsgG8lzty9ms88d6mbIEvaEnlL8qQXI=;
	b=H3e1NrawjZDX73WSWnHRSbiKzC0YhesTBR7mk2Fx19C6p9OK9Lu5exfBbByZahYCF91dPF
	frrTqpRl9QpRCTSFYsXEzgTo6uBZAjABjifvnGI1UQ9OWwP0ZsmfDH3MnDu64ZHi+koZEJ
	90uXMbHptumvSEmfgQEVvDtuykFmonc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760208350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yORy6aYtnGioqsgG8lzty9ms88d6mbIEvaEnlL8qQXI=;
	b=SMAtPwAJEOEX+UcQuXFIFayw0IjUWyQsgo1J92xG2+FYUiZvCEznBWhunnzgJKYzB03uGe
	C4hg3Y1yqGIFtWwewcqoVq9tavuk44aOoeHZBqKE2Q97toOHsrzf6VywPcJ07JdKfgFwKu
	UOSG3CSd/IbrlvfLtrZ20YbDMOqNYfQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760208350; a=rsa-sha256; cv=none;
	b=xY8M5uxqutiBP+BGvrpz00uRHrJOUrOaBHMcuVVdKYGNqI/v3umU7MchnwVxdFrIz73HrA
	c+Ju7Ej7rH3HsxRp3aKruvfimGveWuMDJYtPqefNMTKcADja4RkbdTsvTNmISib7GOqPk9
	pTZMewn3U8t/T6mA43arewxttOdcuuQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: check pac cc and metadata length before use
Date: Sat, 11 Oct 2025 21:45:45 +0300
Message-ID: <6fc999ce7a1a375d52171f7934dbfff0335baba7.1760208260.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't read past buffer end if device provided bogus values for PAC
caps/metadata lengths.

Use iov pull properly, and also check metadata LTV validity.
---
 src/shared/bap.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9b7395223..710b89984 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4708,7 +4708,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 	for (i = 0; i < rsp->num_pac; i++) {
 		struct bt_bap_pac *pac;
 		struct bt_pac *p;
-		struct bt_ltv *cc;
+		struct bt_ltv *cc, *m;
 		struct bt_pac_metadata *meta;
 		struct iovec data, metadata;
 
@@ -4725,29 +4725,41 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 
 		pac = NULL;
 
-		if (!bt_bap_debug_caps(iov.iov_base, p->cc_len, bap->debug_func,
-					bap->debug_data))
-			return;
-
 		cc = util_iov_pull_mem(&iov, p->cc_len);
 		if (!cc) {
 			DBG(bap, "Unable to parse PAC codec capabilities");
 			return;
 		}
 
+		if (!bt_bap_debug_caps(cc, p->cc_len, bap->debug_func,
+					bap->debug_data)) {
+			DBG(bap, "Invalid PAC codec capabilities LTV");
+			return;
+		}
+
 		meta = util_iov_pull_mem(&iov, sizeof(*meta));
 		if (!meta) {
 			DBG(bap, "Unable to parse PAC metadata");
 			return;
 		}
 
+		m = util_iov_pull_mem(&iov, meta->len);
+		if (!m) {
+			DBG(bap, "Unable to parse PAC metadata");
+			return;
+		}
+
+		if (!bt_bap_debug_metadata(meta->data, meta->len,
+					bap->debug_func, bap->debug_data)) {
+			DBG(bap, "Invalid PAC metadata LTV");
+			return;
+		}
+
 		data.iov_len = p->cc_len;
 		data.iov_base = cc;
 
 		metadata.iov_len = meta->len;
-		metadata.iov_base = meta->data;
-
-		util_iov_pull_mem(&iov, meta->len);
+		metadata.iov_base = m;
 
 		DBG(bap, "PAC #%u: type %u codec 0x%02x cc_len %u meta_len %u",
 			i, type, p->codec.id, p->cc_len, meta->len);
-- 
2.51.0

