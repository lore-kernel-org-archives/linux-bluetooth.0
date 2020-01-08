Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22897C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3829206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzI3iNz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgAHAeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:34:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56029 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgAHAeB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:34:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so291127pjz.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BgAM/E2Zi8oiMSGPBJ1qVpBjV8Dt15AxwGSsMerk+Ow=;
        b=FzI3iNz7ytxOLIi46eE/2n4b5jYcnjPLEWv+fgud2sRpPzG42f7IsBIkoK4uqoRKqr
         hUeMn5C5rg8CkektJZFki8URbbsQmMHWGhcT0Z+Kig2P9X9f4q0f/OmzJaLTO7JZy2OB
         awXsf6TkY/ZXJ7dvWg6gm0MQ8s0tOlBobKQ/3bZAtjlcr3Zk3TVKG4PYK2enwPz5R3FJ
         azloGgs6ln9FYuBPwqSzs95GmaTLIYPy7FMHsXe25jf1NQUSgEAfRq0HGa3DqYnCXuek
         YNFORVUqsXXji4uo+gqu8UjTUBETjvGoCBCo9sZZmBu2Nm4rFyWMY/8sHX93bZ4iXoIa
         IU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgAM/E2Zi8oiMSGPBJ1qVpBjV8Dt15AxwGSsMerk+Ow=;
        b=pY5+F+652khDHsRCrgi4b5URzvdx+Ao0xg6zZaSYX6+ejQ4vMXpK6lB19qjm4Xs5J+
         REMjalj+5GJ8ebbr/3sH5Kxghwm3bmwGTGxHB8yqCPzrPAcBv600giExThdYrUUwYkkx
         mDd4gn1OGoI6+9DB51QMEsxKv6+u+B/BJ2BPWYpncUkOQoFBMdfrGVTWFVXOTIBAQcoN
         3d49rxmaPMJrf1AbjGnS7u/26dAZSrgwQsBghYYnjGQiwziduM1ci83wZdVdwfL7G97q
         bm/FMDPe4BV4IhSk15TGZlJjgJnFxg/0NWqr8KX7wlIH+RUFQ+4mYZDqqtK2qiiu1wFg
         YLyQ==
X-Gm-Message-State: APjAAAXTX8XDy+X2y5CLhDBQGlljkDgyHvOHoUrxBz3RFW52toYfPJ1O
        GcJTjHMcGOX03Tga+nBiZCeTRogTajQ=
X-Google-Smtp-Source: APXvYqy9vgHlDvpHsB+Ji4Kg6Q1t58iILUGbEaPJM9RGLO/XnDmPRy/k1bU8/EQb8ZcwNmpsYytH7w==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr2551129plo.28.1578443639908;
        Tue, 07 Jan 2020 16:33:59 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:59 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/22] gatt: Enable EATT bearer support
Date:   Tue,  7 Jan 2020 16:33:36 -0800
Message-Id: <20200108003342.15458-17-luiz.dentz@gmail.com>
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

This adds support for EATT connections.
---
 src/device.c        |  11 +++++
 src/gatt-client.c   |  83 ++++++++++++++++++++++++++++++++++
 src/gatt-database.c | 107 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 175 insertions(+), 26 deletions(-)

