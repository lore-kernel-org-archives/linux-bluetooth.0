Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C856CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927912371F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhAOM0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 07:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbhAOM0W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 07:26:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F6CC06179B
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 04:25:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n76so5409079ybg.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 04:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=TM0u4SZ4j8qIp62RWv0SArv9vIibP2vMp20ShGDIKi8=;
        b=bTEYsL7hYW4mNzN1L7wu5RDxKz57l66JOnglas/RVXmZNEq31iql2FfYkNKAlQhoNT
         W0RSDr1jtLyLgq6olu9w88advYiNcDzNiUOyA10lW946LolhUi/7DM019DvKj5ibhkpg
         0j/nkXb34OtoIHMKU8o+h+tqL9fOspjol9n4L2M589iXyuPD5I/tV572/b6RL4JpCMPR
         NTHYaKWy+ypdqZ6fH3INraHmb6/AdAq+4koX6dN7OKupztNRj+qp+FUGwb4f+5iqXAtz
         IBo632SjmQuRZLA7ZK7HzIoAsmXerVw7jn4mKEC6Of7qVUb7cjkEZWPA2UTvu7pAO2AP
         NFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=TM0u4SZ4j8qIp62RWv0SArv9vIibP2vMp20ShGDIKi8=;
        b=XnbV0+qs7rbG+TIDvVbuMVuECfpikW/IbAxnXZnGU2eQ4XKCrUHwgQT/s7tAuDunxN
         UhntoYAPsiUXB9Ey7BKDiDPB5lGjk/xKnzBj+K/k1A7OaidSo6RFU73uDP9zys6TY+wB
         OSNoOCudmYWARd+EXDA3hxsoI7gR7vCpJqeFR/jWA5qtFDhpeJsDNl9OHi1Y2/DRTaFF
         ejk9y9biUA0vfaFgQbRmBRI0cH7qzZ/+MZklQ0gWK+DEJUfLnCf6FTD0ZtsdiD5a+Ay3
         2Pl5DNtyR3AKuc601WIw/b4G5iYvqwHvD6/D0zTCNWk3z8t+HX5/GAJVLWS0ExR39XEs
         de+w==
X-Gm-Message-State: AOAM531Fd1PHqknmoH1wqsLegypbiGgSwdQcUyzWHMQPCGLCwBfmtIbw
        YnSE0lspRYMZRw0fqN/SJZlR4WlW5MRtbIXqppuZWn2tJuJtjMW9nDGsSclp266fxk0ljj7tH+V
        SbM6PR3BOi818jErglVJOUXzYHOxQnIXYIKX4G4454UL72CVZWhvo7Vgi4LyZGYZxNWX4JxCpF4
        Ld
X-Google-Smtp-Source: ABdhPJwaxG1X3YpyLwORv0QSVW1PQMbONofVww3ik1Gw0qdhdwwGabJTLIJ/BWt/gA2I1iCVJR/8UoYA3XdJ
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:4905:: with SMTP id
 w5mr18239436yba.498.1610713518870; Fri, 15 Jan 2021 04:25:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 20:25:13 +0800
Message-Id: <20210115202432.Bluez.1.I608cbc9e4ad3ffb910de766da79c0f418ab1ba35@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [Bluez PATCH] gatt: Use the same crypto instance for each device
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Every time a device is found, BlueZ would need to open 3 socket
connections for crypto. On a noisy environment where there is a lot
of advertising devices, we could hit the max opened file limit. As
a result, connection to the device would fail until the temporary
devices are removed due to temporary timer timeouts.

This patch store a crypto instance in adapter and reuse the same
crypto instance for each device.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---
Hi BlueZ maintainers,

Is there a reason to have more than one crypto instance? If not,
we could just have a singleton and a getter get_crypto_instance()
which would instantiate a crypto object if it doesn't exist, in lieu
of bt_crypto_new().

 android/gatt.c        |  2 +-
 peripheral/gatt.c     |  4 ++--
 src/adapter.c         | 12 ++++++++++++
 src/adapter.h         |  2 ++
 src/device.c          |  2 +-
 src/gatt-database.c   |  2 +-
 src/shared/gatt-db.c  |  9 +++++++--
 src/shared/gatt-db.h  |  4 +++-
 tools/btgatt-client.c |  2 +-
 tools/btgatt-server.c |  2 +-
 unit/test-gatt.c      |  4 ++--
 11 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a8a0c488b0..d00c4adf2c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -7234,7 +7234,7 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	app_connections = queue_new();
 	listen_apps = queue_new();
 	services_sdp = queue_new();
-	gatt_db = gatt_db_new();
+	gatt_db = gatt_db_new(NULL);
 
 	if (!gatt_db) {
 		error("gatt: Failed to allocate memory for database");
diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index ff1354cb48..1991ec7d4b 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -261,7 +261,7 @@ void gatt_server_start(void)
 		return;
 	}
 
