Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CCBC282C7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF19A20881
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krksKv0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfA2LnH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46628 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfA2LnG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so15653194edt.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=PTgs75YrpH00122Py17ONxSrht+fGI+t4SuS1Tpuezc=;
        b=krksKv0qeKcd9/GxWfYL4QDkk/94L+JkGkG4ASEGvPDjHryexFjBYRZTIvpelUTxTU
         tCYmPJ8qEyZ6C9+OwSI+GtmH92Uppd9r7fKhs8K1Fm7g16hwiz9Z6zbf3Ca9V5xiBYd4
         5eq7ssCJ7q+APN/2Oq91PUWYt7MzouqfXgtByqlGStX5fcmzzZzRDTgLQW4cdKqimhT+
         NkRcqcC+FZC37AjBE5czKyKJJnheSLtpQ+lSfp/OnyyjVj/ivR+mP65+yodMeP+2alYY
         KY92G2TfoyLrHLFmonQGGtzaQe3t4dZk27CTAR2Dfda4QZSmQzzJ8xzZSV3sBbgpCd3v
         uJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=PTgs75YrpH00122Py17ONxSrht+fGI+t4SuS1Tpuezc=;
        b=o8LEUEYdUq20vWDUNHnTTM5PUVp2vwfOY/OyabTyyX/WSHzIPtJ6semse5p7DWG9x+
         xU1UQdUxhrMJpsYXwVPrV8eRuBTHnqwPhEswju+yyRuKSW+tkJigZ7WECWUFMYz7qV48
         KjuSGlQjK/NPST9co3NTtR+5KSjt4ANemtXOvOvTVyrHzkcaBW6Co5tacCb7ANwog887
         3MpBDnHlX3qN5DNhNidkTOxhZnb0ldQN0CiHhVDjvmRULKj6y6zILPswQbGBpe3PW+VI
         F/BdGz0TPPNYrpmYhjw4Anbe1BCiOCxm9wkpC8h08Fzd5ORk2tVCkEhe0Xwvm0moRtqs
         vIWQ==
X-Gm-Message-State: AJcUukd0UMBUFCrUAQmXquUD2e0SUWtnp4iajfMYLSeUheyfhHCBHCSN
        5olnhI91Qtu9s66hbONKPQI0FfSa
X-Google-Smtp-Source: ALg8bN4Bculm0peNiaPivmCdcQocEqjT8ZLxXQSMp+PxQJmLl3zjBz/l8/G5hqGiknD9bOhakbqWOA==
X-Received: by 2002:a50:bae3:: with SMTP id x90mr25689092ede.221.1548762183780;
        Tue, 29 Jan 2019 03:43:03 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d56sm14675692ede.76.2019.01.29.03.43.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:43:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] shared/gatt-db: Allow passing 0 as handle to gatt_db_insert_service
Date:   Tue, 29 Jan 2019 13:42:54 +0200
Message-Id: <20190129114258.20945-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129114258.20945-1-luiz.dentz@gmail.com>
References: <20190129114258.20945-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Handle 0 should be allocate on the next handle just as
gatt_db_add_service.
---
 src/shared/gatt-db.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d28301ac4..b0ab2994e 100644
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
-- 
2.17.2

