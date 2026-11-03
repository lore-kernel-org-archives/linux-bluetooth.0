Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744400;
	b=ec14PU7ThqKnTLQQW0LxyMXx4UZrDeBcqs5aFDh1JJm9lwgH43ylEbp3EuB7cpsSBh1W
	 DRCV32wxbMPVBwaULEke8wUPZ8NyZLbkC/PmU5TVVzJstvyGfgpgCNAuSs35+sufTATQS
	 PIreWA4GtWCdnmvcel+WmgNO25C8fYsJwJkxbMIgBiYYt8ME/LFx824ULLmpLDeXLjlpm
	 N9NoUdz0WBSrWckxQ07ROswU/7cffHsSViVu24p5fdcJKA+NT+4HP+kzO6BgltACC96+q
	 OXmZUUffBnwMVlmn/kovn+QlejgPYZn7Iq0J1RkpigtJImXaVX4LKX6L6WJtSpSOWEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=II++MBTxIfm7+40C0d97qzww84Xgi24DoGK3RupOEK0=;
	b=wGQFaPofRaMRCLtNSN0dzC+/8MpmWKhe56zrRaEiOvELhGfZIe6PZ2NHWfmCgJo+GyeI
	 8psC+L0zSw55AoBz4lhBQUEnKFufi2u1kCTS0mogNHkPSjojv5t8ppEEhsjoU7UD2m6nK
	 u3IwW11jq6H5bvy7uhcaMEA/DF5qmgChCuQqEdgFe+TWhhe+ijt/LmgWw4qbeTPp2OCFr
	 53z7Jqdm/DhREjP19X711ZG3Ry5hbXMIKXZVghlRsut0qwCtUdm7DaAjOhJQXf3rqb0Xm
	 EmY2SNjbSLXyHuf3IkOUkqB8m3hy+7JQDXQ1t/zUz5uhXhE0YXCpv4Ee0YvwJCvumog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7HRajuW;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620C606A326
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5620C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7HRajuW
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-745497ac8fcso24468137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744399; x=1794349199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=II++MBTxIfm7+40C0d97qzww84Xgi24DoGK3RupOEK0=;
        b=M7HRajuWyRz5agX50i/7wRCcniJX5qeVAglPpak+HlAob2yw0l3iZeMXbwJ2SuT6H2
         7LKgerkTAI2OPXmpLgswd7tHXuUmHBPP4nAo3lAAoRQGMm8uNO46jV06kl8RTH2E8J+j
         AxQMyZXiwAiq9mA2riY6VrNEsv6ZhcDLX3ILqfDfYxHIL41VcVU6vGRczZ+deKY4e138
         m6P8v3NeQS8CA6rktNd6yCAbsl0mWiwLvETU9EMZxvhYAx6XfKV7L2Yth/JlSrHEe5wH
         3iNHwPpkqajpaYpFShHTYo8gQlusrc+wQShNW7Ehm5M+QbeXvHY8Taj+C7A3AeK8GAnc
         DClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744399; x=1794349199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=II++MBTxIfm7+40C0d97qzww84Xgi24DoGK3RupOEK0=;
        b=YcdQriuXAI7ToRvkpDUNa/XIp1TUtSHj2A3bxSrX2jz9aKGM8ID6+7S1CCgAquKnWc
         JRZ+qvD7LTq7obpfpj4xWCLtd8wlE1nwtYc6I2I371xjlk+0PLRe6he0gNVxoLRff0C/
         uDSyRXiDn6eeqgmNh7DbXsEzVxZBUnrLKW+LoStyYiZSzUcVqiJ8xAvvMbLx8/yVWNlo
         Byy2sEqSvhAzPV8mnkwPHNEsBYRur8bHmVptTINoil/vuPxdFYEFiLKieK+YjoMk0SCv
         MT/zQ9bwsBOCyAqu7SD0/e71xaKTkBLSvchYhX7fxLaAL3gEijP6j53smHdhoS0jatth
         xLPw==
X-Gm-Message-State: APuU4Z8JNfPFFIOBAz/Z+ay9Kb0mt1m8Fz0eHaqPkX+FQ94cGzXd81oS
	03VRs1QiV4y+S2CPdAPcxcK61cHYno/bNNjPGrpvMpNuxsCcmFtU/b1tzXFKBw==
