Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328515;
	b=HKnTe0G9Z/Vde6JLdLtgcIvyR8dzT5kPQCL1MnTQlVM0n5h25BWyO4Krqhph8QiicO55
	 2KJwfwLRyM6JrrkujptVDmXB1Bm4ETWkUh16g8qcqahMB9cYEGpuuYby3IHZ4qCzFtsYf
	 LyGgdCyoRBLCxojVoI5HXr2NSngXf79mFoAhsRNpTz/SlllL/Avo3iTUFBnRUq6aM6fqj
	 XZfhJCw7HFJgkzzL/m1jSSyC0GJ0u1L9E7Ulp1KO1Qk+/k4SQ7s+DrLKC182PIJon1iPO
	 BkrmvoQDxIV5rd+NViDHSHJdRtgBqAM2eR10PH5MPiu/8hcyymC37A+I8zuLs3+a07Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
	b=Fv7Dcgx+RNogkMkOBKEFElsW1VgPlgyp2VAA4cegeOl1UKhT+vgoknO3a9MzyU7v6cYy
	 ZVhOIHDMorZc6cAYfeCghTnKgTEBZg8npcmIQIfavMUq6u7xk+NvQEZI+rQr4b5BuA7Kn
	 7KM+JidmiyiLQ84l55Y7V+xKMPOFbi0AXtfLFHXJRkFpm3xge5FEXwN4xZd/2ZcHk9bdv
	 I1o/AwRubA0roaR9YWSvtkmcvkvf4jxTIpmdnSym0MS537nrdy3y0bWSabFWoZSYVNRHE
	 FvZswJHn8scq7ok2E//tiiyzvLr5a+yq6DZgmIoyRQ86+wciKob4T60RgnzfS4tYK7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJrCP0po;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D40606A20B
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D40606A20B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJrCP0po
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7a6e560f580so1650108137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328514; x=1794933314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=YJrCP0poQc0/jYk7gVQ7CcTVAajB64ymex3QbGW8GXvuOFEU1J2K5vDrRpqyCLi0Lv
         qCHuT0e2hqHBjdkPt1YU8kNH50GerUl4UTm98mGJuoczFbxhw144KOxljD4ZkZx8APY9
         7/qyg2bmX1mEuCXzdE+BYCzt+hBJQ6YjIWrVbWObL3KDPQ5i+p6oL+h5rxqTyNTeT8Fa
         Y8fpEDkfg7RSD7bQghMJX+YBYgRrOVEOae59NCBUvJFcaOnIE9L4chwDiPvjSwfqaB3F
         NvvVGJ+V4BI8TsMdpwAqMAP+dfmh5jhlOuYPFsYQK1Y7gjIRvtC3QTu+/UVfkN6pk8u7
         fH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328514; x=1794933314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=BDR4MaDev9vkHDWvRzCALNOG8kuECg6D464bial+oSgMq6SvbF7dZxC7IX37nLPoBW
         BONfmX2tWL0aD8Uxdiam0QCsqrjVQhZqpGE+2/FrwUi67+7fAhoPKENSISUEbZ2TBIXw
         USFd0qQpPgs6CKSpXvCIh/2lIW/zyjpQMnrgQ9rgpK8hSBJLNYYtq/AYIF7W31xgWnC5
         GsPgfgMfqUdXvuFfTxUAghehNMjdg1FTcwiESqgChZXjZ17V16sVWGzTE3IvMIogofEc
         /KsPUxZCZjt51WN4XbPaBNmfQVaObm8AkIRrI1U5MuJQfx+spyahZHJTXwwp/CkdXLL1
         VP8g==
X-Gm-Message-State: APuU4Z+zEhSEk8/IayK/T7WrinJUq+2V4Wo+fsLBpGQ7jSj95tWRw/pO
	q1ZqUoA6Dj4/A58LDMAuoMJs4Vww+D9WBQv6L60tM5CG+HMNs5NQTtIhLwyboA==
