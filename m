Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F3C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4755220739
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOGI+TPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGPXTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGPXTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 19:19:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1FC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:19:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so5441967pjc.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8usU1d9z6P0on7EH8VOSZKPN/Qf36pOKKeX7ZcAp564=;
        b=hOGI+TPsl3RU1UI4/IxdpjCKs1mdb22uSRHSLUxuJZoIjCdnAPiRhJUxcgqjK5oFPI
         kKqepTqY6QzQ1AEike/tEhONqEJp1nO18sblgWfqfnHIh/HEcCDUBzAgSAdETRpSO7h2
         sQ4wNZwp18PD0X0iCiQlJMLnScdEQheJD23T4CZpDqH2zCvCHUU/9TIcDGOQzL0SHf40
         HTKs4zWgF+xi7GmPFwPJZtUrmz2kRSoz4uTM36vZQptfts9mVoeGt7/mX5JO/i4u3lRx
         bwQsz/qGHMMDcm9RMNYIfLeHbT1eHGB4kMmef6kevYR23FwHe1Rw80YxlXva7NULrnum
         nV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8usU1d9z6P0on7EH8VOSZKPN/Qf36pOKKeX7ZcAp564=;
        b=lV7kHfT2jssaWAQ7PR8NEOgUWLf++vqs1z4EE0dzaxOKViZu9zyTv11EacoVBwloM2
         QkKk1h9GOlcdYBk9sqHyL1ryvOZW+EcdObwkFqspmO4k+QUgEu87jDATykSvSWXHWG3I
         8YGNSGc8FXqXta3U1rMarqp9M9H30LU2C8ORzPZrC/zdigQwZt3oJX3E5vHtESN4bKwp
         pbzT0YxkpkKOD2JJ0/V66Dz68zcSKNBB7EdYrE5JLGwUdjJtSL4nIuCsoNOaIKcrscys
         ePfjIkK42MJsXq1fkqxeRzooE8fJS1uZX241oXDFkjOtUPJt2IotQaqYr+vE0AUdJX2J
         Tb6w==
X-Gm-Message-State: AOAM531nWSLFVwb4i+kAJb59h56kRS13qMn3lvijl2dbaBRObfRxhrK0
        9m8mKdlWtl5TDpQgGpK1gPaQHvn4y6s=
X-Google-Smtp-Source: ABdhPJzYMPNoNHP9RTwTd2WT7XKzMeeZ58JmGjSk4IOsBjF0xjj9MPmI80sZbmxR/kk0QlhZ/O2vUA==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr7268925pjb.69.1594941539458;
        Thu, 16 Jul 2020 16:18:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm6024530pgf.53.2020.07.16.16.18.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:18:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/gatt-db: Add support for notifying attribute changes
Date:   Thu, 16 Jul 2020 16:18:55 -0700
Message-Id: <20200716231857.934396-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200716231857.934396-1-luiz.dentz@gmail.com>
References: <20200716231857.934396-1-luiz.dentz@gmail.com>
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
2.25.3

