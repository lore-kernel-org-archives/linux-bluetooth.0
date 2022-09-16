Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8551C6FA86
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 23:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIPXqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIPXqI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 19:46:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7029B99CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 16:46:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b23so22653618pfp.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 16:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=Vtv/gTubTymgj1pIDsSVd0kQO6l8mBkVJW14q0tTnrs=;
        b=c60c3YDlRMy1PWELzicIXLNN6Ikl/YqYUwCjwcH56AToWFlQKI7uq06ks4qxh0Pw+8
         cwNvDBn9HxhswY0SXFveyZfcZvpZ3c2bC5DtlKBUbM0RoEIBpk5UNiWKFJvYvD/TipGz
         DMjU09C5OzH+M6eH1hsSstkDiAM2B5lgqvlBg1zOXhVVkCZS8cbk0wf3/w2oTcxRFJmn
         iKRHpbVuxDzt9qactrR7lNZJ3PrOQC/uf0PHBz7J73nVt08FPXXFzp1nGs1jXgZnhsF1
         8XhR4+2YgevFbPxueju5myJ64zJNQZQW/Hm8Q2cLe/6Vt8pVCCNQ+B7mOR3CZl6Kmf4A
         RWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Vtv/gTubTymgj1pIDsSVd0kQO6l8mBkVJW14q0tTnrs=;
        b=5aqF2AeTHOcyElgKshcA9c/Et+WWoQgmvq8Oz6d20iQ35kcRnQfAlIkBZKcc+woBi2
         xy01+umlVeVD3VUmmBdnA5hbUT7UkevwC5w6+nC9/Wk3hHe6nA3cN67mAO6jliACFiEi
         QLGnYS9rMmgGNgHkVcwyIbkamiajaUhAUDTqf3eTbP+sE5A9Em8BeJbIGznAMJ9fziP4
         Fl3up6m8ifVQC0B9CvdbY1x2VpIufcXVY4lH6g3tGC4f4oHf4bsMLcA1bbICAQ6FgYve
         H0Y2qwJtVzWLY5sc1ddXWfXT09r9MkB9znepMfJ9k7srqYji4Pa4FISXLrSnt0oU1Hh+
         +7Cg==
X-Gm-Message-State: ACrzQf2TOxJwtKr8jPG/jcRMn/4kRlauIa9oAQXsJ9TpeziwjGEunPGa
        ukkPe4giGaCggxY0BxrTijDuddUdh0c=
X-Google-Smtp-Source: AMsMyM4MrGvYDZWVC6qpSC9yRViCWvNkUIgHtvA64cU06Ktc+cChzvby+NekCMR9nk1W2HrBUtUZ6Q==
X-Received: by 2002:a62:a512:0:b0:536:e2bd:e15e with SMTP id v18-20020a62a512000000b00536e2bde15emr7402823pfm.1.1663371966688;
        Fri, 16 Sep 2022 16:46:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jm15-20020a17090304cf00b00177ff4019d9sm15398059plb.274.2022.09.16.16.46.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 16:46:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Make use of gatt_db_attribute_get_ccc
Date:   Fri, 16 Sep 2022 16:46:04 -0700
Message-Id: <20220916234604.1156551-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of gatt_db_attribute_get_ccc to locate a CCC of a given
attribute.
---
 src/shared/gatt-client.c | 41 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ba9228ddf3f4..45b6ed92fde1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -211,22 +211,6 @@ static void notify_data_unref(void *data)
 	free(notify_data);
 }
 
-static void find_ccc(struct gatt_db_attribute *attr, void *user_data)
-{
-	struct gatt_db_attribute **ccc_ptr = user_data;
-	bt_uuid_t uuid;
-
-	if (*ccc_ptr)
-		return;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-
-	if (bt_uuid_cmp(&uuid, gatt_db_attribute_get_type(attr)))
-		return;
-
-	*ccc_ptr = attr;
-}
-
 static bool match_notify_chrc(const void *data, const void *user_data)
 {
 	const struct notify_data *notify_data = data;
@@ -273,24 +257,25 @@ static void chrc_removed(struct gatt_db_attribute *attr, void *user_data)
 }
 
 static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
-							uint16_t value_handle)
+							uint16_t handle)
 {
 	struct gatt_db_attribute *attr, *ccc;
 	struct notify_chrc *chrc;
-	bt_uuid_t uuid;
+	uint16_t value_handle;
 	uint8_t properties;
 
-	/* Check that chrc_value_handle belongs to a known characteristic */
-	attr = gatt_db_get_attribute(client->db, value_handle - 1);
+	/* Check that there is an attribute with handle */
+	attr = gatt_db_get_attribute(client->db, handle);
 	if (!attr)
 		return NULL;
 
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	if (bt_uuid_cmp(&uuid, gatt_db_attribute_get_type(attr)))
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						&properties, NULL, NULL))
 		return NULL;
 
-	if (!gatt_db_attribute_get_char_data(attr, NULL, NULL, &properties,
-								NULL, NULL))
+	/* Check that there is an attribute with value_handle */
+	attr = gatt_db_get_attribute(client->db, value_handle);
+	if (!attr)
 		return NULL;
 
 	chrc = new0(struct notify_chrc, 1);
@@ -301,13 +286,7 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 		return NULL;
 	}
 
-	/*
-	 * Find the CCC characteristic. Some characteristics that allow
-	 * notifications may not have a CCC descriptor. We treat these as
-	 * automatically successful.
-	 */
-	ccc = NULL;
-	gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
+	ccc = gatt_db_attribute_get_ccc(attr);
 	if (ccc)
 		chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
 
-- 
2.37.3

