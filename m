Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5786C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715F920700
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 17:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvowUsx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDCRip (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:38:45 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36125 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCRip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 13:38:45 -0400
Received: by mail-lj1-f176.google.com with SMTP id r24so15665437ljg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2019 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAGWbQ5jmEVf1PCSKS9nkk6fEAhwLAhaRQ4vS4wzTqk=;
        b=SvowUsx2YdwImOAQknT9rLa4UsM70xH5WnzDdtznW9rdQHQWE81F2+ZHVuYJ1LrBsT
         meEOIOzvazjvuJyeWqP/O09j1fhztEEgEryANVOQhqrFBTowE3unNpdp0nfMnod5Ve6u
         Ja4k9Oyv2nYfIWc8OD8A4U1EajpvBf2N2w88B3ncz0nzh+uyndpUA+pLU+b51HB0V8Lt
         S/bDSKBWmTShC/Gdnr/LnmZV1n6v32rUM7PfqNGC8lCrF/GlP/I/ut7oVjaiYhgXQSuw
         DjispWrrPH8QWbarFvloYDfzADicJdOql9yKFg5LpxtY+JtrwlSxrAuLTlwz0LExvrxO
         zhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAGWbQ5jmEVf1PCSKS9nkk6fEAhwLAhaRQ4vS4wzTqk=;
        b=nKiE1CEHlTZtPWEzZzeXyD6ahUn7h6/JHHobBx+DPOIJxnzFT9ngZO89PL+JXVDCeZ
         eka0FLV17VhtNm7aC4wgruzxP4Afx67X7nqUpkwIOOzSbfYcgSWL4t9EKaFj/JTI+tCU
         zlERa92InqVCOqQVvVRra5FEA47epJwb9ym71hGcbDnnmB6qnIQmNiJQyTG0mWmGtZmb
         adk0QnTKUCBbdtyHFWaVTe1x9Mj0sJPm4RsEXEDzn4NhxMlxFVMLxcnuwEDarMQsqPKK
         LTzA40nNePOekAVRRn3SCIgpP7mK/5d/8JZPJ8xVfCrOGdjrJGMh4UDYZSr5UIDwtAB3
         gcTA==
X-Gm-Message-State: APjAAAWvHwaiIw/V6XFFXEdpVBvlTa0KnVClfdOwCNBCRVRYIoQavbPh
        Jf0NghujSe/QKhto7Sl1ftxlG3Mp4p4=
X-Google-Smtp-Source: APXvYqxDlzg5WiRSylIHzJqpBFpRl6dE/Yp+K5yKOavHZLE1paTTeeB6n3+4PbEB6cO44FH0D4oDSw==
X-Received: by 2002:a2e:93c7:: with SMTP id p7mr618442ljh.32.1554313122311;
        Wed, 03 Apr 2019 10:38:42 -0700 (PDT)
Received: from vudentzs-t460s.my-cloud.eu ([87.54.40.219])
        by smtp.gmail.com with ESMTPSA id e17sm3397686ljj.20.2019.04.03.10.38.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 10:38:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Skip ahead if handle range is not within service
Date:   Wed,  3 Apr 2019 20:38:40 +0300
Message-Id: <20190403173840.6236-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if a range is within service handles skipping if it is not,
it also convert the direct search to use
gatt_db_foreach_service_in_range instead so all operation that do
lookups in a range can benefit from such optimization.
---
 src/shared/gatt-db.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b5f7094da..7b8d72325 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1180,11 +1180,10 @@ struct find_by_type_value_data {
 	unsigned int num_of_res;
 };
 
-static void find_by_type(void *data, void *user_data)
+static void find_by_type(struct gatt_db_attribute *attribute, void *user_data)
 {
 	struct find_by_type_value_data *search_data = user_data;
-	struct gatt_db_service *service = data;
-	struct gatt_db_attribute *attribute;
+	struct gatt_db_service *service = attribute->service;
 	int i;
 
 	if (!service->active)
@@ -1235,7 +1234,8 @@ unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 	data.func = func;
 	data.user_data = user_data;
 
-	queue_foreach(db->services, find_by_type, &data);
+	gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
+						start_handle, end_handle);
 
 	return data.num_of_res;
 }
@@ -1259,7 +1259,8 @@ unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
 	data.value = value;
 	data.value_len = value_len;
 
-	queue_foreach(db->services, find_by_type, &data);
+	gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
+						start_handle, end_handle);
 
 	return data.num_of_res;
 }
@@ -1271,11 +1272,10 @@ struct read_by_type_data {
 	uint16_t end_handle;
 };
 
-static void read_by_type(void *data, void *user_data)
+static void read_by_type(struct gatt_db_attribute *attribute, void *user_data)
 {
 	struct read_by_type_data *search_data = user_data;
-	struct gatt_db_service *service = data;
-	struct gatt_db_attribute *attribute;
+	struct gatt_db_service *service = attribute->service;
 	int i;
 
 	if (!service->active)
@@ -1310,7 +1310,8 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 	data.end_handle = end_handle;
 	data.queue = queue;
 
-	queue_foreach(db->services, read_by_type, &data);
+	gatt_db_foreach_service_in_range(db, NULL, read_by_type, &data,
+						start_handle, end_handle);
 }
 
 
@@ -1320,21 +1321,16 @@ struct find_information_data {
 	uint16_t end_handle;
 };
 
-static void find_information(void *data, void *user_data)
+static void find_information(struct gatt_db_attribute *attribute,
+						void *user_data)
 {
 	struct find_information_data *search_data = user_data;
-	struct gatt_db_service *service = data;
-	struct gatt_db_attribute *attribute;
+	struct gatt_db_service *service = attribute->service;
 	int i;
 
 	if (!service->active)
 		return;
 
-	/* Check if service is in range */
-	if ((service->attributes[0]->handle + service->num_handles - 1) <
-						search_data->start_handle)
-		return;
-
 	for (i = 0; i < service->num_handles; i++) {
 		attribute = service->attributes[i];
 		if (!attribute)
@@ -1360,7 +1356,8 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 	data.end_handle = end_handle;
 	data.queue = queue;
 
-	queue_foreach(db->services, find_information, &data);
+	gatt_db_foreach_service_in_range(db, NULL, find_information, &data,
+						start_handle, end_handle);
 }
 
 void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
@@ -1382,12 +1379,13 @@ static void foreach_service_in_range(void *data, void *user_data)
 {
 	struct gatt_db_service *service = data;
 	struct foreach_data *foreach_data = user_data;
-	uint16_t svc_start;
+	uint16_t svc_start, svc_end;
 	bt_uuid_t uuid;
 
-	svc_start = get_handle_at_index(service, 0);
+	gatt_db_service_get_handles(service, &svc_start, &svc_end);
 
-	if (svc_start > foreach_data->end || svc_start < foreach_data->start)
+	/* Check if service is within requested range */
+	if (svc_start > foreach_data->end || svc_end < foreach_data->start)
 		return;
 
 	if (foreach_data->uuid) {
-- 
2.20.1

