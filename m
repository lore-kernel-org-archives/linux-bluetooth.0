Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5751E8836
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211525; cv=pass; b=m2qcEcbDs5pzFE5ooQKl/QHWeg9SxDRGQ3Q/OhDh1RzUDcyJpkiHJ0hd66DNpOwwmwnnssRZdHrMPR9xvpalU5kRehLNP65crT++ncXpeEyhPMiFUkX3VHGgrBI0JNz0MnSdYeZ6XpfzlCu/iTAa06u7MHdcj5Il36JjhX+4zdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211525; c=relaxed/simple;
	bh=ezSi9gxXPbsZLoX5QFzkKH/1Co8imPN7NNrqq923Jho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgsqtDBL7wAewkeP1RBp/M9QSHLDKZQdhVURK5bA51T/6+oVgp1QcHmlnuzN0BLsavGE+PrWELx+q0DH6hkEHrlrXMNLastp43tnl1nJnQVL/zRz+OBh0kxmC5kYah4FYDD2DOx8VRoUQEVi7CCalnUKo0FIyyQy7PidtrU+YHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=CjMdUu7Q; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="CjMdUu7Q"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vFr4PwSz104y;
	Sat, 15 Nov 2025 14:58:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763211521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/1lE/wLvrrf4eRqwZiVar3uVkSF6obZMJQLsgVzTV4=;
	b=CjMdUu7QauxsGshZQDeiY7rTqGfQF/hFMucq0F6sLt3E7XIn9ZUgA6j3uBJc+kJSPVuqO+
	iJKg7G0z5kEk5r1JsA6dnHxcmTLJWJ+CGSa68BdoX+OzcCMJT8CDeLSW9PACRQCJoD6QwT
	nt0OkI8uM0E2njZpybJ9gMjgqJS0Unk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763211521;
	b=Os81MNgqpJsL5akHlN0mayRoV5OBpL5LUAi+iTbIYAGHTwwDf28anVcJZ8sIsAOWNuhNwe
	qBNzWOfx4M1B8ocsJhutT2GV5RtlkPRNysafT62EVu7ALBT4riuWkkPWNnGLA4JJ+/79GU
	pgqCKnPjoPDm0VaLNFwFVoSUxm62kIU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763211521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/1lE/wLvrrf4eRqwZiVar3uVkSF6obZMJQLsgVzTV4=;
	b=pFVjcu89sElsIE/G2c43OOHiMG9wB8XT3ACIkoVbABr186hi3VaReQWfTcEJjyn4fn4aEw
	kaWrl5gOynWIWo6g9fTUcLnDuTwWnRSM0+kGB/clbMlxMJ9yOl6PW8X40g364l6J6fdREH
	Nz0WN6/qwwFJ+PcB9pkb4FiX5DlQJ8E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 5/6] test-bap: make PDU macros parametrizable
Date: Sat, 15 Nov 2025 14:58:32 +0200
Message-ID: <dd3e09775b77897214d89d74965288965b7cca2f.1763211509.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust PDU-forming macros, so that they can be used for connecting
multiple streams to parametrizable locations.
---

Notes:
    v4:
    - no change
    
    v3:
    - make parametrization more complete

 unit/test-bap.c | 357 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 258 insertions(+), 99 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index c15afe52d..1a35aaf4a 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -122,6 +122,22 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 }
 
 /* GATT Discover All procedure */
