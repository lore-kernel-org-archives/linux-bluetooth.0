Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D807AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 01:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809E264EFD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 01:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCRBQN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCRBPr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 21:15:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76AC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 18:15:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l3so2337211pfc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkuAZzxiloizkLfpEXJEaF+jLzg47UvQwLcjKmxkgGY=;
        b=VmbVQgRfpgnb+U3XG6GOZMPYhbj9qJhM7AbVbSuu2SQjJTMdSbhY2m02jq3Tshe74L
         uIKCaP3ZG74qcoE041acbs1uur+LCFZiKDMOs4w/kNJV6d2D5dHEDIvmbq77mneDuxEE
         bv1y6y5+El9yxM6ZMmnvTs29vopnU0+WhwOlr/vy9o1wpODZojGKhsmOONPKKcY01mjW
         96MRkHLGY6tZrTmhNl/mB545mhCgCeMABZAx9ICEkuY3IKsZuhGPNgn+YNJ8Vl+hL087
         v7atEzF2KS1d1oWKsHirOxYhb6frtxH7S+OEpjzDa3MSAdO8rYN+BMZYb/Z0TLQz+dsD
         b+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkuAZzxiloizkLfpEXJEaF+jLzg47UvQwLcjKmxkgGY=;
        b=SldTjJUZc2BWgEodnIQOZ6qtw6WLKnGrNyD6nM9yswXmu/SsaLKalYLzmsQNUx4DXN
         A2B3h/0Ad+n3fqq0nZM85LVDiBz3u7tPvz/8qE+9mKqXLzLj/Pn3wvokwZ7qBdvLxlVs
         RdMAd2vO6hWzq7bYgW2fFVtRco9zI8L01vV+fqh8V+yUaod742wSNC8uxwqZ8llvlwom
         nZaJtf7NkWjRfdbdl5Ra0BZMtvpVkezXLzbVkDjY3v12p/jwXldTzKt2VZuTTHmwVd55
         w3eTBY7+vj3+KVRsQ1sZU0qhIJwvw+oVu7gSpQex56auivPqMA5Fp+Igoe7mRaIigYae
         sQRA==
X-Gm-Message-State: AOAM530bLUPSlVA1/QNFAJkku8nun7IWpKbrla+39OfuBp5Qn4AzEgvQ
        tOi8yIiY2cRjnSA2Qc1l7FIfX4+xKKM=
X-Google-Smtp-Source: ABdhPJzEu8ZVWWvD2d7lADL3jOP5cFRF+WTvbzSCnyQADkUR6PJUo9izq7G3M0toKcCE8DVBXL3cUA==
X-Received: by 2002:a63:2214:: with SMTP id i20mr4695989pgi.189.1616030146392;
        Wed, 17 Mar 2021 18:15:46 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:24df:8146:1cd2:2abd])
        by smtp.gmail.com with ESMTPSA id y2sm244028pgf.7.2021.03.17.18.15.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 18:15:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/mgmt-tester: Fix for scan response in read adv feature command
Date:   Wed, 17 Mar 2021 18:15:45 -0700
Message-Id: <20210318011545.407405-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the test failure with the read advertising feature
API which is changed to include the scan response flag.
---
 tools/mgmt-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bb9fb0b9c..1835ca079 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4162,7 +4162,7 @@ static const struct generic_data read_adv_features_invalid_index_test = {
 };
 
 static const uint8_t read_adv_features_rsp_1[] =  {
-	0x7f, 0xf0, 0x00, 0x00,	/* supported flags */
+	0x7f, 0xf0, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -4177,7 +4177,7 @@ static const struct generic_data read_adv_features_success_1 = {
 };
 
 static const uint8_t read_adv_features_rsp_2[] =  {
-	0x7f, 0xf0, 0x00, 0x00,	/* supported flags */
+	0x7f, 0xf0, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -7137,7 +7137,7 @@ static const struct generic_data set_appearance_success = {
 };
 
 static const uint8_t read_adv_features_rsp_3[] =  {
-	0xff, 0xff, 0x00, 0x00,	/* supported flags */
+	0xff, 0xff, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x01,			/* max_instances */
-- 
2.25.1

