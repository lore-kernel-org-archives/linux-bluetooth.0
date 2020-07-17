Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671782070E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iub5c/00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGQTPV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgGQTPU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:15:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE26C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so6980696pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gNYmXc4mJEmOu5CETp29vjI9I1CoKaM9O5sbDcmH11I=;
        b=iub5c/007xX6B3c843zs99TwrWVioltW41PZQX6AbfGcdi6SgxY120mV5CDc++qhbk
         yTszbsp6O675hDh5kYegPxk/7W3h1XEnTSD/0Q9yspPWFDxC4W2TGrbpXVM6pthuNIoW
         V7Tl5s6Zck3RlEfEHyovFt6dqlOpTNEnLyH6qUGpuhPrf2ebE28SfILLvzVUZ5Zq06n3
         /cvRUsKw4rJL7d18zfmT9podkQUh4NnsJ8MzRb79nAP4m7W33AIEtdXp9/PjAl9MKs9H
         weOvCM8/yGxZcbyNfdW9mNRrs9wMgvwwRrrdxHDzGOJ17B9+jjDhIcFTVlsvooskUrHj
         EMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNYmXc4mJEmOu5CETp29vjI9I1CoKaM9O5sbDcmH11I=;
        b=VK3iwBd6SIQ5uUaJO1cChZUJxQj1SMcUe8zrg8qwzVHGGLrOPq4pKeZlkM0czFn8G7
         1OqkPzfHm1wfcCd2HAIKMdnNrVOvTfu3kBXHbYbeXyRuiwFN5zRbOLyMyaM2THTtmy6d
         hK4JGvCbUpSUlC22zEkvPjJdOliptNSfYY1hMVKpdY8m6+NFCKllryctiv0XPLYy4WIM
         XWM9DtqgOSDaePHkaSvyZkzVnV0d9yAHcPVp7NdEO/jWW3o/vRoKZA2ozWr9xkr268oC
         o/gtFlenCxzqA8iVnYAJw4KzewHBT5adbJ1xyl4Q53uRLTSrmmO5DC7pH5EkgeTMIg9X
         SpwA==
X-Gm-Message-State: AOAM532XGCqAbe6XvldFvdh9HpZAdkO4G/R83HKBhuvN/OHivDQNJ+MD
        2lEYYMqCx1JExDQ9fr/ai1lIOm79WM0=
X-Google-Smtp-Source: ABdhPJwAbT2zm+o2JO3CRnlgp9Dtf7KOk/A2akVkwzWFCw3/VVSf9NxriJUqRCRFxwtUbjAlinwPoA==
X-Received: by 2002:a17:90a:a783:: with SMTP id f3mr11466177pjq.142.1595013318353;
        Fri, 17 Jul 2020 12:15:18 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p9sm6488334pgc.77.2020.07.17.12.15.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:15:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/gatt-db: Add support for notifying attribute changes
Date:   Fri, 17 Jul 2020 12:15:12 -0700
Message-Id: <20200717191515.220621-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717191515.220621-1-luiz.dentz@gmail.com>
References: <20200717191515.220621-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables to get notified when an attribute has been changed e.g.
it is being removed so the code can detect changes changes at attribute
level.
---
 src/shared/gatt-db.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |   8 ++++
 2 files changed, 111 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 5eccab3b9..e939ddc3a 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -81,6 +81,13 @@ struct notify {
 	void *user_data;
 };
 
