Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1B3537D5
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679212; cv=none; b=GsvCnpZvIw+7zepgLtS4/zqC9RUYlQJk5gVy5WkQAezvXmHdm66J//jhVmsjhLJ6JMjLJ866cX6ekprkX3m6uQkkRRaRorf9KBz8+XdnOMf68TysIovtD325RoD9jDbmbNIVv4+MG2rYeQpc2aFy+zhHQBPRmEf87Ua4UuadXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679212; c=relaxed/simple;
	bh=ZRSOc/LyLfrF8wS8wmDwfvdqiq5801vJOs/TeTG1/LM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0DivVrw5bvxoR46SxYC5ljc4ZLm5peOP4Ynt/bQ05IXysdvHqGRrnhR1fiQRdjvP3mP0KqxF13/ER3uNWQkR2bD2tfoRMVa6FCoP8zzmh7D/GqlUQcSEx1x2dE8L1ScyWEq1unzLGb3Vq0e7XpCfcNpy1CDvcvfzejY0rSPD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMPcbuuM; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMPcbuuM"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56daad0fdbaso40559e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679209; x=1776284009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eNJI/AsewBmy3J6FAVfzCU9BTAoCsqOSano2s+reVY=;
        b=kMPcbuuMjOeSWQDSeAIgPNPHOzf1Sp9GPj0XvfANDC+38RQENNa+5zmg2iQDJWloxS
         r3Gxwtj40HFwcjAdghQSNMJkt8j2E9sGdRn9Ktio6TXA/OXPFvWkApBS2J6SZa4bkOze
         jQwbvyy1AhqLvgsTDi9bNRgqTX0Td1q/lmBXJ6lvD1y/+pz2NMKdiaCmfL0C61i7A2QR
         V2wCgT1eUnHw1VUFVdIMJZF2lucak5iXWDq/+SxSUbxE3nBmjcCk1g3zr/WqrymXwJvQ
         8Fq21S1sQXgyhKJbnWlJAYzajsC3cp9PrMZlRxibX/pDWh7qa/HYf2uCTy4Z42v/CgPd
         87XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679209; x=1776284009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+eNJI/AsewBmy3J6FAVfzCU9BTAoCsqOSano2s+reVY=;
        b=sx2+euodwO9NLMdfi4LPul2qml6VoRUAa880ZtIYWFYkvyc1PsB5gZA8u1hFqefp4m
         Y2FHLVztXm4gY+GuAFio016r4FcjotFkY8X3JM9ss/T/68TbtFsP8xBN/XPiVyg5S7HQ
         EvPPfSxn6TotyZHRUZg9/UmHKovkkvWs6Ye9IfnwvZc6StID4JvOCQX9uc7V/mdCnOEo
         wz0JMLuRi/j1lVx07fFrwhMnz18mCrINpsj1E/ceW61xg7krqmTmy2+iVyo5X7gH6LVd
         Qsh2cNoczUxECYJsyLA1hxTbMwRli2BSA2OToHrV/+6S/rTUIl/Jy2m6SMW7H7MZJDrA
         fy1w==
X-Gm-Message-State: AOJu0YzBif9z6ZnXs7XWxzx05264RcAJVuM3FkFsO72jBFRKnKF8T5Qm
	C6CgA7hah2VQwet9lF6LJeOTzjS8IpDtski7LR0p5Xzn7a92eEX3WIXyOQrFRL4pEfA=
X-Gm-Gg: AeBDiespH95tQuPWNAqeUoag1ZY9lCa56AcOoySn7a/1Z9idfAKMUiy9TVTowXaEGmS
	/xzJSO4vGHTPJJglzMud5Teklc6MI8Am4p8vQTmbjLl+qsKrq1dVmIFLHZanniOyMNYhIvtX3ss
	5CLa2gUUwc8W54kUf4yxOtkhI3qLgnqhuhdx0gSLGa+TwXoosMvsaKXorP3uGsnPX3eA3TyGA7t
	tLSEwQ6mjugYTxN2UhBj/2IuAMpzJ6k5vt0RiPQI8ggQq2Ao2Ls0z8wNaacJ5F+2LUtfnJ1Oe+U
	KL1bmq0LKNwEpCCpskqpJh/+ydYC+PlNKoxnTXm+CXUAOmxULV4K5YyNU/d6UkBJxxwwjVU7Tdm
	lbMGGw31af72ODO2ETCWZ0+0DMOrF+XWstzZle+UFnbdcroTMbmedqYMyTvky9OsIGycmJ4KAmJ
	W21urPPH3Z2JeOegLUG6yZNNBPoVzOrXmIqScyL6Zk/IUSx/elo5unp6ZczZgbLGJLhA65UvucL
	Ssmxj3/zqp5AQHIEA==
X-Received: by 2002:a05:6122:4893:b0:56d:7b2e:89a1 with SMTP id 71dfb90a1353d-56dab86455amr8439421e0c.4.1775679209158;
        Wed, 08 Apr 2026 13:13:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd2106csm20823096e0c.18.2026.04.08.13.13.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:13:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] main.conf: Add GATT.Security option
Date: Wed,  8 Apr 2026 16:13:18 -0400
Message-ID: <20260408201318.483799-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408201318.483799-1-luiz.dentz@gmail.com>
References: <20260408201318.483799-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GATT.Security option which by default is set to auto to
detect if encryption/authentication is required on demand, but if
Testing is set enables the user to enter a desirable security level.

