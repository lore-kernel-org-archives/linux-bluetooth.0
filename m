Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275635CBC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973573; cv=pass; b=OhmwGcdVTxaG0srWH1h+CR2piMlLyOSxzwdVF7tgUvKX9BCKm2Qa4+BDwQcVryh/WlhDoPKjuecaerBOA/wuc6zyVePhAyCRWDGNBkSPxbtj7jrN8WYudxR3vgEeiklOn0elzDXEfH89x9jUESmp8n8sgPCBT6sSgmYPl7oU4dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973573; c=relaxed/simple;
	bh=6qDzjMV8FqAnppVkg4dKSEjLKlOPZARdyyi19vjy5GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2roTneOmBNxZGpm7afYVmculleIDs4pD6e2/OLwBdCHBi4UDKSjfPlCv33bf4SJPyFmN7ovGS4V5XvxnZn+PuTVSKg0VbsWffTyG1SAl/QaEayYKHlo6HSI78tjp7ASIa7uKbr7pP3J1twHS3YklArDKdPME6k+EBhQrjDMN1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qmVt/Bnm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qmVt/Bnm"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d6CFj4j7Tz103Q;
	Wed, 12 Nov 2025 20:52:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762973562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMy9+cEUJqQybauxigOGM9Xmw+umN38ziGKRcm4heKs=;
	b=qmVt/BnmVojD59TzS9EhswtJngYJ7NjEI/5BSmK7oXEkeNHiKUTlNrYe82TPYlQj05NBb0
	1S6H8vD109I4lJc9oHHxY9drNavXZzrPkdMgoFPNHSV9nkrfP4FQY8HRq1iMU0gZpuvXWJ
	IXoz1mBPxqfRKLuHDKjY3iVwdEkBJpg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1762973562;
	b=OUqnhi2FR2B3EBjeC+Kksfgb4bSmwe5zwoxpvAZHzYKZAzzc1JkUd3eeoH7R9/lG3pJueE
	Z4Ogg38fJ1yBaAtp6wNMf+M0baPXXHd6F/3fOsiQDrFiV2yp1oNe2fsG3oERtAu4+BIV1E
	V8FfB8tMpYAAOF/i/jiOs3QyTKfGNdw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762973562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMy9+cEUJqQybauxigOGM9Xmw+umN38ziGKRcm4heKs=;
	b=hzpYfofmihQl5xZptt2KHti16xFZ8/q9tWgIY5g2N8s/vY8jhib5ye/ped5q87Tb85rHf3
	Mvxb1dVLKDcMHAu5x/tIXnGomIEC50D3LbAcLVfN9UvYadwX0FUJ25yUIuea5ZCkr+CAM+
	/fIDKEmvmTFR2pNVapXsBaz1S7oNeQo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] test-bap: adjust macros for customizing remote audio locations
