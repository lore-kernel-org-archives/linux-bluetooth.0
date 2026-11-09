Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240971;
	b=qGlIg5cYCuzXeFQHP0iKGr3st1dk1IQJyY4SshBgH/Ocn6JR+rvkkt5EW+yoP6DpNxXc
	 xzcW4/THWWiTgZtQ8YcobMGUMFsyioI24rVNuRTsLbOIhebYg4bJkPzz6UyKHKBci0ovm
	 Unqk0SkD2q0QHnISSpz2dKWyP4V4XpvnW9L2+tmFWnMUl+ZcLltHo1crwb9qHC0ynxBfW
	 5co0P5Ftp4lQ8reXZZZSyng6W62FtYn/Vm264gzrsLCzz9/BFaiILSvNAnxk5spyCIS3H
	 lsAY0qOoC8bh/r4qjzHIbI/uhPFrAYej94kyRnBM7tuySM1owdhbyZ1a6pSHk3AEfTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
	b=C/mwO/7B0OiZ2r93VLp8ESR+SDeP+ntbF4tUIUsLTZnEGM1auW0hVfO4qOt8W0gZ4MOb
	 XPc+3qL4JUR5FDW0XNvkQBguQI/QnPiCNMULxKms/S6iV5o/LGgTT9S8vVDa3rvbkkGhV
	 N3q6zz9OH4yb7imObuF8HzE5pfimXzg8wYgY9GJt22QovzsqD7pKInOqrec6kz54/cKVJ
	 Y5jqu++YUtCyva/i+ZYkv0FfOu3yRhZ+nd/riyDpGVG1bze0N3NupCKqc+HUOWYrHIre0
	 FzR6tn+9RKdgvGUjq5VvfigGK45KaUT7JHGv8fMN9oQ9x+/OHGyhhat50wkitwChhrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egaqW001;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168E606EE85
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2168E606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egaqW001
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so844455e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240970; x=1794845770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=egaqW001JjEqTYuQwhu2sHFocAWMwDiKifnXdBNFORahz+4fqzGqJr6bp5ZAewd5Jg
         g4JwJbtGc3ANLuP5/ib3rjHLfHHPyl6XAwbP2Zd8jvm1OaHA+Xh/PYSk2BKcmlBMzOyN
         CQFuHJiSedSlGmG4+j1LLsnC8Yc2hZGmEEJAjxlSuhplenubP6z01EkTqB6M1NiXpSp4
         OHOLFAAGXE9PQonugLRSCcETpr+Iiph6PADsg9tH1DItUJZcv2Ud6mWMfw2RBJlUZprS
         rMOoKSJMyIFfxQuxzSBKXVkAotCjTG4oLBhCAJW1mpcS4C4vCCBn5Z4wYhM/TXVwElTg
         PaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240970; x=1794845770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=Td+Qk9BQGaqeXQqY6RoOOABU3z/sfrnulJVXq96d8WIVloL722+p5rjVTxfXo/cjf7
         4/qomzmTkjkzcjAPIUtJ1iaOgyDlQunekfpFD36yGuvcoudv72SVZa2T+0s8FP3uv1/q
         cQWkEsR/AS/F8ECyQEYzUkX8kCVTPcsTF1wb5PNaubg5xfsf2ENlS1cYkl8kYUaLl9Ej
         ng4iV4GuQHk5hgMJ6iSSQPuYpxfyjq0lNZIAqBwnxVQ3/SI7W09RVZ5fIQMYC146U4DD
         H3mSCxpD1yygOZ5p1XbTX5QcoN9a3mIgqYqDLW3uhDKHzaJL+4V3q5QkWZWBctr/ZWt1
         CjsA==
X-Gm-Message-State: APuU4Z/bIc1+QXPNTLIKIrAxobEXvIY7HEClw2H5tfFXY5V7iQ1rMFsD
	xjxK3wHDvanhoXwoR686ds+kqCqBxS9KBk8jDHWAyHGI+KF5Mn6mCtQuTQ4jpg==
X-Gm-Gg: AYBFou3VE7gVIuo1rW5QQzYAS7o4wPFlpwgRzaGL/E7mqD2MNqTaRkGka9q0exSyvV2
	yr23jn3MmYM3tMYHWhdRaT/5aTKXDAmoSsND82gVnAfMiYTmw0VRDwO5Yk3x7J2PvCr/E6dDg4L
	w4tJHxnfam6aER/uArrwmLeIyl1DXsmZKvBFkZVqwzCd7Aq70HGm2uj+oQPFYDEXarSVs61yvV5
	oLQEFSRzEDqkSF87TgyCm/r31wmCL/2O07Uq85IkiXdKTyui0LkMZYXrmyGkDThzMHzke5RYBPU
	k9QC+kYdgy5aAtb8v6p44Sc/2HETI5K6/iI/lRSbc5rBmP2xnZkh07bozyOLw46yt1gZImpbREI
	bicS91DN0atjlWvtbwDro9Ao6vXpURjv5lU+/dH/CNUv0Im3ykrk//FCU4QvDHcEekWHTnkEJul
	7iGENCjHJ5lJ+DdcSN7NDki08YNCpjCu4IdGFnKws5jNIuErK0bRfFh7AXlyfiJQfp+USZu0isR
	/ibApC0HGpaisX5TIuj4FbuuLifbsiz/CUy/gIk3aOUinWJBHk4/I/5zrErPVmvKsGodv5CmS+2
	kzkM1qNjZxRGfN9opv39NCzqPZb4hTKEQGF7wZ3IpEmolL8zKfOdWskQwIHoKvD17fpsmMXpUjl
	zuHNg4ImDFKHj8xSilG0u1LHW1O0dcCIFloW/mpVNVC837GGRTXi/bfVfd7xm6sHoa0tFdRb9em
	8eIrU=
X-Received: by 2002:a05:6123:4210:20b0:5ec:d7f3:4f3c with SMTP id 71dfb90a1353d-5ecd7f35068mr1097458e0c.12.1794240969929;
        Mon, 09 Nov 2026 08:16:09 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.16.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:16:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 09/11] main.conf: Add HDT configuration
Date: Mon,  9 Nov 2026 11:15:49 -0500
Message-ID: <20261109161553.1506041-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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

