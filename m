Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F333C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340DE206B7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 10:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEqXSoiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfDJKX4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:23:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36666 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfDJKX4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 06:23:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so896437edm.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zlpPcWjIEuS/91TSlMW5f8BmtzzkrusreJOG0HJ1+h0=;
        b=gEqXSoiLFYjMcwL3hjP/y1S2MyVudsnevJ+AFtVSVnymYv50C9isiVv1O6KFVw037j
         pDWjMqZ7SVFTgT8NkyixJvWdTH8NfkqDwhV4mLnyomntg/y1CV5/n1qEPZop8R42KvD3
         LFOWfh7xR+H/JxhnbbPQk96ojCneUVtASkgbVTE1CxJ+sgmjhhQFHMVxtKpebLDT/EWl
         e+50ViGa8qZz0PsXg7GKhIesqAZtF98rxgv5kANjMiyrV5Ksue6XNbfFf+0Bu+sGs+pw
         9/wkF5lNC03uqckYOJJ52KA7YRBuFztTlGvFSQZP4rv0zR1sWE1WkYWzUes1w9KPh435
         jjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zlpPcWjIEuS/91TSlMW5f8BmtzzkrusreJOG0HJ1+h0=;
        b=QFHxHl0jeCncv8GlDKXm6ZuIZw9NnDV0WRKSPi5583bqBQCQQ5vEUJiOFO9IVCXloB
         8cpUX67EML0F2KV+Wu3hThQv2jEorHC9scSS0klg1Jh1kVhYgQU3zwdAH0BHmYtyognX
         omtYLs0/Z46+1YI/R/EEcqJdPWlGmQTzFHbqrxwkX0Cn9/dP5TV0XJFGbWiDzPd3F+ZN
         gj8a/8accc1pVTvZt2pl4cfCK3OGqv+dY3oO2YNSH03+zMyJ+2WB4w/BORwPpCyURjHr
         iKaRAJLy8WhC4ox6yaF1Uqla6lORr/L91tAsOB99SxxR9KRGulEdSuJS2VAweqzpQREJ
         TCeQ==
X-Gm-Message-State: APjAAAXJcH9Flb6Hna1G2cqD9R9oNqd5EPH7ZzMs+eZHAiylclQuHQa5
        fLsBE8pr5+fxsv2pH/cFvsHjmsMt2qg=
X-Google-Smtp-Source: APXvYqxhvXXuFbfs/h/pbw4DFn/BXDuHpQof4aDhJ/UW5gSSU8EvM4baFicSZRjrxqeIFp/Vsa3YqQ==
X-Received: by 2002:a50:eb4d:: with SMTP id z13mr27279500edp.200.1554891833803;
        Wed, 10 Apr 2019 03:23:53 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id p20sm10076738edq.62.2019.04.10.03.23.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Apr 2019 03:23:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Simplify attribute lookup
Date:   Wed, 10 Apr 2019 13:23:50 +0300
Message-Id: <20190410102350.27781-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidates attribute lookup into gatt_db_foreach_in_range and
instead of using custom code for each operation.
---
 src/shared/gatt-db.c | 251 +++++++++++++++++--------------------------
 src/shared/gatt-db.h |   6 ++
 2 files changed, 105 insertions(+), 152 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 7b8d72325..dcfb2093e 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1126,53 +1126,24 @@ bool gatt_db_service_get_claimed(struct gatt_db_attribute *attrib)
 	return attrib->service->claimed;
 }
 