In case the security level is low it then proceeds to disable checking
GATT attribute permissions for server operations.
---
 src/btd.h     |  1 +
 src/device.c  | 16 +++++++++++++---
 src/main.c    | 35 +++++++++++++++++++++++++++++++++++
 src/main.conf |  8 ++++++++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index 1b521706d05e..c84a600d109a 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -158,6 +158,7 @@ struct btd_opts {
 	uint8_t		gatt_channels;
 	bool		gatt_client;
 	enum bt_gatt_export_t gatt_export;
+	bool		gatt_seclevel;
 	enum mps_mode_t	mps;
 
 	struct btd_avdtp_opts avdtp;
diff --git a/src/device.c b/src/device.c
index cfbde307bcc9..3f86e60bd666 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6300,7 +6300,7 @@ static void gatt_client_init(struct btd_device *device)
 	if (btd_opts.gatt_channels > 1)
 		features |= BT_GATT_CHRC_CLI_FEAT_EATT;
 
-	if (device->bonding) {
+	if (!btd_opts.gatt_seclevel && device->bonding) {
 		DBG("Elevating security level since bonding is in progress");
 		bt_att_set_security(device->att, BT_ATT_SECURITY_MEDIUM);
 	}
@@ -6371,6 +6371,9 @@ static void gatt_server_init(struct btd_device *device,
 	if (device->ltk)
 		bt_att_set_enc_key_size(device->att, device->ltk->enc_size);
 
+	if (btd_opts.gatt_seclevel == BT_ATT_SECURITY_LOW)
+		bt_gatt_server_set_permissions(device->server, false);
+
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
 
 	btd_gatt_database_server_connected(database, device->server);
@@ -6442,7 +6445,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
-	if (sec_level == BT_IO_SEC_LOW && dev->le_state.paired) {
+	if (!btd_opts.gatt_seclevel && sec_level == BT_IO_SEC_LOW &&
+					dev->le_state.paired) {
 		DBG("Elevating security level since LTK is available");
 
 		sec_level = BT_IO_SEC_MEDIUM;
@@ -6482,6 +6486,10 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		bt_att_set_remote_key(dev->att, dev->remote_csrk->key,
 							remote_counter, dev);
 
+	/* Force security level if it has been set */
+	if (btd_opts.gatt_seclevel)
+		bt_att_set_security(dev->att, btd_opts.gatt_seclevel);
+
 	database = btd_adapter_get_database(dev->adapter);
 
 	dst = device_get_address(dev);
@@ -6597,7 +6605,9 @@ int device_connect_le(struct btd_device *dev)
 	/* Set as initiator */
 	dev->le_state.initiator = true;
 
-	if (dev->le_state.paired)
+	if (btd_opts.gatt_seclevel)
+		sec_level = btd_opts.gatt_seclevel;
+	else if (dev->le_state.paired)
 		sec_level = BT_IO_SEC_MEDIUM;
 	else
 		sec_level = BT_IO_SEC_LOW;
diff --git a/src/main.c b/src/main.c
index 59df0ad4ca3a..818f7c06ef66 100644
--- a/src/main.c
+++ b/src/main.c
@@ -152,6 +152,7 @@ static const char *gatt_options[] = {
 	"Channels",
 	"Client",
 	"ExportClaimedServices",
+	"Security",
 	NULL
 };
 
@@ -1112,6 +1113,38 @@ static void parse_gatt_export(GKeyFile *config)
 	g_free(str);
 }
 
+static uint8_t parse_gatt_seclevel_str(const char *str)
+{
+	if (!strcmp(str, "auto"))
+		return BT_ATT_SECURITY_AUTO;
+	else if (!strcmp(str, "low") || !strcmp(str, "1"))
+		return BT_ATT_SECURITY_LOW;
+	else if (!strcmp(str, "medium") || !strcmp(str, "2"))
+		return BT_ATT_SECURITY_MEDIUM;
+	else if (!strcmp(str, "high") || !strcmp(str, "3"))
+		return BT_ATT_SECURITY_HIGH;
+	else if (!strcmp(str, "fips") || !strcmp(str, "4"))
+		return BT_ATT_SECURITY_FIPS;
+
+	DBG("Invalid value for Security=%s", str);
+	return BT_ATT_SECURITY_AUTO;
+}
+
+static void parse_gatt_seclevel(GKeyFile *config)
+{
+	char *str = NULL;
+
+	if (!btd_opts.testing)
+		return;
+
+	parse_config_string(config, "GATT", "Security", &str);
+	if (!str)
+		return;
+
+	btd_opts.gatt_seclevel = parse_gatt_seclevel_str(str);
+	g_free(str);
+}
+
 static void parse_gatt(GKeyFile *config)
 {
 	parse_gatt_cache(config);
@@ -1122,6 +1155,7 @@ static void parse_gatt(GKeyFile *config)
 				1, 6);
 	parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client);
 	parse_gatt_export(config);
+	parse_gatt_seclevel(config);
 }
 
 static void parse_csis_sirk(GKeyFile *config)
@@ -1269,6 +1303,7 @@ static void init_defaults(void)
 	btd_opts.gatt_channels = 1;
 	btd_opts.gatt_client = true;
 	btd_opts.gatt_export = BT_GATT_EXPORT_READ_ONLY;
+	btd_opts.gatt_seclevel = BT_ATT_SECURITY_AUTO;
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
diff --git a/src/main.conf b/src/main.conf
index fd1ace651da7..52eb3854addc 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -291,6 +291,14 @@ KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e
 # Default: read-only
 #ExportClaimedServices = read-only
 
+# Security level:
+# Sets security level of ATT channel, setting security anything other than
+# auto requires Testing to be set, setting to low disables GATT server
+# attribite permissions.
+# Possible values: auto, [low=1, medium=2, high=3, fips=4 (Testing = true)]
+# Default = auto
+# Security = auto
+
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 
2.53.0

