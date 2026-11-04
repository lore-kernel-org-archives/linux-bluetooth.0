Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830866;
	b=tvVQBMhTz9g8ochTyRsTqsERh3qZp2sx2IIsCt1Nqcsf3fGK7xBa789T64prObaD9dn0
	 mAN6743gA+Q295hREOtHKoe+T2R3elwuQm03nX9Snytj3VvIEHZqlroS4FpziYcuczldu
	 /HitDDJQq+PkHllE7qGmtRHaFgVm/KwML9IcjUwREM04i1gCsPmRfZD2KYuYPhsMs4t0G
	 5pSUP1lZyCrr97ZMX4ip7YjCVUnvznv3y/oeh0IZRIJTF5TP10KqnbnIplh9mTQhBPL95
	 LoN8fnf1Q/OwyihclLEuFu/osIMl096n05bTZsyin3GxgWEiqVBlQZWZoX74WUe0ulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UySLUbhzLCCE9hsHLrQwYAWKjj3TdpBgYq7O7TGNa0g=;
	b=aQLzW5BSBQpSrYHcapkX14kcXoO/AzRLps1L6WNaqKoa32og9IgNrqKFh1bsZzIArqgU
	 b2mCCj7cHL1VVH9M3A/wpkLAvjVq20zCaK8npK2AzcwRzrVTDjKIIjwxDaJfiXICXmC3m
	 wJP42KlBKxz4gmrI8VQkLj/m75B1ks6pcpl8OkwsW3SAwr5gm9a7SRJvFM9k4fSly87FV
	 8G8yeiKeuaHDJkPPjylXnqrn2a0RXHCaU9cDTk+cr62KSvaX1FilyXngwZT7QPNOKA2MO
	 UR0Rg3rGYrjuSICStam/gzDI3+Dw+ufzoz0zNiBwNjzJEyJIdGLC7L23dWQGubSTaxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KfG3u8ux;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A5606D824
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9A5606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KfG3u8ux
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7c33cc572e6so55118137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830865; x=1794435665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UySLUbhzLCCE9hsHLrQwYAWKjj3TdpBgYq7O7TGNa0g=;
        b=KfG3u8ux+252MPB/3nQ9CztuJ0ZlpYCVLWMki+KMFfv341yRbGsP1+xiVn8yBryEJR
         pBflKsBVj53tTM5EN1xwBq0HwIAOlXOVpQU7h8eSjIDn9zJGuClgfffxNcbTFI4bjmLm
         +OuXNzx7kfLCVrbqmnjRY3K6n84L4oot4NfeBEm1yCzr0rfnLTaNAX1A5DXKmfgm6r1p
         Jw+OvZ4u/qfkfcJF9InmduJqk1JLFASUk7aqN4q6u7f/rrekAVqL87MaWVf9oyhldfsp
         +1mwqLuxJOV7beJbpDRpLLlJjRyNX3g6g5Ksa/0xbCm/Ln3ZoZrRGhBTR249nmsXs76T
         QTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830865; x=1794435665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UySLUbhzLCCE9hsHLrQwYAWKjj3TdpBgYq7O7TGNa0g=;
        b=Y+Jz1xVfl5aXE16xtAhikYjLzvVUYgCmrSNYjXP6w3LUBm5E8vh6XgJ7/43ZKuW4GM
         hvG+lthoKv+fpRlJtKOkVYFbnZrOiVFHHZRch65pMRoLz7Fi/50OmxfkzeJ58FGtEhWW
         N3v3PSsbRfUF/Jmst6r16NQ7gAjtXwBvIEC3mPp9yTpwa0d41RWc5shlZqWmo0MpvTBG
         RoJZv9AME0E2+BkhBc7R6ES8a+G6VcXdVMIFB2vhgpwwlM1iQjk4y7dXKmHrRRmlIXxF
         s9PvPL6Q2wqPYRhV5g0j39u1G/wyN+gXd199QD42mD2uWBIYIUDd4QogxePCw2WvU65o
         I4ow==
X-Gm-Message-State: APuU4Z+09pkH3ElDmwDWsn2kjcy8xCie/wO4BGLIXgsnUSCU4/AhF+fG
	po0tXyx6Y7dluESYcbUS4uHRPIN7fpSbNhvSGb97IX4dV57iZ98y89kRPntgOQ==
X-Gm-Gg: AYBFou18QbikCP1PtyCkoXlJovK1jjKyzVquae3FPaEJOLMIUH02oZWHTy525iYbKxa
	cjlextshfvTx5Pu73yao6bLqQDfTpbS50sOPKy8DqvOEQDDF+KfDsZ3Y+SuvLm0kiz59IIHKxd7
	KjWclcALzSNPRiccpQWDNcBWqypeAVI0Ih0U68U1WN9hv4e4S1n1Fp86On08IRvh4QBjIAH3zBL
	uFElthwvMp2qkrX7R4lJxPDBaVmuCICmQEJwfIGZ8rMe54iL/h+lVdtFxJKkUU9dEQeoiFDALB4
	BjkUpuP/yhkVrNR9XLIA/xEG3D0qsx3TU2n0yx7p0x99PJKxqMn6cStvWRgF2NnlA73ZylmHrAo
	d/+2Fp58LCfvBVA45lavoJZg9nTbkdzOkmq2m9AnCNmgGoYkZ0QB6whHeGnutDk9P4OY0Vqez4o
	OOvaujHxhM9ymZ2vkNtoL2V5hIKPM+XgyrUaflQOHK2F5s2/DooFuU+bi+J3Y9vbpXhdlPykELf
	Yg23u8V5P8GB51t3e7+HYCEPAKxM4QgUvbMdM8uzr4O8p2C1RQ7UsaiO+EBvDal53hoMeb8zvVM
	IavsjUsM++PZYdtnY65h+YAAzIEUpR78C9P91sP5tbz8Vz4eAB8le8/ZQadGRJaF64Qaczx28Ej
	CFtgvV3BwzCB48uaY8FYNzZicWzfxoE+JfHObQOfi0EvEp8/vmBEIzqaoS42evQPU9KmSmSqQy2
	z9p1Y=
X-Received: by 2002:a05:6102:3f0f:b0:7ce:78f9:ae13 with SMTP id ada2fe7eead31-7d2869bb17emr345939137.10.1793830865012;
        Wed, 04 Nov 2026 14:21:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2852206e0c.1.2026.11.04.14.21.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:21:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 08/10] main.conf: Add HDT configuration
Date: Wed,  4 Nov 2026 17:20:52 -0500
Message-ID: <20261104222055.1207928-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104222055.1207928-1-luiz.dentz@gmail.com>
References: <20261104222055.1207928-1-luiz.dentz@gmail.com>
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

