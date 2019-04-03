Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90A8C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BAA20882
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 11:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+tVNFzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDCLCw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:02:52 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41639 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCLCv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 07:02:51 -0400
Received: by mail-ed1-f52.google.com with SMTP id a25so14480179edc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2019 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHxxGMyDVVdYsklQLVwxa1m2cXf+kmqmADB0XweDuFA=;
        b=l+tVNFzq62jbPMq1iZ8oxUiMgnTTipGgxqnAQL0oxVQQl4eunbnyHxQd3ZqmuHKIzi
         NsIU4uvu7MxgmkXafa9D0OTVneLYP7OcR6hWld72xeRTKnYdNcKu3whBo94KHdtIDVYs
         f8euGOkULcJLiC0F4sP4nC+aBoM7yL0ZbFX1v+4v/waWr929EbX6Pu41z6wkL+JkW8GH
         G9j+MpcY1wPctCF0fAlBS5oiOjCVsrGfJYi24Pq+eSfHrr/RLM+TLro7yUx7GtvxGn7D
         SfbtLkBUQCl+heXjPrx614oRvtsfTNbmm8cR4uMiqzrX5Gxbh1EPJreYvY+6MUn23Ie5
         XCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHxxGMyDVVdYsklQLVwxa1m2cXf+kmqmADB0XweDuFA=;
        b=O1lo57uK2hJJZpq0c7pKLpQmv1XuZYjdeyN9XnvEHkukzoHpiVW/t7vaUwynbF/dop
         eh75MnRNSGMeuruLL/Uk08p31AKlu046jKeTVT4d65h5eq0f4AWTqBhYL1tzOsZ6IAJS
         I6QJCtmrhbgB126le9Mz8vTM7C2VEXlJ4w3ADVtHnpJFEFU0Z9OZuPsm4pqxRjUQoW+Y
         pDadM0Qzc12rYkew2xrExny2RmxULBi7oF0jGNUKoWjLIwESWpmypcn71wu7Pe71fMI2
         TCy+WQSnGIa2yu44grWEi+grKD2BjdjHP22sRXctWqaT/z01rF95t73GXLwTNXqhsbvH
         qoag==
X-Gm-Message-State: APjAAAWLin8qiY45ECJhBTjZINaCeOPyRTdASbOBUnvte3pSA2vgWrF/
        jiUFvbfUxb39evV+Uz8KR0Z7Mc7Cwz0=
X-Google-Smtp-Source: APXvYqzQ376ZduINsWMVUzxDpFdfcrXphzHdtlQJTyOIHAi/V9yUV/6ZfQOySrFqeBQXm2lpLnWMXw==
X-Received: by 2002:a50:ef15:: with SMTP id m21mr9945590eds.10.1554289368844;
        Wed, 03 Apr 2019 04:02:48 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id w58sm4863741edd.69.2019.04.03.04.02.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Apr 2019 04:02:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] shared/gatt-db: Skip ahead if handle range is not within service
Date:   Wed,  3 Apr 2019 14:02:45 +0300
Message-Id: <20190403110245.28317-1-luiz.dentz@gmail.com>
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
 src/shared/gatt-db.c | 49 +++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b5f7094da..3b15c9a03 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -773,7 +773,15 @@ static uint16_t get_attribute_index(struct gatt_db_service *service,
 static uint16_t get_handle_at_index(struct gatt_db_service *service,
 								int index)
 {
-	return service->attributes[index]->handle;
+	if (index >= 0)
+		return service->attributes[index]->handle;
+
+	for (index = service->num_handles - 1; index > 0; index--) {
+		if (service->attributes[index])
+			return service->attributes[index]->handle;
+	}
+
+	return service->attributes[0]->handle;
 }
 
 static struct gatt_db_attribute *
@@ -1180,11 +1188,10 @@ struct find_by_type_value_data {
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
@@ -1235,7 +1242,8 @@ unsigned int gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 	data.func = func;
 	data.user_data = user_data;
 
-	queue_foreach(db->services, find_by_type, &data);
+	gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
+						start_handle, end_handle);
 
 	return data.num_of_res;
 }
@@ -1259,7 +1267,8 @@ unsigned int gatt_db_find_by_type_value(struct gatt_db *db,
 	data.value = value;
 	data.value_len = value_len;
 
-	queue_foreach(db->services, find_by_type, &data);
+	gatt_db_foreach_service_in_range(db, NULL, find_by_type, &data,
+						start_handle, end_handle);
 
 	return data.num_of_res;
 }
@@ -1271,11 +1280,10 @@ struct read_by_type_data {
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
@@ -1310,7 +1318,8 @@ void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 	data.end_handle = end_handle;
 	data.queue = queue;
 
-	queue_foreach(db->services, read_by_type, &data);
+	gatt_db_foreach_service_in_range(db, NULL, read_by_type, &data,
+						start_handle, end_handle);
 }
 
 
@@ -1320,21 +1329,16 @@ struct find_information_data {
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
@@ -1360,7 +1364,8 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 	data.end_handle = end_handle;
 	data.queue = queue;
 
-	queue_foreach(db->services, find_information, &data);
+	gatt_db_foreach_service_in_range(db, NULL, find_information, &data,
+						start_handle, end_handle);
 }
 
 void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
@@ -1382,12 +1387,14 @@ static void foreach_service_in_range(void *data, void *user_data)
 {
 	struct gatt_db_service *service = data;
 	struct foreach_data *foreach_data = user_data;
-	uint16_t svc_start;
+	uint16_t svc_start, svc_end;
 	bt_uuid_t uuid;
 
 	svc_start = get_handle_at_index(service, 0);
+	svc_end = get_handle_at_index(service, -1);
 
-	if (svc_start > foreach_data->end || svc_start < foreach_data->start)
+	/* Check if service is within requested range */
+	if (svc_start > foreach_data->end || svc_end < foreach_data->start)
 		return;
 
 	if (foreach_data->uuid) {
-- 
2.20.1

