Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427640;
	b=ncPrU7nYTwmjwxpgekx+VTstPFp3a+AzPPCD9TlW2+FuBvBCp89oB5Gc+kkMFg8mWKbO
	 GHhww9l8nzzYLbFtUgghU2xoXrQyeo0YjdDFJmXthZpXIAYPSsBcLJhtyAwdSNukMF5xn
	 Com0w3+HNIytbogAbpmoyFA9medIZVGCx7PjcUZlfqKKdF0Z9kS5So5JIHg2n6lvcq3H2
	 ui6WX7lUlkPPsY1SzyNPUm19WcqslWUqYd2JBey/41umSxeOG1SB6oIbV3a4HP2MLw30v
	 g0ETDW1AAnRWpa8eeeK1+okFbtfG+BpZ6zqXvkuBBXnn6uE8PjoLvCwszqgH3g3bH4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
	b=Xu2oVShRdgl6Nj7ENynaUKY9n9J3k/fW5NgH8gsJIM1sZEviZv6Q5fcVe/5w0wewxbCe
	 xmsX1Yrng42seHO9vU71/SoqoJuF/4Uoz+LsWtb0+LuuRxzvkOOJHGQPuwABDwqLnsadS
	 IM9voEUYd8F83Jc2vOAKZjL8d0goJBanUW+Yp7Oblh9yprUR82dm7gNjJ6MaCo7XGRv4k
	 AanwIswiynFLX/kM6QZVZWqhPGlf5tjtDZGUSD1Lw7xRMwRtbkJUxU8leFqe14czzOBpQ
	 aHGDn6WLMM44ZazTj+QU9HS0+ezaOgn5fU3tCygtSfHGPDjmK8NV6u2lFp+D3F0qT5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rdC5/99R";
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632D606A88B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0632D606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdC5/99R
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso906088241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427639; x=1795032439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=rdC5/99RB+cYEQpZjWiqOHUsfwt1tIp8rLM9aARz6SLup5giRn7KBNLiJ2GbWAUFfZ
         oEaLLS7Blg0CI70SWEQ3HYPZ+QSKEQZyJK7k9pygZMltDle3CjCfdOtwcEVXKAJLI3kr
         wnZoq36tfbwm+8xXJ3HGslMRtTXMMlOe3MlXAMRAiNTSvmsNVtEq5XFtfWIPNG3ZdapG
         Ot/0mrf5+QrZ5RNrJEJ1HmxRsgYxh66XwCf21id2fge3gmR1vnrqvTDq6aY3NMJcrTIU
         hA8JWgecxNLQKhdM1VO+nsitC5NusXwmn22SQjM6ztjW8w0vYuJ7ccKJeJMm/b2gOh+T
         WPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427639; x=1795032439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=oFhFUIidSk9XdGhELZR5Bb6gBs9RAE64xW27wKKB1G2rjuiVGGJeWcOYJ1pxQ4tqz2
         ojhyVFQNRPT/6rPbT3hF9OTLsHxZzb4Ss3tShnveIkjM5lYDva38JsaAD4hLHFlcGzox
         ZNIW65DKgPHT6nzAHnJ+JtiWGw05t2qj9bVC5VWwe83/jlH+pkkCxp37lvFZezwMHsgC
         3I0lZ477rG/jBDoyZZatiB064l01hNSpVpOyZG8n/8649o1VsdOBgRCZzQF7eakfBVQs
         84iq5B1Rlpf9xY2SGLhh2G1Ty4jcwI5LS8Mv7xvhUeaCHM3HUMF3aWcgljuZPOV33qTn
         XKVw==
X-Gm-Message-State: APuU4Z/CjHvWT1BEVf8qWlJNxNixzCBBbieaLj/gAYrsU4hKyvhWF6+c
	r14m8wIGdjVQ2HQP+LjBjxD7aUTw7UkczNnJYx9KpiX6K5vA1+CgxcMhfArF1g==
X-Gm-Gg: AYBFou0om8KKOhb+uAG1QmffsrKJhbdLwwUfdO3+na3McfQacMTmJSWJLgWP+BDnvh8
	SuNttArmsQaputzzISJQ6xkyB0g8qCZcTzdf4psxgq/yUKv1MVU2tFXrux4owrY5Mwdg5/2PkMk
	wuHfvzFaZcY5N5xSGY0YUE7h2xuIbH4mrIWobX24ObGcPmAOMFXEzk18xkCiMW0F4MMOLKizdfx
	Xl8j9aFY9EMpZDnuN46YeQ6rlNNWNgg9kvQr6VuLeFX0sszKTgUFMnNdW6HR4XPAn1e8bygENwy
	ExhNCVLCz0n3aJW3K+kkFGF5X3dwfHfvFbE8e9NbUp/mDJPT2m0p20Uu+rgGgvnrhvcA7r9u7ar
	lMtbyHTcNzNuhTHj8ZqfX+PGaCw7rm6U4d0zy6ahGWphGM/Zy90utaTo8OHgenGyEUgFiPlNoGT
	DHvQVlszmeuuvHKbY66/YQtp+wMbF9yMD8sIvkMwf3lpxS6WuVcKvkuHbWeanuDe3ZQMGOTI3/Q
	XvWojjQXaW4dOjUdgTV9v1OnOnUeN5PcSiflKpmH/SXMhbG3a5w/puS8qYvOF5LGbJiUII5QhP/
	G0nnP1Q4zvlslbP6m+MObn/9rKN8rlOC/KSoLbfL2CnkiA/XYblAxbPAuoi0B3G19zqlIDuI6Ot
	5jsPqHhhFb3zZajkCrCRtSG3zSoFKheDNb3UOUUcZtPQBRSFNP9Nh7lG4aoa6tJBhXp9ya/oO82
	kxkWk=
X-Received: by 2002:a05:6102:a54:b0:7cc:2daa:90ee with SMTP id ada2fe7eead31-7d4fb2a8f75mr1299613137.15.1794427638742;
        Wed, 11 Nov 2026 12:07:18 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm4954449137.0.2026.11.11.12.07.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:07:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v10 09/11] main.conf: Add HDT configuration
Date: Wed, 11 Nov 2026 15:07:02 -0500
Message-ID: <20261111200705.3802779-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111200705.3802779-1-luiz.dentz@gmail.com>
References: <20261111200705.3802779-1-luiz.dentz@gmail.com>
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

