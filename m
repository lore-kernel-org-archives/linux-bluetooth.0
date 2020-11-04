Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B1C5517A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D8C21734
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdhjP6w7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgKDXmn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbgKDXmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFAEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id f21so87259plr.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/0EA0EvYK58tHqSxuRqoq1ojR/wZ+6JbkYIyKTr4ST8=;
        b=EdhjP6w7+ca0rCDgPww72oKSDNyRBNjiFRPC04DUr9G/ONVnoyvEDORKyAev670N8T
         dYZgZz66JnD+9QQlp12UkldxLvWyRQyIocYs5qa381ZN2gGOxFyqH7PZH7q7cqDgO9Zc
         nUgWwUhrquJ/e9yRzjf/H8d81BvN+6LaAWOLYCRX+TOaAP19mdPGKPJNjdQC9uB3L4r5
         zLf9HyqlYiEj2Jg9eSlv/LKaS4HakDmQpTBzz6D7fldFUL+6zYuO5fDDSnsIn+Q48eHp
         VvApUgFlOkuBMAUyzv0EopsR5WB3HGojhnZmWODoyj5HHiCjNwafMtnG9CQ4XbtZ7Jda
         TeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0EA0EvYK58tHqSxuRqoq1ojR/wZ+6JbkYIyKTr4ST8=;
        b=tUFbESqs2XScvQBQ5VJR+IZs+iaEF3yNrqXw04K5qguwoV1Ia7HPFLvJBu//951aZe
         XP6FMYgNjNeTK0xeJHviFXy4z4vClWNEGKVFBwpCQz7fykX8nhrLS6KOmpbCISzto+Si
         AUeT57iZi5VHzyD2yX1k69H5j7dqoqyJYuaiKX42+BHLdcL8LrHyRiO7K1uo1oZn1vyX
         qJ6OIgnJoQihxc9vB+99njmV7KufGt5DSQPEZtPi6eI0cKo3H2Vb97ksDwb5AvDSHVda
         34APlO3qO7Bg02AUw0HfpIxYRw+C/tzFEeX6aIBOKTUhU5HJYTzXkHJ0wB8Drv4G2Nfd
         nfuw==
X-Gm-Message-State: AOAM532wgV8pfz9R9gLCCLqoCNnHghGNIdDfaQIWiFLKxnS498XxznLE
        O/ZlGYpwqINpLs/tBFeMYa1u0ghnmsVvKA==
X-Google-Smtp-Source: ABdhPJw+3OK4RF7klErVjC2ybqDv64jw8zFzmu7CY0ccTx/h6cSO/+kOzSYfwhcx5ULFRE1K2hGyUA==
X-Received: by 2002:a17:902:fe0f:b029:d6:cf9d:3260 with SMTP id g15-20020a170902fe0fb02900d6cf9d3260mr186437plj.3.1604533355307;
        Wed, 04 Nov 2020 15:42:35 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/8] mgmt-tester: Fix ext advertisement handle
Date:   Wed,  4 Nov 2020 15:42:25 -0800
Message-Id: <20201104234228.2257427-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Handle has been change to 0x01 not 0x00:

< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6
        Extended advertising: Enabled (0x01)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x01
          Duration: 0 ms (0x00)
          Max ext adv events: 0
