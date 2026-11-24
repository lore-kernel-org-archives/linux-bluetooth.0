Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527081;
	b=acc+WEKv33WLtytKbsQ8GNi6bNXzHruk84QZ/zJOsHZxGrOR00DLq00a38VrMLL33E+I
	 wQLlt3erZS8fqVaD8c6iT3GgF7KqTfLpe991dYfJj4z+GnD37lqM6qafPBdzQ1slJr/UD
	 wV6x7MdNCy8/87vA14IccCOGIvj22FhKbu0HjelvJP3xpMt39MIkn61xytfKugq0A1NN2
	 xlVRt3t+5dN7P+O5r2UtKLnzY9Tao3oCwy5pLT7Zx7ra2pHnvJCV7kmml1xa+P6f4UcyD
	 KbnGAjS6r3nIa3WtJMYHyZDxLslxjbVU7NreeeR2H0TVORhTqlXtOnLkDb4WshQTjXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JMKhxmDdjgraqy2kzL0a9bkXH0ysVu6iIgvYfiqgwP8=;
	b=5qSGvF9NX2R7cntVVDt3Kah4EgYVsWsWe5e6GF5A0vV4xVlOhG5eCwCBMB6famZdbU1v
	 +pIh/FtqnvIVPfckONXKkxLx+Fp4mmzriRdWgYJwuV28CaeJJKIAB/8fvZ/8U3Ihosjvj
	 9BDo1jNt785e8/OfSMthyFa38PzJb8dsxVLL8gTvvp8K9XfRizje4Si++8TI4gJjYs/OH
	 Yr9dF7BOGL3THBIJMLpT/YIUcPbX2jdrkdeog7PRyy1yzywMraAbhaa39yrwUnslpOec1
	 1NmM43S5CZc25eSSkK9L/1+Nv4cVdot/oNdjOoxtyIbdYmPju/ycbM/4UF6bS/eGUKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=BQnXPS2Y;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE82606A322
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE82606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=BQnXPS2Y
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d427836e9so615822066b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795527079; x=1796131879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMKhxmDdjgraqy2kzL0a9bkXH0ysVu6iIgvYfiqgwP8=;
        b=BQnXPS2Y6n7bMAqTuaZpiknGz9tzdDGfvmfxWwutNRSHoyUzTxDKgw83xzOSuN6mHn
         ZpdcOeCge11PxVLSnRAozB2CTXJ7m74+0ZCi/YMuL/wL050GzXsuwwH2S3PjXPIYgJlG
         LgBob861snvGQhtcJqndMIDIL3HU8I1IiMWQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527079; x=1796131879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMKhxmDdjgraqy2kzL0a9bkXH0ysVu6iIgvYfiqgwP8=;
        b=teSwYXAiY7CjUGSx9CMYSwKNMAAoDEA5BD/2W7Ngzq27VhGnZ6IkdQd+gG3G5WSGPW
         haTOoTs5dK597SQRbSNkCIQ7EXYy9EmrH+8cZSi6VbMGxNYHp51yKhQiHWa1Nwu8CL1t
         UCLsQ3wYxO1vVEyWfASScycDx8dk5HnnqL4s+CVsjePwbHU79+AGVLb73gQmvgQgK339
         /nfgCOlhb3VKOaDEm6+AIClSRjH4DqWn3tD5m//uf1zKERHPcsYeeSGA4CdXJUWOSPKq
         cpQ26cx29INJzhfMwKaksTXKg0KjZrzDj2N4K5pyQJAD1XAVwNXQS+5LfWyEaPrwTVsl
         81tw==
X-Gm-Message-State: APuU4Z9+VdQt8DNce2jh8QHBVrXKboNNZlt0G/8ENMnu8Bzt6d50DmAl
	4xDK4ebYAWSbwEpsMRx7KEuYMTfFoaUpsnSuOLwDEXTG3zkqXxCHGphs7Rstq/ONpyVeDkwCgkn
	Ji0Hc
