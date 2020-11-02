Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF6C388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5126E22280
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZq+PPeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgKBTMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6EC0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u2so1367515pls.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EWB17hPUKy6O2d/REkLqtreSkP7cey2vDyPWNOp7Ugw=;
        b=XZq+PPeglyEOSi/KSRD/NAXbVirYNIIc7azOIP3JersFq9gvYoweYHdhq0JQkgL0lm
         zxHm3s0H4yfcDopndRdkBi5so71Mp73S/1B1UlhdGPftPRqy0fVAOxVj17vOfohSEJec
         Z7w2+V0vFzz1mHXwLYCVhfcDwms75ncvjPuPLl1dpnottsvEiINEb6xkXSIi6O+AI4QZ
         Cl0eNzZPQhGXzjO3OPOPWCR2vNdbxI7CWzxQJfjbhqzuyB6Z+VqBOukhFBhevdJhR22z
         oOrFjAE59lrYg4vP01eP9XwO9qjDlzj5V9VxxRfZQTKiRgPX5m70nqwQIyDCrQXneKHR
         L6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWB17hPUKy6O2d/REkLqtreSkP7cey2vDyPWNOp7Ugw=;
        b=lvu7a1N9ytcLnrniaaolPomF6+pWsF+XFr4g/dnkhUV1KSfBhvL84QtycyO04cytoJ
         FDEMrzD1BS0QW1NZD/Gi4Jyl79xYiKyQIwmkK2Dpigj9kj87K4wEqmbbhsdxlpMNlxqA
         6ZJZZqj1WnlW5rZ8kR1HF0N0UerjQ/0G/Cpl+zqukn5YIuOinYcxvN9sxdCN2kShh08C
         kvMIPzq1h5Vx9xfYaip79QlfekOil6UhADWX+/EhPUAhQvdinjC3djuYoMbyN13nOGMw
         nkoxVYIueADJsc2c0gB5PGnCgLp+rZlqH1QVrnfiZL8B3HiSYjUtcSz2ugYqRnt289Kf
         kjaA==
X-Gm-Message-State: AOAM531FPpA7VV39YVU77GG6OLMJDdaw3do1jwPEZz37eP5Ien6VFbo1
        zfcAdoBgrI436FefbbjaYnp0iv9J0lSh2w==
X-Google-Smtp-Source: ABdhPJzuVB4G+Y7bwsLf6ErzQxkCOqnUwCGphjFSYpNY+QhaqSc4TvNm7an7XtdEJxKakjygIKQ4Ng==
X-Received: by 2002:a17:902:ee85:b029:d6:c43e:2321 with SMTP id a5-20020a170902ee85b02900d6c43e2321mr8063065pld.29.1604344363790;
        Mon, 02 Nov 2020 11:12:43 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/11] tools/sco-tester: Enable hciemu debug
Date:   Mon,  2 Nov 2020 11:12:31 -0800
Message-Id: <20201102191232.1848737-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102191232.1848737-1-luiz.dentz@gmail.com>
References: <20201102191232.1848737-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable hciemu debug when debug is enabled.
---
 tools/sco-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 471f89418..2b8dc0d4a 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -44,7 +44,7 @@ struct sco_client_data {
 	int expect_err;
 };
 
-static void mgmt_debug(const char *str, void *user_data)
+static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
@@ -150,6 +150,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		return;
 	}
 
+	if (tester_use_debug())
+		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
+
 	tester_print("New hciemu instance created");
 
 	if (data->disable_esco) {
@@ -175,7 +178,7 @@ static void test_pre_setup(const void *test_data)
 	}
 
 	if (tester_use_debug())
-		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
+		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
-- 
2.26.2

