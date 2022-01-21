Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C2EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 20:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiAUUy7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiAUUy6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 15:54:58 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C15C06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:58 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n32so826764pfv.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UQrBgBcqNANOl0cOdNEioTlznopGluw+p1CpMsZGEfk=;
        b=nyA+PD+ES7vdjxmQuBx4n3uQbw5gtgBXH478xuNMDO2oeND9CICLxx/zRvV2dKb6tw
         +Gl1rqjlmyMZWZ80EE17aFBvHNS2kLC8G0jWJugfz84ds4LV1t7JyIoB3ENi3KFTTo1O
         hsGY+ke72q3lmgD5noTa/lHoUQnQkq+9B3FvDgi9POGvIUFUOMymawQopLiwJkaane0i
         eP02PRKdXdHNTHsRTsXmsJpR4GWgsyUymw+Q/6scfX6e9rqIa0LpeloVXRh49lIocniE
         sdQcuAhstLWU4BJuko9QCfeBoqvLugJh4UXOvueNB5eWB6D9eHZoKg9AxRZWPPRc4hp2
         H74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQrBgBcqNANOl0cOdNEioTlznopGluw+p1CpMsZGEfk=;
        b=nLGiATXYIkLxLcHBgP7wLH1gEcLkjDUye4nQHHo9YtgFPfmZQ219VucUDS2yAlRINi
         qj/7A2nqiYcKU8kN+OyLpzUAAnUaMjWLKMFpDdcSgtxqcqfs+YQfrJgFa2yoBRpYZ727
         GcaafcI52181kBAXFLyvHP14OmnuR6rFLA1dHaZOuRQm9GJBpyPl7HZQsrMXFUp/nHFJ
         YQf1poUfa8DTth0OxTi5MmWvFF4zMLuCKmoXwB4BUDFef/2XdcuMtnr1mcuRUe3kmCM7
         XqCSwO/u79ZnERfTnBeB8kL6o4lRDAwJZ9RzAJkJh8fG8zZ0N/6oHqXjk74LEBxAYPXf
         we+w==
X-Gm-Message-State: AOAM530pkWeYgO0ZUbtWmEENFpjfFufsUfWFjy/nfBK2vM/ESkUVq+8/
        RfJHoyruo+gSAvsFC8lrRPi2NCnHYX/dzw==
X-Google-Smtp-Source: ABdhPJyMNz1r8nEois63hkqXwQu41L7RVheT6Vl9u3240aPgp5X9erCIRUa+1La7mg3EKlm1Mw5aHQ==
X-Received: by 2002:aa7:888e:0:b0:4c4:3ad:9eee with SMTP id z14-20020aa7888e000000b004c403ad9eeemr5061995pfe.13.1642798497657;
        Fri, 21 Jan 2022 12:54:57 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j20sm7441279pfj.218.2022.01.21.12.54.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 12:54:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/gatt-db: Introduce gatt_db_attribute_notify
Date:   Fri, 21 Jan 2022 12:54:53 -0800
Message-Id: <20220121205454.1413365-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121205454.1413365-1-luiz.dentz@gmail.com>
References: <20220121205454.1413365-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces gatt_db_attribute_notify which can be used to trigger a
notification using the callback set by gatt_db_ccc_register.
---
 src/gatt-database.c  |  2 +-
 src/shared/gatt-db.c | 46 ++++++++++++++++++++++++++++++++++++++++----
 src/shared/gatt-db.h | 13 ++++++++++++-
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 25641da8a..dc75762f3 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1302,7 +1302,7 @@ static void populate_devinfo_service(struct btd_gatt_database *database)
 static void register_core_services(struct btd_gatt_database *database)
 {
 	gatt_db_ccc_register(database->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
-								database);
+							NULL, database);
 
 	populate_gap_service(database);
 	populate_gatt_service(database);
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 12ff5badb..59d19eea3 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -43,10 +43,13 @@ static const bt_uuid_t included_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_INCLUDE_UUID };
 static const bt_uuid_t ext_desc_uuid = { .type = BT_UUID16,
 				.value.u16 = GATT_CHARAC_EXT_PROPER_UUID };
