Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 22:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D994650B2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 22:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCEWZz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 17:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhCEWZr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 17:25:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF3C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 14:25:47 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g20so2143125plo.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLSACR2rGLj4GMP/8Poeu6HCwTLgbb1l/hD8kBqfPT0=;
        b=g74B9Z58w/NbMw7a6gl/r2a3TdKqOT5LEvff1DF7gS8N7RVoVIImEX0IXLaEOWrfck
         BKeVNMWVc0Ctx3JfbrzbfceVa28Zi4E0+smC5mAt22T2keemUC3Idw3cbdGe894rcU98
         TT6Jn+ZeB6dxQUSwEspwANxoJFh+FePdsrV3m8YVTLWn2RbvE6Z4S/zeiQb6k2IGAODr
         NzLt27y/KXX2/mwT/LqXaFIsM3yiF/7Kl49Z8ojm7F/5Qe6xq+mc5Wuy2aJFUnVYRfP4
         OpU6J33PM/SvQdSC4b2NBfD/AMTUVRGsvQgPGgtxrtjMotsLzjbeRUf0dDu4faMOofyp
         wwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GLSACR2rGLj4GMP/8Poeu6HCwTLgbb1l/hD8kBqfPT0=;
        b=At+4wltAGINMFpQERb/0ifY3XFeCAyGJoqDE7/KGOXdQj6rqwaJcUAuLyV1ceQHk7w
         4eIPpZkiGmas/K0ItF0yVhE1UZN28FnlUoprInVfA+8L4PUDuHBHeYDmysvBk3EJsCr+
         VQ95iI+F1WZmUiuPdLs1HKGJj/KI0VLtnUGJkM7ie8CKVj01yFXLk72HlnnvIrJDLbiG
         /6CBn2WDkyxEVF7g+Qiat2U6hJao4dFglI6gZwNPOsqbR4u77fhYsOw4z7gjiRRvjdxg
         AvrRqgYfzjxRSkYD9SuTtUrOROno17iKlj0e8VsaWTXppUgfEnWjZMPt3tX4M8MzgUuK
         Rt9g==
X-Gm-Message-State: AOAM53371TDmiHzjbyjEkGLqBRn7ydSwdE0VGQB2eoRb4D2z/Fpe8HEF
        bK4Ig5jN9t2b86Rp3U/NM/Sg7KY3RtB3+g==
X-Google-Smtp-Source: ABdhPJwNTGuKIb4cRMWnTM0/l8150TNEKWvaOcMeiXuG3Cpd4DpPTngqfOjDBEKij83vTMdlZcL3hA==
X-Received: by 2002:a17:902:503:b029:e4:2ce1:f0c9 with SMTP id 3-20020a1709020503b02900e42ce1f0c9mr10334689plf.52.1614983146404;
        Fri, 05 Mar 2021 14:25:46 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gw20sm3106893pjb.3.2021.03.05.14.25.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:25:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix registering DIS without a valid source
Date:   Fri,  5 Mar 2021 14:25:44 -0800
Message-Id: <20210305222544.4005053-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If source has not been set don't register DIS as it would not contain
any useful information and by doing this it actually allows systems to
register their own DIS instance.

Fixes https://github.com/bluez/bluez/issues/101
---
 src/gatt-database.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index bd5864bcd..6c9e19ff3 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1241,22 +1241,23 @@ static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
 static void populate_devinfo_service(struct btd_gatt_database *database)
 {
 	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *attrib;
 	bt_uuid_t uuid;
 
+	/* Only register DIS if source has been set */
+	if (!btd_opts.did_source)
+		return;
+
 	bt_uuid16_create(&uuid, UUID_DIS);
 	service = gatt_db_add_service(database->db, &uuid, true, 3);
 
-	if (btd_opts.did_source > 0) {
-		struct gatt_db_attribute *attrib;
-
-		bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
-		attrib = gatt_db_service_add_characteristic(service, &uuid,
+	bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
+	attrib = gatt_db_service_add_characteristic(service, &uuid,
 						BT_ATT_PERM_READ,
 						BT_GATT_CHRC_PROP_READ,
 						device_info_read_pnp_id_cb,
 						NULL, database);
-		gatt_db_attribute_set_fixed_length(attrib, 7);
-	}
+	gatt_db_attribute_set_fixed_length(attrib, 7);
 
 	gatt_db_service_set_active(service, true);
 
-- 
2.29.2