X-Gm-Gg: AZFdTZccnSwCniQaLTyiH9nOKa5hbhJJqJA3qUEcTXnM7sc9EU51AdAHYBdTDC4Ou98
	KThiBIH5jGfKDkJSsJuUKhTTwfXBXaLIdqePpanC2/PVbJswPDpDy+V4vxegmWNhxMsCl6zNPiT
	AvZ5NSXTzq5gHb4lSqNTjX1d7jgSCdnxZsu+2/P6k/33LVj7uk6UWIcZW7ndVjxKMLV9p7KWj0u
	9ZCUYOATNOjQ0pK000tK/G3HeszPa8amupwUeoODZ+2+A9SuZOZjZgmSpEhOvEWoHteBsMgN+ox
	9fkClVqharRi5fBlh/sTL4ATDgyVVNRjONZCJ27OKxsy3XY8L7ydrtKJNzaxcOSXTOMZ/mp+g5X
	dw9ZdsqaoTy2GRgatOxMX+oC+nyBooH00FpnPmUSuVFIFp9AoP+7P82yFDizaBkKj3iZyn9s8bG
	0X22ajQxobFbBktH3gxq3F1EsOPAmj3g1UluC5uBuita/UxkeBgqx4gG7VIsXk/J0LaKoHddUED
	YVWK6b+Qi/Cju2qBQL1HWPLR+BKVcH77tzBEGHJEiuzvIrLB+xGDRJlIwnINWwRnlXjjNrUqPgC
	ecM18l9HfMLJO0huwA4E5ocP3CGBlGJUsT28QUAsKD09hIDcIg==
X-Received: by 2002:a17:906:ccc1:b0:c29:5172:6151 with SMTP id a640c23a62f3a-c513ac9b721mr940649266b.45.1795527079481;
        Tue, 24 Nov 2026 05:31:19 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm28145115f8f.50.2026.11.24.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:31:19 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] unit/test-bap: Add test for an unknown ASE CP opcode
Date: Tue, 24 Nov 2026 14:31:12 +0100
Message-ID: <20261124133112.3956249-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
References: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
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

Write an unknown opcode to the ASE Control Point with a Write Request
and expect the Unsupported Opcode notification and a Write Response.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-bap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index bfe98a885..7c5f94d86 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4624,6 +4624,26 @@ static void test_scc_metadata(void)
 	IOV_DATA(0x52, CP_HND, _op, 0x00), \
 	ASE_CP_RSP_TRUNCATED(_op)
 
+/* ATT: Write Request (0x12) len 5
+ *   Handle: 0x0022 Type: ASE Control Point (0x2bc6)
+ *     Data: 0f0101
+ * ATT: Write Response (0x13) len 0
+ * ATT: Handle Value Notification (0x1b) len 7
+ *   Handle: 0x0022 Type: ASE Control Point (0x2bc6)
+ *     Data: 0fff000100
+ *       Opcode: Unknown (0x0f)
+ *       Number of ASE(s): 255
+ *       ASE: #0
+ *       ASE ID: 0x00
+ *       ASE Response Code: Unsupported Opcode (0x01)
+ *       ASE Response Reason: None (0x00)
+ */
+#define SPE_CP_UNSUPPORTED(_op) \
+	IOV_DATA(0x12, CP_HND, _op, 0x01, 0x01), \
+	IOV_DATA(0x13), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, CP_HND, _op, 0xff, 0x00, 0x01, 0x00)
+
 #define SPE_METADATA_TRUNCATED(_ase) \
 	IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase), \
 	ASE_CP_RSP_TRUNCATED(0x07)
@@ -4657,6 +4677,10 @@ static void test_usr_spe(void)
 	define_test("BAP/USR/SPE/BI-02-C [USR ASE Control Point zero ASEs]",
 			test_setup_server, test_server, NULL,
 			SPE_CP_ZERO_ASES(0x03));
+	define_test("BAP/USR/SPE/BLUEZ-1 [USR ASE Control Point unsupported "
+			"opcode]",
+			test_setup_server, test_server, NULL,
+			SPE_CP_UNSUPPORTED(0x0f));
 	define_test("BAP/USR/SPE/BI-03-C [USR Update Metadata truncated]",
 			test_setup_server, test_server, NULL,
 			SPE_METADATA_TRUNCATED(SRC_ID(0)));
-- 
2.43.0

