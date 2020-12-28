Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B828C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9CC207B2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgL1GXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgL1GXW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 01:23:22 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC6C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:22:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id m23so7550063pgl.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=G8mTuI59vHARrWXenok3n0BrbeW6B94jcY14Tht2HbY=;
        b=Dg5JNA6Gc8fQ6TeLqfivSU/ryWRvkFcfsojppNO/3b14rKilcUJe5scJJ2WhrqoNTy
         rhds1HXsknt65hwGWh7ag31ycIz3XY0B5iYn6bUrXhN4Pq1p16MTzVIgdW5is7jBjmXQ
         h9OtKSicLoNxiFbO0GSTCUJq2NNT1ZyrcqENeY2zWrCR6ZtlCsXD9GstWX5OuSAxE93z
         fRlZDmuuf7kHJk6d1q1eQ1cXsV39C7YzFlBToSdKYFaNe1uhuY435r1wAX/VwiI3XIN2
         Vg4zP9NH5VDaxf2enzYNs7VqUBDIJB9HVsRsEA2wMbmNOrW7crap32X8HlnhfwAjSj77
         TEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=G8mTuI59vHARrWXenok3n0BrbeW6B94jcY14Tht2HbY=;
        b=phMPl5H64BV0DQw2MJ8VNLsuypLHsaCfOl50xcZCkTrZ73DX+0D3n1B6RMOJIKUeYK
         p0SPUJEn3DMsTAm7zV4+UkyT94cMsvTZEdCEDHqiMsfaWWLlmLYcjHlapSFt9Q+6/Nhz
         GRPrpMzSRY2cENedDyC62HgXejvBPOeaUwj5DRlfSl7bkVZMx1dkrZ2d90HvPm9P9glN
         +kXjcLHAQQc2cfH1PQU/+dKzrj/+xw9pMfvd8I+Yye8E67i7jXLVuUF4PGefEFM9/9Yg
         OIzLCV47zik7kv/mY4UcC+deGR8kXX8TkV41hYKInqyVdI3JZiRgyO1ULP0eUXCR3ry4
         GEVA==
X-Gm-Message-State: AOAM530OWZhEFPGjlugIlJPUkA0+HyA4K/G/ExoP8SARNJNSXJLscYsY
        kJJUMaggld9cEngNSfKpqGsNAUZ1pfWaVDRh5wwpnYVVZQCH9IPKAWfpkc1DfAsL12sOaaVv+7j
        J/8TzxKzL46c4s+rRI9fUG/QEli33zh2rGzIiw+u8grH1o3MvRmOGEqZ0UttxKLwCr5ARPGGZGq
        c5I860FT10nYo=
X-Google-Smtp-Source: ABdhPJy2aXj8AwKqRkLi/L/FgKhxtgMqwU6YlbK1xV7CJK9TA/nmoKZzRZ4HylvXbEb+Hnd9SO5C9o5E4y48sF/6nQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr1967093pjn.1.1609136561606; Sun, 27 Dec 2020 22:22:41 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:22:36 +0800
Message-Id: <20201228142224.Bluez.v1.1.I89c3c683e3dec6439f3b0d2c00da86a2107019af@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1] shared/gatt-client: Fix GATT client attribute read
 with offset
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     sonnysasaka@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bluez always replies the whole value despite a user specify the offset.
This patch fixes the issue.

Reviewed-by: sonnysasaka@chromium.org
---

 src/gatt-client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 0cf5324ffa46..bec6e1ec049e 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -368,7 +368,8 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 	}
 
 	/* Read the stored data from db */
-	if (!gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op)) {
+	if (!gatt_db_attribute_read(desc->attr, op->offset, 0, NULL, read_op_cb,
+									op)) {
 		error("Failed to read database");
 		att_ecode = BT_ATT_ERROR_UNLIKELY;
 		goto fail;
@@ -906,7 +907,8 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	}
 
 	/* Read the stored data from db */
-	if (!gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op)) {
+	if (!gatt_db_attribute_read(chrc->attr, op->offset, 0, NULL, read_op_cb,
+									op)) {
 		error("Failed to read database");
 		att_ecode = BT_ATT_ERROR_UNLIKELY;
 		goto fail;
-- 
2.29.2.729.g45daf8777d-goog

