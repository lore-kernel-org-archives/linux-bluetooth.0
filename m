Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E1BC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0836F2147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoyhP4wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfA2N1A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:27:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45808 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfA2N1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:27:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so15920402edb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=F3gF1hphAkFz4gdxjgAF/w5A5aOIHJl3XerGNJsdtco=;
        b=PoyhP4wgPTgGp8GKxJGZ+h1T6CgnvbgtRa4RbEpyx+6Wl5f0EcxuftW2kPHsRqyG5I
         Td+2/t21uburaP4bZvR9rCRIZDGNByRAn2sZV9/sl3AJhihBKYHZ0RMrPtD2yjQuz/Ai
         ixlMKn1G3drBfXuusNiJgUcdHdG7SnVFN6a3rEUxesBGYDbBGrsH4RAzQtVO4gd8dUjJ
         TQ1r6ONMmuiCTsaa8dKE7ZAflUcIgf7mdj7r9wWze6giNjC4hg9IZ0YI3PQhfYYAjTyL
         Zhr9J/Q0B1fUrbn6bpXQYdEQRHTI68uo8ZC2gZQ+ksPfWluINgmbKrRCEiiLi5N8tfp3
         9uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=F3gF1hphAkFz4gdxjgAF/w5A5aOIHJl3XerGNJsdtco=;
        b=s0Z7ilBNzSsPHkshRLFftJSpfTsYu9jQn9EhJ53lwVrCthfE5/Fa8RkOAQDElNXudu
         UgfO9y/spaH4tv/EwOZIbirE4tRjJM+fpqycwBvbG9HFkGS21pdfXJJrk2ATWgNyTWvo
         WTOPut+4VhPg0HAewrbLzfumO3DHMuA84Kd0hRfUO66qbSE2EY/njbHT+3CVIB/wYLy2
         duH5a4GXEx6HRqI5C8n5f3BgvH4RUO2CexfVS/HBRYfQeEmFhLq5LMg7EVwJ1Kt2WyDo
         r7PCVNaMzXbB2WCRbFyclr9xH3BKeoikyhEGs2lr00wG5dPLc5H9CPSf4sawntC8Y45O
         ElnA==
X-Gm-Message-State: AJcUukehGW3uvkU1NfjMY98R3AKSYda2A8xebWpdxRCveO5kYuGcqJHe
        5gQSuJEXwd2GD2834G67bsNOBO4I
X-Google-Smtp-Source: ALg8bN4Sy/uCwtNSkgYNDcWs9oPEiidS7nROXgAC/h13VP7+o8mgBPc4+ErP08WPlXbYonbNWQwvFQ==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr25054648edn.117.1548768418170;
        Tue, 29 Jan 2019 05:26:58 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/15] device: Store Database Hash on storage
Date:   Tue, 29 Jan 2019 15:26:34 +0200
Message-Id: <20190129132634.28786-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores the hash on the storage so it can be reloaded when the
daemon/system restarts.
---
 src/device.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index 060251f66..8ddfa28ff 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2143,6 +2143,18 @@ struct gatt_saver {
 	GKeyFile *key_file;
 };
 
+static void db_hash_read_value_cb(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	const uint8_t **hash = user_data;
+
+	if (err || (length != 16))
+		return;
+
+	*hash = value;
+}
+
 static void store_desc(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct gatt_saver *saver = user_data;
@@ -2174,7 +2186,7 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
 	char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
 	uint16_t handle_num, value_handle;
 	uint8_t properties;
-	bt_uuid_t uuid;
+	bt_uuid_t uuid, hash_uuid;
 
 	if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
 						&properties, &saver->ext_props,
@@ -2185,8 +2197,34 @@ static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
 
 	sprintf(handle, "%04hx", handle_num);
 	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-	sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s", value_handle,
-							properties, uuid_str);
+
+	/* Store Database Hash  value if available */
+	bt_uuid16_create(&hash_uuid, GATT_CHARAC_DB_HASH);
+	if (!bt_uuid_cmp(&uuid, &hash_uuid)) {
+		const uint8_t *hash = NULL;
+
+		attr = gatt_db_get_attribute(saver->device->db, value_handle);
+
+		gatt_db_attribute_read(attr, 0, BT_ATT_OP_READ_REQ, NULL,
+					db_hash_read_value_cb, &hash);
+		if (hash)
+			sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:"
+				"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
+				"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
+				"%02hhx%02hhx:%s", value_handle, properties,
+				hash[0], hash[1], hash[2], hash[3],
+				hash[4], hash[5], hash[6], hash[7],
+				hash[8], hash[9], hash[10], hash[11],
+				hash[12], hash[13], hash[14], hash[15],
+				uuid_str);
+		else
+			sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s",
+				value_handle, properties, uuid_str);
+
+	} else
+		sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hhx:%s",
+				value_handle, properties, uuid_str);
+
 	g_key_file_set_string(key_file, "Attributes", handle, value);
 
 	gatt_db_service_foreach_desc(attr, store_desc, saver);
@@ -3228,6 +3266,20 @@ static void load_desc_value(struct gatt_db_attribute *attrib,
 		warn("loading descriptor value to db failed");
 }
 
+static ssize_t str2val(const char *str, uint8_t *val, size_t len)
+{
+	const char *pos = str;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (sscanf(pos, "%2hhx", &val[i]) != 1)
+			break;
+		pos += 2;
+	}
+
+	return i;
+}
+
 static int load_desc(char *handle, char *value,
 					struct gatt_db_attribute *service)
 {
@@ -3247,7 +3299,7 @@ static int load_desc(char *handle, char *value,
 		val = 0;
 	}
 
-	DBG("loading descriptor handle: 0x%04x, value: 0x%04x, uuid: %s",
+	DBG("loading descriptor handle: 0x%04x, value: 0x%04x, value uuid: %s",
 				handle_int, val, uuid_str);
 
 	bt_string_to_uuid(&uuid, uuid_str);
@@ -3282,21 +3334,31 @@ static int load_chrc(char *handle, char *value,
 	uint16_t properties, value_handle, handle_int;
 	char uuid_str[MAX_LEN_UUID_STR];
 	struct gatt_db_attribute *att;
+	char val_str[32];
+	uint8_t val[16];
+	size_t val_len;
 	bt_uuid_t uuid;
 
 	if (sscanf(handle, "%04hx", &handle_int) != 1)
 		return -EIO;
 
-	if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", &value_handle,
-						&properties, uuid_str) != 3)
-		return -EIO;
+	/* Check if there is any value stored */
+	if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%32s:%s",
+			&value_handle, &properties, val_str, uuid_str) != 4) {
+		if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s",
+				&value_handle, &properties, uuid_str) != 3)
+			return -EIO;
+		val_len = 0;
+	} else
+		val_len = str2val(val_str, val, sizeof(val));
 
 	bt_string_to_uuid(&uuid, uuid_str);
 
 	/* Log debug message. */
 	DBG("loading characteristic handle: 0x%04x, value handle: 0x%04x,"
-				" properties 0x%04x uuid: %s", handle_int,
-				value_handle, properties, uuid_str);
+				" properties 0x%04x value: %s uuid: %s",
+				handle_int, value_handle, properties,
+				val_len ? val_str : "", uuid_str);
 
 	att = gatt_db_service_insert_characteristic(service, value_handle,
 							&uuid, 0, properties,
@@ -3306,6 +3368,12 @@ static int load_chrc(char *handle, char *value,
 		return -EIO;
 	}
 
+	if (val_len) {
+		if (!gatt_db_attribute_write(att, 0, val, val_len, 0, NULL,
+						load_desc_value, NULL))
+			return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.17.2

