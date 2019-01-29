Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4164C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51332147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9xxTDGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfA2N0u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35669 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfA2N0u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so15998899edx.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vLwe/+rJ4RKQgBAYmxmK0w9wIE1xNanRiQE30O4s8AE=;
        b=W9xxTDGBioamOmCWozYyJHls/iaeChqGABOI4IDyC4lrkd+059o/hHWYncDuD4ZQwk
         BHxiizUO3gng1tJNsIrH/8TEZPjgBaU/uxu9z+OVrj7U5UpAXBvGBmGI7roQ72qjH4uR
         OEZiTOmfydanG4H2gD8XRwD1nS1xuPvFZ5fC3gB0pbyJG2PdCtBT9vx8w3RFrGsjnFCF
         /rLnuraHGANAAYmEHA8EgO4L1ZwdwwCnSp9mKYGDCiE34TTRNgc1ui7qoaX37VfCObgp
         vVYTmX60DjbS8wit/JmmUcFnwj532EDJDO+A3WP9Rbb96cRUXRfXeDWMOidhjH4w76PM
         1G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLwe/+rJ4RKQgBAYmxmK0w9wIE1xNanRiQE30O4s8AE=;
        b=n2LLubEzrZk58j7/y30loZSQsI9/4W90XH2l4c1WOdUMqdEH5PG3HVdFuwpxISu2XV
         1rEJLTMGNA10dezoRERZolWBmZ8RbO0YehQdiNtJZeWcMfITLlcNTAR0eHTPY7vHM9r5
         pwn49G0bdNNZOq5DW04sv+1zOoDwKxb7OzAOjS1gZ8WF1IOwVGZD3v0PUqfU+2xWiZ5p
         ePQP3dbVT+wipxAt5+vIam8tUGdo9Kf36KW6p2icO9DzsdxrLWinOxa4rpMpf59yjGJ3
         DADZ5fSdxpE5/ILMXuvLuXhJ7Dgb3KSK0Y9WHa2ubmzy/I840bMnBzKyXTLNTGTY6DQ7
         ZrPw==
X-Gm-Message-State: AJcUukdscFP5A5tM8I711yic+YFYA18gbE7sJAW8i/mOy7DSfTybXntN
        5NX3lIJAadMf9cehB8sJSCCUUK3h
X-Google-Smtp-Source: ALg8bN5e8S47W3BGTd8en+zD+omD8HbqgdTgeER7NDsB4jdfs0qpFMYRwbZEMDsojfOt5gVcsH7NKg==
X-Received: by 2002:a50:a741:: with SMTP id h59mr24240167edc.106.1548768407092;
        Tue, 29 Jan 2019 05:26:47 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/15] shared/gatt-db: Generate database hash
Date:   Tue, 29 Jan 2019 15:26:27 +0200
Message-Id: <20190129132634.28786-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This use bt_crypto_hash (AES-CMAC) to generate a database hash
using the content of the attribute:

