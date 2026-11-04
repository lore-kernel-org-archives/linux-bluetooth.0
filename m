Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817416;
	b=xURVxMygbF/KWEXc+5RabTFodRyyrzDwIEfHVSQkb9O190vGOa+Si9UkRCjlN0XZi8j2
	 cW5dDBanNepMNQEaXlhOcdZdamMwcKn1zMsn5g2AZ2DT+mOUM5bfQFc0gvJ3zknSl6SaJ
	 pwEbBisBBfDjzgU1IaIfHZw2G/9m2TP3LvyJxbe1f1WWPF8ihhPh/hMfZz+Ro5hV43gF9
	 0voB3ckk8XTgfU/XJ0FlrNazb0Nb9Vjy3tZNJm1nW/hYnPejRkT4CECbU0Xgr7fKFKOw1
	 vKrbHpS1wDSiishxHKTGdxu+4iaGTU0FLmFauRorFzLSha1W7mY2qD798Q0cCNVmKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UySLUbhzLCCE9hsHLrQwYAWKjj3TdpBgYq7O7TGNa0g=;
	b=HlEQ+0YpVUFtSRQU8e2RRb/7W9mYhwOeK850z5G3vjINwRLafD4+cNgVAkFf37mSkw4O
	 YUm89DwrPl36UsvbpsE1aTBR5ZMvAFKxa6dBm//Zzny7+np9wxCm4Q5PX6mIM5bnO4VyQ
	 xBu6RZ+nWoYvjIZDrdk9Rvrdx1kEc2UHXBJHrnkL6bWUSQOcEP+e8m3+YEKf5Lf4XHCPd
	 EsF6jaoqX3zHqVqui5mKcP70Wom/PaOibmwU/by/LrLGplwNlo8zwTJaXeOqNxpcH52bB
	 o0EVKwxmbnjYwLJcQSeuJA2bdkFG4cy/nGtjzBFUYKg5cebkvgPOwDMs49c7MkGGdVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mt3fUCu5;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A89606A330
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A89606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mt3fUCu5
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d06ecaf709so536966137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817415; x=1794422215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UySLUbhzLCCE9hsHLrQwYAWKjj3TdpBgYq7O7TGNa0g=;
        b=Mt3fUCu5JR9bJpfv6e8VN24m2mJi3FyBc38XzR3/txaRup7AMRVDy3OVlvlGDpikbx
         vTVY6ThB4dl1a+B8bQcOeCJ42Wm0SrpsDSrtFVMsAQ3VtMZEUV69/FvDuFB8n7TULdKT
         iGiUmPq9QajazdxrpXyHrFw92JIwpXOi1th8IMxzD7WY/Wz+R3PBs2AyxmAG5zP/xkYC
         FbbDzamHaTrrWYWvl95h7Lwwug8C+E4SAAk4rSvYafI4ttWvAm/p5RYngYc9fzrAYwOx
         gorwbDOkBjNdThMwBQxdg91FadLCdH4lCPhZWfUFCZdwJVQy5P0KbxmOYa63dzkyCvcn
         7XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817415; x=1794422215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UySLUbhzLCCE9hsHLrQwYAWKjj3TdpBgYq7O7TGNa0g=;
        b=eoC62YEHG5wWWu7so8Brlk0GZNBOBdVDDdGAQYD6deOF0L+kLCK9GLJgPx7Mld0etr
         MTsnS5G6RKh6KC2BcZRfEr0IksZEwK+C4xL4Tn4JJIhwDke1md6+AlvRLwrk3C0FfwWg
         pAIsvRaIlMUbqe3wUiunwBRYHQGzDx8JXl8pzG7X5dUpRP4RXDXhAfpj+8oVv5WQ0Gzs
         Tb3viewiIKhn9ZO9Yzik+wCyafrITRGPbAB6BxeUGInuwzAjy7hJIzDpknCrn0QyPa9P
         428A/OP0YENhcf4dfFPvzWOYRAqa/BSl60QtUGbeKLo8o9v7BTCDzwtdUdnDD4Uggj+I
         1DwQ==
X-Gm-Message-State: APuU4Z9aJ8LkIKy+ohK6/vIkKbtGK530/FGb6NUvvF2PfC44xsFupMsC
	x7nPBet1pHzsHvEbLepX2ccJ1iYbPiFtPHX//36c+AgGUlE7kcP8twPCG8Ku5A==
X-Gm-Gg: AYBFou3phsWmQntjdlUT5AKcLGStZzN62DEiLXAhFBc8tERehqPnCQLi089WF4vdJxM
	RoFHVY47TZ1iO+gBsE+WqBrQanHQSJxFc0ClUVFwKjYjU+i8HevEUEYHRTZh7+0DvyMEBjkmZ3J
	7ggJJwEI1OdReD6RajKhlfh7o3rR+znEhvTga05B1KCgTCKG/kMiecgEOPG1UduSSLys9V/eYwa
	wUzepiYxKolHnUM4LAPZUkgovkPTsRY1GpQVHOSOo84RGOx7cKNca7+AZ7X+NyMOXblIrdM/vQp
	Ii+hLpqUb6a973NAciwg3QXVRkXCIdduVc6qhAvcmzLDzKOxADHJrxNnonoJQU2MWdQGiOIkC4G
	gTgkmkvbwer7xvtW3IKwN321bmfPbY84iLhe4Jedh9Zj/5JETo0W7frhFzMDVf0wmjTMtDBS9lE
	D7+GgEDl5bx/TC4PKby+vCb+TPfRGllfcYQ78V9lku03kyAOQx+9+p1Ny3MNhwTUrFVn/hyvfBo
	z7JxSh0+jvLkKHjf50bqsj0voVENu7jY5nkFC+m360EDW0JNOyRDBvZ3JyLiVPCzGff6TmpfWGN
	EtkNRpW8MamhYVRCfuHdD6o65zfXOrBZ0k5rtzYEUkmE0KsuTLldpslnrBTB1pKHvtmynQg5+Dm
	xF6OEgvF8UJj9O1IyZ4vMAUrrKAM9pOkQnvepwhJVQWJWmGGlrhdrerq2aqiwwk6NXmYGWAhLSV
	eKPhka4awxayHog5zEL6PZsmGl
X-Received: by 2002:a05:6102:3706:b0:7bb:c382:2ff4 with SMTP id ada2fe7eead31-7d0726ca2femr6344866137.20.1793817415436;
        Wed, 04 Nov 2026 10:36:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm696605241.9.2026.11.04.10.36.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/9] main.conf: Add HDT configuration
Date: Wed,  4 Nov 2026 13:36:42 -0500
Message-ID: <20261104183647.839090-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183647.839090-1-luiz.dentz@gmail.com>
References: <20261104183647.839090-1-luiz.dentz@gmail.com>
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

