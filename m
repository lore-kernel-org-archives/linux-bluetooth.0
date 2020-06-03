Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C62053B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EreiaZG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFCRmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFCRmq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:42:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC86C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:35:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so1059131plr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HdGQH8ewb/MVR7Me82ORCscMq0KLTyZo+yRvedrkDw=;
        b=EreiaZG9QfofIjMh+NsZCVJeqreByRnThmXg3qc8zzRfJ9IhIChugvgYWANAwuYKdU
         I6Ggbp0TWCa2IZsa1K/HSdcGSdoskOg5L0Ymd2wiei+oamwNXldm6dLZ8GqFKOT+wEtN
         FkBntGFGRhhnLRwUHc1bn0CXVlB6KCC5pSz6CBVWaYXyAZmZzqwtDoBwRh6kg5OWRl+J
         0YmOGkNQx5JM/9YxefTLDQ+a7uy323xPmyFqdd6OUG4UBTEQcSClIN4ZV8vIxvhPpmhy
         BFmvK0dntIvjj0pwChKERZNqol8Z50W5b/eQWBhZ1cYzNqGiOA06LwEDpb+FC+GpKT1a
         6QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HdGQH8ewb/MVR7Me82ORCscMq0KLTyZo+yRvedrkDw=;
        b=IlnpN6KijRXu2cHomP4S/X09Vuz2wihh0Wis2R/vb10y7ujOSPSABfe1LadxL+lGPz
         qraEYRc9/WecKQuQHffqfDFhaaaAxW74MY+rj8n0NsRCJIGyKb4+7GvYE6YoTq58WxGX
         EaSiU23rzRr4aTmt0B8P5MKU1RUCe4IhRnDLlTVw5JCOVSqLEmFRU3qJ1e56B3uZruFa
         X6Al/U81A7wtWYY5DcLIHcNOMXQ6cH7ATdrp4NgSd27Lg6kZ0eBocpnGiZ5UsuTxjtOC
         ZeLNLgmLCSnx7IYuHaCdUzbw6YkcgirhKxDlrA5vgngWH7J9nO5FnEP1wBs5yEbK+jaG
         VxWw==
X-Gm-Message-State: AOAM532tr8tQDBTjLWc0OX+MY7dGCcO0zmKORXr9KhoR3YqpQctKhHPO
        +0ougv85ugFGyF29HdgAIhezh5ze
X-Google-Smtp-Source: ABdhPJybG8EtV0lv9Dfv9w2qGZxk+/bzxsf5dzNkmcycYvudXTOKzTDkAwMbPDpDDv+9qCT2umiwuA==
X-Received: by 2002:a17:902:ab87:: with SMTP id f7mr961156plr.166.1591205720535;
        Wed, 03 Jun 2020 10:35:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y26sm2386707pff.26.2020.06.03.10.35.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:35:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix possible crash when unable to generate hash
Date:   Wed,  3 Jun 2020 10:35:19 -0700
Message-Id: <20200603173519.559897-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_db_get_hash actually depends on crypto so platforms that don't
have it enabled shall not register GATT_CHARAC_DB_HASH as otherwise it
would cause a crash due to hash being NULL.
---
 src/gatt-database.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 8cbe09bae..d717bbcde 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1211,10 +1211,14 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 				cli_feat_read_cb, cli_feat_write_cb,
 				database);
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
-	database->db_hash = gatt_db_service_add_characteristic(service,
+
+	/* Only expose database hash chrc if supported */
+	if (gatt_db_get_hash(database->db)) {
+		bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+		database->db_hash = gatt_db_service_add_characteristic(service,
 				&uuid, BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_READ,
 				db_hash_read_cb, NULL, database);
+	}
 
 	/* Only enable EATT if there is a socket listening */
 	if (database->eatt_io) {
-- 
2.25.3

