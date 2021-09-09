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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CC460ED8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbhIIXKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbhIIXKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 19:10:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F1C061756
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 16:09:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w7so30833pgk.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yyHvWInz3uuTDAiQ5ACOjUA89TJOt2Ed2qTMRVnSqVY=;
        b=gRVG9VC2d8KBGz3XEqe5K+EjLxvsBgGHi6D/W8Xmtvdtepr+MLxHlTbgFwH2pEFk4w
         EwSZX+977VuuuQhaC+7wVKTnyrko21lrWGlLBdbccsY/Op2ZhBKhuqPnr/iqA+Dy/AaK
         pjq2sCSSB5QYSLJ0PvCS29P04lWYZLfYy32uH3LzQqt9DpmLwuSqCGIcgybIbv50mlpw
         lDuU14FvhOYCSelwWep4LMKYRM6+pIs3Id3setn47i8QS5NBeeEHGweJRwx9y1kc16xo
         ej2y7fGK0i/hby/+3VaP9+GXuZ/jSAXtCbv4vy1F+wOwPErCiGMlz+kgqOOAno3J4Rq9
         ndoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yyHvWInz3uuTDAiQ5ACOjUA89TJOt2Ed2qTMRVnSqVY=;
        b=z4grfmEIk3LULxeSB6/yzfU3E2mh6fbv+woIVnMS8DUp1sIDHnmWt1PG58wUPePh3n
         SNawpyAn5NYu1x1GjZgvwXnGx5JNAjPxRAPjIcbc+BrDxULubrJpPY/E3O4RyCQedYUK
         71A9XuVj8vF8FJDmd5Qy7lwR1GTBF4T1COCMAwy+3k+2tgiEQ59IPFglsZtRA2J6yO74
         +iB6VTcOavGrXewp+xefiXVf3jxgMKHnUj8axsMGePzZ4eOQ2b88HmE0IAuTkNIlbXBh
         ++P20Wb0V1SQX78u0w8xJN0A9eKtqyTzzmAGCy7bXg9vRkO+WjS4K4JjZXktRaigtMQx
         dvcA==
X-Gm-Message-State: AOAM533nkRMw2ktV82Xyx8dws0AXGm/+l9gRjcRGRKnujGLZwapePx9+
        stJU/ie/RcfTfz27UT4goTbFYGqYPJE=
X-Google-Smtp-Source: ABdhPJzJ3VUGKpygIjrJDfJERzgWjWag3ecaEyz50RcoZCeUdju9gN7i9iNrMbXXBTKN+wRA6A329g==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr4782060pgk.322.1631228947457;
        Thu, 09 Sep 2021 16:09:07 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:cfe1:5bc7:a7f1:cb9f])
        by smtp.gmail.com with ESMTPSA id n11sm3425982pjh.23.2021.09.09.16.09.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:09:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Add test cases for load_long_term_keys command
Date:   Thu,  9 Sep 2021 16:09:06 -0700
Message-Id: <20210909230906.165577-1-hj.tedd.an@gmail.com>
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
index da53e4484..3feb62f1a 100644
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
+static void setup_load_ltks_20_by_1(const void *test_data)
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
+				setup_load_ltks_20_by_1, test_command_generic);
+	test_bredrle("Load Long Term Keys - Success 4 (20 with count 20)",
+				&load_ltks_success_test_4,
+				NULL, test_command_generic);
+	test_bredrle("Load Long Term Keys - Success 5 (Power On and 20 keys)",
+				&load_ltks_success_test_5,
+				NULL, test_command_generic);
 	test_bredrle("Load Long Term Keys - Invalid Parameters 1",
 				&load_ltks_invalid_params_test_1,
 				NULL, test_command_generic);
-- 
2.25.1

