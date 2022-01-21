Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiAUUzA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiAUUy7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 15:54:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA3C06173D
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n16-20020a17090a091000b001b46196d572so10060601pjn.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T157zpPrAdmyj6XH3cNbxAkpr5gHylRa4bo497MB4js=;
        b=UepqD61U4Bkan4OsbJGvZc6mGoSi77NvVSwPgfKJbK2KXIUvPwh1kc80n318b3acH+
         aqIy1w/C1z0syuMBg9bzgy5b7D4afK9wkC+5PgHLlAhFuFbXlSIJQKEj/M++pf53hmSS
         rbayCD1i790B3t+2D88Ut7DQCOoV/Z9wv4dljogRNxTG+9PBHFkoi/ittUQLFZQr/vyH
         IuAWgLF+offo6Dq2fAavIJhBqtivDizFYqdFVfEwzfFw8NSGSyiaUnAm6AYil4EEmDCd
         ffXDHfuCxwTQZjCxAPdXKgL07uxG1foiV7u/1Fx4pnHuA0huZsxvltgnRo9JBiSoG2qV
         eMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T157zpPrAdmyj6XH3cNbxAkpr5gHylRa4bo497MB4js=;
        b=s/HT5ZDCoi6pj9dZlzdJCqYekXoXqQRgQJ5hNaX49oQn6/MXa/+JwWSwTcWAgrRsui
         mjlQFvS1qTsNHd172C8TKlwyGyiYyJxKlBgjua1eiCV2UXHWaTyM1CM2ljrySojFT49Y
         ax0Aw7u/1h1qT9hdy7SfCjDvqPyUuaC8IEXED18CWpfQtcSB/E8xaPMID7tJmJT976vz
         4braVxeqYJwavTI8UbBoizeLqjyIBT19HQr5BwIEEVy/Ag9a2tgeUun8Ehc5NzF53Z0D
         Dwt1kq52O/j/pAxIpcyG8NgAmKbRVJYc0Nck4UxKiM3BchO9Uuj/KOCqaBiiBUFxbJqU
         0lQw==
X-Gm-Message-State: AOAM5318zxswtvuzLi6BK2u19mpTti8hfu47WDcJw9xVg9HwplbQEdJ+
        ECcK5XeBcmrkDE6MthcbpVoCjzeHvLPi6Q==
X-Google-Smtp-Source: ABdhPJzRuK+pJGWY34S2nh5uUEOFtVJbx4MSp7udzjlzzMyt6pb+2THe8hdSJTmzJF0293K567PfsQ==
X-Received: by 2002:a17:902:ed85:b0:14a:2471:e11d with SMTP id e5-20020a170902ed8500b0014a2471e11dmr5135351plj.77.1642798498228;
        Fri, 21 Jan 2022 12:54:58 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j20sm7441279pfj.218.2022.01.21.12.54.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 12:54:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] gatt: Make use of gatt_db_attribute_notify
Date:   Fri, 21 Jan 2022 12:54:54 -0800
Message-Id: <20220121205454.1413365-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121205454.1413365-1-luiz.dentz@gmail.com>
References: <20220121205454.1413365-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of gatt_db_attribute_notify to send indications of
Service Changed.
---
 src/gatt-database.c | 73 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index dc75762f3..d3518ebfc 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -378,6 +378,18 @@ static bool get_dst_info(struct bt_att *att, bdaddr_t *dst, uint8_t *dst_type)
 	return true;
 }
 
+static struct device_state *
+find_device_state_by_att(struct btd_gatt_database *database, struct bt_att *att)
+{
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+
+	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
+		return NULL;
+
+	return find_device_state(database, &bdaddr, bdaddr_type);
+}
+
 static struct device_state *get_device_state(struct btd_gatt_database *database,
 						struct bt_att *att)
 {
@@ -1299,16 +1311,6 @@ static void populate_devinfo_service(struct btd_gatt_database *database)
 	database_add_record(database, service);
 }
 
-static void register_core_services(struct btd_gatt_database *database)
-{
-	gatt_db_ccc_register(database->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
-							NULL, database);
-
-	populate_gap_service(database);
-	populate_gatt_service(database);
-	populate_devinfo_service(database);
-}
-
 static void conf_cb(void *user_data)
 {
 	GDBusProxy *proxy = user_data;
@@ -1432,6 +1434,49 @@ remove:
 	}
 }
 
+static void gatt_notify_cb(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att, void *user_data)
+{
+	struct btd_gatt_database *database = user_data;
+	struct notify notify;
+
+	memset(&notify, 0, sizeof(notify));
+
+	notify.database = database;
+	notify.handle = gatt_db_attribute_get_handle(attrib);
+	notify.ccc_handle = gatt_db_attribute_get_handle(ccc);
+	notify.value = (void *) value;
+	notify.len = len;
+
+	if (attrib == database->svc_chngd)
+		notify.conf = service_changed_conf;
+
+	/* If a specific att is provided notify only to that device */
+	if (att) {
+		struct device_state *state;
+
+		state = find_device_state_by_att(database, att);
+		if (!state)
+			return;
+
+		send_notification_to_device(state, &notify);
+	} else
+		queue_foreach(database->device_states,
+				send_notification_to_device, &notify);
+}
+
+static void register_core_services(struct btd_gatt_database *database)
+{
+	gatt_db_ccc_register(database->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
+						gatt_notify_cb, database);
+
+	populate_gap_service(database);
+	populate_gatt_service(database);
+	populate_devinfo_service(database);
+}
+
 static void send_notification_to_devices(struct btd_gatt_database *database,
 					uint16_t handle, uint8_t *value,
 					uint16_t len, uint16_t ccc_handle,
@@ -1478,8 +1523,8 @@ static void send_service_changed(struct btd_gatt_database *database,
 	put_le16(start, value);
 	put_le16(end, value + 2);
 
-	send_notification_to_devices(database, handle, value, sizeof(value),
-					ccc_handle, service_changed_conf, NULL);
+	gatt_db_attribute_notify(database->svc_chngd, database->svc_chngd_ccc,
+				 value, sizeof(value), NULL);
 }
 
 static void gatt_db_service_added(struct gatt_db_attribute *attrib,
@@ -3917,6 +3962,6 @@ void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database)
 	put_le16(0x0001, value);
 	put_le16(0xffff, value + 2);
 
-	send_notification_to_devices(database, handle, value, sizeof(value),
-					ccc_handle, service_changed_conf, NULL);
+	gatt_db_attribute_notify(database->svc_chngd, database->svc_chngd_ccc,
+				 value, sizeof(value), NULL);
 }
-- 
2.34.1