+static const bt_uuid_t ccc_uuid = { .type = BT_UUID16,
+				.value.u16 = GATT_CLIENT_CHARAC_CFG_UUID };
 
 struct gatt_db_ccc {
 	gatt_db_read_t read_func;
 	gatt_db_write_t write_func;
+	gatt_db_notify_t notify_func;
 	void *user_data;
 };
 
@@ -109,6 +112,7 @@ struct gatt_db_attribute {
 
 	gatt_db_read_t read_func;
 	gatt_db_write_t write_func;
+	gatt_db_notify_t notify_func;
 	void *user_data;
 
 	unsigned int read_id;
@@ -1047,12 +1051,20 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					user_data);
 }
 
+static void find_ccc_value(struct gatt_db_attribute *attrib, void *user_data)
+{
+	uint16_t *handle = user_data;
+
+	gatt_db_attribute_get_char_data(attrib, NULL, handle, NULL, NULL, NULL);
+}
+
 struct gatt_db_attribute *
 gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
 {
 	struct gatt_db *db;
 	struct gatt_db_attribute *ccc;
-	bt_uuid_t uuid;
+	struct gatt_db_attribute *value;
+	uint16_t handle = 0;
 
 	if (!attrib)
 		return NULL;
@@ -1062,9 +1074,17 @@ gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
 	if (!db->ccc)
 		return NULL;
 
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	/* Locate value handle */
+	gatt_db_service_foreach_char(attrib, find_ccc_value, &handle);
+
+	if (!handle)
+		return NULL;
+
+	value = gatt_db_get_attribute(db, handle);
+	if (!value || value->notify_func)
+		return NULL;
 
-	ccc = service_insert_descriptor(attrib->service, 0, &uuid,
+	ccc = service_insert_descriptor(attrib->service, 0, &ccc_uuid,
 					permissions,
 					db->ccc->read_func,
 					db->ccc->write_func,
@@ -1073,12 +1093,16 @@ gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
 		return ccc;
 
 	gatt_db_attribute_set_fixed_length(ccc, 2);
+	ccc->notify_func = db->ccc->notify_func;
+	value->notify_func = db->ccc->notify_func;
 
 	return ccc;
 }
 
 void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
-				gatt_db_write_t write_func, void *user_data)
+				gatt_db_write_t write_func,
+				gatt_db_notify_t notify_func,
+				void *user_data)
 {
 	if (!db)
 		return;
@@ -1088,6 +1112,7 @@ void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
 
 	db->ccc->read_func = read_func;
 	db->ccc->write_func = write_func;
+	db->ccc->notify_func = notify_func;
 	db->ccc->user_data = user_data;
 }
 
@@ -2103,6 +2128,19 @@ bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 	return true;
 }
 
+bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att)
+{
+	if (!attrib || !ccc || !attrib->notify_func)
+		return false;
+
+	attrib->notify_func(attrib, ccc, value, len, att, ccc->user_data);
+
+	return true;
+}
+
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
 {
 	if (!attrib)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 3de22403c..acd8f6a81 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -47,6 +47,10 @@ typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data);
+typedef void (*gatt_db_notify_t) (struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att, void *user_data);
 
 struct gatt_db_attribute *
 gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
@@ -197,7 +201,9 @@ unsigned int gatt_db_register(struct gatt_db *db,
 bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 
 void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
-				gatt_db_write_t write_func, void *user_data);
+					gatt_db_write_t write_func,
+					gatt_db_notify_t notify_func,
+					void *user_data);
 
 typedef uint8_t (*gatt_db_authorize_cb_t)(struct gatt_db_attribute *attrib,
 					uint8_t opcode, struct bt_att *att,
@@ -275,6 +281,11 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 						unsigned int id, int err);
 
+bool gatt_db_attribute_notify(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att);
+
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
 
 void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib);
-- 
2.34.1

