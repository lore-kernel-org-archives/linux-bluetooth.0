Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7976C282D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9512147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdM/DAhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfA2N0s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34804 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfA2N0r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so16018336ede.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TB+yaC6dItKoKrWkR2poBUqKnXeYYgYQWV1twhkf4BY=;
        b=tdM/DAhW5nuI932fQfcagPlA9Zt74pib4GtogcnYYjs55jfJj6YPfN1Y/w2qjw6kR4
         SUTPg7ayUPoiR8uIAcOHIrZnJoUCcUyZNihhMxJEi9ACXwgSmPNcj4Qc0rxWOpyG4rNh
         oEwYPECB7HGkW1Qahu2lyQ8z+XzyArsHXL93mfNgLi75bbSrsUwX9fuCVlLmy2Ll2fNF
         l65vl0BAkvCyFi5Bz95u4gFrIzBNK6NQsaV/2eMnIMrMrRJntxlJSQjK62cEOhAMQE5q
         bSjvX1CilcvH9nqXtjFaiQxVQJSZW1XwtnF1m1u1FMpOjKhKgr5GqvK+DEutwBPZphtI
         /yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TB+yaC6dItKoKrWkR2poBUqKnXeYYgYQWV1twhkf4BY=;
        b=iCO5m58mf0EfpXGrM0MmgN3fUbZuv/39Whgrk7vGXOjVJ7FtiPyIDDxClTK40NNReQ
         bRDWh9QFzamZkl5nqkkSkF4mZPi0qOw26RhDhJPkvj/9wuzShHDz12q1y3rLgLriy2vK
         odcgNNNS1PWdzSus+CRh7JDdp35PHwcebRVp4Z0gKr9GHdtMYF860x+lfRST36hUeaQq
         UJNfayViAyGWAsZw3hi/i5v3sEp9kRGd1Kn/QEuvrniqHkJlRIk/BMwqJGZsg0w4jHBh
         JX2oMuyZt3XEaAMD3pI5TY6aFbYzboV1W4Sic9BHgny3aTzkk3qCkl/V3vi28nEYlDB2
         i5Zw==
X-Gm-Message-State: AJcUukcJoUm+QbpzsqZSH0nNZE2RnfJUbXJCYKYBRcHjmYyPNPmdj8kF
        gB4v/rYGCU6gquaCb4+ep7vrvGPc
X-Google-Smtp-Source: ALg8bN5R5gI8ZZ5DCUw9y+NEFiiabgqmzWTpb8e1wQgC7qeCy5BR2ee1HRYEPPcD6iu4kp40BPQ1Pg==
X-Received: by 2002:a50:9ead:: with SMTP id a42mr26007649edf.291.1548768405654;
        Tue, 29 Jan 2019 05:26:45 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/15] shared/gatt-db: Introduce Database Hash
Date:   Tue, 29 Jan 2019 15:26:26 +0200
Message-Id: <20190129132634.28786-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces a database hash which is generate whenever the database
changes.
---
 src/shared/gatt-db.c | 36 ++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d28301ac4..d97dca124 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -43,6 +43,7 @@
 #define MAX_CHAR_DECL_VALUE_LEN 19
 #define MAX_INCLUDED_VALUE_LEN 6
 #define ATTRIBUTE_TIMEOUT 5000
+#define HASH_UPDATE_TIMEOUT 100
 
 static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_PRIM_SVC_UUID };
@@ -57,6 +58,8 @@ static const bt_uuid_t ext_desc_uuid = { .type = BT_UUID16,
 
 struct gatt_db {
 	int ref_count;
+	uint8_t hash[16];
+	unsigned int hash_id;
 	uint16_t next_handle;
 	struct queue *services;
 
@@ -263,6 +266,15 @@ static void handle_notify(void *data, void *user_data)
 		notify->service_removed(notify_data->attr, notify->user_data);
 }
 
+static bool db_hash_update(void *user_data)
+{
+	struct gatt_db *db = user_data;
+
+	db->hash_id = 0;
+
+	return false;
+}
+
 static void notify_service_changed(struct gatt_db *db,
 						struct gatt_db_service *service,
 						bool added)
@@ -279,6 +291,11 @@ static void notify_service_changed(struct gatt_db *db,
 
 	queue_foreach(db->notify_list, handle_notify, &data);
 
+	/* Tigger hash update */
+	if (!db->hash_id)
+		db->hash_id = timeout_add(HASH_UPDATE_TIMEOUT, db_hash_update,
+								db, NULL);
+
 	gatt_db_unref(db);
 }
 
@@ -309,6 +326,9 @@ static void gatt_db_destroy(struct gatt_db *db)
 	queue_destroy(db->notify_list, notify_destroy);
 	db->notify_list = NULL;
 
+	if (db->hash_id)
+		timeout_remove(db->hash_id);
+
 	queue_destroy(db->services, gatt_db_service_destroy);
 	free(db);
 }
@@ -482,6 +502,22 @@ done:
 	return true;
 }
 
+uint8_t *gatt_db_get_hash(struct gatt_db *db)
+{
+	uint8_t hash[16] = {};
+
+	if (!db)
+		return NULL;
+
+	/* Generate hash if if has not been generated yet */
+	if (db->hash_id || !memcmp(db->hash, hash, 16)) {
+		timeout_remove(db->hash_id);
+		db_hash_update(db);
+	}
+
+	return db->hash;
+}
+
 static struct gatt_db_service *find_insert_loc(struct gatt_db *db,
 						uint16_t start, uint16_t end,
 						struct gatt_db_service **after)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index e2ac645f3..f3ab803d1 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -41,6 +41,7 @@ bool gatt_db_remove_service(struct gatt_db *db,
 bool gatt_db_clear(struct gatt_db *db);
 bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle);
+uint8_t *gatt_db_get_hash(struct gatt_db *db);
 
 struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 							uint16_t handle,
-- 
2.17.2

