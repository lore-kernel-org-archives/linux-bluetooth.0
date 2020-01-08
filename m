Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C4DC33C9B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE8206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgR2MRHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAHAeH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:34:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43349 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgAHAeH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:34:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so660112pga.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=asgOSiO3en3MKirTF13/FJXqhGCOjS4KYj7aip7vEMk=;
        b=cgR2MRHjczWnaS1aW48i4voSB3UOGaH+Eav1yu3hM52L1qu9Y5fGt5llo/tq79LuNl
         HrEkTVikTy/yi8wVmDZfloe0vnCIbCQArUrZK4aFMB/pJGP4cEhzAg/iZAECKpzxAwcu
         ofwOtKl1Sjhv/qYr0VkzIP3ZxJE6TeiLc0k8ogBKAb9EmXUUM2vOXcr5gpTiwBTMM9Sc
         8BQW4Ee9xkTar96uyMkRLfiaH1GSGYGGsfUdmaMSerwPoesK4vKP5QTnM7rjbRSUhU2j
         gQZfMuIqpLv2bIJpuvnfrZurd2JEO80gMH+8N4aXsdrKw3IsRJqhrKzddW8cwZ+rOfQm
         TEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asgOSiO3en3MKirTF13/FJXqhGCOjS4KYj7aip7vEMk=;
        b=WWZzKjczr/ZjnRTHsdzPBbpu5Gv+5ePTcjnqlA7U/sGBvcEW5vI0Yz851kjhA/ot6i
         Xhr+0JJU1pKyZfrG3/YZoUFjH24gXaWT6eEit1dn+8BSWrKsKPmT2jda5anIFbwWrI+t
         XYCKXOkTfJYH7SAEsl/iyL0J0XjW81B3eBqFlh2dW82+HpvNwjKzqHGFTekkGredn7Ou
         euiEDRWpZIZ51z4o2pTS0hv6dod05RiHmvegymFQWt9+EEF0zETj3qM0ZyAKrmPx10Ei
         OTE4zzSXtu394t0msjuPOVTCy68VMPJSlX9ADrTRYUAO+fv97ULzRT3B5ADDcqpp5ypz
         T2vA==
X-Gm-Message-State: APjAAAWTYEMMRsx6jnwWQ0wagIUf03kFCK+Ry7PLzCOPNkS+uHd6mb72
        mcSHbMdN6tUe+pNq7O4OTYjDsG3srJY=
X-Google-Smtp-Source: APXvYqxYlFjixI2EP3BpUEnzOSUqX6uTRXNsvgrI3B9plpIEFRs7qlC/95r+2w27WHnZb45Hiz9/Fg==
X-Received: by 2002:a63:e309:: with SMTP id f9mr2347223pgh.391.1578443646161;
        Tue, 07 Jan 2020 16:34:06 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.34.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:34:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 21/22] core: Add support for setting the number of GATT bearers
Date:   Tue,  7 Jan 2020 16:33:41 -0800
Message-Id: <20200108003342.15458-22-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
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
index f7f0bc789..828fe9810 100644
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
index 04a7e5319..203af709b 100644
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
index d4c892113..455201efd 100644
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
index adea85ce2..083f70c5b 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -56,6 +56,7 @@ struct main_opts {
 	bt_mode_t	mode;
 	bt_gatt_cache_t gatt_cache;
 	uint16_t	gatt_mtu;
+	uint8_t		gatt_channels;
 
 	uint8_t		key_size;
 };
diff --git a/src/main.c b/src/main.c
index 1a6ab36a3..701cd279c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -108,6 +108,7 @@ static const char *gatt_options[] = {
 	"Cache",
 	"KeySize",
 	"ExchangeMTU",
+	"EATTChannels",
 	NULL
 };
 
@@ -444,6 +445,18 @@ static void parse_config(GKeyFile *config)
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
@@ -470,6 +483,7 @@ static void init_defaults(void)
 
 	main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	main_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
+	main_opts.gatt_channels = 3;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 40687a755..35e4238f2 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -94,6 +94,11 @@
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
2.21.0