diff --git a/src/device.c b/src/device.c
index dbbc59b15..f7f0bc789 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5048,6 +5048,17 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
+	if (dev->att) {
+		if (!bt_att_attach_fd(dev->att, g_io_channel_unix_get_fd(io))) {
+			DBG("EATT channel connected");
+			g_io_channel_set_close_on_unref(io, FALSE);
+			return true;
+		}
+
+		error("Failed to attach EATT channel");
+		return false;
+	}
+
 	if (sec_level == BT_IO_SEC_LOW && dev->le_state.paired) {
 		DBG("Elevating security level since LTK is available");
 
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 6bcdecf09..04a7e5319 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -35,9 +35,11 @@
 #include "lib/uuid.h"
 
 #include "gdbus/gdbus.h"
+#include "btio/btio.h"
 
 #include "log.h"
 #include "error.h"
+#include "hcid.h"
 #include "adapter.h"
 #include "device.h"
 #include "src/shared/io.h"
@@ -57,8 +59,11 @@
 #define GATT_CHARACTERISTIC_IFACE	"org.bluez.GattCharacteristic1"
 #define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
+#define EATT_MAX_BEARERS 2
+
 struct btd_gatt_client {
 	struct btd_device *device;
+	uint8_t features;
 	bool ready;
 	char devaddr[18];
 	struct gatt_db *db;
@@ -2154,6 +2159,70 @@ static void register_notify(void *data, void *user_data)
 	notify_client_free(notify_client);
 }
 
+static void eatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	struct btd_gatt_client *client = user_data;
+
+	if (gerr)
+		return;
+
+	device_attach_att(client->device, io);
+}
+
+static void eatt_connect(struct btd_gatt_client *client)
+{
+	struct btd_device *dev = client->device;
+	struct btd_adapter *adapter = device_get_adapter(dev);
+	GIOChannel *io;
+	GError *gerr = NULL;
+	char addr[18];
+	int i;
+
+	ba2str(device_get_address(dev), addr);
+
+	DBG("Connection attempt to: %s", addr);
+
+	for (i = 0; i < EATT_MAX_BEARERS; i++) {
+		io = bt_io_connect(eatt_connect_cb, client, NULL, NULL,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_SOURCE_TYPE,
+				btd_adapter_get_address_type(adapter),
+				BT_IO_OPT_DEST_BDADDR, device_get_address(dev),
+				BT_IO_OPT_DEST_TYPE,
+				device_get_le_address_type(dev),
+				BT_IO_OPT_MODE, BT_IO_MODE_ECRED,
+				BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_MTU, main_opts.gatt_mtu,
+				BT_IO_OPT_INVALID);
+		if (io == NULL) {
+			/* Fallback to regular LE mode */
+			io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR,
+					btd_adapter_get_address(adapter),
+					BT_IO_OPT_SOURCE_TYPE,
+					btd_adapter_get_address_type(adapter),
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(dev),
+					BT_IO_OPT_DEST_TYPE,
+					device_get_le_address_type(dev),
+					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_INVALID);
+			if (!io) {
+				error("EATT bt_io_connect(%s): %s", addr,
+								gerr->message);
+				g_error_free(gerr);
+				return;
+			}
+		}
+
+		g_io_channel_unref(io);
+	}
+}
+
 void btd_gatt_client_ready(struct btd_gatt_client *client)
 {
 	if (!client)
@@ -2175,6 +2244,15 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
 	DBG("GATT client ready");
 
 	create_services(client);
+
+	DBG("Features 0x%02x", client->features);
+
+	if (!client->features) {
+		client->features = bt_gatt_client_get_features(client->gatt);
+		DBG("Update Features 0x%02x", client->features);
+		if (client->features & BT_GATT_CHRC_CLI_FEAT_EATT)
+			eatt_connect(client);
+	}
 }
 
 void btd_gatt_client_connected(struct btd_gatt_client *client)
@@ -2197,6 +2275,11 @@ void btd_gatt_client_connected(struct btd_gatt_client *client)
 	 * for any pre-registered notification sessions.
 	 */
 	queue_foreach(client->all_notify_clients, register_notify, client);