X-Gm-Gg: AYBFou2m7v9xAcGlNGcnZLU7qJm/rzzB9xaX2C7lRTETBEXeNVXTmNIA7SJJyprZtUe
	QkduyKG++ONtG9qa+F0aXs5pH9O/nk75r93EqTIjodC6A5Pr+8OOa9RP/EhMbPq/jcud7sl/nCD
	MwKjTexSCMKT8sfAW/+WqTjm9/k6PhLbcSQ5RZUZlj4IvgTIcqPtIy0Mf2Vyez2zIS1ip6dlH+u
	Dr4WsMt+0DUxULt4Svt4T8255tn+BXWvbPPs/RaoHaisISodCec0DWEwo/Eh1M54tZydM+1yv24
	+vOLCXWWhgbDR9B+idt/P+whrqhOukBgSZSknjHW6+3kLhtve6pp7LN1rId1D95LiGBTBoRMURY
	mUkN8LU/YMZUetybCUBC60DaVgINbblHS7xcmOaWUadWdckowfBaXVVwkx0nVgJCmyHBVXcejQJ
	x9TNpsiOgKmhzzW23W0yd29SrAoaULUkOFgDC6W014i67NlZiVPcXZnu1oZZGAWXk6pCEhMqfRt
	Iow9Hbuhj03W+mgk8gQhqFbLkZ6ZS6iw2WQbiCfbf9IWrL+Pfylei/M/mPhnViRIh14si3WO17B
	JeZGH+FwdbLDp+Cc7fGhHXZ0x0K82XMxIfL+xRCe32GDFh1WYdaM3eD4s0/FDO3jCtBybkPiwvB
	Th6Sl7UWFbk86hW+2QQW/ynAhefKfyBcLIXyVDj91qCiO3iQM0FVwufdvE/P9phH8WCTWmQGtkL
	3JVgc=
X-Received: by 2002:a67:e112:0:b0:7c0:9788:b46e with SMTP id ada2fe7eead31-7d072d2c920mr4266268137.32.1793744399153;
        Tue, 03 Nov 2026 14:19:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/9] main.conf: Add HDT configuration
Date: Tue,  3 Nov 2026 17:19:41 -0500
Message-ID: <20261103221944.4072041-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
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

Add an [HDT] group with DefaultMICLength, DefaultPacketFormat,
DefaultRates and EKSOpportunistic, and pass them to the kernel with the
LE HDT default parameters and Opportunistic Encryption system
configuration TLVs, documented in mgmt-protocol.rst.
---
 doc/mgmt-protocol.rst |  3 +++
 src/adapter.c         | 28 ++++++++++++++++++++++++++++
 src/btd.h             |  7 +++++++
 src/main.c            | 33 +++++++++++++++++++++++++++++++++
 src/main.conf         | 27 +++++++++++++++++++++++++++
 5 files changed, 98 insertions(+)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index bf6a3b20084c..c4e1421e3a5c 100644
--- a/doc/mgmt-protocol.rst
+++ b/doc/mgmt-protocol.rst
@@ -3469,6 +3469,9 @@ Currently defined Parameter_Type values are:
 	0x001e, LE No Filter Scanning Duration for adv monitoring
 	0x001f, LE Enable Interleave Scan for adv monitoring
 	0x0020, BR/EDR Connection Idle Timeout
+	0x0021, LE HDT Default MIC Length
+	0x0022, LE HDT Default Packet Format
+	0x0023, LE HDT Default Rates
 
 This command can be used at any time and will return a list of supported default
 parameters as well as their current value.
diff --git a/src/adapter.c b/src/adapter.c
index 6588a6e2bdc9..f967f6132012 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5167,6 +5167,34 @@ static bool load_le_defaults(struct btd_adapter *adapter,
 			return false;
 	}
 
+	if (btd_opts.hdt.mic_len >= 0) {
+		uint8_t val = btd_opts.hdt.mic_len;
+
+		if (!mgmt_tlv_add_fixed(list, 0x0021, &val))
+			return false;
+	}
+
+	if (btd_opts.hdt.format >= 0) {
+		uint8_t val = btd_opts.hdt.format;
+
+		if (!mgmt_tlv_add_fixed(list, 0x0022, &val))
+			return false;
+	}
+
+	if (btd_opts.hdt.rates >= 0) {
+		uint16_t val = btd_opts.hdt.rates;
+
+		if (!mgmt_tlv_add_fixed(list, 0x0023, &val))
+			return false;
+	}
+
+	if (btd_opts.hdt.eks_oppt >= 0) {
+		uint8_t val = btd_opts.hdt.eks_oppt ? 0x01 : 0x00;
+
+		if (!mgmt_tlv_add_fixed(list, 0x0024, &val))
+			return false;
+	}
+
 	return true;
 }
 