X-Gm-Gg: AYBFou27bYIdaQUl2VApD1duJnO2MwvYoAVhil62zy7GnJiV1ws5QZHeytE9SG4w4yV
	AN63ecIJVYBSCouJ7L+Qe3/bglg/H5j38s3o5wqLEb4KsOtl6mmW21eeS7Z/NQ8cdBUrc9TnpvV
	NQrjajJzSYNfCzKqMwh8j5+kNQRb+DjrE/poYqmPpK0yiKcR2z5S9qH3IHjAoyUObKaookNZwd5
	vf7Og5Xr95sDYbVLT1rVpF9kODo6LohrftbnXST6gZbPwKkbUT6XNeVQmtTNJHIqN5pgkHks49L
	BxhPZObSg02tUfaCdCmv59yrn0ieaiSAH0H42O7aKQHOOMRIeKWjEbQn4mfJv8W7S9q9EShwxmN
	OoO3DdZ/SFtgEAICDZrcIVe6x2+abcf4gl3yEMUl0GoQaB0wlbZwF7M4W5whOhvDfReXClGJNfQ
	8KjOAenwS/tK8MRSB7QnE3IIY0vavuB8dqU+4/GrRWALCY+wfEhHNNbJzgD8dymklWLqgfjVwfy
	nfkHwLRyVIvNBtyghmCSoOw9D9bSlrrpIlEetARQXp8yf8Nt1NOUizTS2VZxcQ39XWpyPWqRIro
	EwozFSmiYluZpx166dn4jcmp2txs0b+66nBjCiIYFeXBq5RWSB8wYCU6CC0LEkOQJ83xbVnG0ih
	bIJxMmPQts77qUj9N4EQxsn+taukYBlvJnqQz0aagcTQrMLmzq21Z+5wFidVulMyDdsDo4lnV9S
	romZw=
X-Received: by 2002:a05:6102:9d6:b0:7c1:9286:296f with SMTP id ada2fe7eead31-7d301bce4femr1172871137.25.1794328513473;
        Tue, 10 Nov 2026 08:35:13 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.35.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:35:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 09/11] main.conf: Add HDT configuration
Date: Tue, 10 Nov 2026 11:34:49 -0500
Message-ID: <20261110163452.2649366-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110163452.2649366-1-luiz.dentz@gmail.com>
References: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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

The values are those of LE Set HDT Default Parameters. In particular
DefaultMICLength can only be 64 or 128 bits: the spec reserves every
other value, the 32-bit MIC being the one of the GFSK PHYs, and the
controller rejects it, which would fail powering on the controller.
---
 doc/mgmt-protocol.rst |  3 +++
 src/adapter.c         | 28 +++++++++++++++++++++++++
 src/btd.h             |  7 +++++++
 src/main.c            | 48 +++++++++++++++++++++++++++++++++++++++++++
 src/main.conf         | 27 ++++++++++++++++++++++++
 5 files changed, 113 insertions(+)

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
index 6588a6e2bdc9..ea438375cc72 100644
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
+		uint16_t val = cpu_to_le16(btd_opts.hdt.rates);
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
index 8e58b6b58ae2..3a051c5a46dd 100644
--- a/src/main.c
+++ b/src/main.c
@@ -190,6 +190,14 @@ static const char *advmon_options[] = {
 	NULL
 };
 
+static const char *const hdt_options[] = {
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
 
@@ -1398,6 +1407,39 @@ static void parse_advmon(GKeyFile *config)
 				0, UINT8_MAX);
 }
 
+static void parse_hdt(GKeyFile *config)
+{
+	int val;
+	bool bval;
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.159:
+	 *
+	 * Preferred_MIC_Length: 0x01 Preferred MIC length is 64 bits.
+	 * 0x02 MIC length is 128 bits (default). All other values Reserved
+	 * for future use.
+	 *
+	 * So 0x00 (32 bits) is not valid, the controller would reject it.
+	 */
+	if (parse_config_int(config, "HDT", "DefaultMICLength", &val, 1, 2))
+		btd_opts.hdt.mic_len = val;
+
+	/* Preferred_Packet_Format: 0x00 any supported, 0x01 packet format 0,
+	 * 0x02 packet format 1. All other values Reserved for future use.
+	 */
+	if (parse_config_int(config, "HDT", "DefaultPacketFormat", &val, 0, 2))
+		btd_opts.hdt.format = val;
+
+	/* Preferred_ACL_Rates: bits 0 to 4 are HDT2, HDT3, HDT4, HDT6 and
+	 * HDT7.5. All other bits Reserved for future use.
+	 */
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
@@ -1417,6 +1459,7 @@ static void parse_config(GKeyFile *config)
 	parse_avrcp(config);
 	parse_le_cs_config(config);
 	parse_advmon(config);
+	parse_hdt(config);
 }
 
 static void init_defaults(void)
@@ -1444,6 +1487,11 @@ static void init_defaults(void)
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
index 7eb75d87163c..714e1e6fab49 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -253,6 +253,33 @@ KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
 # Defaults to 1
 #EnableAdvMonInterleaveScan=
 
+[HDT]
+# Default Parameters sent to the controller via HCI_LE_Set_HDT_Default_Parameters.
+
+# Default MIC Length
+# 0x01: 64-bit
+# 0x02: 128-bit
+# The 32-bit MIC is only used on the GFSK PHYs, so it can't be set here.
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

