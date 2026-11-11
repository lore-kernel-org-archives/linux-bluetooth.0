Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414490;
	b=gYSFkVKaVCdf5I/t14AI12dn0qwRrIogw1guSqQnqdirOLi2PYy8pIP4ZOw0ZDQYqwrp
	 ZG7prR/RhGnSK1ca3ipRIRfwn26/dGteapb9hbwEGRmQeR/n0op1Yf0zSf2LFpKjdCuFz
	 cpAtBD93bpndiCV5q32zEDXxplbgzogzAxH274O22Fuppm9Hv80odNXewSWalnxc38VHY
	 qZlruE0ptOw9hd5O+E9d9rawvUCUUmu8L5i2D5av39O+E8BecEmmboeGYZpYTXN2DFZxn
	 A8rK9MHiMe2lsIaUH2k3KNrzESiB/EjSz6+ZDXhcKP8P8YIqFBtgAR+Vx+K7W6Txdwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
	b=uGrfiIFKjPFyf7X/OlAHpDrv+kTfwbSbcwqOyXhk511ik0+SOQ3pGiC0M+9uem7zWr2T
	 dgBv5+E9lPtUUQwWasfxVUkMCMk2VPf0HbguIVGDXKiYtxuLooAwWZutWdFjQDyfpIEK0
	 VDpwGNHQhftS7NZbTGPWRz0WHlvHpLn0PNM4EmmDbaMxkEXKaeYHw5xmC/DNH9s8Kwakz
	 t/gWUlNdlkGp0iOyf6OFYem7M8/rS4buZNlRGwDhIXHeRUzZvDT7QPzHQJ8F7QMKSa3LI
	 CAsFIQTk4LU2Uac0IMa5bckS8XlaqBfY2kKb7gXDhsUiB/Vp8x8uPhSj3FghlyVx8iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hBBA8Q26;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0151606A888
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0151606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hBBA8Q26
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eae12762c9so1180659e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414489; x=1795019289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=hBBA8Q260EibxvsOkB+WUQcMChGiVxjrBZcdGSft5X4K/vgIYal4Hw8Pes6Qr8UvMi
         P5kRfVOui6kbRWbCbwd7dKrti1lJi822wa5EQ6+Dua7aBj+6AL6GVXk6WsaYxQR13bSs
         zw/k9plu4ncOHak4cXm59YzNtvVevDVDJccP71cRzr4pNsXcV00li2XOCccQJ5fGIwCv
         WB/AAtXSFcXcnTjsRD6ors8zlZQLUYlmvSUkIyutQu3MNS5SGfN/tfoTZWXi+115RIfB
         6IlH2YEwb75+Dskz5e0bKNhzbRGbVxSl+MJ46oF2NPr4+hiNctkL30JXT1GuQr5fwey1
         rsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414489; x=1795019289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kXIyzr00gUT1YHgDddFrKekDf0iooBself3c83fTVF0=;
        b=RC6smpSZYc/c64wcprJ/jebzHl9W4IusyQ8iEG2A/uRAaN6136F162B1JEKhcxMTIM
         tkS8bbmTssDWJGGct9pNWKpRYyyYTKCVk+desa83C693c68tHhUZoSc29p7rQ0xrcsHb
         wWdAGSY5nvtO8b+4059VQhBTxTcocS6cuh9JhjGpND2uCR5dN2mVFtRsOzDOxRS+Wbsw
         VV8ecBSp4+DEjUlKqhknA69yTm3kwBb8dgzDefeh5tZmrvFqjGqDF/R1rWdrjmXyjjgC
         0Il7JDcCtfH+eP6KD9Ax+EGyxH2bOx76f9Jg0Ab57+pyWjAQ1/JF1otgrnC0Dk/S+0BU
         f6MA==
X-Gm-Message-State: APuU4Z8kDIIaimdYXdLK5Sx9J166XHdAcU7s1EHKT/ifkB92u8Y3W04d
	iyk4bLs32vzoDUmq8OytsqtFUoWEGnhYT1r5aIHzATpYxs1vezND7GIm0j4rpw==
X-Gm-Gg: AYBFou0DGdyo09BSIwcelyYTLTtBtjJj4ZdmdUOo2pXaZJe1FVy0qta9HRqoNdG0MqK
	ECdGyftNn/GV2KR87sVw5V+v6F+YGJchTyD9B++uD09B4QU6vTN5/HQpeRYPGcmLx+qlizQPVuO
	W2dAnIZC7TKmudV6E+Yj/w0sievGo09I2U8YRhSCK2aoJKyUQre1h02giQoWQKQH3lKepScM6kk
	rDGZDjhyThxouhyvrCULTdkJ66l55OJlV1/5rg8j99wrYcRe+XLU0wiQfV7ENYUxTGAVCqKRfpS
	bC+s8J8g5YnZ//Ykgs9QY5haB/S9R0OFuFbDaTZmX8nEOgx+i536olK0ZTT/JNrZ5RQypnOlNrU
	bqK0R2l9zu/FyQbgfiJW/bFEo795/tpkcdyJEIrg9wPkhJRw/Gy8gVAeyY+3n0jlpgYKmtvdEYS
	YFP4UtRqJH/sUH77vX7kU/ijG45G7Xy0ce5vIawWKdbLx+prQuYl+1vqr/xfLcbwVBO4I7w9P5J
	aGCzgrTZx6QR4AgeDoJzR1YKxs1xSjSRDLTF55XQOdHb1ykhHQLrk+/Pv0iYJR/n7JW1Wm0T165
	eNhDhroCQry2mf4qamR19eLWB3sqbaqF6lnxECJmZnpKIwbLbvq5LKMfaPp+YYVapPEIEeQ2NwI
	tuR0klaGnOITYO0mx5atO1p704jzw00eiOzN7fsFUVofXVyx/z4cFYp1rJLXjhDY4jwiJzBBabD
	gYMc8cEZ1tvY+4Zx88llt1lpr5
X-Received: by 2002:a05:6122:420e:b0:5ea:c51a:37a1 with SMTP id 71dfb90a1353d-5ee1c3c5603mr1032041e0c.8.1794414488708;
        Wed, 11 Nov 2026 08:28:08 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.28.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:28:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 09/11] main.conf: Add HDT configuration
Date: Wed, 11 Nov 2026 11:27:52 -0500
Message-ID: <20261111162755.3506226-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162755.3506226-1-luiz.dentz@gmail.com>
References: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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

