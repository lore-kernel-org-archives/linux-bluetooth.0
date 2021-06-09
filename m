Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490BFC48BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26170613EE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 21:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFIV1Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:27:24 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40882 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFIV1X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 17:27:23 -0400
Received: by mail-pg1-f170.google.com with SMTP id j12so20793697pgh.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsDYiFPivdCsT30AKXpyooyDO3J+E7B57CkrlDOuHxA=;
        b=r34hCJTeEGmwMlLONuIHz9UugJaG31JYC9kngwbZKsoDBIgrq/B2g3WW0vc4Hh/PuI
         jgLVgzKNDWfinKLe5LtofNPliLbbk0tQuNouMgT55N4Fyxc9Ob3k1waF8uE9SI6WXkkv
         wk/BGZB0ziQgNcUszWAa0Nu95DVCqfIjG+TxoY+yzigNEOIEsbNY1GoNK7vV5ISWC2TB
         GVUUpjFrn2plkJYfBRdvBu7XortanoyDvUPBkqT6ViKTIEuZRS56lmblOb1hFLk3fgp0
         WCDYUM4rCHMukhNg7muyanJaO/x8R6+VxRt6FDHKvCspkG0QXw2XmAlyQIRimFGRlreN
         fMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsDYiFPivdCsT30AKXpyooyDO3J+E7B57CkrlDOuHxA=;
        b=jyjCE7OHviP0+4u9ghOyQ/aA4IkEg0WOjctfbZoLQYt6KdHXygRb5HmIHCz+H9G8rW
         6p1rf6V0+1VwE+ug39mLJH1ojhDEEWkHsHQE1dbi4AUX++IfoUsPmVbRUYbXurRbddn/
         Y7CQxFXvaZL4VM73MVQb+1L8ERM4Hq4hMTwM36AEe7yMQJtfesztVkq6zLKNhyHMR98b
         VEu7pmScBgFnVxYs2ZlW8fzwHcNYPwfWrEBX2zdm6Gyhid9JXZPCMqPHXeG7AljXWYwF
         8RvQFg0Civ8Uqt6fBolphrl7MCk9qiLh+PoX2+24CU8VPINzDHT4QVJmNCmfa2OPSZlQ
         PQ2Q==
X-Gm-Message-State: AOAM533lQL4SF93EH/LViOEBhDJ2zLH5VmExV+MyRDaIOrSvaoW+C2cG
        h04Ln/Qo+1vDT+Ay0tAd1sfl02IQWdM=
X-Google-Smtp-Source: ABdhPJwmGvxE14ryNc1h+KkpCGNDeBtaLhxbUsDyZ/quTMVgk0T5xsVDR5dom1i1ey8y2AQbkTOjkg==
X-Received: by 2002:a63:fa03:: with SMTP id y3mr1614541pgh.389.1623273854526;
        Wed, 09 Jun 2021 14:24:14 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q23sm417207pff.175.2021.06.09.14.24.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 14:24:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Fix adding padding for Ext Adv (Scan Response) Data