In ascending order of attribute handles, starting with the first handle,
concatenate the fields Attribute Handle, Attribute Type, and Attribute
Value if the attribute has one of the following types:
«Primary Service», «Secondary Service», «Included Service»,
«Characteristic», or «Characteristic Extended Properties», concatenate
the fields Attribute Handle and Attribute Type if the attribute has one
of the following types: «Characteristic User Description»,
«Client Characteristic Configuration»,
«Server Characteristic Configuration», «Characteristic Format», or
«Characteristic Aggregate Format», and ignore the attribute if it has
any other type (such attributes are not part of the concatenation).
---
 src/shared/gatt-db.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d97dca124..7dc93268b 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -35,6 +35,7 @@
 #include "src/shared/timeout.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/crypto.h"
 
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -58,6 +59,7 @@ static const bt_uuid_t ext_desc_uuid = { .type = BT_UUID16,
 
 struct gatt_db {
 	int ref_count;
+	struct bt_crypto *crypto;
 	uint8_t hash[16];
 	unsigned int hash_id;
 	uint16_t next_handle;
@@ -225,6 +227,7 @@ struct gatt_db *gatt_db_new(void)
 	struct gatt_db *db;
 
 	db = new0(struct gatt_db, 1);
+	db->crypto = bt_crypto_new();
 	db->services = queue_new();
 	db->notify_list = queue_new();
 	db->next_handle = 0x0001;
@@ -266,12 +269,71 @@ static void handle_notify(void *data, void *user_data)
 		notify->service_removed(notify_data->attr, notify->user_data);
 }
 
+static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct iovec *iov = user_data;
+	uint8_t *data;
+	size_t len;
+
+	if (bt_uuid_len(&attr->uuid) != 2)
+		return;
+
+	switch (attr->uuid.value.u16) {
+	case GATT_PRIM_SVC_UUID:
+	case GATT_SND_SVC_UUID:
+	case GATT_INCLUDE_UUID:
+	case GATT_CHARAC_UUID:
+		/* Allocate space for handle + type + value */
+		len = 2 + 2 + attr->value_len;
+		data = malloc(2 + 2 + attr->value_len);
+		put_le16(attr->handle, data);
+		bt_uuid_to_le(&attr->uuid, data + 2);
+		memcpy(data + 4, attr->value, attr->value_len);
+		break;
+	case GATT_CHARAC_USER_DESC_UUID:
+	case GATT_CLIENT_CHARAC_CFG_UUID:
+	case GATT_SERVER_CHARAC_CFG_UUID:
+	case GATT_CHARAC_FMT_UUID:
+	case GATT_CHARAC_AGREG_FMT_UUID:
+		/* Allocate space for handle + type  */
+		len = 2 + 2;
+		data = malloc(2 + 2 + attr->value_len);
+		put_le16(attr->handle, data);
+		bt_uuid_to_le(&attr->uuid, data + 2);
+		break;
+	default:
+		return;
+	}
+
+	iov[attr->handle].iov_base = data;
+	iov[attr->handle].iov_len = len;
+
+	return;
+}
+
+static void service_gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
+{
+	gatt_db_service_foreach(attr, NULL, gen_hash_m, user_data);
+}
+
 static bool db_hash_update(void *user_data)
 {
 	struct gatt_db *db = user_data;
+	struct iovec *iov;
+	uint16_t i;
 
 	db->hash_id = 0;
 
+	iov = new0(struct iovec, db->next_handle);
+
+	gatt_db_foreach_service(db, NULL, service_gen_hash_m, iov);
+	bt_crypto_gatt_hash(db->crypto, iov, db->next_handle, db->hash);
+
+	for (i = 0; i < db->next_handle; i++)
+		free(iov[i].iov_base);
+
+	free(iov);
+
 	return false;
 }
 
@@ -292,7 +354,7 @@ static void notify_service_changed(struct gatt_db *db,
 	queue_foreach(db->notify_list, handle_notify, &data);
 
 	/* Tigger hash update */
-	if (!db->hash_id)
+	if (!db->hash_id && db->crypto)
 		db->hash_id = timeout_add(HASH_UPDATE_TIMEOUT, db_hash_update,
 								db, NULL);
 
@@ -319,6 +381,8 @@ static void gatt_db_destroy(struct gatt_db *db)
 	if (!db)
 		return;
 
+	bt_crypto_unref(db->crypto);
+
 	/*
 	 * Clear the notify list before clearing the services to prevent the
 	 * latter from sending service_removed events.
@@ -506,7 +570,7 @@ uint8_t *gatt_db_get_hash(struct gatt_db *db)
 {
 	uint8_t hash[16] = {};
 
-	if (!db)
+	if (!db || !db->crypto)
 		return NULL;
 
 	/* Generate hash if if has not been generated yet */
-- 
2.17.2

