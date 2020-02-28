Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BC5C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92867246B6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1MPxMf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgB1XrR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgB1XrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so2291721pgm.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=71j6KIh4O1bMSaDqDl28Qe8IFycvbdYvPA383k/CA+I=;
        b=e1MPxMf/ShhmI4JzT0UYt3+mUh0qpkuHA4nqMhnSFZ6WlSIj3DGK/v69QPw/6J4/KJ
         2i7QjCk1R57r+/bZDZcwnqhpHGHEBqByq2FChrD0Ehi7WOUW56Me5OlJ8mL1nZhPhFyV
         7y16OBR75snJapXp7KwZRdibMvFDV488bOUk4wy1ARpltuB+/af1kEL/WOwg5MrBM9eT
         1L7EQszOdP4LuJPytFeYt4zpUqIU5TWPepYKBQG1okRjtZjfoRiVEtjkHQRdGsvKCFqD
         TXoMizG947axpiBI7qvanEfCuJLaAxU7X+MayvSGRlsmg9gI7NtnZHKu6bLEz+12ZYMX
         529A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71j6KIh4O1bMSaDqDl28Qe8IFycvbdYvPA383k/CA+I=;
        b=eYKGRFY+dVrVDr6TgYxxP4GFl4GothxShUP72GaK4ZxRWgjiVpp3Gjk4M3C8sB/oar
         0ao9vJdywZ4VRNM9K7nhqE5GcOH+G/Wp73dpGn2jIsHJnvk0zw0wtAQyirBQdvqzrnex
         D5rVe9kLloEzyZeolBHusJDPb3PVorkuPFPjLtwyWzPkrP0kobt3MB8LPi30VmV+zCjr
         eTsI3Sm0dK2mDhZKitc8fTsLbpS5sX+uP+ayvTGXnj8rIyNW6Hi+Q7N4aGUpBpjxNNfz
         xyuemfOLjNZ0DAYeAfvOl0EGC5iGgOD6K/FfW2xxSXTbMFsSHpGcbX2s8hTn1v6LUhxh
         AFMA==
X-Gm-Message-State: APjAAAVkgJSLfVCUDTEaO36QpTd7Ipy/JZRMhhwtpcDoZaKPEqqQNqct
        QRyGD+UXFbb4l7QTofeAmjrs6GEErt4=
X-Google-Smtp-Source: APXvYqy3JCtxwvKMG1akJpnWwJCfitFbk23IBwhatCcu0SyP6sI/a9XoymcAWZCNa6sb6UFLcoL1VQ==
X-Received: by 2002:a62:3808:: with SMTP id f8mr6868661pfa.30.1582933635323;
        Fri, 28 Feb 2020 15:47:15 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/12] core: Add support for setting the number of GATT bearers
Date:   Fri, 28 Feb 2020 15:47:00 -0800
Message-Id: <20200228234701.14614-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds option to set the numbers of GATT Channels/Bearers to be
connected in main.conf.
---
 src/device.c        |  5 +++++
 src/gatt-client.c   |  8 +++++---
 src/gatt-database.c | 12 ++++++++++--
 src/hcid.h          |  1 +
 src/main.c          | 14 ++++++++++++++
 src/main.conf       |  5 +++++
 6 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index c86e9a64d..7e3c2b215 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5049,6 +5049,11 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	}
 
 	if (dev->att) {
+		if (main_opts.gatt_channels == bt_att_get_channels(dev->att)) {
+			DBG("EATT channel limit reached");
+			return false;
+		}
+
 		if (!bt_att_attach_fd(dev->att, g_io_channel_unix_get_fd(io))) {
 			DBG("EATT channel connected");
 			g_io_channel_set_close_on_unref(io, FALSE);
diff --git a/src/gatt-client.c b/src/gatt-client.c
index aa77661ad..958ce5f9b 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -59,8 +59,6 @@
 #define GATT_CHARACTERISTIC_IFACE	"org.bluez.GattCharacteristic1"
 #define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
-#define EATT_MAX_BEARERS 2
-
 struct btd_gatt_client {
 	struct btd_device *device;
 	uint8_t features;
@@ -2171,6 +2169,7 @@ static void eatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 static void eatt_connect(struct btd_gatt_client *client)
 {
+	struct bt_att *att = bt_gatt_client_get_att(client->gatt);
 	struct btd_device *dev = client->device;
 	struct btd_adapter *adapter = device_get_adapter(dev);
 	GIOChannel *io;
@@ -2178,11 +2177,14 @@ static void eatt_connect(struct btd_gatt_client *client)
 	char addr[18];
 	int i;
 
+	if (bt_att_get_channels(att) == main_opts.gatt_channels)
+		return;
+
 	ba2str(device_get_address(dev), addr);
 
 	DBG("Connection attempt to: %s", addr);
 
-	for (i = 0; i < EATT_MAX_BEARERS; i++) {
+	for (i = bt_att_get_channels(att); i < main_opts.gatt_channels; i++) {
 		io = bt_io_connect(eatt_connect_cb, client, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1b514aa4f..d0ab4da99 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1215,10 +1215,13 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
 				db_hash_read_cb, NULL, database);
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_SERVER_FEAT);
-	database->eatt = gatt_db_service_add_characteristic(service,
+	/* Only enable EATT if there is a socket listening */
+	if (database->eatt_io) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_SERVER_FEAT);
+		database->eatt = gatt_db_service_add_characteristic(service,
 				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
 				server_feat_read_cb, NULL, database);
+	}
 
 	gatt_db_service_set_active(service, true);
 
@@ -3564,6 +3567,10 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 		goto fail;
 	}
 
+	/* If just just 1 channel is enabled EATT is not required */
+	if (main_opts.gatt_channels == 1)
+		goto bredr;
+
 	/* EATT socket */
 	database->eatt_io = bt_io_listen(connect_cb, NULL, NULL, NULL, NULL,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
@@ -3591,6 +3598,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 		}
 	}
 
+bredr:
 	/* BR/EDR socket */
 	database->bredr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
diff --git a/src/hcid.h b/src/hcid.h
index ca405fde4..1bf93784d 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -62,6 +62,7 @@ struct main_opts {
 	bt_mode_t	mode;
 	bt_gatt_cache_t gatt_cache;
 	uint16_t	gatt_mtu;
+	uint8_t		gatt_channels;
 
 	uint8_t		key_size;
 
diff --git a/src/main.c b/src/main.c
index fc8c869fc..7b927ac79 100644
--- a/src/main.c
+++ b/src/main.c
@@ -109,6 +109,7 @@ static const char *gatt_options[] = {
 	"Cache",
 	"KeySize",
 	"ExchangeMTU",
+	"EATTChannels",
 	NULL
 };
 
@@ -471,6 +472,18 @@ static void parse_config(GKeyFile *config)
 		DBG("ExchangeMTU=%d", val);
 		main_opts.gatt_mtu = val;
 	}
+
+	val = g_key_file_get_integer(config, "GATT", "Channels", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("Channels=%d", val);
+		/* Ensure the channels is within a valid range. */
+		val = MIN(val, 5);
+		val = MAX(val, 1);
+		main_opts.gatt_channels = val;
+	}
 }
 
 static void init_defaults(void)
@@ -497,6 +510,7 @@ static void init_defaults(void)
 
 	main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	main_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
+	main_opts.gatt_channels = 3;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index bb5ff5b15..16701ebe4 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -99,6 +99,11 @@
 # Defaults to 517
 #ExchangeMTU = 517
 
+# Number of ATT channels
+# Possible values: 1-5 (1 disables EATT)
+# Default to 3
+#Channels = 3
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.21.1

