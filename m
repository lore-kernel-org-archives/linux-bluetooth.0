Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898765;
	b=ywF8TUXGbUIqHlYmf0/To7coFcY3sED6FhbYAmSPG8uf6wAzc+UKJaWB0yYqO3oRbOzc
	 NOLay2dYSdwgbrBSYFDFAxi/8GJEE2KGIQH7K+2As+sDHRpsMmrr4+/dAeA5zSZpwzMBD
	 fr86mPZETpwRtLln7pgd2c0LNd7wPqhMLaVofwwIPhjVsscoOUPZSAgx/6eEjJ+DpNlL1
	 XNJKSeyMMMgjlHC3FWJTU+dwG0ZFLmUofqMpO+XWE8btodbk+B9h7p7fJhAOQGpSRJu1Z
	 gnpbc6Ljhv3CsQ7QOLC+/H1u+qpdtCWw39FOwfcSSgA0h7fX2c7Xl3ZTm+1TlnjVIHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W1sqlPzsHlqEK5jVHUyZ6N7i4sQiHM8hLYhCOCjrQBA=;
	b=ujo0yJoWfNON6DSkvt4Bmtr+tzWc4YwE3AMYzU6IaBp6Lp73Ru+yJt7nn8MxOZ7A4ZMJ
	 Kx2q5KyqseQCZa3IPG3IwZsnO48PxohkP+li0pUaLKM/0lr4uk3stAy/dq5YR4sZYXOzS
	 +2VKMMXhfMBPQBxxq57xIag5LjZo9o44yvK/yxYbKZl9GAC3jf8npXD/Sg8aMcxqnsxiu
	 IHwZtbV7qbeZG1as+iViyGPL2OynegbFLj4nlLuhozdO58UsjUzCcy0SKdy2tTgEGo5QB
	 cqAbh4JqQsEXsKvd55DlYk5lbyBZe4EoqhU9USzktM6s/gj7jRjh1dToALC5UppZ9pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AycKSnlZ;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414B606D839
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F414B606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AycKSnlZ
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1343537137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898764; x=1794503564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W1sqlPzsHlqEK5jVHUyZ6N7i4sQiHM8hLYhCOCjrQBA=;
        b=AycKSnlZZeYKJAaRTdCUc8e2rqrEhmi7toXRpwT3E97cYvkSMMlzNecQLvQjQUAyow
         Z54+2AY6vZdArmtQEFo9OUUJF3XkHIYPDchTcuwfEG4XKEOUmPZfJ30967fl9N4pcuX4
         Cg8VVnRVo2I7s3GZp80AaPr1Up6KlRHjzoyG4TyjwEefViNpSQ6wuBek/QX6QJJy2hpO
         Pbk+qvjwfD3qUPtz+WvTla/v20deLBC2mm92ldfwAmChmfJxsKiBWAtwIeWEXM0eEPv4
         FKK6+Wh8z5wTk9rie1vkCKeqccDRKermL4UDxbmvBP4xOcANQwcOpVhlvK0KyOTJbWOi
         avcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898764; x=1794503564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W1sqlPzsHlqEK5jVHUyZ6N7i4sQiHM8hLYhCOCjrQBA=;
        b=0LkkSuRXrWHQQzwfS8fiTdd8qfASUxA0JxSNBT0ctXpGQJYJivSa/EkfH0woyU7RCx
         w68Ym71nTMB4GL7uksdtT7EV5WOYlUOxxt+K5s8NN10+WZEvl/qunh6L3VEKEOWb32zX
         sSt30TpS7/P8buusufKGlU2EzeYFJeSicBgMAD7csgjI1rCY56Or3gYo/cMM5vCD7FgC
         bmed1CB1qRQNTcTDM7DMRVT+67GKte0u/ATqs1Bw1BTpu/7BMoStCVSKNArSmg2vk0Fe
         w5L0mY7dhf1RmkuvwjHzZoFJ8tQbwTs5LO+iNvj+t+qMXR9vuIvC5Yn8dhzDi7HF5l9s
         eAUw==
X-Gm-Message-State: APuU4Z/UbRd26z8UJS/cB17CmQb6Aes6z12RmGFgwMzRW0bXXRO4nv3w
	fI0kOREeWpgDOp+j7dd54HOvcSIdaeXtUYyAMGWI5fHuJnYNyv7szAf9k1lZ+g==
X-Gm-Gg: AYBFou0rCvGMWnHEPA6QTFDlbkjCjF03+i2WhG+E0PF+t6reQu9AM8Xun0FANfgj3cT
	QGUfd/4lHttQLKxyLHFQc5yb640xKFvoiW2lefZ9gpTaZNLXAKdkvctUBwWXX0VYFUeNNclD+zr
	covnucug377b0DEa9UbxvROS3LAZT/FZK/e486/GCv3/5HiwSNIz4cwUU6C4k6Ny8SSbRDjVI2b
	8m6JwBkcTnMAfIKcKRmYe0Qx2OcbKXBaDeQq169mnOxQAASnXd0QphcH9COb8OLLhX9zsRLPm/K
	s3t1sz0X/T/yo7En7/Biot90r7F/YF13OOnlikmNbw16tTcGCgzkZTITsrhToxxBDXxry1lZihX
	1D8xLgMEZfaf4OOD6zmHBu1fjQoXIyGH++mq+fqhmf/rdlP7SdxeirgXuCEBwk835fisijWTqUj
	QqAi6DB9usPtht3d0NVt3YfRS55pPe4o48xEyosbSXdXxVrZe6DxXzWFSwof2F8dFBT6IUrotUU
	EvmsJE+zvAOiyNZdpmAbiRBkctrKQcU3+VRDwz4fsHDAGSGJX5duxBwU8TBcXh0ZPtln66ie67s
	jAk3p2UyQWbFpbEK/Bo5ju1+LpyV/taUjIFiZL+Vrxn7l7cCbruUUSZrhTGyJaR69OxyrrBjhGU
	YGRBi7kQiiXga+71udbWE6K7UgUAqIsIpty5qKtSuOPLd/IkZw5iSGzWk5CYabI03z55/VHW2fa
	nMrtI=
X-Received: by 2002:a67:e104:0:b0:7d0:65f5:2bab with SMTP id ada2fe7eead31-7d2a165eaa6mr149878137.29.1793898763876;
        Thu, 05 Nov 2026 09:12:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm4050798137.10.2026.11.05.09.12.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 09/11] main.conf: Add HDT configuration
Date: Thu,  5 Nov 2026 12:12:21 -0500
Message-ID: <20261105171229.2053802-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105171229.2053802-1-luiz.dentz@gmail.com>
References: <20261105171229.2053802-1-luiz.dentz@gmail.com>
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