Date: Wed, 12 Nov 2025 20:52:36 +0200
Message-ID: <e0c9ea208e5bebefe168bcdc4bd3ae7ddfe15d07.1762973380.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
References: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arguments to customize audio locations, in the macros defining data
for remote PACS.
---
 unit/test-bap.c | 123 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 35 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index c15afe52d..b1d1a42f1 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -35,7 +35,6 @@
 #include "src/shared/lc3.h"
 
 struct test_config {
-	struct bt_bap_pac_qos pqos;
 	struct iovec cc;
 	struct iovec base;
 	struct bt_bap_qos qos;
@@ -933,16 +932,26 @@ static void test_teardown(const void *user_data)
  *       Front Left (0x00000001)
  *       Front Right (0x00000002)
  */
-#define DISC_SNK_PAC(_caps...) \
+
+#define IOV_CONTENT(data...) data
+
+#define DISC_SNK_PAC(_caps) \
 	IOV_DATA(0x0a, 0x03, 0x00), \
-	IOV_DATA(0x0b, 0x01, _caps), \
+	IOV_DATA(0x0b, 0x01, _caps)
+
+#define DISC_SNK_LOC(locations) \
 	IOV_DATA(0x0a, 0x06, 0x00), \
-	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
+	IOV_DATA(0x0b, locations & 0xff, (locations >> 8)  & 0xff, \
+		(locations >> 16) & 0xff, (locations >> 24) & 0xff)
+
+#define LC3_PAC_CAPS(ch_counts) \
+	0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
+	0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, ch_counts, 0x05, 0x04, \
+	0x1a, 0x00, 0xf0, 0x00, 0x00
 
 #define DISC_SNK_LC3 \
-	DISC_SNK_PAC(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SNK_PAC(LC3_PAC_CAPS(0x03)), \
+	DISC_SNK_LOC(0x00000003)
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0009 Type: Source PAC (0x2bcb)
@@ -981,17 +990,28 @@ static void test_teardown(const void *user_data)
  *       Front Left (0x00000001)
  *       Front Right (0x00000002)
  */
-#define DISC_SRC_PAC(_caps...) \
-	DISC_SNK_PAC(_caps), \
+#define DISC_SRC_PAC(_caps) \
 	IOV_DATA(0x0a, 0x09, 0x00), \
-	IOV_DATA(0x0b, 0x01, _caps), \
+	IOV_DATA(0x0b, 0x01, _caps)
+
+#define DISC_SRC_LOC(locations) \
 	IOV_DATA(0x0a, 0x0c, 0x00), \
-	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
+	IOV_DATA(0x0b, locations & 0xff, (locations >> 8) & 0xff, \
+		(locations >> 16) & 0xff, (locations >> 24) & 0xff)
+
+#define DISC_PACS(snk_locations, src_locations, snk_caps, src_caps) \
+	DISC_SNK_PAC(IOV_CONTENT(snk_caps)), \
+	DISC_SNK_LOC(snk_locations), \
+	DISC_SRC_PAC(IOV_CONTENT(src_caps)),	\
+	DISC_SRC_LOC(src_locations)
+
+#define DISC_PACS_NO_LOCATION(snk_caps, src_caps) \
+	DISC_SNK_PAC(IOV_CONTENT(snk_caps)), \
+	DISC_SRC_PAC(IOV_CONTENT(src_caps))
 
 #define DISC_SRC_LC3 \
-	DISC_SRC_PAC(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_PACS(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
@@ -999,15 +1019,21 @@ static void test_teardown(const void *user_data)
  *   Value: ff0fff0f
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
  */
-#define DISC_CTX(_caps...) \
-	DISC_SRC_PAC(_caps), \
+#define DISC_CTX(snk_locations, src_locations, snk_caps, src_caps) \
+	DISC_PACS(snk_locations, src_locations, \
+			IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, 0x0f, 0x00), \
+	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
+
+#define DISC_CTX_NO_LOCATION(snk_caps, src_caps) \
+	DISC_PACS_NO_LOCATION(IOV_CONTENT(snk_caps), \
+				IOV_CONTENT(src_caps)), \
 	IOV_DATA(0x0a, 0x0f, 0x00), \
 	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
 
 #define DISC_CTX_LC3 \
-	DISC_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_CTX(0x00000003, 0x00000003, \
+		LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
@@ -1015,15 +1041,20 @@ static void test_teardown(const void *user_data)
  *   Value: ff0fff0f
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
  */
-#define DISC_SUP_CTX(_caps...) \
-	DISC_CTX(_caps), \
+#define DISC_SUP_CTX(snk_locations, src_locations, snk_caps, src_caps) \
+	DISC_CTX(snk_locations, src_locations, \
+			IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, 0x12, 0x00), \
+	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
+
+#define DISC_SUP_CTX_NO_LOCATION(snk_caps, src_caps) \
+	DISC_CTX_NO_LOCATION(IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
 	IOV_DATA(0x0a, 0x12, 0x00), \
 	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
 
 #define DISC_SUP_CTX_LC3 \
-	DISC_SUP_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SUP_CTX(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0016 Type: Sink ASE (0x2bc4)
@@ -1046,8 +1077,9 @@ static void test_teardown(const void *user_data)
  *       Notification (0x01)
  * ATT: Write Response (0x13) len 0
  */
-#define DISC_SNK_ASE(_caps...) \
-	DISC_SUP_CTX(_caps), \
+#define DISC_SNK_ASE(snk_locations, src_locations, snk_caps, src_caps)	\
+	DISC_SUP_CTX(snk_locations, src_locations, \
+			IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
 	IOV_DATA(0x0a, 0x16, 0x00), \
 	IOV_DATA(0x0b, 0x01, 0x00), \
 	IOV_DATA(0x12, 0x17, 0x00, 0x01, 0x00), \
@@ -1057,10 +1089,15 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x12, 0x1a, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x13)
 
+#define DISC_SNK_ASE_NO_LOCATION(snk_caps, src_caps) \
+	DISC_SUP_CTX_NO_LOCATION(IOV_CONTENT(snk_caps), \
+				IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, 0x16, 0x00), \
+	IOV_DATA(0x0b, 0x01, 0x00)
+
 #define DISC_SNK_ASE_LC3 \
-	DISC_SNK_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SNK_ASE(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x001c Type: Source ASE (0x2bc5)
@@ -1088,8 +1125,9 @@ static void test_teardown(const void *user_data)
  *       Notification (0x01)
  * ATT: Write Response (0x13) len 0
  */
-#define DISC_SRC_ASE(_cfg...) \
-	DISC_SNK_ASE(_cfg), \
+#define DISC_SRC_ASE(snk_locations, src_locations, snk_pacs, src_pacs) \
+	DISC_SNK_ASE(snk_locations, src_locations, \
+			IOV_CONTENT(snk_pacs), IOV_CONTENT(src_pacs)), \
 	IOV_DATA(0x0a, 0x1c, 0x00), \
 	IOV_DATA(0x0b, 0x03, 0x00), \
 	IOV_DATA(0x12, 0x1d, 0x00, 0x01, 0x00), \
@@ -1101,10 +1139,17 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x12, 0x23, 0x00, 0x01, 0x00), \
 	IOV_DATA(0x13)
 
+#define DISC_SRC_ASE_NO_LOCATION(snk_pacs, src_pacs) \
+	DISC_SNK_ASE_NO_LOCATION(IOV_CONTENT(snk_pacs), \
+				IOV_CONTENT(src_pacs)), \
+	IOV_DATA(0x0a, 0x1c, 0x00), \
+	IOV_DATA(0x0b, 0x03, 0x00), \
+	IOV_DATA(0x12, 0x23, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
 #define DISC_SRC_ASE_LC3 \
-	DISC_SRC_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SRC_ASE(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 #define DISC_ASE_LC3 \
 	DISC_SNK_ASE_LC3, \
@@ -1867,8 +1912,16 @@ static struct test_config cfg_snk_vs = {
 	.vs = true,
 };
 
+#define VS_PAC_CAPS(ch_count) \
+	0xff, 0x01, 0x00, 0x01, 0x00, 0x03, 0x02, 0x03, ch_count, \
+	0x00
+
+#define VS_PAC_CAPS_NO_COUNT				\
+	0xff, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00
+
 #define DISC_SRC_ASE_VS \
-	DISC_SRC_ASE(0xff, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00)
+	DISC_SRC_ASE(0x00000003, 0x00000003, \
+			VS_PAC_CAPS_NO_COUNT, VS_PAC_CAPS_NO_COUNT)
 
 #define SCC_SNK_VS \
 	DISC_SRC_ASE_VS,  \
-- 
2.51.1

