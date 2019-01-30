Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3556C282D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ABF20833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP3vpZgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfA3Nyc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:32 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:34682 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3Nyc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:32 -0500
Received: by mail-ed1-f45.google.com with SMTP id b3so19122835ede.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/NkFctSFhKp6VYGrFVhRVXmbjQfu3lrETokz0GrwKew=;
        b=XP3vpZgQBEMF5n0RdwB8FY6I1BFKpCd3SXEJST3+X0n7UGGPTT/nbr03vLDXRCnrMi
         5dkDUmc00PC4jW3YWCoyNaLn/ha0woC8amaHur7cZ7s6Fp3RCgea94v6YVMyQS1XEIUb
         MB+dJgsf57nGJxKL9jMa7mbgLFahRRGWPfTB5oJt9/stDUaExuLbQuJNS6SE4gZHgv0t
         4EU1DHnXLra+p5AoiejXD47aKV2TFq5KevPIdv2jsa/jvF8iBk9bQIFdl3VRvI+Iojy1
         elvPR//17bMOLVsgO43aI7DmDYtoIL1Q8swJmhkyB7kRY7x43HCc3Q4YSxSAzjnpHbJ8
         u5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/NkFctSFhKp6VYGrFVhRVXmbjQfu3lrETokz0GrwKew=;
        b=CP0RJlQfstOHGEMs2Hs7PIp3JhIC1Y3S5qc9Ga9+LP3jkdcoEm5cA8dvL0Q9bq5uUb
         oZPRYvuFuIxs0/HkKOP+5XM3qOUGCm3g451hBwha8jE59B4vngyrrGaz0qxXvvitqFb+
         yivlKteWNDvbAhPl7QNGhupetWSdv/ekWKlUwv7Jb0yFeBgr8Z19vpZWmp6zxw4NaUEj
         81K6uMfps7zeWc+VX/rMh63z6Kub5el6bpyUTY4J/temT2LRGMMnYaQf5yAEI+wns0bm
         GGLPWKH4C2epBXKv1AQutfK1JrmyiijoIBq0BF0tELw3Z4TuKmzp6VAMan3D87aGnDrU
         vgcg==
X-Gm-Message-State: AJcUukcA2uGVyngbCMxohwrlI2yuPZzi2HvbOJwWsl1wmiUG60JOiZWV
        gt4ytp4sHGCsf4qnynROIO2ETlQf
X-Google-Smtp-Source: ALg8bN4ICV39zzY43NW0CPph9cz4OvHnTuf951zlGOPhb0DCzIopqJPw/M59UmIB6areq3tt5typfg==
X-Received: by 2002:a17:906:a40a:: with SMTP id l10mr26195494ejz.248.1548856469590;
        Wed, 30 Jan 2019 05:54:29 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] shared/gatt-db: Allow passing 0 as handle to gatt_db_insert_*
Date:   Wed, 30 Jan 2019 15:54:18 +0200
Message-Id: <20190130135424.2091-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Handle 0 should be allocate on the next handle just as any of
gatt_db_add_* functions.
---
 src/shared/gatt-db.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d28301ac4..c62255fee 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -525,9 +525,12 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 
 	after = NULL;
 
-	if (!db || handle < 1)
+	if (!db)
 		return NULL;
 
+	if (!handle)
+		handle = db->next_handle;
+
 	if (num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
 		return NULL;
 
@@ -585,8 +588,7 @@ struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
 						bool primary,
 						uint16_t num_handles)
 {
-	return gatt_db_insert_service(db, db->next_handle, uuid, primary,
-								num_handles);
+	return gatt_db_insert_service(db, 0, uuid, primary, num_handles);
 }
 
 unsigned int gatt_db_register(struct gatt_db *db,
@@ -768,7 +770,7 @@ gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
 					gatt_db_write_t write_func,
 					void *user_data)
 {
-	if (!attrib || !handle)
+	if (!attrib)
 		return NULL;
 
 	return service_insert_characteristic(attrib->service, handle, uuid,
@@ -856,7 +858,7 @@ gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 					gatt_db_write_t write_func,
 					void *user_data)
 {
-	if (!attrib || !handle)
+	if (!attrib)
 		return NULL;
 
 	return service_insert_descriptor(attrib->service, handle, uuid,
-- 
2.17.2