+
+	if (!(client->features & BT_GATT_CHRC_CLI_FEAT_EATT))
+		return;
+
+	eatt_connect(client);
 }
 
 void btd_gatt_client_service_added(struct btd_gatt_client *client,
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 419e4f9e1..47d32889d 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -48,14 +48,6 @@
 #include "profile.h"
 #include "service.h"
 
-#ifndef ATT_CID
-#define ATT_CID 4
-#endif
-
-#ifndef ATT_PSM
-#define ATT_PSM 31
-#endif
-
 #define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
 #define GATT_PROFILE_IFACE	"org.bluez.GattProfile1"
 #define GATT_SERVICE_IFACE	"org.bluez.GattService1"
@@ -80,7 +72,8 @@ struct btd_gatt_database {
 	struct gatt_db *db;
 	unsigned int db_id;
 	GIOChannel *le_io;
-	GIOChannel *l2cap_io;
+	GIOChannel *eatt_io;
+	GIOChannel *bredr_io;
 	struct queue *records;
 	struct queue *device_states;
 	struct queue *ccc_callbacks;
@@ -88,6 +81,7 @@ struct btd_gatt_database {
 	struct gatt_db_attribute *svc_chngd_ccc;
 	struct gatt_db_attribute *cli_feat;
 	struct gatt_db_attribute *db_hash;
+	struct gatt_db_attribute *eatt;
 	struct queue *apps;
 	struct queue *profiles;
 };
@@ -594,9 +588,14 @@ static void gatt_database_free(void *data)
 		g_io_channel_unref(database->le_io);
 	}
 
-	if (database->l2cap_io) {
-		g_io_channel_shutdown(database->l2cap_io, FALSE, NULL);
-		g_io_channel_unref(database->l2cap_io);
+	if (database->eatt_io) {
+		g_io_channel_shutdown(database->eatt_io, FALSE, NULL);
+		g_io_channel_unref(database->eatt_io);
+	}
+
+	if (database->bredr_io) {
+		g_io_channel_shutdown(database->bredr_io, FALSE, NULL);
+		g_io_channel_unref(database->bredr_io);
 	}
 
 	/* TODO: Persistently store CCC states before freeing them */
@@ -717,7 +716,7 @@ static sdp_record_t *record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 	uuid_t root_uuid, proto_uuid, l2cap;
 	sdp_record_t *record;
 	sdp_data_t *psm, *sh, *eh;
-	uint16_t lp = ATT_PSM;
+	uint16_t lp = BT_ATT_PSM;
 
 	if (uuid == NULL)
 		return NULL;
@@ -1098,7 +1097,10 @@ static void cli_feat_write_cb(struct gatt_db_attribute *attrib,
 {
 	struct btd_gatt_database *database = user_data;
 	struct device_state *state;
+	uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
+				BT_GATT_CHRC_CLI_FEAT_EATT };
 	uint8_t ecode = 0;
+	unsigned int i;
 
 	DBG("Client Features write");
 
@@ -1113,13 +1115,12 @@ static void cli_feat_write_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	/* A client shall never clear a bit it has set.
-	 * TODO: make it generic to any bits.
-	 */
-	if (state->cli_feat[0] & BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING &&
-			!(value[0] & BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING)) {
-		ecode = BT_ATT_ERROR_VALUE_NOT_ALLOWED;
-		goto done;
+	for (i = 0; i < sizeof(bits); i++) {
+		/* A client shall never clear a bit it has set */
+		if (state->cli_feat[0] & (1 << i) && !(value[0] & (1 << i))) {
+			ecode = BT_ATT_ERROR_VALUE_NOT_ALLOWED;
+			goto done;
+		}
 	}
 
 	/* Shall we reallocate the feat array if bigger? */
@@ -1129,7 +1130,7 @@ static void cli_feat_write_cb(struct gatt_db_attribute *attrib,
 		len--;
 	}
 
-	state->cli_feat[0] &= BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING;
+	state->cli_feat[0] &= ((1 << sizeof(bits)) - 1);
 	state->change_aware = true;
 
 done:
@@ -1161,6 +1162,28 @@ static void db_hash_read_cb(struct gatt_db_attribute *attrib,
 		state->change_aware = true;
 }
 
+static void server_feat_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	struct device_state *state;
+	uint8_t ecode = 0;
+	uint8_t value = 0;
+
+	state = get_device_state(database, att);
+	if (!state) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	value |= BT_GATT_CHRC_SERVER_FEAT_EATT;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, &value, sizeof(value));
+}
+
 static void populate_gatt_service(struct btd_gatt_database *database)
 {
 	bt_uuid_t uuid;
@@ -1168,7 +1191,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
-	service = gatt_db_add_service(database->db, &uuid, true, 8);
+	service = gatt_db_add_service(database->db, &uuid, true, 10);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
@@ -1191,6 +1214,11 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
 				db_hash_read_cb, NULL, database);
 
+	bt_uuid16_create(&uuid, GATT_CHARAC_SERVER_FEAT);
+	database->eatt = gatt_db_service_add_characteristic(service,
+				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
+				server_feat_read_cb, NULL, database);
+
 	gatt_db_service_set_active(service, true);
 
 	database_add_record(database, service);
@@ -3525,7 +3553,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 					BT_IO_OPT_SOURCE_BDADDR, addr,
 					BT_IO_OPT_SOURCE_TYPE,
 					btd_adapter_get_address_type(adapter),
-					BT_IO_OPT_CID, ATT_CID,
+					BT_IO_OPT_CID, BT_ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
 	if (!database->le_io) {
@@ -3534,14 +3562,41 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 		goto fail;
 	}
 
+	/* EATT socket */
+	database->eatt_io = bt_io_listen(connect_cb, NULL, NULL, NULL, NULL,
+					BT_IO_OPT_SOURCE_BDADDR, addr,
+					BT_IO_OPT_SOURCE_TYPE,
+					btd_adapter_get_address_type(adapter),
+					BT_IO_OPT_MODE, BT_IO_MODE_ECRED,
+					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_INVALID);
+	if (!database->eatt_io) {
+		/* Fallback to regular LE mode */
+		database->eatt_io = bt_io_listen(connect_cb, NULL, NULL, NULL,
+					&gerr,
+					BT_IO_OPT_SOURCE_BDADDR, addr,
+					BT_IO_OPT_SOURCE_TYPE,
+					btd_adapter_get_address_type(adapter),
+					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_INVALID);
+		if (!database->eatt_io) {
+			g_error_free(gerr);
+			goto fail;
+		}
+	}
+
 	/* BR/EDR socket */
-	database->l2cap_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
+	database->bredr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, addr,
-					BT_IO_OPT_PSM, ATT_PSM,
+					BT_IO_OPT_PSM, BT_ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_MTU, main_opts.gatt_mtu,
 					BT_IO_OPT_INVALID);
-	if (database->l2cap_io == NULL) {
+	if (database->bredr_io == NULL) {
 		error("Failed to start listening: %s", gerr->message);
 		g_error_free(gerr);
 		goto fail;
-- 
2.21.0

