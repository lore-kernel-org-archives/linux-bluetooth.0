Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6B466B79
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053601; cv=none; b=YfjvO36tJkexT53rIewv4xbc/AbhUszngOfyJ4qETh5njlU7thgkYYgSkYy9VcI3YGZXF1GsmpN/CZCpDYJBwkhy8HlQnjs4UjlprmmS478fWCXzY8cvJAQw9ZtqgbpHli8+OdkfSOuDfrmIhvAZgnPIN7bPvK8YQgGr4Vx6xjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053601; c=relaxed/simple;
	bh=J+J+bWR0JSMAop1O45dFkdUa5+H1RobXwWc4cgdrsSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdL44ipsIBo5IqQKIg2p1JgVxReB3zjkKEYU1runUp568vXix5rGRPvKJLVG5EMXRzPKkKk69J6FHsPgEoa39DlscnOcdrrc5lvXn9pZj/GDaWrj1UY9O04JIVdb4icFsPgyJ2qB9d3dSBk71b3ydWs26bR4SPSZ4w+07k/ybAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2PQibA7; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2PQibA7"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56ce44a204dso5139303e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053598; x=1775658398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYtID1JLV72KvB6/EylLB/Ug+lrJq+S5Pfsss9yZqq4=;
        b=c2PQibA7V1xrw84xavDOyavfUxc87E1JY9zDhOgUCN9AZJsVZfdf5/EWsZz6XzDAtr
         hyS/+AGKvtHYP7erqWe2kT9wYqYq4T2soaxVMbiErigfTRHBELm1dRlzOLEruDQ5mm9P
         T9Ep0FjUyPZ75fv/Xi0mT4C8SAD5o48CRSB9uUOFmHmTiKWsKF7CR/O/cg21l+DAqU5u
         MRICJ2oak9g6F91V8SFouODye9LFl3vNXHZtU7lTj/ZUvptDV/8MbA3e+0Ue4cs+4GAI
         7UC9QkiPHb4YZ9CXaXtlxN5572hNaO1fS6IkNsNdjvSZYmjlxA3vi612du7ZYx/y5O1D
         OAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053598; x=1775658398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pYtID1JLV72KvB6/EylLB/Ug+lrJq+S5Pfsss9yZqq4=;
        b=Pnqsb6XToAk+lYE/YoR5p/z5+jSk3W5BG1OwNdsPs/NvwfVN3uJGldpWLLC0DO9U+M
         0c4b43iNXOlJq1eQ4O+YERDaGtmNE0vVX46WljE8+9oBhcibWdEmI/M1Q2bVSsHEb+bz
         KNVRUbuMo/FWqoAaryuoiekoKuykdVocD9JMUkKlMiNJ7TTksSNTk+ccEMcQRewr46Ih
         d6xRfzt1bfx6uPjj55VzUyUDK+GpowpEOv6CqLUU8L4wy0rMuCFbM4AWSCXKCKPTAMh4
         RVxLQyxbP9mxp4p4oV0B64UuFIInuQETC3rteGDBctsOgTguCS2ZKu5SuCIci/hNdKOY
         uHzg==
X-Gm-Message-State: AOJu0YwcNC5AFlF4qOMBs1Di+h/Z3tIlK1cJczjjbSOupTDsrl9MvxbL
	oGpjb6ivJbvyS4qjrJM96SjkwG+UhPqLliLYVAg0NnJ9iQjAdKoOd4IW7U6qQeiN+vg=
X-Gm-Gg: ATEYQzxZvkcZONL4McKSVQ+ygAuyA8xTOniPZrouFeYNh58bupjWQUYH7G+r5Ms5fH1
	T98H1uqidmnSem4RrtWQ8JzDlKDxU3WRA7OgmwgpB8uZf5Ehmy/f9IP9Pav21WEzLZED4QwPxg+
	c29oh23urltIyij7rxrSJBJbBQu/OM/i8sbu7pnKoU5v6FDS5NyUhaZETP8ya27zh0UTlMp0Hv1
	tUqYIrug6JOuulRI2e4Gh2k89pJD7A2034ZL1E5dXz3OpTkNM42aGaIlLji1TFowxZDeIiZo2gj
	4naixSom8Lmfolj4nEQvi8LyMyGM+Veph8a5hxpy6Euxnqp4gSfbGc9RF+uKlAlYjocKMZSe1i+
	g7dkPjJcYDNBHLWjPhT5tUWlEZ2/VKCS5ZxHTphy7ZPIBXrYCPfqU1HWSG8zAyNHoNqf8wlxIIb
	cMnJbUr6GYXQaa4uQKzUAnHQgqdBh4D9SgYHAg8d3/VL70Z4VGo8uxINWb/gZ16/NCsRFjYJieD
	/if9PEZiz4E6O9HUg==
X-Received: by 2002:a05:6122:80aa:b0:566:341b:4ddd with SMTP id 71dfb90a1353d-56d8a64f111mr1702452e0c.0.1775053598223;
        Wed, 01 Apr 2026 07:26:38 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d88e0ac0bsm4237790e0c.12.2026.04.01.07.26.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] main.conf: Add GATT.Security option
Date: Wed,  1 Apr 2026 10:26:27 -0400
Message-ID: <20260401142627.1944044-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401142627.1944044-1-luiz.dentz@gmail.com>
References: <20260401142627.1944044-1-luiz.dentz@gmail.com>
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
 src/device.c  | 13 ++++++++++---
 src/main.c    | 35 +++++++++++++++++++++++++++++++++++
 src/main.conf |  8 ++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)

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
index 3ea683667bd8..c7f218808fb9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6296,7 +6296,7 @@ static void gatt_client_init(struct btd_device *device)
 	if (btd_opts.gatt_channels > 1)
 		features |= BT_GATT_CHRC_CLI_FEAT_EATT;
 
-	if (device->bonding) {
+	if (!btd_opts.gatt_seclevel && device->bonding) {
 		DBG("Elevating security level since bonding is in progress");
 		bt_att_set_security(device->att, BT_ATT_SECURITY_MEDIUM);
 	}
@@ -6438,7 +6438,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
-	if (sec_level == BT_IO_SEC_LOW && dev->le_state.paired) {
+	if (!btd_opts.gatt_seclevel && sec_level == BT_IO_SEC_LOW &&
+					dev->le_state.paired) {
 		DBG("Elevating security level since LTK is available");
 
 		sec_level = BT_IO_SEC_MEDIUM;
@@ -6478,6 +6479,10 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		bt_att_set_remote_key(dev->att, dev->remote_csrk->key,
 							remote_counter, dev);
 
+	/* Force security level if it has been set */
+	if (btd_opts.gatt_seclevel)
+		bt_att_set_security(dev->att, btd_opts.gatt_seclevel);
+
 	database = btd_adapter_get_database(dev->adapter);
 
 	dst = device_get_address(dev);
@@ -6593,7 +6598,9 @@ int device_connect_le(struct btd_device *dev)
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
index 724c4b44fc75..d31dd1b8f91d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -291,6 +291,14 @@
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

