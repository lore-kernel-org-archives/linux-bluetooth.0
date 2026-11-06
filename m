Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989103;
	b=WeP6bukLsF4R34qmcNAlx3D0HEJ5iEZV0rUqb9OpY3/D3V3Rce2YZtB2go73Lk20sm+x
	 HmEFQerdf76aOyM4EViMkreSOPndEfS+kkl8ojLPUN5Yf75DvT7dDp48C/b48UgMOvbWa
	 HutpstJiQoYMILhHjB6DX2RMY82ws2bvt3vz+luGBjXsdYenAo6e1uvemaLlzQlMSR5IC
	 Odlmo8/bOpGM5RCOaa/TRpvjozHX8BNiol6f3xsmDDqxSSj+GodHWNgtfA/5sFQl6GjEk
	 nI9gZ2UV+QVye522fKquQOp2U2AwqqwgXmVQOm9uTmqsOD4Ug66uRiMgvbu+tztQB+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W1sqlPzsHlqEK5jVHUyZ6N7i4sQiHM8hLYhCOCjrQBA=;
	b=Xn8mCRtFSVRbR2JsjYilPZRBsJ4/vE+qxrI6p/qKnc0YK7NwCuQN5m35dHJi2/oWOTUP
	 8jnhl8Wud9fofWzMIz10DshcjJG0BzJJXNihsxlqGtQrEmw4dwWEx+81Qq71Hz9CtLLJ4
	 NSD/5tXWLajL0d5ctvqwVtiuvhUw0R/hLBoEYo+l/C4TRRd5DZR7FdGFaPN4HF+bOu+cQ
	 648K/QVAwD7ou0xHRxdTTgn7YCX9tCuZYKwejLopOSomMBMSKEaCX3fD9Wb7YEzbhQNk4
	 ZRFO20GpXhhWaVPE0FqlgFH1AwvmNmBM8I4umrCvFsSv9jllEiTWc3HjZIBOC8QVPLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkHtgmSs;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72243606A333
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72243606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkHtgmSs
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso404197e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989102; x=1794593902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W1sqlPzsHlqEK5jVHUyZ6N7i4sQiHM8hLYhCOCjrQBA=;
        b=jkHtgmSsOJHrbs3wh1lfS6t20hZCUCGFMiA5SeaKozf9hcEz/ypKsrefY5nfX5Ki0c
         hhKE6ZxGe3P1DDkexkxPxgbe8OHIRXRQ/+WQNtzpksI2X8NDTZU/XIRR2eXvwLexaWd/
         VHlKGlOFuMxFCAOqKWZbNDVm4Tw2+58nrZY/7aaTyG7qOI7f65DCgXn1q/QMLJVOce8x
         ep3s6Qa0RIV2LbocJez7rrLrVGZQk117SsJQ/ZWXcJ4CBmh9lhNvtOubCYr7PjFJ1Uak
         IABfVHnkKgEF9GDiiub7p8sn7fyhTPAjlR9gSXbE+zjr+qsoL55j/f5b01p/ZeVW/Sx/
         0nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989102; x=1794593902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W1sqlPzsHlqEK5jVHUyZ6N7i4sQiHM8hLYhCOCjrQBA=;
        b=EMogM1lu8btPstGu3uoWCyqNji5hbrQOLN92xdzwsjeA+CoC1KBtRL1YKeZqKgASpV
         IR1HyxkZBQdcGyRhJIMfZblrIh4qP9flISJUFOFH4AfmE1uEf/SDdwaFAChhzhiZDLd6
         hC2NgRc5vD3pl31Ra7Pa+Jl7f8H/KeckykaNjD0ZviGIEsoHF0/lcgY+tRA6JcqBhXJL
         IIioVxlQIySJCtZHJlt5i3HguF5JUPr5LvH9E3PRx4E7jXTD4/cV91erCdOk62/CpFRS
         7aWF4uvr62ufMIwgQl7Y2AMdX9G7fBFxVWAuUxAQ3RNqrKtUZExp8IEic3d5PgalpBLR
         ZIUA==
X-Gm-Message-State: APuU4Z9T8k2HJ+rgy8NKuWnSO833zVHYiJrrdT+m+ZNuUt8KDSwobq5L
	QagTha9Hn/6PB9ekTkA6lOh6DEwd8F03hFjk24w0DyYjzscPpZYTbY/J3uilMA==
X-Gm-Gg: AYBFou09b2dlPrRuK/41IXfd+FuE9hPQb3E/mhNLba0V7SfrHja9SUIiIn2ZY1V0f66
	jEZvZ7AM7Fg8XN52smTJh1SDSFvvqJwmaHohXFk9cXn+r3TyIxMtScAQT7qlgcSW9wOdDKjLlwr
	mvJkDs9mk9FiaZxMLVvuTz5LNDVjetxLBotWQg70hhaSDSoo+ueptap3iAoJjYsj18vXpy8Y5VQ
	opHjXbhYhnSp8lxhGp9PpVb9wKsLJMd4+47CpZTss+XQ+8q/FzZmceVJBlu4MdyqAztyLG7ey6q
	jNJbT0uygFi3/Kfe96fs8ouvNrs2xv3VPk+lV0TeXM8bY2+aT3SqdVIfO4u9yItEC8y9XEfWKZK
	huGABxw7NJ6h1sEUmXyPFaYLMJC1ONzIuhYCabf64ROyMNvwqyeBrFP8VVumn5fx3WGKUh7EXvx
	ZZYA0RSr2s2cGooyfLUFjIMx4gfbwT2vKVjc6xEAaeiY1KJ4jlZuXYxOUamfKBBeXn0kWCO/Tsw
	0LJu+GzcCFrmVHvKm+xIT1YH9jwZJqtz9BByWst98jmhlC0OjRVelaDY9qodHxsSEylrWT3Hkec
	IC5ybmw6e8vfQe+7GjJfXx1ltfJC0oJJhSjp30wck/uOVgvdJcXgSPrUMLa9xqST7lbPPErrS73
	hHF+fkf9gR/1BsnXlhFdWjU6xHR9GsWJke7Lrwn4U+8nzKDW+9e2poClMCRTocgoTFLx6zBgT1t
	5KubTyA+JclgOE/pwasXT+4a4j
X-Received: by 2002:a05:6122:134e:b0:5ec:2c33:f782 with SMTP id 71dfb90a1353d-5ecc444c9d0mr1753218e0c.22.1793989102400;
        Fri, 06 Nov 2026 10:18:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 09/11] main.conf: Add HDT configuration
Date: Fri,  6 Nov 2026 13:18:06 -0500
Message-ID: <20261106181809.3134862-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106181809.3134862-1-luiz.dentz@gmail.com>
References: <20261106181809.3134862-1-luiz.dentz@gmail.com>
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
index 8e58b6b58ae2..b71a64f163c6 100644
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

