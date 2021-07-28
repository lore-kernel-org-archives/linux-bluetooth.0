Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA9C4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E4960240
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhG1NXN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhG1NXN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:23:13 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD2C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:23:11 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y3-20020ae9f4030000b02903b916ae903fso492553qkl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qOenT5vGuREZjOeQZhrIQYj+foyedhyCo05+xZGFt9s=;
        b=UijolomkkedgNmlaU6ROawvJg+WEhF5ulxYY0FNlATcoJxhMn+z2e1hqM/8/iIEbsW
         ZHGs/gsr87saOhSj2bbdYHtCkNr85gwJYt2VyX17WxyPJuT2LZBlZlTeAn4y163tPDHS
         6qGWKpqpbo3Fm+fsxHLwOXFOVj5IhLh+xc1MIRXi7jlybtNuvbGsZqkRglzDfUxZuHFQ
         G7Fea9XwxABScrEI3NZbAgFVH6nGP1mTG4RVGrHH06hrvCvIrXxZ6qFDmJjmjjgAYulT
         ASVFM6NCb6oNEiOCtSl+Li5A03ZqlyRP+BfFC7R/ujaAs3GB75gwcGeclt9gqBruRDD1
         k7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qOenT5vGuREZjOeQZhrIQYj+foyedhyCo05+xZGFt9s=;
        b=I2Zlu7NvdvCnCYUCSvEuNvYQxqrxU7Kxw1mzGQCf4QCdSl1hO+xH36m9vDI21w/kKA
         aFcWVkBKAIbogNtvDta7f+tjcuD8KNtsE0/WL1ccnQ359E5jQxP8cEZKAh0nPsws3U9n
         jBFZveOlLcndAWLqZASc0soYU0YZV0yliNU85vqySrERuF4DJlEGJdfHlsCmo+L95frU
         ebVQmSDa73GKXSCDyRoL5Tvt1BcbYHNrelfFfg6cMCBuopnae9wK1/Pm3+EZAYaLp4T9
         Sdm8sCKy9AnSr337vrr/Sj3Nii/9gT9tLXIeaILr9ktJcpKPNNyQ2xAzLcjqyHSXHw6/
         2A+w==
X-Gm-Message-State: AOAM530zKeoxRhgifCQeB614zsIFEXpUhCqlLz8cNIA15NMPaTL9Uhhg
        kuUGu159rXu/dJVk0Qr5rGSofPWuMCHtOOPa1VDZ14guR/9U+VarI3dndjIUdba03xity2SoJis
        g/VVstAs0cE3ZwBrXHFzbM4yF3kjXc7xMgWwhq4j8/50IYvbcFYEIgcbAso8H9PcZABXNUbtevT
        jLUUhDD4ExM/o=
X-Google-Smtp-Source: ABdhPJxLOGuc/api9URMBq6dZp7WGD0d1rf17GNwcktWnvVjNPum1Fqezni2TLEUDi8RFCZfQLFbt9c1wvvKhDAcNQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a05:6214:e4c:: with SMTP id
 o12mr28154271qvc.18.1627478590670; Wed, 28 Jul 2021 06:23:10 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:23:04 +0800
Message-Id: <20210728212259.Bluez.v2.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v2] gatt-db: fix service in range check
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

The previous check already makes sure the service range overlaps with
the search range. There is no need to add another check.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v2:
- remove the entire check

 src/shared/gatt-db.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8bff4d37aaa2..658f82812cf6 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1347,12 +1347,8 @@ static void foreach_in_range(void *data, void *user_data)
 	if (svc_start > foreach_data->end || svc_end < foreach_data->start)
 		return;
 
-	if (!foreach_data->attr) {
-		if (svc_start < foreach_data->start ||
-					svc_start > foreach_data->end)
-			return;
+	if (!foreach_data->attr)
 		return foreach_service_in_range(data, user_data);
-	}
 
 	for (i = 0; i < service->num_handles; i++) {
 		struct gatt_db_attribute *attribute = service->attributes[i];
-- 
2.32.0.432.gabb21c7263-goog

