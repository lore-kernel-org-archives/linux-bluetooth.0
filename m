Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1376AC282C7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76422147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8MsS8Ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfA2N0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40465 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfA2N0w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so15943652edr.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=fMbXDlFiFbdSTTrU5t3bjt/0unjzM05NVMIwByr4qf0=;
        b=g8MsS8Ym8xmTgEHh1UgaByg0ta3+3vTHVWJKHMELNIeyuMiefVlAKUxSAwO84r9pNx
         ANd12aYYa2s3JmhiUy9BlgWJuFCQV2CUDnQp6PFod328RLQ3rjV1laBChiya4Im3HCXF
         TZa3nlGF+8PkVVOqyKUpcqUqu6gXpsT8aqiKoIcNTjuVSOSjCDaiAN1JMMkU7+yAdgCs
         N+l5aI0CuhOLY4YxY8EkHGu4thuHXu3gU1KwVpPArC/mOWVdgMTs6zKD4cqdR5Dj+HvW
         9qoR7AyvznEA+kF5j8j13EKZUjrVu380JOZ7ImlMpaSxTPK5XqJL2ftd1cocfc6SNBre
         kgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=fMbXDlFiFbdSTTrU5t3bjt/0unjzM05NVMIwByr4qf0=;
        b=CzIWtbMv8YhXlwiwoaJycEcPlO56BcTHF22iNiXmYsDB466AAcrEC0nlrGCN/U3QSE
         i0smWyvz9a/mIzeKNY7xvZyuWc4XaD6AfwGtbVpmqqN3++CLAETdJaB9Tmdg9fVwlbv7
         jOe3wv+5dQC4c8K9s1eewDuSs8oNy4XwND4WVTX5O3+xGiTJjq10uqEuAKrBdkdg5E2R
         VBOsLbSeJ4lmxowlxDX6f8IcxBNjlgZPY0RhMsn+S2+/5oOsvbJOchRwOCD7+cHmX6tm
         33wvxMLP8BIVrjZAzhTD/ynd8e1gPUkWX91TEkxebAgxLaiPQqxJUBVn8/h4z6quoQLC
         K/pw==
X-Gm-Message-State: AJcUukfJyQjzAgURxiexV1g9bOPHecm00o52jS/3/w/krPX7PfqZhTzk
        FPVvb5BWevvvp27fY/yE/2/kob05
X-Google-Smtp-Source: ALg8bN450x80JDH9xJnsHCudCarnQJWxv1iIr7b0fcF/fiTNLMa2o0yoCfJPwGk5j/SXBa71YEnb/A==
X-Received: by 2002:aa7:d1d7:: with SMTP id g23mr21290391edp.217.1548768409921;
        Tue, 29 Jan 2019 05:26:49 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/15] shared/gatt-db: Add gatt_db_set_authorize
Date:   Tue, 29 Jan 2019 15:26:29 +0200
Message-Id: <20190129132634.28786-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_db_set_authorize can be used to set the callback to authorize
attribute operations.
---
 src/shared/gatt-db.c | 41 +++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  6 ++++++
 2 files changed, 47 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 7dc93268b..4d3653a53 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -67,12 +67,16 @@ struct gatt_db {
 
 	struct queue *notify_list;
 	unsigned int next_notify_id;
+
+	gatt_db_authorize_cb_t authorize;
+	void *authorize_data;
 };
 
 struct notify {
 	unsigned int id;
 	gatt_db_attribute_cb_t service_added;
 	gatt_db_attribute_cb_t service_removed;
+	gatt_db_authorize_cb_t authorize_cb;
 	gatt_db_destroy_func_t destroy;
 	void *user_data;
 };
@@ -736,6 +740,18 @@ bool gatt_db_unregister(struct gatt_db *db, unsigned int id)
 	return true;
 }
 
+bool gatt_db_set_authorize(struct gatt_db *db, gatt_db_authorize_cb_t cb,
+							void *user_data)
+{
+	if (!db)
+		return false;
+
+	db->authorize = cb;
+	db->authorize_data = user_data;
+
+	return true;
+}
+
 static uint16_t get_attribute_index(struct gatt_db_service *service,
 							int end_offset)
 {
@@ -1821,6 +1837,17 @@ static bool read_timeout(void *user_data)
 	return false;
 }
 
+static uint8_t attribute_authorize(struct gatt_db_attribute *attrib,
+					uint8_t opcode, struct bt_att *att)
+{
+	struct gatt_db *db = attrib->service->db;
+
+	if (!db->authorize)
+		return 0;
+
+	return db->authorize(attrib, opcode, att, db->authorize_data);
+}
+
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
 				gatt_db_attribute_read_t func, void *user_data)
@@ -1832,6 +1859,13 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 
 	if (attrib->read_func) {
 		struct pending_read *p;
+		uint8_t err;
+
+		err = attribute_authorize(attrib, opcode, att);
+		if (err) {
+			func(attrib, err, NULL, 0, user_data);
+			return true;
+		}
 
 		p = new0(struct pending_read, 1);
 		p->attrib = attrib;
@@ -1913,6 +1947,13 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 
 	if (attrib->write_func) {
 		struct pending_write *p;
+		uint8_t err;
+
+		err = attribute_authorize(attrib, opcode, att);
+		if (err) {
+			func(attrib, err, user_data);
+			return true;
+		}
 
 		p = new0(struct pending_write, 1);
 		p->attrib = attrib;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f3ab803d1..398d69ad8 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -198,6 +198,12 @@ unsigned int gatt_db_register(struct gatt_db *db,
 					gatt_db_destroy_func_t destroy);
 bool gatt_db_unregister(struct gatt_db *db, unsigned int id);
 
+typedef uint8_t (*gatt_db_authorize_cb_t)(struct gatt_db_attribute *attrib,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data);
+bool gatt_db_set_authorize(struct gatt_db *db, gatt_db_authorize_cb_t cb,
+					void *user_data);
+
 struct gatt_db_attribute *gatt_db_get_service(struct gatt_db *db,
 							uint16_t handle);
 
-- 
2.17.2

