Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDC11725
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612563; cv=none; b=NwoJEeH30YprNppPCAyCKUj1WeyDoen0jFmY37isFEtxGKOh+bJnzqGy6vHeaFaMEDzo3f5L/8DAPiapbHdR85IGE2kdSkDzLryV6o5bjpwRQWrZL8dzip07WWy3QrNkg6077BXEMpnaSRCA+zSMB4C6G29epz4nekNZ3jjsKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612563; c=relaxed/simple;
	bh=ZN39ykyt1o5qp4A+cGNdXbedG0APKeNz0mx3+ZrZl4g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D7shn3+mJvhnQ4U7AGI7mkJWqVx+trzW46nP/KJz6n21FSlVVQ3TYTQu/QccvlsrcwjonPdjkoQ7w/eCdzlC9N9CviGBYCw+AtP2YiNlNucCbUsoQlyUIA3q9QG0BcRtokmH62w6/hqZDJcpG7hlGOpST3vAzNZ18ZSIS4jCF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcU9ycA+; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcU9ycA+"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-479dcaaf2b1so1264835137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712612560; x=1713217360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zM/WeBB8767+bL9zn0hQE6QySizR2eaR9vMmPoSdXWQ=;
        b=hcU9ycA+m5Z5iQbVeBQNa6XnD6KdyTfdUEKlh7ItQRN8W2wwi6FBe9xIzjyzGntvaz
         OIoSL+f271JegXY6UirUYzLEJd10yaQag/BtfcEnFGRiK3Fg/Y9HfI67HnNEpizWn1z2
         JGDZ06CNWN35V9vE8v49KCLgMEtIDi/oxou7CYkQSWfE4WKFGBiN0f2sn1wcoeZRAWw5
         PWbtGeUMOi5xnau0cpbGHnQWpHHiBmAqo+cmvNL2RGRteUSlvtdJB/w3pqgGaUQqUf4X
         g6Z2BXLW9A2lIAJqel8HzJ5Ymm97+UOP3ierhTsu4To3crmbS98pz5IV+uHR6SxSf0LN
         R7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612560; x=1713217360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM/WeBB8767+bL9zn0hQE6QySizR2eaR9vMmPoSdXWQ=;
        b=OaR3rDs6U5VyC13i8brq3CtUQP5Y69PAWRL4dXC6UbawisrAI+dnn+YKyiXAWim9IU
         QyqHWhgsfHxIEXEgZLuSCjIihwV3HUHkNQYYzYTG7lvbxlsR+ayaJOj0NSj1+TbO/4Jp
         metRJphhdpnsUZdqjETnhQzbxolGANbsEA1ejH5WOpzUbdOIoZxCTR5fA89Z/Y+Fhpq+
         WhKSHUJEZP7YhsA9Unhpm4cNTUi0jrwv1TdWYIb4qqGmVSk4h87AEq1gd91uY94QCI3z
         3ewAepvfw9BOmkiaI90Qfl64/FXdP6X5uZzkJF2o8Jaj7OdXHPuqn67PDkMrOTR7tmui
         DH5w==
X-Gm-Message-State: AOJu0Yzkv0uc+TiwMgXH/uXAadGC1XLOLZXL3Q5l843cqKLB2FI1BiDi
	Ad16hsRhTbXTFszL4mm5farREWkeR0p5bZpeSWmzEsMIFINcddthFBMd8hQE
X-Google-Smtp-Source: AGHT+IEMKu16AtmeWMgfpduPrPcWASTDl231eESCM6s7UTQ/4yWe/ChSGuc+YI4GRrQU22QttUwDWQ==
X-Received: by 2002:a05:6102:2044:b0:479:ec13:ec84 with SMTP id q4-20020a056102204400b00479ec13ec84mr5104823vsr.20.1712612558467;
        Mon, 08 Apr 2024 14:42:38 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id eh2-20020a0561302b8200b007e105506d5csm621487uab.10.2024.04.08.14.42.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:42:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/gatt-db: Fix gatt_db_service_insert_characteristic
