Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9FEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AFC6509B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCEXAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCEXAH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:00:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B9DC06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:00:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m8so40176pjs.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GDtOAbNEiMQsJu7rqlIJ8wTu/VMRVhdyIetw5QxZ5Uo=;
        b=oBtzh/4BHtrxwmtKLZ2fS8csf+arlSwc6OM7t3u8eTngBH4y1/wr7d2qtp8KvoXWix
         N6mEKsZLLRDjRo7x9tY53JsDxKjYp2kUW/BM9HC0S4K/dWmjVGocXj4pS2RyO7QQDv2/
         oPGc82+Cm8/faOKkYi2MZToOEm2CA4kUU7zq2dAqdyX7mzgsN9fOOvLWEM5VEV09kvXn
         4nPjgxWQKtfFT0iG3NcLMK2IdA8H6ug+ELvZ+cpitk0B+HAlAbM4161BGM7znssyXlyz
         HRX6eBhCRpK5kQIhc2l+nWWgsq7t6K7ouT+ESwDzlpys2sVu0LIq+zrOkSiNBJv6goOS
         J3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDtOAbNEiMQsJu7rqlIJ8wTu/VMRVhdyIetw5QxZ5Uo=;
        b=BbGMlAIFxfsaizDvp1oXGpLu+tIqcGhHvvml5LMQ+/DPZ5Pxpig0Z05/ukX0+5EnxP
         lNTPIn0hfvMrbwQJwMhDyCz/e1ZtdRyXvpV3ovDJlopndZVc9ubHRX72g9taryBUrvDH
         DgiqdKhEmjJW1yLY2b6e1h/YRNCeXaJIZJFPg43n7lLmIGFu47LMsgAaIOQE010dHLlB
         BJEhvhaR2cnNHMAidQWySTjq6M2HxC0ONox12T3VtcejgkSvtlmF73gOvkpOM/ngoEqT
         ie5gHMu84e2egrA0UFHUhColLWo13J7X0vIFyOWn449mPB5X0O4jBLfyzh81vdFmUD3J
         fZxA==
X-Gm-Message-State: AOAM531iUCmve5lIjBoKlA/yD1x1+UduGRwtqdD0MJAMbwZTyvF8IXsk
        Zalhw3XCzHL0f9pixCK/Gkt9sI5Gs0sdyA==
X-Google-Smtp-Source: ABdhPJzMDlrCnXaUVGUEzZedynEqVOHmggldBO+NfdwZ6tvABBeH4UrHlhnAmyLIQrTxoqlxAlHI1w==
X-Received: by 2002:a17:90a:5417:: with SMTP id z23mr12324518pjh.111.1614985206840;
        Fri, 05 Mar 2021 15:00:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e1sm3483546pfi.175.2021.03.05.15.00.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:00:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Fix registering DIS without a valid source
Date:   Fri,  5 Mar 2021 15:00:04 -0800
Message-Id: <20210305230004.4010887-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305230004.4010887-1-luiz.dentz@gmail.com>
References: <20210305230004.4010887-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If source has not been set don't register DIS as it would not contain
any useful information and by doing this it actually allows systems to
register their own DIS instance.
---
 src/gatt-database.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index bd5864bcd..be6dfb265 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1241,22 +1241,22 @@ static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
 static void populate_devinfo_service(struct btd_gatt_database *database)
 {
 	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *attrib;
 	bt_uuid_t uuid;
 
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
 
@@ -1267,10 +1267,7 @@ static void register_core_services(struct btd_gatt_database *database)
 {
 	populate_gap_service(database);
 	populate_gatt_service(database);
-
-	if (btd_opts.did_source > 0)
-		populate_devinfo_service(database);
-
+	populate_devinfo_service(database);
 }
 
 static void conf_cb(void *user_data)
-- 
2.29.2