+static void read_by_group_type(struct gatt_db_attribute *attribute,
+						void *user_data)
+{
+	struct queue *queue = user_data;
+
+	queue_push_tail(queue, attribute);
+}
+
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
 							struct queue *queue)
 {
-	const struct queue_entry *services_entry;
-	struct gatt_db_service *service;
-	uint16_t grp_start, grp_end, uuid_size;
-
-	uuid_size = 0;
-
-	services_entry = queue_get_entries(db->services);
-
-	while (services_entry) {
-		service = services_entry->data;
-
-		if (!service->active)
-			goto next_service;
-
-		if (bt_uuid_cmp(&type, &service->attributes[0]->uuid))
-			goto next_service;
-
-		grp_start = service->attributes[0]->handle;
-		grp_end = grp_start + service->num_handles - 1;
-
-		if (grp_end < start_handle || grp_start > end_handle)
-			goto next_service;
-
-		if (grp_start < start_handle || grp_start > end_handle)
-			goto next_service;
-
-		if (!uuid_size)
-			uuid_size = service->attributes[0]->value_len;
-		else if (uuid_size != service->attributes[0]->value_len)
-			return;
-
-		queue_push_tail(queue, service->attributes[0]);
-
-next_service:
-		services_entry = services_entry->next;
-	}
+	gatt_db_foreach_service_in_range(db, &type, read_by_group_type, queue,
+						start_handle, end_handle);
 }
 
 struct find_by_type_value_data {
-	bt_uuid_t uuid;
-	uint16_t start_handle;
-	uint16_t end_handle;
 	gatt_db_attribute_cb_t func;
 	void *user_data;
 	const void *value;
@@ -1183,39 +1154,19 @@ struct find_by_type_value_data {
 static void find_by_type(struct gatt_db_attribute *attribute, void *user_data)
 {
 	struct find_by_type_value_data *search_data = user_data;
-	struct gatt_db_service *service = attribute->service;
-	int i;
-
-	if (!service->active)
-		return;
-
-	for (i = 0; i < service->num_handles; i++) {
-		attribute = service->attributes[i];
 
-		if (!attribute)
-			continue;
-
-		if ((attribute->handle < search_data->start_handle) ||
-				(attribute->handle > search_data->end_handle))
-			continue;
-
-		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
-			continue;
-
-		/* TODO: fix for read-callback based attributes */
-		if (search_data->value) {
-			if (search_data->value_len != attribute->value_len)
-				continue;
-
-			if (memcmp(attribute->value, search_data->value,
-					search_data->value_len)) {
-				continue;
-			}
-		}
+	/* TODO: fix for read-callback based attributes */
+	if (search_data->value) {
+		if (search_data->value_len != attribute->value_len)
+			return;
 
-		search_data->num_of_res++;
-		search_data->func(attribute, search_data->user_data);
+		if (memcmp(attribute->value, search_data->value,
+					search_data->value_len))
+			return;
 	}
+
+	search_data->num_of_res++;
+	search_data->func(attribute, search_data->user_data);
 }
 
 unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
@@ -1228,13 +1179,10 @@ unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 
 	memset(&data, 0, sizeof(data));
 
-	data.uuid = *type;
-	data.start_handle = start_handle;
-	data.end_handle = end_handle;
 	data.func = func;
 	data.user_data = user_data;
 
-	gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
+	gatt_db_foreach_in_range(db, type, find_by_type, &data,
 						start_handle, end_handle);
 
 	return data.num_of_res;
@@ -1251,52 +1199,22 @@ unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
 {
 	struct find_by_type_value_data data;
 
-	data.uuid = *type;
-	data.start_handle = start_handle;
-	data.end_handle = end_handle;
 	data.func = func;
 	data.user_data = user_data;
 	data.value = value;
 	data.value_len = value_len;
 
-	gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
+	gatt_db_foreach_in_range(db, type, find_by_type, &data,
 						start_handle, end_handle);
 
 	return data.num_of_res;
 }
 
-struct read_by_type_data {
-	struct queue *queue;
-	bt_uuid_t uuid;
-	uint16_t start_handle;
-	uint16_t end_handle;
-};
-
 static void read_by_type(struct gatt_db_attribute *attribute, void *user_data)
 {
-	struct read_by_type_data *search_data = user_data;
-	struct gatt_db_service *service = attribute->service;
-	int i;
-
-	if (!service->active)
-		return;
-
-	for (i = 0; i < service->num_handles; i++) {
-		attribute = service->attributes[i];
-		if (!attribute)
-			continue;
-
-		if (attribute->handle < search_data->start_handle)
-			continue;
+	struct queue *queue = user_data;
 
-		if (attribute->handle > search_data->end_handle)
-			return;
-
-		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
-			continue;
-
-		queue_push_tail(search_data->queue, attribute);
-	}
+	queue_push_tail(queue, attribute);
 }
 
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
@@ -1304,59 +1222,24 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 						const bt_uuid_t type,
 						struct queue *queue)
 {
-	struct read_by_type_data data;
-	data.uuid = type;
-	data.start_handle = start_handle;
-	data.end_handle = end_handle;
-	data.queue = queue;
-
-	gatt_db_foreach_service_in_range(db, NULL, read_by_type, &data,
+	gatt_db_foreach_in_range(db, &type, read_by_type, queue,
 						start_handle, end_handle);
 }
 
 
-struct find_information_data {
-	struct queue *queue;
-	uint16_t start_handle;
-	uint16_t end_handle;
-};
-
 static void find_information(struct gatt_db_attribute *attribute,
 						void *user_data)
 {
-	struct find_information_data *search_data = user_data;
-	struct gatt_db_service *service = attribute->service;
-	int i;
+	struct queue *queue = user_data;
 
-	if (!service->active)
-		return;
-
-	for (i = 0; i < service->num_handles; i++) {
-		attribute = service->attributes[i];
-		if (!attribute)
-			continue;
-
-		if (attribute->handle < search_data->start_handle)
-			continue;
-
-		if (attribute->handle > search_data->end_handle)
-			return;
-
-		queue_push_tail(search_data->queue, attribute);
-	}
+	queue_push_tail(queue, attribute);
 }
 
 void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							struct queue *queue)
 {
-	struct find_information_data data;
-
-	data.start_handle = start_handle;
-	data.end_handle = end_handle;
-	data.queue = queue;
-
-	gatt_db_foreach_service_in_range(db, NULL, find_information, &data,
+	gatt_db_foreach_in_range(db, NULL, find_information, queue,
 						start_handle, end_handle);
 }
 
@@ -1373,29 +1256,71 @@ struct foreach_data {
 	const bt_uuid_t *uuid;
 	void *user_data;
 	uint16_t start, end;
+	bool attr;
 };
 
 static void foreach_service_in_range(void *data, void *user_data)
 {
 	struct gatt_db_service *service = data;
+	struct gatt_db_attribute *attribute = service->attributes[0];
 	struct foreach_data *foreach_data = user_data;
-	uint16_t svc_start, svc_end;
 	bt_uuid_t uuid;
 
+	if (foreach_data->uuid) {
+		gatt_db_attribute_get_service_uuid(attribute, &uuid);
+		if (bt_uuid_cmp(&uuid, foreach_data->uuid)) {
+			/* Compare with attribute UUID in case it is a lookup
+			 * by group type.
+			 */
+			if (bt_uuid_cmp(&attribute->uuid, foreach_data->uuid))
+				return;
+		}
+	}
+
+	foreach_data->func(service->attributes[0], foreach_data->user_data);
+}
+
+static void foreach_in_range(void *data, void *user_data)
+{
+	struct gatt_db_service *service = data;
+	struct foreach_data *foreach_data = user_data;
+	uint16_t svc_start, svc_end;
+	int i;
+
+	if (!service->active)
+		return;
+
 	gatt_db_service_get_handles(service, &svc_start, &svc_end);
 
 	/* Check if service is within requested range */
 	if (svc_start > foreach_data->end || svc_end < foreach_data->start)
 		return;
 
-	if (foreach_data->uuid) {
-		gatt_db_attribute_get_service_uuid(service->attributes[0],
-									&uuid);
-		if (bt_uuid_cmp(&uuid, foreach_data->uuid))
+	if (!foreach_data->attr) {
+		if (svc_start < foreach_data->start ||
+					svc_start > foreach_data->end)
 			return;
+		return foreach_service_in_range(data, user_data);
 	}
 
-	foreach_data->func(service->attributes[0], foreach_data->user_data);
+	for (i = 0; i < service->num_handles; i++) {
+		struct gatt_db_attribute *attribute = service->attributes[i];
+
+		if (!attribute)
+			continue;
+
+		if (attribute->handle < foreach_data->start)
+			continue;
+
+		if (attribute->handle > foreach_data->end)
+			return;
+
+		if (foreach_data->uuid && bt_uuid_cmp(foreach_data->uuid,
+							&attribute->uuid))
+			continue;
+
+		foreach_data->func(attribute, foreach_data->user_data);
+	}
 }
 
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
@@ -1415,8 +1340,30 @@ void gatt_db_foreach_service_in_range(struct gatt_db *db,
 	data.user_data = user_data;
 	data.start = start_handle;
 	data.end = end_handle;
+	data.attr = false;
+
+	queue_foreach(db->services, foreach_in_range, &data);
+}
+
+void gatt_db_foreach_in_range(struct gatt_db *db, const bt_uuid_t *uuid,
+						gatt_db_attribute_cb_t func,
+						void *user_data,
+						uint16_t start_handle,
+						uint16_t end_handle)
+{
+	struct foreach_data data;
+
+	if (!db || !func || start_handle > end_handle)
+		return;
+
+	data.func = func;
+	data.uuid = uuid;
+	data.user_data = user_data;
+	data.start = start_handle;
+	data.end = end_handle;
+	data.attr = true;
 
-	queue_foreach(db->services, foreach_service_in_range, &data);
+	queue_foreach(db->services, foreach_in_range, &data);
 }
 
 void gatt_db_service_foreach(struct gatt_db_attribute *attrib,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 398d69ad8..08f037428 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -168,6 +168,12 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
 						gatt_db_attribute_cb_t func,
 						void *user_data);
+void gatt_db_foreach_in_range(struct gatt_db *db, const bt_uuid_t *uuid,
+						gatt_db_attribute_cb_t func,
+						void *user_data,
+						uint16_t start_handle,
+						uint16_t end_handle);
+
 void gatt_db_foreach_service_in_range(struct gatt_db *db,
 						const bt_uuid_t *uuid,
 						gatt_db_attribute_cb_t func,
-- 
2.20.1

