Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D2FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiAUUy6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiAUUy5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 15:54:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A75C06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c3so9710904pls.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBlCYKmp+TeOJ8JAROGHcnVF8Gb8mmBUiMsm/SyOeFw=;
        b=pvwziCX4VgNiS08uF1wNf3B9Qp/m0jV+mPcDhxDYS/VqS4tenQYhZhfdLLAt0YPoz9
         nx8K9MlfBvR2UCypEg9rMBByYIIuzEg7DR4IMGtkK62P7z0b1Z5IQ7eT0B4lBxMEGLiC
         rGSudpTJvmGpwVMTIptv2KZna5scLcw9Ch/U2Ly1y1om3kcCe+mIlzqvEOJWdVVVshsj
         YGTyeLQb9v76N4kyRGSJxAN3StKxccKL7o14Y0pv+4Zsu9MOYE/bcp9Hj/IYHjc4Gmeu
         DrNim92NswNedqlMPN6BReRDMETudR8Ps0cY71YgCJKbtZZ+pa1u5p1hsGYSWq8nllE7
         b0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBlCYKmp+TeOJ8JAROGHcnVF8Gb8mmBUiMsm/SyOeFw=;
        b=fFFpuids2fkWkUXZgHBAtqVUiVGylRvgwPt52MR9CbQ6qoaJZakeRTllRP/xAJ+Wj9
         SeON7ZbvyBSYf7B3v/+Iutavg1UYurC33MKYIy+UF0ARoTP1lxczm9N+ffo7ka+HwaTW
         RyVyeSSDgcGa1aCdywLu0BQpB7kqCCEP/YowM1luTCrWlt1BA8ncfKpEatiV7FIdqAEb
         DKXruU9vlLIUT1h00uwBee3JaDg4K9IPAIC24NUT6PsjRzLASkcl0L9mqUbhj349OTwG
         WjN+YeWT3UQ/Lq/bbXM9Yl6D5WHmF9WR8x79ACW89NtmC9Heyc3jd4fxnDtmpcsnhgbW
         zEhA==
X-Gm-Message-State: AOAM531r9QbCRV1kWzzzr/d4WHaMKiDMF0SEsEIurc7o6vFigEnZwOaj
        LONjKhrkI4899domlHMt7jVMQrjv+WvmJA==
X-Google-Smtp-Source: ABdhPJxHcIfPXN0lVXlKCD+caJXQGTUb+74MEs3n75QWYtml032t5HxZx5XwOVnYNSWWX43mO1rJfw==
X-Received: by 2002:a17:902:6949:b0:14a:752c:58f2 with SMTP id k9-20020a170902694900b0014a752c58f2mr5680888plt.159.1642798496047;
        Fri, 21 Jan 2022 12:54:56 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j20sm7441279pfj.218.2022.01.21.12.54.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 12:54:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/gatt-db: Introduce gatt_db_service_add_ccc
Date:   Fri, 21 Jan 2022 12:54:51 -0800
Message-Id: <20220121205454.1413365-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds gatt_db_service_add_ccc so the likes of plugins can use it
with the defaults callbacks which is useful for tracking their states.
---
 src/shared/gatt-db.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  7 ++++++
 2 files changed, 60 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 3a02289ce..12ff5badb 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -44,6 +44,12 @@ static const bt_uuid_t included_service_uuid = { .type = BT_UUID16,
 static const bt_uuid_t ext_desc_uuid = { .type = BT_UUID16,
 				.value.u16 = GATT_CHARAC_EXT_PROPER_UUID };
 
+struct gatt_db_ccc {
+	gatt_db_read_t read_func;
+	gatt_db_write_t write_func;
+	void *user_data;
+};
+
 struct gatt_db {
 	int ref_count;
 	struct bt_crypto *crypto;
@@ -57,6 +63,8 @@ struct gatt_db {
 
 	gatt_db_authorize_cb_t authorize;
 	void *authorize_data;
+
+	struct gatt_db_ccc *ccc;
 };
 
 struct notify {
@@ -444,6 +452,7 @@ static void gatt_db_destroy(struct gatt_db *db)
 		timeout_remove(db->hash_id);
 
 	queue_destroy(db->services, gatt_db_service_destroy);
+	free(db->ccc);
 	free(db);
 }
 
@@ -1038,6 +1047,50 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					user_data);
 }
 
+struct gatt_db_attribute *
+gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
+{
+	struct gatt_db *db;
+	struct gatt_db_attribute *ccc;
+	bt_uuid_t uuid;
+
+	if (!attrib)
+		return NULL;
+
+	db = attrib->service->db;
+
+	if (!db->ccc)
+		return NULL;
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	ccc = service_insert_descriptor(attrib->service, 0, &uuid,
+					permissions,
+					db->ccc->read_func,
+					db->ccc->write_func,
+					db->ccc->user_data);
+	if (!ccc)
+		return ccc;
+
+	gatt_db_attribute_set_fixed_length(ccc, 2);
+
+	return ccc;
+}
+
+void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
+				gatt_db_write_t write_func, void *user_data)
+{
+	if (!db)
+		return;
+
+	if (!db->ccc)
+		db->ccc = new0(struct gatt_db_ccc, 1);
+
+	db->ccc->read_func = read_func;
+	db->ccc->write_func = write_func;
+	db->ccc->user_data = user_data;
+}
+
 static struct gatt_db_attribute *
 service_insert_included(struct gatt_db_service *service, uint16_t handle,
 					struct gatt_db_attribute *include)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 321a2aba6..3de22403c 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -92,6 +92,7 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					gatt_db_read_t read_func,
 					gatt_db_write_t write_func,
 					void *user_data);
+
 struct gatt_db_attribute *
 gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 					uint16_t handle,
@@ -101,6 +102,9 @@ gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 					gatt_db_write_t write_func,
 					void *user_data);
 
+struct gatt_db_attribute *
+gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions);
+
 struct gatt_db_attribute *
 gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
 			struct gatt_db_attribute *include);
@@ -192,6 +196,9 @@ unsigned int gatt_db_register(struct gatt_db *db,
 					gatt_db_destroy_func_t destroy);
 bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 
+void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
+				gatt_db_write_t write_func, void *user_data);
+
 typedef uint8_t (*gatt_db_authorize_cb_t)(struct gatt_db_attribute *attrib,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data);
-- 
2.34.1