-	gatt_db = gatt_db_new();
+	gatt_db = gatt_db_new(NULL);
 	if (!gatt_db) {
 		close(att_fd);
 		att_fd = -1;
@@ -271,7 +271,7 @@ void gatt_server_start(void)
 	populate_gap_service(gatt_db);
 	populate_devinfo_service(gatt_db);
 
-	gatt_cache = gatt_db_new();
+	gatt_cache = gatt_db_new(NULL);
 
 	conn_list = queue_new();
 	if (!conn_list) {
diff --git a/src/adapter.c b/src/adapter.c
index c1f976323e..794fe1045d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -46,6 +46,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/crypto.h"
 
 #include "btio/btio.h"
 #include "btd.h"
@@ -281,6 +282,8 @@ struct btd_adapter {
 	bool is_default;		/* true if adapter is default one */
 
 	bool le_simult_roles_supported;
+
+	struct bt_crypto *crypto;
 };
 
 typedef enum {
@@ -5376,6 +5379,8 @@ static void adapter_free(gpointer user_data)
 
 	g_slist_free(adapter->connections);
 
+	bt_crypto_unref(adapter->crypto);
+
 	g_free(adapter->path);
 	g_free(adapter->name);
 	g_free(adapter->short_name);
@@ -6321,6 +6326,8 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 
 	adapter->auths = g_queue_new();
 
+	adapter->crypto = bt_crypto_new();
+
 	return btd_adapter_ref(adapter);
 }
 
@@ -9917,3 +9924,8 @@ bool btd_has_kernel_features(uint32_t features)
 {
 	return (kernel_features & features) ? true : false;
 }
+
+struct bt_crypto *btd_adapter_get_crypto(struct btd_adapter *adapter)
+{
+	return adapter->crypto;
+}
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcca..2c7f06493a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -240,3 +240,5 @@ enum kernel_features {
 };
 
 bool btd_has_kernel_features(uint32_t feature);
+
+struct bt_crypto *btd_adapter_get_crypto(struct btd_adapter *adapter);
diff --git a/src/device.c b/src/device.c
index af13badfc8..0cf7423cce 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4047,7 +4047,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
 	device->tx_power = 127;
 
-	device->db = gatt_db_new();
+	device->db = gatt_db_new(btd_adapter_get_crypto(adapter));
 	if (!device->db) {
 		g_free(device);
 		return NULL;
diff --git a/src/gatt-database.c b/src/gatt-database.c
index d99604826e..2024fdd5d2 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3623,7 +3623,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 
 	database = new0(struct btd_gatt_database, 1);
 	database->adapter = btd_adapter_ref(adapter);
-	database->db = gatt_db_new();
+	database->db = gatt_db_new(btd_adapter_get_crypto(adapter));
 	database->records = queue_new();
 	database->device_states = queue_new();
 	database->apps = queue_new();
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8bff4d37aa..d616c17e47 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -235,12 +235,17 @@ struct gatt_db *gatt_db_ref(struct gatt_db *db)
 	return db;
 }
 
-struct gatt_db *gatt_db_new(void)
+struct gatt_db *gatt_db_new(struct bt_crypto *crypto)
 {
 	struct gatt_db *db;
 
 	db = new0(struct gatt_db, 1);
-	db->crypto = bt_crypto_new();
+
+	if (crypto)
+		db->crypto = bt_crypto_ref(crypto);
+	else
+		db->crypto = bt_crypto_new();
+
 	db->services = queue_new();
 	db->notify_list = queue_new();
 	db->next_handle = 0x0001;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 321a2aba61..1dac1af4fe 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -8,10 +8,12 @@
  *
  */
 
+#include "src/shared/crypto.h"
+
 struct gatt_db;
 struct gatt_db_attribute;
 
-struct gatt_db *gatt_db_new(void);
+struct gatt_db *gatt_db_new(struct bt_crypto *crypto);
 
 struct gatt_db *gatt_db_ref(struct gatt_db *db);
 void gatt_db_unref(struct gatt_db *db);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 8c9365aa2c..945e24d6f8 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -197,7 +197,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 	}
 
 	cli->fd = fd;
-	cli->db = gatt_db_new();
+	cli->db = gatt_db_new(NULL);
 	if (!cli->db) {
 		fprintf(stderr, "Failed to create GATT database\n");
 		bt_att_unref(cli->att);
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 000145a3db..50004acee5 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -569,7 +569,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	server->device_name[name_len] = '\0';
 
 	server->fd = fd;
-	server->db = gatt_db_new();
+	server->db = gatt_db_new(NULL);
 	if (!server->db) {
 		fprintf(stderr, "Failed to create GATT database\n");
 		goto fail;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 4aa87d09c4..1916ace6c7 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -674,7 +674,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 						"bt_gatt_server:", NULL);
 		break;
 	case CLIENT:
-		context->client_db = gatt_db_new();
+		context->client_db = gatt_db_new(NULL);
 		g_assert(context->client_db);
 
 		context->client = bt_gatt_client_new(context->client_db,
@@ -1363,7 +1363,7 @@ struct att_handle_spec {
 
 static struct gatt_db *make_db(const struct att_handle_spec *spec)
 {
-	struct gatt_db *db = gatt_db_new();
+	struct gatt_db *db = gatt_db_new(NULL);
 	struct gatt_db_attribute *att, *include_att;
 	bt_uuid_t uuid;
 
-- 
2.30.0.296.g2bfb1c46d8-goog