---
 tools/mgmt-tester.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 55df2953c..a67860da4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6950,7 +6950,7 @@ static const struct generic_data add_ext_advertising_fail_4 = {
 
 static const uint8_t set_ext_adv_data_uuid[] = {
 	/* handle */
-	0x00,
+	0x01,
 	/* complete data */
 	0x03,
 	/* controller should not fragment */
@@ -6982,7 +6982,7 @@ static const struct generic_data add_ext_advertising_success_1 = {
 };
 
 static const uint8_t set_ext_adv_data_test1[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x07,				/* adv data len */
@@ -7010,7 +7010,7 @@ static const struct generic_data add_ext_advertising_success_pwron_data = {
 static const char set_ext_adv_on_set_adv_enable_param[] = {
 	0x01,		/* Enable */
 	0x01,		/* No of sets */
-	0x00,		/* Handle */
+	0x01,		/* Handle */
 	0x00, 0x00,		/* Duration */
 	0x00,		/* Max events */
 };
@@ -7082,7 +7082,7 @@ static const struct generic_data add_ext_advertising_success_6 = {
 };
 
 static const uint8_t set_ext_scan_rsp_uuid[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x0a,			/* scan rsp data len */
@@ -7115,7 +7115,7 @@ static const struct generic_data add_ext_advertising_success_7 = {
 };
 
 static uint8_t set_connectable_on_ext_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x13, 0x00, 			/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08, 0x00,		/* max_interval */
@@ -7146,7 +7146,7 @@ static const struct generic_data add_ext_advertising_success_8 = {
 };
 
 static const uint8_t set_ext_adv_data_general_discov[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x0c,			/* adv data len */
@@ -7165,7 +7165,7 @@ static const uint8_t set_ext_adv_data_general_discov[] = {
 };
 
 static const uint8_t set_ext_adv_data_limited_discov[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x0c,			/* adv data len */
@@ -7180,7 +7180,7 @@ static const uint8_t set_ext_adv_data_limited_discov[] = {
 };
 
 static const uint8_t set_ext_adv_data_uuid_txpwr[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x0c,			/* adv data len */
@@ -7251,7 +7251,7 @@ static const struct generic_data add_ext_advertising_success_12 = {
 };
 
 static uint8_t set_connectable_off_scan_ext_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x12, 0x00,				/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08,	0x00,		/* max_interval */
@@ -7282,7 +7282,7 @@ static const struct generic_data add_ext_advertising_success_13 = {
 };
 
 static uint8_t set_connectable_off_ext_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x10, 0x00, 			/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08, 0x00,		/* max_interval */
@@ -7424,7 +7424,7 @@ static const struct generic_data remove_ext_advertising_success_2 = {
 };
 
 static const uint8_t set_ext_adv_data_test2[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x07,				/* adv data len */
@@ -7531,7 +7531,7 @@ static const struct generic_data add_ext_advertising_scrsp_appear_null = {
 };
 
 static const uint8_t ext_scan_rsp_data_empty[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x01, /* scan rsp data len */
@@ -7556,7 +7556,7 @@ static const struct generic_data add_ext_advertising_no_name_set = {
 };
 
 static const uint8_t set_ext_scan_rsp_data_name_fits_in_scrsp[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x0c, /* Scan rsp data len */
@@ -7585,7 +7585,7 @@ static const struct generic_data add_ext_advertising_name_fits_in_scrsp = {
 };
 
 static const uint8_t set_ext_scan_rsp_data_shortened_name_fits[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x0d, /* Scan rsp data len */
@@ -7615,7 +7615,7 @@ static const struct generic_data add_ext_advertising_shortened_name_in_scrsp = {
 };
 
 static const uint8_t set_ext_scan_rsp_data_param_name_data_ok[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x1e, /* Scan rsp data len */
@@ -7660,7 +7660,7 @@ static const struct generic_data add_ext_advertising_name_data_inv = {
 };
 
 static const uint8_t set_ext_scan_rsp_data_name_data_appear[] = {
-	0x00,				/* handle */
+	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x1e, /* Scan rsp data len */
@@ -7710,7 +7710,7 @@ static const uint8_t add_advertising_1m_param_uuid[] = {
 };
 
 static uint8_t set_connectable_off_ext_1m_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x00, 0x00, 			/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08, 0x00,		/* max_interval */
@@ -7758,7 +7758,7 @@ static const uint8_t add_advertising_2m_param_uuid[] = {
 };
 
 static uint8_t set_connectable_off_ext_2m_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x00, 0x00, 			/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08, 0x00,		/* max_interval */
@@ -7806,7 +7806,7 @@ static const uint8_t add_advertising_coded_param_uuid[] = {
 };
 
 static uint8_t set_connectable_off_ext_coded_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x00, 0x00, 			/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08, 0x00,		/* max_interval */
@@ -7857,7 +7857,7 @@ static const uint8_t add_advertising_param_scanrsp_1m[] = {
 };
 
 static uint8_t set_connectable_off_scan_ext_pdu_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x02, 0x00,				/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08,	0x00,		/* max_interval */
@@ -7888,7 +7888,7 @@ static const struct generic_data add_ext_advertising_success_scannable = {
 };
 
 static uint8_t set_connectable_on_ext_pdu_adv_param[] = {
-	0x00,					/* Handle */
+	0x01,					/* Handle */
 	0x01, 0x00,				/* Event type */
 	0x00, 0x08, 0x00,		/* min_interval */
 	0x00, 0x08,	0x00,		/* max_interval */
-- 
2.26.2

