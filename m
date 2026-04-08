Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371D37754E
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679269; cv=none; b=Euq0cRmLe17cICDckLa0bK3cxPzyVN5jNkXTmNDpS0bwVb8sm6pmEVyTiGEq0LaGavDMGoySvvfERQu2y2ryNKk5dASJQG58o6450nCl8zbVmtF601QdivB2qHxUVQ4+V+cgMIQehmi0h+2isfhRZgWHKlwshh3fbA+E5I1vyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679269; c=relaxed/simple;
	bh=ZRSOc/LyLfrF8wS8wmDwfvdqiq5801vJOs/TeTG1/LM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6p2xqiPhZQGSxdacqE9LJAKpurTragS2B9ld1qYIlnR8zXZFnJQVcJ+3CzxGBnCkM6IMzaZZL38UrS5G2HAFCbFwTQntXKTghFk4fytoeamMu97z9REy0/nJm47P/4SInyqofzaGPpfHFvwbdnmTD5T0ttI1KxQifc71I8z19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaUgK5mU; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaUgK5mU"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-953acf7ae20so60014241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679267; x=1776284067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eNJI/AsewBmy3J6FAVfzCU9BTAoCsqOSano2s+reVY=;
        b=ZaUgK5mUm9SbKMShejnmF6D277vfa4fRBmVJoiChnBgmzPOQzypF5sLedDyhHwpLDy
         2T4ac3VLj2QSG80Tp6dtcvMrosTxiA3owWQhM92RamkabcJWDUkQt9Fr6+a6sxSg9Un0
         PwUx8TRq0qW/GDZoR4JhB/j8AgM81wOFxahW36IQ3SnfC8kViuwXiYZKidqyMLXSceJD
         QLpwdm0VCyGaIVD5aB/4Nys4K2YDMXkxCI9R1CKMrpQGcCbLyx+5h46/5tQtywvWwi9a
         0Th4JKeQtGku9zRD+1WnVyI7nsP7DJFK9ubjm1Z/jlLIqpAVAgjO/HpfNrCvPdE56/Dx
         hhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679267; x=1776284067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+eNJI/AsewBmy3J6FAVfzCU9BTAoCsqOSano2s+reVY=;
        b=ZbEtXLxPtutRmIqHz3YMG1zIZm+sHgrqg+yBfKAa9ZzXmx0YJxDRyKeVFL1IF3gW4o
         OL7xdo+fzDXKJamz8hnA04pZE1n7JYfe78/jN8LDm4tr1cxY/m7Sd4IHmTTpbYtdfglg
         ToAz1se1FauHj3Ve6xPWYElHVdGnj9gkHj+AfQoD+RyWRJXZB+FwHWpJnlHScutgTIRu
         doZTfPCOqJKk9HOJ7fiD5Si/4qZW7zbVE122O8SCDClZdwXbYGet3WRiN08ovjzanOZ9
         p8qN3J5IdQtivppcMEDXi2HRDPO2uWinDs247CAvmf+EgJ2mW6etDv3Pd6zT0lpXcdsC
         EmCA==
X-Gm-Message-State: AOJu0Yw6STvLdMYQISkJjK4fkTjmAU2BHmSgwZdyjtZndppzh5HOJ4dW
	GrO559rYqQO2UHHuYyp986vS4Ynshwp4bov38eB6X7g845opMaBJy7YZtb++U7AhMGY=
X-Gm-Gg: AeBDieuIYQt0Ow+7T19KuXeWxsSRx1UXbFLos3KxjD/xfhanNKZB58JJzgEkmLKmtAK
	RZHhWkszE8g0tk1yJx8EG4wSyCHV7XGuUork6GlZHyg8xMNWw/+Vadq+KsjJ3F5ickCHLtxlGbx
	fS/lYWh2K5hRlDbTscEPJENHKW16HatIuUHUUL30+4Udbiyn2nc1ZaBWZfiKOd80Hzzvvm4Lk29
	u/qXdC2f2TrQlzkwNefJyIofl3AENqUOv5DP8n3VA0HKXZ+ALKlCVfeHc8jJ1QdRKKKcK+QvqCu
	wPJZE4v+As/vvS/er53Rrq+b1X/9IW3scvOyR56RpgKl2kN7XGgWqYJE2WCF6V+yarLsRFdd1Ze
	BstYIOJZFWO/a54fO6CBvkyTREEQkca4Y8st3CiBLjfvSYQ8+45BHyjpv6kHnZq3wsdZB6/wBNo
	g4HLc7dHp3mq7HXNN8ZcKB8Wtac/lFR4zicJpRuecu3kEJpDcCxn93R3exoJFnuOfQHr64SeaSd
	U6Lwl+2o4YX+ADDBg==
X-Received: by 2002:a05:6102:6a8b:b0:604:df34:b769 with SMTP id ada2fe7eead31-6087004796amr403403137.14.1775679267039;
        Wed, 08 Apr 2026 13:14:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60583098fa7sm21071024137.10.2026.04.08.13.14.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:14:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] main.conf: Add GATT.Security option
Date: Wed,  8 Apr 2026 16:14:15 -0400
Message-ID: <20260408201415.488511-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408201415.488511-1-luiz.dentz@gmail.com>
References: <20260408201415.488511-1-luiz.dentz@gmail.com>
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

