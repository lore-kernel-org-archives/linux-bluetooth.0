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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3507C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D366861167
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbhIIWg7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhIIWg7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 18:36:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1BC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 15:35:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w7so3327864pgk.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jbi7fwZ7pjOSaqwKvqnwGFFpPi6vWIWB1jKg88AS6QM=;
        b=ObGVJvYNqFtC+X7tqrECk71v3RqolFMydBL3WNZg9S1Z+NOCW7CblaLzZjdc6PnVsG
         ke45Y1Fzb/nyNpwLmkqm7tIVukP5HEZeK6KqSBFZgM/IL/Zdj5gll7dF6jBAqDx9d0D/
         sLotOHk+KHDYaBx2iTjiBp2/V4d5yHIAKWOr2oIvRdNen9L2WDBzUIkrb20OteLNz2A4
         KjotYx/2I7adLFtGmU5ijY0SPINEbWwGfXiWh2RVdqgGltBbG/yx/QtqG0CodZKey4VB
         /GKZSxYfbDDQltBC802gaA5lUEgtK4NsUhYBEsddM6fIs/0bX4M+DiNqQjiRp1UQEsoU
         eSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jbi7fwZ7pjOSaqwKvqnwGFFpPi6vWIWB1jKg88AS6QM=;
        b=qBang9LV7EwLI6/R42OSDROWXeKmU60gtL0zHikJP1nDlxp4GzE0Ur1xSUOSWkqh2+
         CdGaI/zleqxqd/vOkqeB6p6103AtkhciNgQ23qNdRTKXWYuZ/k8Sdzu31ImuqhMqwief
         ThwuMwC/IkMENdexVzNk2YnX70l1Ul4oYREP5+Hgv8QncNhNicb+3JddDIfe5nLDJAOE
         iVhfQzspjhe/kMFy3vg1f3I0JD+qRnU7kXQRokltRvDjE/GREFbxsWDIAXf4P7HqsYdE
         uVH3IyPrEza9PdlpeC9GfEIo4FNd/P5GP8Htu6lfvde+rvo373KBtAeD+SrASlYaG53P
         Ryqg==
X-Gm-Message-State: AOAM533R5NcJa5xDWRuorksXQLNWMaEbo1GrsY+k2YvkVWmzOmZkv2lq
        MdAe5sNZ77evRdelhHCY8dQ8hElAdzo=
X-Google-Smtp-Source: ABdhPJwyUoGptH5lAT3BVHKoQITyg274eBFHc0ZxbBlo78Ug9QQX98t1ZkAPhszs0RLb3cASMhbKhA==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr4718320pgs.450.1631226948214;
        Thu, 09 Sep 2021 15:35:48 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:cfe1:5bc7:a7f1:cb9f])
        by smtp.gmail.com with ESMTPSA id m28sm3464536pgl.9.2021.09.09.15.35.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:35:47 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Add test cases for load_long_term_keys command
Date:   Thu,  9 Sep 2021 15:35:47 -0700
Message-Id: <20210909223547.164560-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds extra test cases for load_long_term_keys command.
---
 tools/mgmt-tester.c | 299 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index da53e4484..2b87aa818 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2690,6 +2690,224 @@ static const struct generic_data load_link_keys_invalid_params_test_3 = {
 };
 
 static const char load_ltks_valid_param_1[] = { 0x00, 0x00 };
+
+static const char load_ltks_valid_param_2[] = {
+	0x01, 0x00,					/* count */
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+};
+
+/* 20 keys at once */
+static const char load_ltks_valid_param_20[] = {
+	0x14, 0x00,					/* count */
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x01, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x02, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x03, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x04, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x05, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x06, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x07, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x08, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x09, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x0a, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x0b, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x0c, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x0d, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x0e, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x0f, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x10, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x11, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x12, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+
+	0x13, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
+	0x01,						/* addr type */
+	0x00,						/* authenticated */
+	0x00,						/* master */
+	0x00,						/* encryption size */
+	0x00, 0x00,					/* diversifier */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
+};
+
 /* Invalid key count */
 static const char load_ltks_invalid_param_1[] = { 0x01, 0x00 };
 /* Invalid addr type */
@@ -2726,6 +2944,35 @@ static const struct generic_data load_ltks_success_test_1 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
+static const struct generic_data load_ltks_success_test_2 = {
+	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
+	.send_param = load_ltks_valid_param_2,
+	.send_len = sizeof(load_ltks_valid_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const struct generic_data load_ltks_success_test_3 = {
+	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
+	.send_param = load_ltks_valid_param_2,
+	.send_len = sizeof(load_ltks_valid_param_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const struct generic_data load_ltks_success_test_4 = {
+	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
+	.send_param = load_ltks_valid_param_20,
+	.send_len = sizeof(load_ltks_valid_param_20),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const struct generic_data load_ltks_success_test_5 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
+	.send_param = load_ltks_valid_param_20,
+	.send_len = sizeof(load_ltks_valid_param_20),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
 static const struct generic_data load_ltks_invalid_params_test_1 = {
 	.send_opcode = MGMT_OP_LOAD_LONG_TERM_KEYS,
 	.send_param = load_ltks_invalid_param_1,
@@ -6312,6 +6559,46 @@ static void setup_uuid_mix(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_load_ltks_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Loaded Long Term Key");
+}
+
+static void setup_load_ltks_20_count_1(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_load_long_term_keys *cp;
+	struct mgmt_ltk_info *info;
+	unsigned char param[sizeof(*cp) + sizeof(*info)] = { 0x00 };
+	unsigned char param_on[] = { 0x01 };
+	int i;
+
+	cp = (struct mgmt_cp_load_long_term_keys *)param;
+	cp->key_count = 1;
+
+	info = (struct mgmt_ltk_info *)cp->keys;
+	info->addr.type = 0x01;		/* LE Public */
+
+	for (i = 0; i < 20; i++) {
+		/* Update BDADDR */
+		info->addr.bdaddr.b[0] = i + 1;
+
+		mgmt_send(data->mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS,
+			  data->mgmt_index, sizeof(param), param,
+			  setup_load_ltks_callback, NULL, NULL);
+	}
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param_on), param_on,
+					setup_powered_callback, NULL, NULL);
+}
+
 static void setup_add_device(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -10632,6 +10919,18 @@ int main(int argc, char *argv[])
 	test_bredrle("Load Long Term Keys - Success 1",
 				&load_ltks_success_test_1,
 				NULL, test_command_generic);
+	test_bredrle("Load Long Term Keys - Success 2",
+				&load_ltks_success_test_2,
+				NULL, test_command_generic);
+	test_bredrle("Load Long Term Keys - Success 3 (20 with count 1)",
+				&load_ltks_success_test_3,
+				setup_load_ltks_20_count_1, test_command_generic);
+	test_bredrle("Load Long Term Keys - Success 4 (20 with count 20)",
+				&load_ltks_success_test_4,
+				NULL, test_command_generic);
+	test_bredrle("asdf Load Long Term Keys - Success 5 (Power On and 20 keys)",
+				&load_ltks_success_test_5,
+				NULL, test_command_generic);
 	test_bredrle("Load Long Term Keys - Invalid Parameters 1",
 				&load_ltks_invalid_params_test_1,
 				NULL, test_command_generic);
-- 
2.25.1

