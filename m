Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737822;
	b=bh0w4IOf7oAk5HLhiP2ynALvKvYUkt5bERMjj1ghkc6UtfBPU1WWVW6Yx6Nw+1gP493j
	 5OTxPnORztlOu4Gz4NcnBiPlftUFFKyoA0Xj6o0XJiquok3V/FB83+b771wcvvn45YVxD
	 XUf6TLoD7C0uf+Fwso3xrqA2ma2Vi/RGJGLqi0sBCgVhE3T65POh5an50x5aZf7rjdx4P
	 d9yx+m4kHw/QDecg7Z2tXKCZv/93ibD5/dWNpxaP/X+qC++J2QKYamW1MAgK0snpeFyc4
	 m93bRNxx8CFkpIi9Ayoz9W8CAS6EE76lyF1Hv4CeGOAV/L+gDXpGzXntv8caMb4R7KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gqxeT8+uE7DdgspHC0PikC3IAoswocAF/lI2mcCcPhc=;
	b=QPtkMxMi9pFoCcm8sk3cfWJFNCKrCLVy28mVa7Ofd40dxOJEu0FLXHNiDXjFejA/QrbU
	 OtxbOzIWiQMCG8iJfcudByQYg7IhRROASrSHRARG6KYM5joT2a40/mFs5KQMdYDg5BJYc
	 JF3OZTJUbfgqwpLrM31oy6Rn+/+GjhRxSuAJbjPJjJqiKrFJ8sxdRNe8Dclu/uYUpJRvq
	 RDQT9fLjHrib1pMl7E3Mu7APvrLLifOmNtU2HyAKv9UPDgcDcgkfILV0IJ0kn25SR8B58
	 qYmDUv8Fnaq9GJhVVIcZ61BURxUX5RQDWaEynTl6TgHunyVwAr/6RPvxNc8XPeJIWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pz0Ejfw7;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE8606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DE8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pz0Ejfw7
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98c78660542so4577241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737820; x=1794342620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gqxeT8+uE7DdgspHC0PikC3IAoswocAF/lI2mcCcPhc=;
        b=Pz0Ejfw7xf3y5RkNzbSrX3Rht29tX8+xq7I4Nt6Uix2SxHYnI9E4b7Lh1G7TAatn+l
         WRSYpIFh9vnFoDmyMI8a56RZPRet1/8X4XN/zyFskixSIbPAKj1dvX5NjJ8uvQzy+FyV
         iogNs8LL23TwHZXCcauHSjO0DYij0vTXtjdRrmYuRmqxOW9PqmtXoeD8lxY5m0y5ggeh
         NPCVOz4tD8AHXaJwHS9bi5BKns9TBQ0qJYGMi/6XFuYM59PqtDoXR4lBuWcL47a21J9S
         dK86Q183GjflCZ271NMAJweyzPIvB7APmcvUOaVMJX6wV0TcCmdyPK2WskPjBeMyZgtv
         MNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737820; x=1794342620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gqxeT8+uE7DdgspHC0PikC3IAoswocAF/lI2mcCcPhc=;
        b=mqqBuPZ9mzHM3u4Fed+kHXXyBRMtETpVkKr9DsE43OsoSbrO4RdpmogyQB0/UgF2fo
         GrpIcC4BpzgPS5WSWtFMb3aaXwh+D5dQaOYCW9W9TwzWpQi91Y3MJa9VwzX1IxvmKvpc
         wJTyuxh/vm6bbhTuy0fKjqBfiWqEkx1ci/TfgyEaKoEhNlDzqmaWQFWEXKJIb2t9oThl
         CfSC8SqhCnr9ToVd9l2dW6c2/SD6uXRo+evQdMD4X0ndW1IBoQXj0Qyx+eX5DXkrdB88
         WkCZayhq3APCaOrRB4f2VEGQ7PWqdrEcfsi9HiEnnStbILApaAd1NtwpO13zsL1AQQIQ
         2/Cw==
X-Gm-Message-State: APuU4Z+gQ+EEiYsblgGkYKrW0vMh/wa2z0xBAGEt8QrbOKs68qJONmvt
	jarbK8sA4TI8YjU3cOhDPjmD8xxknC4khyVRmAXAbuEMeDk35e7KUngXaRnRFA==
X-Gm-Gg: AYBFou0tPdBVXTWG2FpDsHQwGwEwRnqNHHHcxAGRz0zxZPntmA9CCCkjomlWv3vA9HN
	YylgQgsmAv7lTJ4uVkOH/K0C1KwODGqOjuaM7KzlPmnlyByDL72zbb041OyokyfpVKc7aaaFc9j
	92lQkMiH8YMkNLzlPOESlN52PUNWw8T80++s1ERCQpyugmF7pod0MU9yRxj7mEtJISZBGdNTJ06
	VuEUKzex/ubDdjBH2eQGq3NjEdo6K/4obo0wDvjKmWf9FJUyHPe5ONyIad8BKNJ1C8qLGuHySuG
	77SmbcnpRUqum4X0taR7qJtYhXlsNjZitIOwSt/43HFJMSaPyWZv9DpZ9cdWWgRXIGBEukhvj6U
	y1xFfAN2u/P5LtwlvnLl1GwTN57s0Yy6/PMca7HjJe8/SF6/YSnxKBmyrYNPknqc1EG2F24UD4T
	52Xi53h+YeT9Ha6nHXwhA2O9FLkbVSxIeuRfbd6yQ2kwZhy2+0DWFgbBM0G9m5GKDVCfmlWKr/L
	oZvStvhmO8N6aObjnaPYTw/sA/uMK0QBmwVvNF2ziMOmcgVufr77BJHxpe6LMnSjEgO8tb4yEWt
	qb+dEOBnT4uJzeagEdIM667jqr2MgsVHTteKwX/Auv51Z/Wews87qtoafKSK/Hz0rgaCSKfBBAV
	6GTmaTLcYfkUSj9PYhiXXUIPhrYLbI/U4ct+7kDusAXwrZ5II6UB6CTi1oxGGSY1ecc18XTDLXD
	mXNfc=
