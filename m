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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA97E61108
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbhIIXKh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhIIXKf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 19:10:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 16:09:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso108845pji.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yyHvWInz3uuTDAiQ5ACOjUA89TJOt2Ed2qTMRVnSqVY=;
        b=LLwUMhOJVnFWK7Nke/kfiVCYMGzQ+JzwoyWO82+ozMs41UPpaQK9vasjsdHHNVBwkT
         LF3Ho2qR9u8gobtNRxft3AvUYTHPm/3Jorpqez2Fkf8rJsHjHjSMFgZRC81FuKRiS8AU
         77RIwpdX/XpDwpokhB019hNYpOEtjny+5lpePm54uzP5F+JNu1NVkGWotMyAG+ITJk5e
         wYqpqzC3Lhzw/zxa8jl6+gsc/w+xMYQNXOY6VpnEzGNEy6fHxOhpPKWXR9zrPUmPZQNu
         /2U3/DMCmWKW7ObC6b7+vhd5EmN95p6eh/+O49uuu7HqYIUePB1r+7hWgOM1lvgNm72f
         z8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yyHvWInz3uuTDAiQ5ACOjUA89TJOt2Ed2qTMRVnSqVY=;
        b=o++Q6on+tjEgCGWpLxtyaAlUw5zRxHtR1tQKd2XC8iiEGXqsDWUKjKtLUHILRXVNpY
         +M+pmoQbbRK0WjmUVzmkmyo3DF0jG1nEVw6Hx0JzwNcTOUfYuk3CMd3SWvbwEWEMySh+
         x3a2ePa+nWz8jNKEFGF4xjjQXiFyXjacIM36ZxwJ15qcHenbYqnXYouJLOgOWmdsbAkp
         PfAb5bU8Pd9+6YTYQ2NtvchsxekY89sTtdbKypVZV23U2K3TkR0CsDYhvGBGThWlwAEG
         fwMqR7DO5VUKym1hgQ1pZG7LxodaqxHfQt8aIPuCaKTm9LF/PW3mzdgZSopZDEab6mT9
         fpPg==
X-Gm-Message-State: AOAM532Vk08NoqD8/ny3hUAtackSBEnFsT/lTlSy82iM6fYxp/3JG7CE
        psBw6pV76y/dftf5k1IhaAYyymvSe5k=
X-Google-Smtp-Source: ABdhPJxccQEn6l0MJ/kj5k/e3y7O7gQgGuep6AOodE9O3//KxB4bTSxhiP4z4+Gb/P367nHWnmkJYA==
X-Received: by 2002:a17:90b:1d8d:: with SMTP id pf13mr6246589pjb.130.1631228964230;
        Thu, 09 Sep 2021 16:09:24 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:cfe1:5bc7:a7f1:cb9f])
        by smtp.gmail.com with ESMTPSA id m21sm3418183pfa.216.2021.09.09.16.09.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:09:23 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH V2] tools/mgmt-tester: Add test cases for load_long_term_keys command
Date:   Thu,  9 Sep 2021 16:09:23 -0700
Message-Id: <20210909230923.165649-1-hj.tedd.an@gmail.com>
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

