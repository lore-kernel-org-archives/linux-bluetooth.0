Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD606C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiCNVv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCNVv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 17:51:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58030344CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 14:50:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s42so16352340pfg.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOAzIAGITBNGyHFTZ7Cmq/ShOyrjrDEaYD2HgQ928xA=;
        b=DLYCCBHwiNA5sjj3uvWwFKxvEiTB0jetmihNzm67O409zkWwRO48S4VDNj183TGhBz
         HMCnDIGgruSeuktVZg7obi6p4q+veP7iHNkLshZijvIrZcnbOaBr0ILMmRtDh0TCJ5Ip
         qhnwNgEExppuPFN/fZU4qL07RoCAByPUoDCDMnXvvJz8Yc2kxniFSRWvnzaw0AxGpbpX
         Lzsxx2umpULGzoQkYQ8WE4bC6fxFQXHPNJjmu2kOCAPdMy+xMqRpzW5xxDrb0cmxSdyN
         D6bEZKISbhZMoislZ0Aook0cQ1/u7sHI+wBqOC16t2jh/RZ/fC41Ei7l9hgJcvgKi/eY
         v/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOAzIAGITBNGyHFTZ7Cmq/ShOyrjrDEaYD2HgQ928xA=;
        b=VB8EIOYcQj2ycwR6289fnGNdQbbEhUlmBvswbt1Hc4v8447baaUI41CrDp5udJVTWI
         kXTEB85Ej/fqmWGQpVmn980+mH/PJuy2vuG/Kv2VQ2oO78UDNoTxs9g/Qax6FDY+7QJ7
         0uQnv7uxUzp806qMH+ZxjOBJb9cVDQ4FLmVtghNkBLoz6gUyDZUZragTjT2U9UIF2Mcy
         yNXuQk+OkePYhHEAvEn8WiM9RpN9JGoFjJOjGazhsR3h18Es3w7KaUZNkNSKoF3M1Zhl
         Y5PWud8MjuF5bPhcdLYMLXeLkb4v+NRsRgO1X9Fjo83mpUSIopuP4ZgVwVj9D68knohM
         c/GQ==
X-Gm-Message-State: AOAM532NtSLdRF3zRy2nA1ly7cTBL+nukdeWiYYrWQ6Ji31ylMzbfhNr
        0d5yMSn45GdWlhdaMv0lk2AmZdlAS4M=
X-Google-Smtp-Source: ABdhPJy9EXlOReQq8IvYirkcC2sl+tXUHRegwgZC30HikrABwSOoEAA68wGRBpTdDR+mmZRWn7PHgQ==
X-Received: by 2002:a63:9c4:0:b0:380:f8fd:561d with SMTP id 187-20020a6309c4000000b00380f8fd561dmr18248153pgj.60.1647294617305;
        Mon, 14 Mar 2022 14:50:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s15-20020a63af4f000000b0037c8875108dsm18029032pgo.45.2022.03.14.14.50.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:50:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gatt: Print error if gatt_db_attribut_notify fails
Date:   Mon, 14 Mar 2022 14:50:09 -0700
Message-Id: <20220314215010.23822-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints an error if gatt_db_attribut_notify fails.
---
 src/gatt-database.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 485af04ea..d6c94058c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1523,8 +1523,9 @@ static void send_service_changed(struct btd_gatt_database *database,
 	put_le16(start, value);
 	put_le16(end, value + 2);
 
-	gatt_db_attribute_notify(database->svc_chngd, value, sizeof(value),
-				NULL);
+	if (!gatt_db_attribute_notify(database->svc_chngd, value, sizeof(value),
+								NULL))
+		error("Failed to notify Service Changed");
 }
 
 static void gatt_db_service_added(struct gatt_db_attribute *attrib,
@@ -3967,6 +3968,7 @@ void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database)
 	put_le16(0x0001, value);
 	put_le16(0xffff, value + 2);
 
-	gatt_db_attribute_notify(database->svc_chngd, value, sizeof(value),
-				NULL);
+	if (!gatt_db_attribute_notify(database->svc_chngd, value, sizeof(value),
+								NULL))
+		error("Failed to notify Service Changed");
 }
-- 
2.35.1

