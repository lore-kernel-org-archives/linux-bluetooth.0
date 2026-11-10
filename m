Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349525;
	b=T7aCpMmlWp8MSNJFm2DoudPC2x4zL4QsH/OvwMKxIVCk8wyIaEe+CbdaWZx7Ir5fSnOr
	 6+09+o50DLP55fn7S5OtFc0d6NzTtxRll0E/q3ngsff2r9NMYql+tSqPcCKthP0zHqu2e
	 dgkIy85bcnNXADpL4L37xEJqFK5ee71nrJJngTOX8Qj+5+ZUbeg1kB0+WCraxgFYTRTS5
	 U6kEwWjMmTD8OBpxbEavuUUmvQAWUQfN2OEOP/jqnsuRUxbUqR3IsjO+e3OkNfIJqNST8
	 s56RCZ9K18tkip93RDfwia2tAe6yIg1Md6Wo/YDfQdIXWT/UtgsVo058HMYOevm1uiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
	b=Q0/p8hcE/UCuCoEeK7SBMwnFqQ2zAgqwUA2W8Vr+9be3DyvUVk5ThNpUor2xbBTsC8yt
	 AOZ++mLRPT7aTLh+dxqKK/sfsbNKWo0U08NSRood1Nh1abX1LebLOa6nTcw8S5oEP0Mxw
	 WhGZI6VsqXaOjTiv4XIk0vqnFOTCKLGQImbIN4t7GqGzAovDcDR5pae1sV151cOGXF0fx
	 x1hRYZkSGP8kkh+TXFfY7oYgbCRbfpnYQDGMJhYdwdPnWQa97//GbiwZM7UxiLR1sbeZy
	 1+qgTiAHiSYkzwuHZlXyAWaNvV86btLtwjsb6i1SNcOH84X0wz454tuSCjG0kL4dGzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ib67Mv79;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831F606A33E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9831F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ib67Mv79
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso1239390137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349523; x=1794954323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=Ib67Mv79dT+tYhhhfgrPIQGW/bI+5M1wSkye14lWt5TymhdrN6UN2JdedR9oVsqzu9
         zx0KpR8enPQhRbKu6/Ocym1c5nGwbBw0YkUsWJk+bjDigYIG73kkr7kxEnAUyxqTAD2b
         UE8dOtCzcEk10X9WEoekVwtDUjySslDMF+VS09zzaNPdMb5hXYja7cDI2Pf/7pMtQpzY
         DiAkXepSoeijivtrci3vGa+/1IWb48T7cKt0lNpGGwY1PJlfNoa/XtoiZV0FzfFrxvUD
         11Lj1v52xR83PKZ711c6Z66kAQrW/O2ip27OCKwyrne+914BL6u6SV6nhp8SF++qFUtl
         X7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349523; x=1794954323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=pMADfYeI0RXFdcQKjzMBS5RGhohfih4mcbJg/Elt6IjuGDFckd1jfajcptSoBm9rxJ
         l77aARK5GSsTYNvif5EGqRlK0ZGVKyct2ffcHj4smPywDWJF81hCstsFboIaPoMqNg2U
         xryz8CzCnlvNhekSqQVxC83KK7g6HpgC+PEXDxIz2s9tacdgqMS5Qb7+PKy4z57iU0mD
         QLcmCCgsPNhPvxRaQg7i1UX6zCW5N7ZPlSaz0nvmkRhmbgvmUynnpykKfn0jrtXwwY3v
         GAN3IFU0ONEH/cvzhenJJZ5zjPUsNQHTxC3BwFFQKalFKRLx6FKyw+55+pGihMB0lwit
         /TKA==
X-Gm-Message-State: APuU4Z9Fz29rV09DRIghKHl5dLIqFo1St6S62dG/SrS55cUiz99+4WJN
	SQ+TNemzwE1xSbMVaVEelc499b6wkBeQ5Rhyo9aXes4Dt84Q5Ix3e8ILNEqtTg==
X-Gm-Gg: AYBFou2wuaQQ46tWujBuCdDY80ky+Cwgi2WgP8nkk/hebG4u3kfI6Lhnc5rJdPcQCUh
	wQlWO/artWp2FO5st6Nbhy50fmT8vgztigL6CBAQ6mqG7Hc+4vO+teGt8+SQbMILbM2HydQm6D3
	A/+2Dx22JGbaw+TekxCx2ZcE5uN4pmn+Z2TjxCSH9OvhyDwdkSdybJDnmV36Iz/pVJlQZcoWvKZ
	fDOMSfCc7hebvlDzNOyojNeu/CzM++yPvXSn6YbN3iNkNiEmjtmgiVnx++nq8X9PAq57LZfcQiG
	LqlsbWGwV608MQ1OMzCuGvAt8Z7YDvU2r/z080m8zFjwZJiAbuRws2/JIxhbe3i1xVeQY4CQkZV
	Y7h3P7jLPAAb4J4tRBZXD2FEEvYdQvocOJ/wRKkO2v17mIM3Ll8fO8PGCZVrppiGdG8GKMtmkyM
	ECYP7CrTbnac37ASPniV9v+IwC6pNe7A55CjScWNMBuqq4WCXMFUh7/NxO9lxpwFU7Dz873rhQ2
	qLttP5NypkOsOfu2JLufzIVblWI3zxHdayV6nZwBIZoj/FBUmuUDYI0JhVS9CTmYCDNiw/9G+30
	EYnfG+NwOIaS53R7QndFyx0BsIrXugH5ozMnvd026FBL/MRnzaOvE3TIPzm6reYiZk4rUO5ZD8u
	MK9BxImIhhkuEy/VeCyBnfkcNPs5lA8JKElnL5VvwApCRz86kgYWRRIwpzb0ZqJtMlu8ArEIZDP
	9TE28=
X-Received: by 2002:a05:6102:c48:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7d4ee0f0687mr166209137.1.1794349523452;
        Tue, 10 Nov 2026 14:25:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30223977dsm2609190137.1.2026.11.10.14.25.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:25:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 09/11] main.conf: Add HDT configuration
Date: Tue, 10 Nov 2026 17:25:08 -0500
Message-ID: <20261110222511.3011494-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110222511.3011494-1-luiz.dentz@gmail.com>
References: <20261110222511.3011494-1-luiz.dentz@gmail.com>
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