Date: Mon,  8 Apr 2024 17:42:33 -0400
Message-ID: <20240408214236.3758202-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_db_service_insert_characteristic shall not attempt to insert the
characteristic attribute handle on the next available index as there
could be descriptors in between so this changes the way
get_attribute_index calculates the index based on the given handle to
properly skip indexes used by descriptors.
---
 monitor/att.c            |   7 +--
 src/gatt-database.c      |   7 +--
 src/settings.c           |   3 +-
 src/shared/gatt-client.c |   3 ++
 src/shared/gatt-db.c     | 101 +++++++++++++++++++++++----------------
 src/shared/gatt-db.h     |   2 +
 unit/test-gatt.c         |   1 +
 7 files changed, 76 insertions(+), 48 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 3e5d7f12d182..b3fb3ba6a0ad 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -506,6 +506,7 @@ static struct gatt_db *get_db(const struct l2cap_frame *frame, bool rsp)
 
 static struct gatt_db_attribute *insert_chrc(const struct l2cap_frame *frame,
 						uint16_t handle,
+						uint16_t value_handle,
 						bt_uuid_t *uuid, uint8_t prop,
 						bool rsp)
 {
@@ -515,8 +516,8 @@ static struct gatt_db_attribute *insert_chrc(const struct l2cap_frame *frame,
 	if (!db)
 		return NULL;
 
-	return gatt_db_insert_characteristic(db, handle, uuid, 0, prop, NULL,
-							NULL, NULL);
+	return gatt_db_insert_characteristic(db, handle, value_handle, uuid, 0,
+						prop, NULL, NULL, NULL);
 }
 
 static int bt_uuid_from_data(bt_uuid_t *uuid, const void *data, uint16_t size)
@@ -615,7 +616,7 @@ static void print_chrc(const struct l2cap_frame *frame)
 	print_uuid("    Value UUID", frame->data, frame->size);
 	bt_uuid_from_data(&uuid, frame->data, frame->size);
 
-	insert_chrc(frame, handle, &uuid, prop, true);
+	insert_chrc(frame, handle - 1, handle, &uuid, prop, true);
 }
 
 static void chrc_read(const struct l2cap_frame *frame)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 7221ffc87f0d..6c11027a79ed 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3352,9 +3352,10 @@ static bool database_add_chrc(struct external_service *service,
 	}
 
 	chrc->attrib = gatt_db_service_insert_characteristic(service->attrib,
-						handle, &uuid, chrc->perm,
-						chrc->props, chrc_read_cb,
-						chrc_write_cb, chrc);
+						handle - 1, handle, &uuid,
+						chrc->perm, chrc->props,
+						chrc_read_cb, chrc_write_cb,
+						chrc);
 	if (!chrc->attrib) {
 		error("Failed to create characteristic entry in database");
 		return false;
diff --git a/src/settings.c b/src/settings.c
index 85534f2c7aca..033e9670ac40 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -125,7 +125,8 @@ static int load_chrc(struct gatt_db *db, char *handle, char *value,
 				handle_int, value_handle,
 				properties, val_len ? val_str : "", uuid_str);
 
-	att = gatt_db_service_insert_characteristic(service, value_handle,
+	att = gatt_db_service_insert_characteristic(service, handle_int,
+							value_handle,
 							&uuid, 0, properties,
 							NULL, NULL, NULL);
 	if (!att || gatt_db_attribute_get_handle(att) != value_handle)
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6340bcd8508e..dcf6f0211a67 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -735,6 +735,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		}
 
 		attr = gatt_db_insert_characteristic(client->db,
+							chrc_data->start_handle,
 							chrc_data->value_handle,
 							&chrc_data->uuid, 0,
 							chrc_data->properties,
@@ -829,6 +830,8 @@ done:
 	return true;
 
 failed:
+	DBG(client, "Failed to discover descriptors");
+
 	free(chrc_data);
 	return false;
 }
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9559583d11a7..2c8e7d31eda1 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -825,28 +825,45 @@ bool gatt_db_set_authorize(struct gatt_db *db, gatt_db_authorize_cb_t cb,
 	return true;
 }
 
-static uint16_t get_attribute_index(struct gatt_db_service *service,
+static uint16_t service_get_attribute_index(struct gatt_db_service *service,
+							uint16_t *handle,
 							int end_offset)
 {
 	int i = 0;
 
-	/* Here we look for first free attribute index with given offset */
-	while (i < (service->num_handles - end_offset) &&
+	if (!service || !service->attributes[0] || !handle)
+		return 0;
+
+	if (*handle) {
+		/* Check if handle is in within service range */
+		if (*handle < service->attributes[0]->handle)
+			return 0;
+
+		/* Return index based on given handle */
+		i = *handle - service->attributes[0]->handle;
+	} else {
+		/* Here we look for first free attribute index with given
+		 * offset.
+		 */
+		while (i < (service->num_handles - end_offset) &&
 						service->attributes[i])
-		i++;
+			i++;
+	}
 
-	return i == (service->num_handles - end_offset) ? 0 : i;
-}
+	if (i >= (service->num_handles - end_offset))
+		return 0;
 
-static uint16_t get_handle_at_index(struct gatt_db_service *service,
-								int index)
-{
-	return service->attributes[index]->handle;
+	/* Set handle based on the index */
+	if (!(*handle))
+		*handle = service->attributes[0]->handle + i;
+
+	return i;
 }
 
 static struct gatt_db_attribute *
 service_insert_characteristic(struct gatt_db_service *service,
 					uint16_t handle,
+					uint16_t value_handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
 					uint8_t properties,
@@ -854,6 +871,7 @@ service_insert_characteristic(struct gatt_db_service *service,
 					gatt_db_write_t write_func,
 					void *user_data)
 {
+	struct gatt_db_attribute **chrc;
 	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
 	uint16_t len = 0;
 	int i;
@@ -874,37 +892,48 @@ service_insert_characteristic(struct gatt_db_service *service,
 	if (handle == UINT16_MAX)
 		return NULL;
 
-	i = get_attribute_index(service, 1);
+	i = service_get_attribute_index(service, &handle, 1);
 	if (!i)
 		return NULL;
 
-	if (!handle)
-		handle = get_handle_at_index(service, i - 1) + 2;
-
 	value[0] = properties;
 	len += sizeof(properties);
 
 	/* We set handle of characteristic value, which will be added next */
-	put_le16(handle, &value[1]);
+	put_le16(value_handle, &value[1]);
 	len += sizeof(uint16_t);
 	len += uuid_to_le(uuid, &value[3]);
 
-	service->attributes[i] = new_attribute(service, handle - 1,
+	service->attributes[i] = new_attribute(service, handle,
 							&characteristic_uuid,
 							value, len);
 	if (!service->attributes[i])
 		return NULL;
 
-	set_attribute_data(service->attributes[i], NULL, NULL, BT_ATT_PERM_READ, NULL);
+	chrc = &service->attributes[i];
+	set_attribute_data(service->attributes[i], NULL, NULL, BT_ATT_PERM_READ,
+				NULL);
 
-	i++;
-
-	service->attributes[i] = new_attribute(service, handle, uuid, NULL, 0);
-	if (!service->attributes[i]) {
-		free(service->attributes[i - 1]);
+	i = service_get_attribute_index(service, &value_handle, 0);
+	if (!i) {
+		free(*chrc);
+		*chrc = NULL;
 		return NULL;
 	}
 
+	service->attributes[i] = new_attribute(service, value_handle, uuid,
+						NULL, 0);
+	if (!service->attributes[i]) {
+		free(*chrc);
+		*chrc = NULL;
+		return NULL;
+	}
+
+	/* Update handle of characteristic value_handle if it has changed */
+	put_le16(value_handle, &value[1]);
+	if (memcmp((*chrc)->value, value, len))
+		memcpy((*chrc)->value, value, len);
+
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
 
@@ -914,6 +943,7 @@ service_insert_characteristic(struct gatt_db_service *service,
 struct gatt_db_attribute *
 gatt_db_insert_characteristic(struct gatt_db *db,
 					uint16_t handle,
+					uint16_t value_handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
 					uint8_t properties,
@@ -927,7 +957,8 @@ gatt_db_insert_characteristic(struct gatt_db *db,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_characteristic(attrib->service, handle, uuid,
+	return service_insert_characteristic(attrib->service, handle,
+						value_handle, uuid,
 						permissions, properties,
 						read_func, write_func,
 						user_data);
@@ -936,6 +967,7 @@ gatt_db_insert_characteristic(struct gatt_db *db,
 struct gatt_db_attribute *
 gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 					uint16_t handle,
+					uint16_t value_handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
 					uint8_t properties,
@@ -946,7 +978,8 @@ gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_characteristic(attrib->service, handle, uuid,
+	return service_insert_characteristic(attrib->service, handle,
+						value_handle, uuid,
 						permissions, properties,
 						read_func, write_func,
 						user_data);
@@ -964,7 +997,7 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_characteristic(attrib->service, 0, uuid,
+	return service_insert_characteristic(attrib->service, 0, 0, uuid,
 						permissions, properties,
 						read_func, write_func,
 						user_data);
@@ -981,17 +1014,10 @@ service_insert_descriptor(struct gatt_db_service *service,
 {
 	int i;
 
-	i = get_attribute_index(service, 0);
+	i = service_get_attribute_index(service, &handle, 0);
 	if (!i)
 		return NULL;
 
-	/* Check if handle is in within service range */
-	if (handle && handle <= service->attributes[0]->handle)
-		return NULL;
-
-	if (!handle)
-		handle = get_handle_at_index(service, i - 1) + 1;
-
 	service->attributes[i] = new_attribute(service, handle, uuid, NULL, 0);
 	if (!service->attributes[i])
 		return NULL;
@@ -1151,17 +1177,10 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 		len += include->value_len;
 	}
 
-	index = get_attribute_index(service, 0);
+	index = service_get_attribute_index(service, &handle, 0);
 	if (!index)
 		return NULL;
 
-	/* Check if handle is in within service range */
-	if (handle && handle <= service->attributes[0]->handle)
-		return NULL;
-
-	if (!handle)
-		handle = get_handle_at_index(service, index - 1) + 1;
-
 	service->attributes[index] = new_attribute(service, handle,
 							&included_service_uuid,
 							value, len);
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index fb939e40d40e..f7596e33529a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -63,6 +63,7 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 struct gatt_db_attribute *
 gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 					uint16_t handle,
+					uint16_t value_handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
 					uint8_t properties,
@@ -73,6 +74,7 @@ gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 struct gatt_db_attribute *
 gatt_db_insert_characteristic(struct gatt_db *db,
 					uint16_t handle,
+					uint16_t value_handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
 					uint8_t properties,
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5e06d4ed4bf9..1613fbcb5f21 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1237,6 +1237,7 @@ add_char_with_value(struct gatt_db_attribute *service_att, uint16_t handle,
 
 	if (handle)
 		attrib = gatt_db_service_insert_characteristic(service_att,
+								handle - 1,
 								handle, uuid,
 								att_permissions,
 								char_properties,
-- 
2.44.0