X-Received: by 2002:a05:6102:8092:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d07279cd1amr6084442137.31.1793737820457;
        Tue, 03 Nov 2026 12:30:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/7] unit/test-bap: Expect the ASE state following Releasing
Date: Tue,  3 Nov 2026 15:30:08 -0500
Message-ID: <20261103203011.3904290-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

After Releasing the server moves the ASE to Idle, or to Codec Configured
if the configuration is cached, but the Release tests ended at
Releasing so the notification of the following state was ignored.
---
 unit/test-bap.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 1b1a51b03e51..8b091a5f640d 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4007,9 +4007,25 @@ static struct test_config cfg_src_cc_release = {
 	IOV_NULL, \
 	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x06)
 
+/* After Releasing the ASE moves to Idle, or to Codec Configured if the
+ * configuration is cached.
+ */
+#define ASE_SRC_RELEASE_IDLE \
+	ASE_SRC_RELEASE, \
+	IOV_NULL, \
+	IOV_DATA(0x1b, SRC_HND(0), SRC_ID(0), 0x00)
+
+#define LC3_CONFIG_16_2_DATA \
+	LC3_CODEC_ID_DATA, 0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, \
+	0x04, 0x28, 0x00
+
+#define ASE_SRC_RELEASE_CC \
+	ASE_SRC_RELEASE, \
+	SCC_SRC_NOTIFY(0, LC3_CONFIG_16_2_DATA)
+
 #define SCC_SRC_CC_RELEASE \
 	SCC_SRC_16_2, \
-	ASE_SRC_RELEASE
+	ASE_SRC_RELEASE_IDLE
 
 static struct test_config cfg_snk_cc_release = {
 	.cc = LC3_CONFIG_16_2,
@@ -4034,9 +4050,18 @@ static struct test_config cfg_snk_cc_release = {
 	IOV_NULL, \
 	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x06)
 
+#define ASE_SNK_RELEASE_IDLE \
+	ASE_SNK_RELEASE, \
+	IOV_NULL, \
+	IOV_DATA(0x1b, SNK_HND(0), SNK_ID(0), 0x00)
+
+#define ASE_SNK_RELEASE_CC \
+	ASE_SNK_RELEASE, \
+	SCC_SNK_NOTIFY(0, LC3_CONFIG_16_2_DATA)
+
 #define SCC_SNK_CC_RELEASE \
 	SCC_SNK_16_2, \
-	ASE_SNK_RELEASE
+	ASE_SNK_RELEASE_IDLE
 
 static void state_qos_release(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
@@ -4063,7 +4088,7 @@ static struct test_config cfg_src_qos_release = {
 
 #define SCC_SRC_QOS_RELEASE \
 	SCC_SRC_16_2_1, \
-	ASE_SRC_RELEASE
+	ASE_SRC_RELEASE_CC
 
 static struct test_config cfg_snk_qos_release = {
 	.cc = LC3_CONFIG_16_2,
@@ -4075,7 +4100,7 @@ static struct test_config cfg_snk_qos_release = {
 
 #define SCC_SNK_QOS_RELEASE \
 	SCC_SNK_16_2_1, \
-	ASE_SNK_RELEASE
+	ASE_SNK_RELEASE_CC
 
 static void state_enable_release(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
@@ -4102,7 +4127,7 @@ static struct test_config cfg_src_enable_release = {
 
 #define SCC_SRC_ENABLE_RELEASE \
 	SCC_SRC_ENABLE, \
-	ASE_SRC_RELEASE
+	ASE_SRC_RELEASE_CC
 
 static struct test_config cfg_snk_enable_release = {
 	.cc = LC3_CONFIG_16_2,
@@ -4114,7 +4139,7 @@ static struct test_config cfg_snk_enable_release = {
 
 #define SCC_SNK_ENABLE_RELEASE \
 	SCC_SNK_ENABLE, \
-	ASE_SNK_RELEASE
+	ASE_SNK_RELEASE_CC
 
 static void state_start_release(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
@@ -4142,7 +4167,7 @@ static struct test_config cfg_src_start_release = {
 #define SCC_SRC_START_RELEASE \
 	SCC_SRC_ENABLE, \
 	SRC_START, \
-	ASE_SRC_RELEASE
+	ASE_SRC_RELEASE_CC
 
 static void state_disable_release(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
@@ -4169,7 +4194,7 @@ static struct test_config cfg_src_disable_release = {
 
 #define SCC_SRC_DISABLE_RELEASE \
 	SCC_SRC_DISABLE, \
-	ASE_SRC_RELEASE
+	ASE_SRC_RELEASE_CC
 
 /* Test Purpose:
  * Verify that a Unicast Client IUT can release an ASE by initiating a Release
-- 
2.56.0

