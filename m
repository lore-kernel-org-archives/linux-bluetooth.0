Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087987;
	b=f4ZYda2H0luAkIHWPYU8RqhCsXkxw9uYBeMfKJ8J+VlEhWSO5cyLsfFDfgKPDEydkkF0
	 kJ5c8bWSGGWzDXYAYlWsmkHyaNjen3G2kgmsYMOcqLfbCU76LpNfgA8berEwWBXbLjw08
	 tQbuQkPT0anCym8qxMjaZMDM3Ic5O3Uw2usjEZVS2d1CI3QBeASM//ZWkG2BXs2crnTJy
	 NgekV4VAc7o1qh80/lvbTfxOms+TwW1ZHYcM9jRuElrnFdVAxwDa8unWJQcoFWJ/6hMw3
	 NdsU1tIY2GOG3aTz+xr+BWfaSYriKSvLAr3Y8h3xMsFOizUqoSmgD8tG3U0e5WRCROQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
	b=kdzDTFRihXnpxASRAc+V4IbzPzr94qZefl9USSRtvr8RFelQcMtIVOOU0Lew1MXG0kEA
	 ZUViOh4ZIMgnZ2ysVd0Kx0Vesgmvq308i3AdPE2G2uI6Xq76j1NNs/XqUCxZWlYG7H9v9
	 0pPRmcpT7iyDRH1hb4XScrnkcQvU2V+qhVfuNuZXd+C75Ag671OPKBGwdnEa1w6QZE2aL
	 iOXV6lgGtDPAd77VA73SVHeir4QMdjgzEV476xvVyE8fCKhfcxt+PpSDo3wy+pf0i9MVY
	 3rSJWQ+CQxJ17iXOWyxmLXgbiCCHRoihfYtqoOfN8bU7GUak8BHIm5MtmwKtaOqkFRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxptnoIu;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEE606A330
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 21:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12AEE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxptnoIu
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so59280137.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 13:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794087986; x=1794692786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=MxptnoIuVsSVixbqiNw9H/5Ia2JB9A9mt1zB0S5D+TFzeq2iCxSkj4UB23jat1PmB9
         pEtoihCTHR6ov+mHTl1bNeKTNFwBmnUHDwHvZH0xPBGB6o5/gayqnb0yu3CzsLpopmCB
         x0JrH+FNlUixe50K9UHkgyTZs6P87aumh0oNRky26cGk0yd0vn11B1umfudVhT/DoE/m
         vMeyM3Q7JS9pdnJZTaROwCWnq+3liiksmqawu1gFg0G4YUdF64sEMu+h9ho3v2OBouKd
         foA+GyPsaV5dkIMZsMnkQPBK72nCBsmjFDYIb4UaVUfBmgIHUpK61QDCNGdOyTJcNIJD
         j70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794087986; x=1794692786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=wYQ+54R1ssbafcZCV5Qp+6LqbUBvJ41RvseF4h4JI5K6fiwWQTP7M11/wIEOO9wMqa
         nqXuRb6vbhZrz/Hxc5Sz/4cA1CjMHEXk3+R1Vynu3by3sJZH+uOEn7yvaB1H6J4NN/7x
         1fkfKtOyom8YTV38yzqevrhRRjipFLNWNeC64yqlv5BlQwaYNaUunjILnbrrtVREhfc8
         9wZE7ISZHh+/dzqSrh+3Z4NXiG1GpzF1PWks/gfyLR27H5WutFtrtYLp/XgDSjEypKDc
         OBmQNyiEp/xtHHsH9e500l2/+JQHxllKOOWphqBlk3ST7/dVdcL5YtbLIPacjUQ0HhZU
         iLLA==
X-Gm-Message-State: APuU4Z87DoOSYsIKE1SRQ6kKeUFUgMFA3w583vwJ0zSUx64sUF1fxXXj
	ler1uSTgKRg9bp4iS7MSP3ikY1CLTAc6IMBEJRPilNMP99wlO1EFvHJEm+m+tw==
X-Gm-Gg: AYBFou10Sh5iOLbQUS92o7HyIoV7gYF7OAJ1rDc09gMBoS5Yj4vtq1vDue4LfY0+pDS
	EtUJ9tAmd/8wo/17TZDbtAZ6t3rTx93V3ks2hXM3A19XT+aQNd+gqsX5wb6plsYDK/rqdaJ7/aW
	/N1vJev530fx8xZx3N72iwIGqFA14EgGmhIpcThPH1Rf09zjEVcOQHjPdpP9Da7bphvK0e8BGq/
	zzBc+Y4mhrFmFYi0XUXqHinQmwqHIgWKnBGTpTupWFQG9qtuz/9D8UGduYTkGlrqeeEKXEUOJAz
	dmLM17QejLaYZv45ME/Zrw15a0bmFMZU08K/KCwIcVn/S4U13N9qCYcLQ00dhSrMXpczn+9jyGR
	39K4jqrOeFwGdzOcg2R83JWoJ2B+1FvHjterTe53a4HsWLWZk0/LSNiJOeDwkoXu8e8B3xAzcAT
	IPXLmc3aPvKJWjh3Lt3fWf/JLzQ27TSyKKctCfEITDidFVgWMdGLSMlKfiyH/40veOhp47M4Jzg
	si3kqY309xxeGKIChzC+n1HVCttcJDsJ+xUrqNgNzlOv/YAlQ2JfW4mWx7z1tW3k2OXxja+Sdze
	hfQqJy8yY8r2uVGccy5w3yog3nCcRGgVk9TQq82K/LB5apt4PgpEE3vUwWvTYGb5hIgVM0TFBhf
	/2ThN1xUScGWPemSdB0UvvNq5E8bdktU1rb33JjDR1z2lYfvMH9Cma+52tjAtIUMY03ij5w+izO
	hlaZk=
X-Received: by 2002:a05:6102:41a8:b0:7cb:bd9b:4873 with SMTP id ada2fe7eead31-7d2bd87885bmr570698137.21.1794087985791;
        Sat, 07 Nov 2026 13:46:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6418de3sm382617e0c.13.2026.11.07.13.46.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 13:46:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 09/11] main.conf: Add HDT configuration
Date: Sat,  7 Nov 2026 16:46:08 -0500
Message-ID: <20261107214611.388705-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107214611.388705-1-luiz.dentz@gmail.com>
References: <20261107214611.388705-1-luiz.dentz@gmail.com>
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