+struct attribute_notify {
+	unsigned int id;
+	gatt_db_attribute_cb_t removed;
+	gatt_db_destroy_func_t destroy;
+	void *user_data;
+};
+
 struct pending_read {
 	struct gatt_db_attribute *attrib;
 	unsigned int id;
@@ -114,6 +121,9 @@ struct gatt_db_attribute {
 
 	unsigned int write_id;
 	struct queue *pending_writes;
+
+	unsigned int next_notify_id;
+	struct queue *notify_list;
 };
 
 struct gatt_db_service {
@@ -171,6 +181,16 @@ static void pending_write_free(void *data)
 	pending_write_result(p, -ECANCELED);
 }
 
+static void attribute_notify_destroy(void *data)
+{
+	struct attribute_notify *notify = data;
+
+	if (notify->destroy)
+		notify->destroy(notify->user_data);
+
+	free(notify);
+}
+
 static void attribute_destroy(struct gatt_db_attribute *attribute)
 {
 	/* Attribute was not initialized by user */
@@ -179,6 +199,7 @@ static void attribute_destroy(struct gatt_db_attribute *attribute)
 
 	queue_destroy(attribute->pending_reads, pending_read_free);
 	queue_destroy(attribute->pending_writes, pending_write_free);
+	queue_destroy(attribute->notify_list, attribute_notify_destroy);
 
 	free(attribute->value);
 	free(attribute);
@@ -208,6 +229,7 @@ static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
 
 	attribute->pending_reads = queue_new();
 	attribute->pending_writes = queue_new();
+	attribute->notify_list = queue_new();
 
 	return attribute;
 
@@ -352,12 +374,38 @@ static bool db_hash_update(void *user_data)
 	return false;
 }
 
+static void handle_attribute_notify(void *data, void *user_data)
+{
+	struct attribute_notify *notify = data;
+	struct gatt_db_attribute *attrib = user_data;
+
+	if (notify->removed)
+		notify->removed(attrib, notify->user_data);
+}
+
+static void notify_attribute_changed(struct gatt_db_service *service)
+{
+	int i;
+
+	for (i = 0; i < service->num_handles; i++) {
+		struct gatt_db_attribute *attr = service->attributes[i];
+
+		if (!attr)
+			continue;
+
+		queue_foreach(attr->notify_list, handle_attribute_notify, attr);
+	}
+}
+
 static void notify_service_changed(struct gatt_db *db,
 						struct gatt_db_service *service,
 						bool added)
 {
 	struct notify_data data;
 
+	if (!added)
+		notify_attribute_changed(service);
+
 	if (queue_isempty(db->notify_list))
 		return;
 
@@ -1993,3 +2041,58 @@ void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib)
 
 	return attrib->user_data;
 }
+
+static bool match_attribute_notify_id(const void *a, const void *b)
+{
+	const struct attribute_notify *notify = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify->id == id;
+}
+
+unsigned int gatt_db_attribute_register(struct gatt_db_attribute *attrib,
+					gatt_db_attribute_cb_t removed,
+					void *user_data,
+					gatt_db_destroy_func_t destroy)
+{
+	struct attribute_notify *notify;
+
+	if (!attrib || !removed)
+		return 0;
+
+	notify = new0(struct attribute_notify, 1);
+	notify->removed = removed;
+	notify->destroy = destroy;
+	notify->user_data = user_data;
+
+	if (attrib->next_notify_id < 1)
+		attrib->next_notify_id = 1;
+
+	notify->id = attrib->next_notify_id++;
+
+	if (!queue_push_tail(attrib->notify_list, notify)) {
+		free(notify);
+		return 0;
+	}
+
+	return notify->id;
+}
+
+bool gatt_db_attribute_unregister(struct gatt_db_attribute *attrib,
+						unsigned int id)
+{
+	struct attribute_notify *notify;
+
+	if (!attrib || !id)
+		return false;
+
+	notify = queue_find(attrib->notify_list, match_attribute_notify_id,
+						UINT_TO_PTR(id));
+	if (!notify)
+		return false;
+
+	queue_remove(attrib->notify_list, notify);
+	attribute_notify_destroy(notify);
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index a0fd66c53..5bf19d302 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -281,3 +281,11 @@ bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
 
 void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib);
+
+unsigned int gatt_db_attribute_register(struct gatt_db_attribute *attrib,
+					gatt_db_attribute_cb_t removed,
+					void *user_data,
+					gatt_db_destroy_func_t destroy);
+
+bool gatt_db_attribute_unregister(struct gatt_db_attribute *attrib,
+						unsigned int id);
-- 
2.26.2