Date:   Wed,  9 Jun 2021 14:24:11 -0700
Message-Id: <20210609212411.288330-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These commands are actually of variable size so they don't expect
padding like in the non-extended version.
---
 tools/mgmt-tester.c | 54 +++------------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6109883ad..52cd19a36 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5572,9 +5572,6 @@ static const char ext_adv_hci_ad_data_valid[] = {
 	0x19, /* GAP Appearance */
 	0x01,
 	0x23,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
 static const char ext_adv_hci_scan_rsp_data_valid[] = {
@@ -5588,9 +5585,6 @@ static const char ext_adv_hci_scan_rsp_data_valid[] = {
 	'e',
 	's',
 	't',
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const uint8_t ext_adv_data_invalid[] = {
@@ -7619,10 +7613,6 @@ static const uint8_t set_ext_adv_data_uuid[] = {
 	0x09,
 	/* advertise heart rate monitor and manufacturer specific data */
 	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00
 };
 
 static const struct generic_data add_ext_advertising_success_1 = {
@@ -7649,10 +7639,6 @@ static const uint8_t set_ext_adv_data_test1[] = {
 	0x06,				/* AD len */
 	0x08,				/* AD type: shortened local name */
 	0x74, 0x65, 0x73, 0x74, 0x31,	/* "test1" */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data add_ext_advertising_success_pwron_data = {
@@ -7695,10 +7681,6 @@ static const uint8_t set_ext_adv_data_txpwr[] = {
 	0x02, 			/* AD len */
 	0x0a,			/* AD type: tx power */
 	0x00,			/* tx power */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data add_ext_advertising_success_4 = {
@@ -7752,10 +7734,6 @@ static const uint8_t set_ext_scan_rsp_uuid[] = {
 	0x05,			/* AD len */
 	0x03,			/* AD type: all 16 bit service class UUIDs */
 	0x0d, 0x18, 0x0f, 0x18,	/* heart rate monitor, battery service */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
 };
 
 static const struct generic_data add_ext_advertising_success_7 = {
@@ -7819,9 +7797,6 @@ static const uint8_t set_ext_adv_data_general_discov[] = {
 	0x04,			/* AD len */
 	0xff,			/* AD type: manufacturer specific data */
 	0x01, 0x02, 0x03,	/* custom advertising data */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const uint8_t set_ext_adv_data_limited_discov[] = {
@@ -7834,9 +7809,6 @@ static const uint8_t set_ext_adv_data_limited_discov[] = {
 	0x01,			/* limited discoverable */
 	/* rest: same as before */
 	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const uint8_t set_ext_adv_data_uuid_txpwr[] = {
@@ -7853,9 +7825,6 @@ static const uint8_t set_ext_adv_data_uuid_txpwr[] = {
 	0x02,			/* AD len */
 	0x0a,			/* AD type: tx power */
 	0x00,			/* tx power */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data add_ext_advertising_success_9 = {
@@ -8131,10 +8100,6 @@ static const uint8_t set_ext_adv_data_test2[] = {
 	0x06,				/* AD len */
 	0x08,				/* AD type: shortened local name */
 	0x74, 0x65, 0x73, 0x74, 0x32,	/* "test2" */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data multi_ext_advertising_switch = {
@@ -8236,10 +8201,6 @@ static const uint8_t ext_scan_rsp_data_empty[] = {
 	0x01,				/* controller should not fragment */
 	0x01, /* scan rsp data len */
 	0x00, /* scan rsp data */
-	/* placeholder data */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data add_ext_advertising_no_name_set = {
@@ -8262,10 +8223,8 @@ static const uint8_t set_ext_scan_rsp_data_name_fits_in_scrsp[] = {
 	0x0c, /* Scan rsp data len */
 	0x0b, /* Local name data len */
 	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* "Test name" */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
 };
 
 static const struct generic_data add_ext_advertising_name_fits_in_scrsp = {
@@ -8291,11 +8250,8 @@ static const uint8_t set_ext_scan_rsp_data_shortened_name_fits[] = {
 	0x0d, /* Scan rsp data len */
 	0x0c, /* Local name data len */
 	0x08, /* Short name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31,
 	/* "Test name1" */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31, 0x00,
 };
 
 static const struct generic_data add_ext_advertising_shortened_name_in_scrsp = {
@@ -8326,8 +8282,6 @@ static const uint8_t set_ext_scan_rsp_data_param_name_data_ok[] = {
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
 	/* "Test name" */
-	/* padding */
-	0x00,
 };
 
 static const struct generic_data add_ext_advertising_name_data_ok = {
@@ -8374,8 +8328,6 @@ static const uint8_t set_ext_scan_rsp_data_name_data_appear[] = {
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
 	/* "Test name" */
-	/* padding */
-	0x00,
 };
 
 static const struct generic_data add_ext_advertising_name_data_appear = {
-- 
2.31.1

