Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87043AB4
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142365; cv=none; b=N+Fu0ojC2t33IB+Kq0kfoWGvgzB+TtnocyP6Pgcl2YEtwYNnEnN9Z4Mbs/RUmSKtdt/hdwfv4kqN/cBiOdESVA0PHbPjvhJTvQn8jg4AuLbSO9AU7VG1AmpjUJmNe00ylOzih++1wl72B0Wxy5kpB/hJyda1m5P30SRyC3TOP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142365; c=relaxed/simple;
	bh=9H6A7GDkKM8hFUi+f7hTIhCwvva5D66AQrVJEk8giMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5Y+gcEHRC1XfVeQmvuUzccZNUEDK4gc51/amxj/iFGkdbI0bgRCB8WRYhA+Ep52rMxItD6s/dZj26XPE5dMeFxj6ZHxBag/dmdeiuswRoxPexkhSYOS0QxOibWB2+MmbayfEy9usikL91FpqlmNqZzh7mv1TeHZ0imSG5mlsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toKxbwHp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toKxbwHp"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so7236831276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712142363; x=1712747163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+rphQ+8P30AHpH1Di6SAIf6r013utQBq8KphCA64vg=;
        b=toKxbwHpY2UAIigL3TMQCoPU98XTIy3X8jsej6xsrAYn7u7wgGldlk/ZDzO0xGyiHf
         uYGgoaTtV4oIdGsA70dvNfuXqp6kBToK9hCTofpSArPhzKBz9lMZ3nb0H6Y5rjbg54Cc
         bbBIWcPnja12D2VcdHVcZocRZqTVhc9PyxYz/G8/1MBrkHtFnTryt/ZDP8n++k4UpRdY
         cbr3iMmmhvFNmdrbjFUZvPFisZqYTAvMnPcV5z3kHtO9X5C1q88UUEMsn8z1ZqrY3esp
         AdWz2jzna3Q64bXyS4cwr58UjUod5w04ChsuiRVzZNpdq8pAir+FCeXs3uKwD9621THA
         1u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142363; x=1712747163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+rphQ+8P30AHpH1Di6SAIf6r013utQBq8KphCA64vg=;
        b=vtWpbNHmmUhAnRQfogZHi6XZxoHqBLgTS/vZU8C1T0PuUzH30UHYcAH1GWWobT90uB
         rS7BUToke9av20YXJnj1kI+OE3Ze2L7a2uBRbwtB4qv/ZQtDy0HRidOY4pmzx2XYydJk
         SwxLVD8QdYBg6AYFq/DrQJ+bwAdeFNl7FTgY/5LztoYp3sAjgkNgw3h/FXcvafd5fvvg
         yeI2uVPfmUqAXtyYhTFOqL1c/HKawqmbsBVfJPEcXCEX5Fkx0cvDBUeS6YAjK/lXJOO/
         4oJSkdz9qIj+OQ/nxWD8z8mIbye5TOYayzCLF+yWkPjGM3OaV3HKugRPRRZzB7Mm+Kjy
         FDXQ==
X-Gm-Message-State: AOJu0YwtapjqNm0Ft0e7ZR3c0DCIg+qUDOHSIuXLA7baHuZXZFXh6Bxg
	tS4PwV7YysNPDJ4xVQgDY4GcvZKpGwXIsr/NEHXWynsRitf5P3YVWDcDUCVk+gOP74RcIXa/Aq+
	1dQIhQWU8oQVYyjMqcCtHKnQO4eqhYTEg0tGgavpKv0+uepCXMuM9/XJQHKCqyospeUxBqyRAe5
	oV46194saoj8zbDZTPBAmBHBBuhgDSPjJIMWva7ou1G94ELGO1HtTtL8+ZjW1tX10XUonMCz4=
X-Google-Smtp-Source: AGHT+IHeWYzZMEBrIuQnaT48yw3SGBsntwulUxTSpD9Nnnf2nhbx3Wse3jJ/1EoTY04RcRb5/SfSU9dT4yOC7/1bwg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:a99c:36f2:1a05:fa42])
 (user=howardchung job=sendgmr) by 2002:a05:6902:1006:b0:dcc:94b7:a7a3 with
 SMTP id w6-20020a056902100600b00dcc94b7a7a3mr1039156ybt.12.1712142360512;
 Wed, 03 Apr 2024 04:06:00 -0700 (PDT)