+
+#define SNK_PAC_HND	0x03, 0x00
+#define SRC_PAC_HND	0x09, 0x00
+#define SNK_LOC_HND	0x06, 0x00
+#define SRC_LOC_HND	0x0c, 0x00
+#define CTX_HND		0x0f, 0x00
+#define SUP_CTX_HND	0x12, 0x00
+#define SNK_HND(i)	(0x16 + 3*(i)), 0x00
+#define SRC_HND(i)	(0x1c + 3*(i)), 0x00
+#define SNK_CCC_HND(i)	(0x17 + 3*(i)), 0x00
+#define SRC_CCC_HND(i)	(0x1d + 3*(i)), 0x00
+#define SNK_ID(i)	(0x1 + (i))
+#define SRC_ID(i)	(0x3 + (i))
+#define CP_HND		0x22, 0x00
+#define CP_CCC_HND	0x23, 0x00
+
 static const struct iovec setup_data[] = {
 	/* ATT: Exchange MTU Response (0x03) len 2
 	 *   Server RX MTU: 64
@@ -933,16 +949,26 @@ static void test_teardown(const void *user_data)
  *       Front Left (0x00000001)
  *       Front Right (0x00000002)
  */
-#define DISC_SNK_PAC(_caps...) \
-	IOV_DATA(0x0a, 0x03, 0x00), \
-	IOV_DATA(0x0b, 0x01, _caps), \
-	IOV_DATA(0x0a, 0x06, 0x00), \
-	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
+
+#define IOV_CONTENT(data...) data
+
+#define DISC_SNK_PAC(_caps) \
+	IOV_DATA(0x0a, SNK_PAC_HND), \
+	IOV_DATA(0x0b, 0x01, _caps)
+
+#define DISC_SNK_LOC(locations) \
+	IOV_DATA(0x0a, SNK_LOC_HND), \
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
@@ -981,17 +1007,28 @@ static void test_teardown(const void *user_data)
  *       Front Left (0x00000001)
  *       Front Right (0x00000002)
  */
-#define DISC_SRC_PAC(_caps...) \
-	DISC_SNK_PAC(_caps), \
-	IOV_DATA(0x0a, 0x09, 0x00), \
-	IOV_DATA(0x0b, 0x01, _caps), \
-	IOV_DATA(0x0a, 0x0c, 0x00), \
-	IOV_DATA(0x0b, 0x03, 0x00, 0x00, 0x00)
+#define DISC_SRC_PAC(_caps) \
+	IOV_DATA(0x0a, SRC_PAC_HND), \
+	IOV_DATA(0x0b, 0x01, _caps)
+
+#define DISC_SRC_LOC(locations) \
+	IOV_DATA(0x0a, SRC_LOC_HND), \
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
@@ -999,15 +1036,21 @@ static void test_teardown(const void *user_data)
  *   Value: ff0fff0f
  *   Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
  */
-#define DISC_CTX(_caps...) \
-	DISC_SRC_PAC(_caps), \
-	IOV_DATA(0x0a, 0x0f, 0x00), \
+#define DISC_CTX(snk_locations, src_locations, snk_caps, src_caps) \
+	DISC_PACS(snk_locations, src_locations, \
+			IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, CTX_HND), \
+	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
+
+#define DISC_CTX_NO_LOCATION(snk_caps, src_caps) \
+	DISC_PACS_NO_LOCATION(IOV_CONTENT(snk_caps), \
+				IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, CTX_HND), \
 	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
 
 #define DISC_CTX_LC3 \
-	DISC_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_CTX(0x00000003, 0x00000003, \
+		LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
@@ -1015,15 +1058,20 @@ static void test_teardown(const void *user_data)
  *   Value: ff0fff0f
  *   Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
  */
-#define DISC_SUP_CTX(_caps...) \
-	DISC_CTX(_caps), \
-	IOV_DATA(0x0a, 0x12, 0x00), \
+#define DISC_SUP_CTX(snk_locations, src_locations, snk_caps, src_caps) \
+	DISC_CTX(snk_locations, src_locations, \
+			IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, SUP_CTX_HND), \
+	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
+
+#define DISC_SUP_CTX_NO_LOCATION(snk_caps, src_caps) \
+	DISC_CTX_NO_LOCATION(IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, SUP_CTX_HND), \
 	IOV_DATA(0x0b, 0xff, 0x0f, 0xff, 0x0f)
 
 #define DISC_SUP_CTX_LC3 \
-	DISC_SUP_CTX(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SUP_CTX(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x0016 Type: Sink ASE (0x2bc4)
@@ -1046,21 +1094,29 @@ static void test_teardown(const void *user_data)
  *       Notification (0x01)
  * ATT: Write Response (0x13) len 0
  */
-#define DISC_SNK_ASE(_caps...) \
-	DISC_SUP_CTX(_caps), \
-	IOV_DATA(0x0a, 0x16, 0x00), \
+#define DISC_SNK_ASE(snk_locations, src_locations, snk_caps, src_caps)	\
+	DISC_SUP_CTX(snk_locations, src_locations, \
+			IOV_CONTENT(snk_caps), IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, SNK_HND(0)), \
 	IOV_DATA(0x0b, 0x01, 0x00), \
-	IOV_DATA(0x12, 0x17, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x12, SNK_CCC_HND(0), 0x01, 0x00), \
 	IOV_DATA(0x13), \
-	IOV_DATA(0x0a, 0x19, 0x00), \
+	IOV_DATA(0x0a, SNK_HND(1)), \
 	IOV_DATA(0x0b, 0x02, 0x00), \
-	IOV_DATA(0x12, 0x1a, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x12, SNK_CCC_HND(1), 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+#define DISC_SNK_ASE_NO_LOCATION(snk_caps, src_caps) \
+	DISC_SUP_CTX_NO_LOCATION(IOV_CONTENT(snk_caps), \
+				IOV_CONTENT(src_caps)), \
+	IOV_DATA(0x0a, SNK_HND(0)), \
+	IOV_DATA(0x0b, 0x01, 0x00), \
+	IOV_DATA(0x12, SNK_CCC_HND(0), 0x01, 0x00), \
 	IOV_DATA(0x13)
 
 #define DISC_SNK_ASE_LC3 \
-	DISC_SNK_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SNK_ASE(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 /* ATT: Read Request (0x0a) len 2
  *   Handle: 0x001c Type: Source ASE (0x2bc5)
@@ -1088,23 +1144,33 @@ static void test_teardown(const void *user_data)
  *       Notification (0x01)
  * ATT: Write Response (0x13) len 0
  */
-#define DISC_SRC_ASE(_cfg...) \
-	DISC_SNK_ASE(_cfg), \
-	IOV_DATA(0x0a, 0x1c, 0x00), \
+#define DISC_SRC_ASE(snk_locations, src_locations, snk_pacs, src_pacs) \
+	DISC_SNK_ASE(snk_locations, src_locations, \
+			IOV_CONTENT(snk_pacs), IOV_CONTENT(src_pacs)), \
+	IOV_DATA(0x0a, SRC_HND(0)), \
 	IOV_DATA(0x0b, 0x03, 0x00), \
-	IOV_DATA(0x12, 0x1d, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x12, SRC_CCC_HND(0), 0x01, 0x00), \
 	IOV_DATA(0x13), \
-	IOV_DATA(0x0a, 0x1f, 0x00), \
+	IOV_DATA(0x0a, SRC_HND(1)), \
 	IOV_DATA(0x0b, 0x04, 0x00), \
-	IOV_DATA(0x12, 0x20, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x12, SRC_CCC_HND(1), 0x01, 0x00), \
 	IOV_DATA(0x13), \
-	IOV_DATA(0x12, 0x23, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x12, CP_CCC_HND, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+#define DISC_SRC_ASE_NO_LOCATION(snk_pacs, src_pacs) \
+	DISC_SNK_ASE_NO_LOCATION(IOV_CONTENT(snk_pacs), \
+				IOV_CONTENT(src_pacs)), \
+	IOV_DATA(0x0a, SRC_HND(0)), \
+	IOV_DATA(0x0b, 0x03, 0x00), \
+	IOV_DATA(0x12, SRC_CCC_HND(0), 0x01, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, CP_CCC_HND, 0x01, 0x00), \
 	IOV_DATA(0x13)
 
 #define DISC_SRC_ASE_LC3 \
-	DISC_SRC_ASE(0x06, 0x00, 0x00, 0x00, 0x00, 0x10, 0x03, 0x01, \
-		0xff, 0x00, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x05, 0x04, \
-		0x1a, 0x00, 0xf0, 0x00, 0x00)
+	DISC_SRC_ASE(0x00000003, 0x00000003, \
+			LC3_PAC_CAPS(0x03), LC3_PAC_CAPS(0x03))
 
 #define DISC_ASE_LC3 \
 	DISC_SNK_ASE_LC3, \
@@ -1251,17 +1317,33 @@ static void test_disc(void)
  *   Handle: 0x0016
  *     Data: 01010002010a00204e00409c00204e00409c00_cfg
  */
-#define SCC_SNK(_cfg...) \
-	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, _cfg), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00), \
+
+#define SCC_PDU(count) \
+	0x52, CP_HND, 0x01, (count)
+
+#define SCC_PDU_ASE(id, _cfg...) \
+	id, 0x02, 0x02, _cfg
+
+#define SCC_ASE(id, _cfg...) \
+	IOV_DATA(SCC_PDU(1), SCC_PDU_ASE(id, _cfg)), \
+	IOV_DATA(0x1b, CP_HND, 0x01, 0x01, id, 0x00, 0x00)
+
+#define SCC_SNK_NOTIFY(i, _cfg...) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x01, 0x00, 0x02, 0x01, 0x0a, 0x00, \
+	IOV_DATA(0x1b, SNK_HND(i), SNK_ID(i), 0x01, \
+			0x00, 0x02, 0x01, 0x0a, 0x00, \
 			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
 			0x40, 0x9c, 0x00, _cfg)
 
+#define SCC_SNK(_cfg...) \
+	SCC_ASE(SNK_ID(0), _cfg), SCC_SNK_NOTIFY(0, _cfg)
+
+#define LC3_CODEC_ID_DATA \
+	0x06, 0x00, 0x00, 0x00, 0x00
+
 #define SCC_SNK_LC3(_cc...) \
 	DISC_SRC_ASE_LC3, \
-	SCC_SNK(0x06, 0x00, 0x00, 0x00, 0x00, _cc)
+	SCC_SNK(LC3_CODEC_ID_DATA, _cc)
 
 #define QOS_BALANCED_2M \
 	{ \
@@ -1442,14 +1524,18 @@ static struct test_config cfg_snk_48_6 = {
  *   Handle: 0x001c
  *     Data: 03010002010a00204e00409c00204e00409c00_cfg
  */
-#define SCC_SRC(_cfg...) \
-	IOV_DATA(0x52, 0x22, 0x00, 0x01, 0x01, 0x03, 0x02, 0x02, _cfg), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x01, 0x01, 0x03, 0x00, 0x00), \
+
+#define SCC_SRC_NOTIFY(i, _cfg...) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x01, 0x00, 0x02, 0x01, 0x0a, 0x00, \
+	IOV_DATA(0x1b, SRC_HND(i), SRC_ID(i), 0x01, \
+			0x00, 0x02, 0x01, 0x0a, 0x00, \
 			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
 			0x40, 0x9c, 0x00, _cfg)
 
+#define SCC_SRC(_cfg...) \
+	SCC_ASE(SRC_ID(0), _cfg), \
+	SCC_SRC_NOTIFY(0, _cfg)
+
 #define SCC_SRC_LC3(_cc...) \
 	DISC_SRC_ASE_LC3, \
 	SCC_SRC(0x06, 0x00, 0x00, 0x00, 0x00, _cc)
@@ -1867,12 +1953,23 @@ static struct test_config cfg_snk_vs = {
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
+
+#define VS_CODEC_ID_DATA \
+	0xff, 0x01, 0x00, 0x01, 0x00
 
 #define SCC_SNK_VS \
 	DISC_SRC_ASE_VS,  \
-	SCC_SNK(0xff, 0x01, 0x00, 0x01, 0x00, 0x00)
+	SCC_SNK(VS_CODEC_ID_DATA, 0x00)
 
 static struct test_config cfg_src_vs = {
 	.cc = IOV_NULL,
@@ -2066,11 +2163,24 @@ static struct test_config cfg_snk_48_6_1 = {
  *   Handle: 0x0016
  *     Data: 01010102010a00204e00409c00204e00409c00_qos
  */
-#define QOS_SNK(_qos...) \
-	IOV_DATA(0x52, 0x22, 0x00, 0x02, 0x01, 0x01, 0x00, 0x00, _qos), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x02, 0x01, 0x01, 0x00, 0x00), \
+
+#define QOS_PDU(count) \
+	0x52, CP_HND, 0x02, (count)
+
+#define QOS_PDU_ASE(id, cis, _qos...) \
+	id, 0x00, cis, _qos
+
+#define QOS_ASE(id, cis, _qos...) \
+	IOV_DATA(QOS_PDU(1), QOS_PDU_ASE(id, cis, _qos)), \
+	IOV_DATA(0x1b, CP_HND, 0x02, 0x01, id, 0x00, 0x00)
+
+#define QOS_SNK_NOTIFY(i, cis, _qos...) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x02, 0x00, 0x00, _qos)
+	IOV_DATA(0x1b, SNK_HND(i), SNK_ID(i), 0x02, 0x00, cis, _qos)
+
+#define QOS_SNK(_qos...) \
+	QOS_ASE(SNK_ID(0), 0, _qos), \
+	QOS_SNK_NOTIFY(0, 0, _qos)
 
 #define SCC_SNK_8_1_1 \
 	SCC_SNK_8_1, \
@@ -2274,16 +2384,22 @@ static struct test_config cfg_src_48_6_1 = {
  *   Handle: 0x001c
  *     Data: 03010102010a00204e00409c00204e00409c00_qos
  */
-#define QOS_SRC(_qos...) \
-	IOV_DATA(0x52, 0x22, 0x00, 0x02, 0x01, 0x03, 0x00, 0x00, _qos), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x02, 0x01, 0x03, 0x00, 0x00), \
+
+#define QOS_SRC_NOTIFY(i, cis, _qos...) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x02, 0x00, 0x00, _qos)
+	IOV_DATA(0x1b, SRC_HND(i), SRC_ID(i), 0x02, 0x00, cis, _qos)
+
+#define QOS_SRC(_qos...) \
+	QOS_ASE(SRC_ID(0), 0, _qos), \
+	QOS_SRC_NOTIFY(0, 0, _qos)
+
+#define QOS_SRC_8_1_1_DATA \
+	0x4c, 0x1d, 0x00, 0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, \
+	0x40, 0x9c, 0x00
 
 #define SCC_SRC_8_1_1 \
 	SCC_SRC_8_1, \
-	QOS_SRC(0x4c, 0x1d, 0x00, 0x00, 0x02, 0x1a, 0x00, 0x02, 0x08, 0x00, \
-		0x40, 0x9c, 0x00)
+	QOS_SRC(QOS_SRC_8_1_1_DATA)
 
 #define SCC_SRC_8_2_1 \
 	SCC_SRC_8_2, \
@@ -3252,14 +3368,31 @@ static struct test_config cfg_snk_enable = {
  *   Handle: 0x0016
  *     Data: 0101010300403020100
  */
+
+#define ENABLE_PDU(count) \
+	0x52, CP_HND, 0x03, (count)
+
+#define ENABLE_PDU_ASE(id) \
+	id, 0x04, 0x03, 0x02, 0x01, 00
+
+#define ENABLE_ASE(id) \
+	IOV_DATA(ENABLE_PDU(1), ENABLE_PDU_ASE(id)), \
+	IOV_DATA(0x1b, CP_HND, 0x03, 0x01, id, 0x00, 0x00)
+
+#define SNK_ENABLE_NOTIFY(i, cis) \
+	IOV_NULL, \
+	IOV_DATA(0x1b, SNK_HND(i), SNK_ID(i), 0x03, \
+			0x00, cis, 0x04, 0x03, 0x02, 0x01, 0x00)
+
+#define SNK_START_NOTIFY(i, cis) \
+	IOV_NULL, \
+	IOV_DATA(0x1b, SNK_HND(i), SNK_ID(i), 0x04,		\
+			0x00, cis, 0x04, 0x03, 0x02, 0x01, 0x00)
+
 #define SCC_SNK_ENABLE \
 	SCC_SNK_16_2_1, \
-	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x01, \
-			00), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x01, 0x00, 0x00), \
-	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
-			0x01, 0x00)
+	ENABLE_ASE(SNK_ID(0)), \
+	SNK_ENABLE_NOTIFY(0, 0)
 
 static struct test_config cfg_src_enable = {
 	.cc = LC3_CONFIG_16_2,
@@ -3278,17 +3411,19 @@ static struct test_config cfg_src_enable = {
  *   Handle: 0x001c
  *     Data: 030300000403020100
  */
-#define SRC_ENABLE \
-	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x03, 0x04, 0x03, 0x02, 0x01, \
-			00), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x03, 0x00, 0x00), \
+#define SRC_ENABLE_NOTIFY(i, cis) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
-			0x01, 0x00)
+	IOV_DATA(0x1b, SRC_HND(i), SRC_ID(i), 0x03, \
+			0x00, cis, 0x04, 0x03, 0x02, 0x01, 0x00)
+
+#define SRC_ENABLE \
+	ENABLE_ASE(SRC_ID(0)), \
+	SRC_ENABLE_NOTIFY(0, 0)
 
 #define SCC_SRC_ENABLE \
 	SCC_SRC_16_2_1, \
-	SRC_ENABLE
+	ENABLE_ASE(SRC_ID(0)), \
+	SRC_ENABLE_NOTIFY(0, 0)
 
 /* Test Purpose:
  * Verify that a Unicast Client IUT can initiate an Enable operation for an ASE
@@ -3353,17 +3488,28 @@ static struct test_config cfg_snk_disable = {
  *   Handle: 0x0016
  *     Data: 01010102010a00204e00409c00204e00409c00_qos
  */
-#define ASE_SNK_DISABLE \
-	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x01), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x01, 0x00, 0x00), \
+
+#define DISABLE_PDU(count) \
+	0x52, CP_HND, 0x05, (count)
+
+#define DISABLE_ASE(id) \
+	IOV_DATA(DISABLE_PDU(1), id), \
+	IOV_DATA(0x1b, CP_HND, 0x05, 0x01, id, 0x00, 0x00)
+
+#define SNK_DISABLE_NOTIFY(i, cis) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x02, 0x00, 0x00, 0x10, 0x27, 0x00, \
+	IOV_DATA(0x1b, SNK_HND(i), SNK_ID(i), 0x02, \
+			0x00, cis, 0x10, 0x27, 0x00, \
 			0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x00, 0x40, 0x9c, \
 			0x00)
 
+#define SNK_DISABLE \
+	DISABLE_ASE(SNK_ID(0)), \
+	SNK_DISABLE_NOTIFY(0, 0)
+
 #define SCC_SNK_DISABLE \
 	SCC_SNK_ENABLE, \
-	ASE_SNK_DISABLE
+	SNK_DISABLE
 
 static struct test_config cfg_src_disable = {
 	.cc = LC3_CONFIG_16_2,
@@ -3382,15 +3528,19 @@ static struct test_config cfg_src_disable = {
  *   Handle: 0x001c
  *     Data: 030300000403020100
  */
-#define ASE_SRC_DISABLE \
-	IOV_DATA(0x52, 0x22, 0x00, 0x05, 0x01, 0x03), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x05, 0x01, 0x03, 0x00, 0x00), \
+
+#define SRC_DISABLE_NOTIFY(i, cis) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x05, 0x00, 0x00, 0x04, 0x03, 0x02, \
-		 0x01, 0x00)
+	IOV_DATA(0x1b, SRC_HND(i), SRC_ID(i), 0x05, \
+			0x00, cis, 0x04, 0x03, 0x02, 0x01, 0x00)
+
+#define SRC_DISABLE \
+	DISABLE_ASE(SRC_ID(0)), \
+	SRC_DISABLE_NOTIFY(0, 0)
+
 #define SCC_SRC_DISABLE \
 	SCC_SRC_ENABLE, \
-	ASE_SRC_DISABLE
+	SRC_DISABLE
 
 static void state_start_disable(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
@@ -3426,17 +3576,26 @@ static struct test_config cfg_src_disable_streaming = {
  *   Handle: 0x0016
  *     Data: 0101010400403020100
  */
-#define SRC_START \
-	IOV_DATA(0x52, 0x22, 0x00, 0x04, 0x01, 0x03), \
-	IOV_DATA(0x1b, 0x22, 0x00, 0x04, 0x01, 0x03, 0x00, 0x00), \
+#define START_PDU(count) \
+	0x52, CP_HND, 0x04, (count)
+
+#define START_ASE(id) \
+	IOV_DATA(START_PDU(1), id), \
+	IOV_DATA(0x1b, CP_HND, 0x04, 0x01, id, 0x00, 0x00)
+
+#define SRC_START_NOTIFY(i, cis) \
 	IOV_NULL, \
-	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x04, 0x00, 0x00, 0x04, 0x03, 0x02, \
-			0x01, 0x00)
+	IOV_DATA(0x1b, SRC_HND(i), SRC_ID(i), 0x04, \
+			0x00, cis, 0x04, 0x03, 0x02, 0x01, 0x00)
+
+#define SRC_START \
+	START_ASE(SRC_ID(0)), \
+	SRC_START_NOTIFY(0, 0)
 
 #define SCC_SRC_DISABLE_STREAMING \
 	SCC_SRC_ENABLE, \
 	SRC_START, \
-	ASE_SRC_DISABLE
+	SRC_DISABLE
 
 /* Test Purpose:
  * Verify that a Unicast Client IUT can initiate a Disable operation for an ASE
-- 
2.51.1