diff --git a/src/btd.h b/src/btd.h
index b059ab872764..9bf310271972 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -180,6 +180,13 @@ struct btd_opts {
 	struct btd_advmon_opts	advmon;
 
 	struct btd_csis csis;
+
+	struct {
+		int16_t	mic_len;	/* -1 = not set */
+		int16_t	format;		/* -1 = not set */
+		int32_t	rates;		/* -1 = not set */
+		int8_t	eks_oppt;	/* -1 = not set, 0/1 = off/on */
+	} hdt;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index 8e58b6b58ae2..729a6faa0892 100644
--- a/src/main.c
+++ b/src/main.c
@@ -190,6 +190,14 @@ static const char *advmon_options[] = {
 	NULL
 };
 
+static const char *hdt_options[] = {
+	"DefaultMICLength",
+	"DefaultPacketFormat",
+	"DefaultRates",
+	"EKSOpportunistic",
+	NULL
+};
+
 static const struct group_table {
 	const char *name;
 	const char * const *options;
@@ -204,6 +212,7 @@ static const struct group_table {
 	{ "AVRCP",	avrcp_options },
 	{ "ChannelSounding",	bcs_options },
 	{ "AdvMon",	advmon_options },
+	{ "HDT",	hdt_options },
 	{ }
 };
 
@@ -1398,6 +1407,24 @@ static void parse_advmon(GKeyFile *config)
 				0, UINT8_MAX);
 }
 
+static void parse_hdt(GKeyFile *config)
+{
+	int val;
+	bool bval;
+
+	if (parse_config_int(config, "HDT", "DefaultMICLength", &val, 0, 2))
+		btd_opts.hdt.mic_len = val;
+
+	if (parse_config_int(config, "HDT", "DefaultPacketFormat", &val, 0, 2))
+		btd_opts.hdt.format = val;
+
+	if (parse_config_int(config, "HDT", "DefaultRates", &val, 0, 0x1f))
+		btd_opts.hdt.rates = val;
+
+	if (parse_config_bool(config, "HDT", "EKSOpportunistic", &bval))
+		btd_opts.hdt.eks_oppt = bval ? 1 : 0;
+}
+
 static void parse_config(GKeyFile *config)
 {
 	if (!config)
@@ -1417,6 +1444,7 @@ static void parse_config(GKeyFile *config)
 	parse_avrcp(config);
 	parse_le_cs_config(config);
 	parse_advmon(config);
+	parse_hdt(config);
 }
 
 static void init_defaults(void)
@@ -1444,6 +1472,11 @@ static void init_defaults(void)
 	btd_opts.defaults.le.addr_resolution = 0x01;
 	btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
 
+	btd_opts.hdt.mic_len = -1;
+	btd_opts.hdt.format = -1;
+	btd_opts.hdt.rates = -1;
+	btd_opts.hdt.eks_oppt = -1;
+
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
 
diff --git a/src/main.conf b/src/main.conf
index 7eb75d87163c..882b0755ac35 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -253,6 +253,33 @@ KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
 # Defaults to 1
 #EnableAdvMonInterleaveScan=
 
+[HDT]
+# Default Parameters sent to the controller via HCI_LE_Set_HDT_Default_Parameters.
+
+# Default MIC Length
+# 0x00: 32-bit (no preference)
+# 0x01: 64-bit
+# 0x02: 128-bit
+#DefaultMICLength=0x02
+
+# Default Packet Format
+# 0x00: No preference
+# 0x01: Packet Format 0
+# 0x02: Packet Format 1
+#DefaultPacketFormat=0x00
+
+# Default Rates (bitmask)
+# Bit 0: HDT 2M
+# Bit 1: HDT 3M
+# Bit 2: HDT 4M
+# Bit 3: HDT 6M
+# Bit 4: HDT 7.5M
+#DefaultRates=0x001f
+
+# Enable EKS Opportunistic Encryption. When both sides support it and no
+# LTK is available, the link will be encrypted with an ephemeral key.
+#EKSOpportunistic=true
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.56.0