Date: Wed,  3 Apr 2024 19:05:11 +0800
In-Reply-To: <20240403110549.75516-1-howardchung@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403110549.75516-1-howardchung@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403190511.Bluez.1.I0e799d0a6494565e232db4c86a8979cf898b1840@changeid>
Subject: [Bluez PATCH 1/2] shared/gatt: Rename some gatt insert functions to append
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Howard Chung <howardchung@google.com>, Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Many of the Gatt insert functions are actually append. They append an
attribute to the end of the service attributes list.
This simply rename these functions.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 monitor/att.c            |  4 ++--
 src/gatt-database.c      |  4 ++--
 src/settings.c           |  4 ++--
 src/shared/gatt-client.c |  8 ++++----
 src/shared/gatt-db.c     | 38 +++++++++++++++++++-------------------
 src/shared/gatt-db.h     | 12 ++++++------
 unit/test-gatt.c         |  4 ++--
 7 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 3e5d7f12d..ddeb54d9e 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -515,7 +515,7 @@ static struct gatt_db_attribute *insert_chrc(const struct l2cap_frame *frame,
 	if (!db)
 		return NULL;
 
-	return gatt_db_insert_characteristic(db, handle, uuid, 0, prop, NULL,
+	return gatt_db_append_characteristic(db, handle, uuid, 0, prop, NULL,
 							NULL, NULL);
 }
 
@@ -4153,7 +4153,7 @@ static struct gatt_db_attribute *insert_desc(const struct l2cap_frame *frame,
 	if (!db)
 		return NULL;
 
-	return gatt_db_insert_descriptor(db, handle, uuid, 0, NULL, NULL, NULL);
+	return gatt_db_append_descriptor(db, handle, uuid, 0, NULL, NULL, NULL);
 }
 
 static void att_find_info_rsp_16(const struct l2cap_frame *frame)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 7221ffc87..4c3554211 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3178,7 +3178,7 @@ static bool database_add_desc(struct external_service *service,
 		return false;
 	}
 
-	desc->attrib = gatt_db_service_insert_descriptor(service->attrib,
+	desc->attrib = gatt_db_service_append_descriptor(service->attrib,
 							handle, &uuid,
 							desc->perm,
 							desc_read_cb,
@@ -3351,7 +3351,7 @@ static bool database_add_chrc(struct external_service *service,
 		return false;
 	}
 
-	chrc->attrib = gatt_db_service_insert_characteristic(service->attrib,
+	chrc->attrib = gatt_db_service_append_characteristic(service->attrib,
 						handle, &uuid, chrc->perm,
 						chrc->props, chrc_read_cb,
 						chrc_write_cb, chrc);
diff --git a/src/settings.c b/src/settings.c
index 85534f2c7..025c75b62 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -78,7 +78,7 @@ static int load_desc(struct gatt_db *db, char *handle, char *value,
 	if (!bt_uuid_cmp(&uuid, &ext_uuid) && !val)
 		return -EIO;
 
-	att = gatt_db_service_insert_descriptor(service, handle_int, &uuid,
+	att = gatt_db_service_append_descriptor(service, handle_int, &uuid,
 							0, NULL, NULL, NULL);
 	if (!att || gatt_db_attribute_get_handle(att) != handle_int)
 		return -EIO;
@@ -125,7 +125,7 @@ static int load_chrc(struct gatt_db *db, char *handle, char *value,
 				handle_int, value_handle,
 				properties, val_len ? val_str : "", uuid_str);
 
-	att = gatt_db_service_insert_characteristic(service, value_handle,
+	att = gatt_db_service_append_characteristic(service, value_handle,
 							&uuid, 0, properties,
 							NULL, NULL, NULL);
 	if (!att || gatt_db_attribute_get_handle(att) != value_handle)
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6340bcd85..eddbd1778 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -638,7 +638,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 			continue;
 		}
 
-		attr = gatt_db_insert_included(client->db, handle, attr);
+		attr = gatt_db_append_included(client->db, handle, attr);
 		if (!attr) {
 			DBG(client,
 				"Unable to add include attribute at 0x%04x",
@@ -734,7 +734,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 			op->cur_svc = svc;
 		}
 
-		attr = gatt_db_insert_characteristic(client->db,
+		attr = gatt_db_append_characteristic(client->db,
 							chrc_data->value_handle,
 							&chrc_data->uuid, 0,
 							chrc_data->properties,
@@ -788,7 +788,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 			 */
 			bt_uuid16_create(&ccc_uuid,
 					GATT_CLIENT_CHARAC_CFG_UUID);
-			attr = gatt_db_insert_descriptor(client->db, desc_start,
+			attr = gatt_db_append_descriptor(client->db, desc_start,
 							&ccc_uuid, 0, NULL,
 							NULL, NULL);
 			if (attr) {
@@ -952,7 +952,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 
 		DBG(client, "handle: 0x%04x, uuid: %s", handle, uuid_str);
 
-		attr = gatt_db_insert_descriptor(client->db, handle,
+		attr = gatt_db_append_descriptor(client->db, handle,
 							&uuid, 0, NULL, NULL,
 							NULL);
 		if (!attr) {
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9559583d1..39bba9b54 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -845,7 +845,7 @@ static uint16_t get_handle_at_index(struct gatt_db_service *service,
 }
 
 static struct gatt_db_attribute *
-service_insert_characteristic(struct gatt_db_service *service,
+service_append_characteristic(struct gatt_db_service *service,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -912,7 +912,7 @@ service_insert_characteristic(struct gatt_db_service *service,
 }
 
 struct gatt_db_attribute *
-gatt_db_insert_characteristic(struct gatt_db *db,
+gatt_db_append_characteristic(struct gatt_db *db,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -927,14 +927,14 @@ gatt_db_insert_characteristic(struct gatt_db *db,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_characteristic(attrib->service, handle, uuid,
+	return service_append_characteristic(attrib->service, handle, uuid,
 						permissions, properties,
 						read_func, write_func,
 						user_data);
 }
 
 struct gatt_db_attribute *
-gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
+gatt_db_service_append_characteristic(struct gatt_db_attribute *attrib,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -946,7 +946,7 @@ gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_characteristic(attrib->service, handle, uuid,
+	return service_append_characteristic(attrib->service, handle, uuid,
 						permissions, properties,
 						read_func, write_func,
 						user_data);
@@ -964,14 +964,14 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_characteristic(attrib->service, 0, uuid,
+	return service_append_characteristic(attrib->service, 0, uuid,
 						permissions, properties,
 						read_func, write_func,
 						user_data);
 }
 
 static struct gatt_db_attribute *
-service_insert_descriptor(struct gatt_db_service *service,
+service_append_descriptor(struct gatt_db_service *service,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -1003,7 +1003,7 @@ service_insert_descriptor(struct gatt_db_service *service,
 }
 
 struct gatt_db_attribute *
-gatt_db_insert_descriptor(struct gatt_db *db,
+gatt_db_append_descriptor(struct gatt_db *db,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -1017,13 +1017,13 @@ gatt_db_insert_descriptor(struct gatt_db *db,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_descriptor(attrib->service, handle, uuid,
+	return service_append_descriptor(attrib->service, handle, uuid,
 					permissions, read_func, write_func,
 					user_data);
 }
 
 struct gatt_db_attribute *
-gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
+gatt_db_service_append_descriptor(struct gatt_db_attribute *attrib,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -1034,7 +1034,7 @@ gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_descriptor(attrib->service, handle, uuid,
+	return service_append_descriptor(attrib->service, handle, uuid,
 					permissions, read_func, write_func,
 					user_data);
 }
@@ -1050,7 +1050,7 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_descriptor(attrib->service, 0, uuid,
+	return service_append_descriptor(attrib->service, 0, uuid,
 					permissions, read_func, write_func,
 					user_data);
 }
@@ -1088,7 +1088,7 @@ gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
 	if (!value || value->notify_func)
 		return NULL;
 
-	ccc = service_insert_descriptor(attrib->service, 0, &ccc_uuid,
+	ccc = service_append_descriptor(attrib->service, 0, &ccc_uuid,
 					permissions,
 					db->ccc->read_func,
 					db->ccc->write_func,
@@ -1121,7 +1121,7 @@ void gatt_db_ccc_register(struct gatt_db *db, gatt_db_read_t read_func,
 }
 
 static struct gatt_db_attribute *
-service_insert_included(struct gatt_db_service *service, uint16_t handle,
+service_append_included(struct gatt_db_service *service, uint16_t handle,
 					struct gatt_db_attribute *include)
 {
 	struct gatt_db_service *included;
@@ -1186,22 +1186,22 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 	if (!attrib || !include)
 		return NULL;
 
-	return service_insert_included(attrib->service, 0, include);
+	return service_append_included(attrib->service, 0, include);
 }
 
 struct gatt_db_attribute *
-gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
+gatt_db_service_append_included(struct gatt_db_attribute *attrib,
 				uint16_t handle,
 				struct gatt_db_attribute *include)
 {
 	if (!attrib || !handle || !include)
 		return NULL;
 
-	return service_insert_included(attrib->service, handle, include);
+	return service_append_included(attrib->service, handle, include);
 }
 
 struct gatt_db_attribute *
-gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
+gatt_db_append_included(struct gatt_db *db, uint16_t handle,
 			struct gatt_db_attribute *include)
 {
 	struct gatt_db_attribute *attrib;
@@ -1210,7 +1210,7 @@ gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
 	if (!attrib)
 		return NULL;
 
-	return service_insert_included(attrib->service, handle, include);
+	return service_append_included(attrib->service, handle, include);
 }
 
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index fb939e40d..ec0eccdfc 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -61,7 +61,7 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 					gatt_db_write_t write_func,
 					void *user_data);
 struct gatt_db_attribute *
-gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
+gatt_db_service_append_characteristic(struct gatt_db_attribute *attrib,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -71,7 +71,7 @@ gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 					void *user_data);
 
 struct gatt_db_attribute *
-gatt_db_insert_characteristic(struct gatt_db *db,
+gatt_db_append_characteristic(struct gatt_db *db,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -81,7 +81,7 @@ gatt_db_insert_characteristic(struct gatt_db *db,
 					void *user_data);
 
 struct gatt_db_attribute *
-gatt_db_insert_descriptor(struct gatt_db *db,
+gatt_db_append_descriptor(struct gatt_db *db,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -98,7 +98,7 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					void *user_data);
 
 struct gatt_db_attribute *
-gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
+gatt_db_service_append_descriptor(struct gatt_db_attribute *attrib,
 					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
@@ -110,14 +110,14 @@ struct gatt_db_attribute *
 gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions);
 
 struct gatt_db_attribute *
-gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
+gatt_db_append_included(struct gatt_db *db, uint16_t handle,
 			struct gatt_db_attribute *include);
 
 struct gatt_db_attribute *
 gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *include);
 struct gatt_db_attribute *
-gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
+gatt_db_service_append_included(struct gatt_db_attribute *attrib,
 				uint16_t handle,
 				struct gatt_db_attribute *include);
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5e06d4ed4..20b25cf8c 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1236,7 +1236,7 @@ add_char_with_value(struct gatt_db_attribute *service_att, uint16_t handle,
 	struct gatt_db_attribute *attrib;
 
 	if (handle)
-		attrib = gatt_db_service_insert_characteristic(service_att,
+		attrib = gatt_db_service_append_characteristic(service_att,
 								handle, uuid,
 								att_permissions,
 								char_properties,
@@ -1265,7 +1265,7 @@ add_desc_with_value(struct gatt_db_attribute *att, uint16_t handle,
 	struct gatt_db_attribute *desc_att;
 
 	if (handle)
-		desc_att = gatt_db_service_insert_descriptor(att, handle, uuid,
+		desc_att = gatt_db_service_append_descriptor(att, handle, uuid,
 							att_perms, NULL, NULL,
 							NULL);
 	else
-- 
2.44.0.478.gd926399ef9-goog

