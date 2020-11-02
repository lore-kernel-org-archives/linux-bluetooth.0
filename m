Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0802C4742C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A26D222BA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9cewqXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKBTMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:42 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66937C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:42 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so9685923pgh.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HteQAn3IGqjmxIHgroMoj4yWs2m49AZfmpW8oo2dT5Q=;
        b=V9cewqXgniNaADfcUcj7ITXJwO8wFjM9vPG1ZLgqncwV4bDD7lh0vruQLtXw9NFq90
         45An1hkLpQLQYpuz+uK/lCFyXoNXDW6rrRNugKxpZQWRn3JEYprVwWXTD+vaXEki3giK
         hqffsMIO3dzecjeF9UbvUjTvI+8p9/DcyRmUQ7ELBYbDwbZr/11ragcWLdf3jwsTySJb
         rZHKYlc0D3ZsGMOhMtNw8LdaM156etLBNEOm7pq4JxA1SHVWWvd1XRJKXFZns9tFzQPA
         9fm1S2Q7wCJvcSXJFSmQf9Rr/Td+tFPOLB0eBGye/yPqsPe3PE+aB5nZfSVk88Zs/Pz+
         /JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HteQAn3IGqjmxIHgroMoj4yWs2m49AZfmpW8oo2dT5Q=;
        b=CWE2rYmGD8G+K7SEB6KE5LjFD9DhEaJVzm2Vztl0JhxvD50xHu6zKGlHmOoXwhkGlC
         YKcjc2HrGZaVgOlt9cgtY3uVSt+0yZ5sswwSGpwA9t6JginSTDvtO98MfKabNiO+/xkS
         +wD0F1nx4XzzIXOebSvKtTv+D31gHWagNIdzc7dosqM6m0LBg/1VP3qHBUtpAI88WONy
         PsxUvrXijfmLU80hPl07y/FwoLByTvtgAbQexRo1Zua5tYo1XD1votK/ag/UIohAhbS6
         W6onzsylT7W9AKQ5em73/sTcW5NBL1iESGoK6IQb5yB1nk7CM6CQ6FksdQpyzx4esgXf
         BnzQ==
X-Gm-Message-State: AOAM531oFhHvDhBD+vzx0fRQqyAL61YEW7SPlIF8o/wVKbSRcWjw31Rt
        oG8DGSEXaIIOf3VBxfLNnqbGBVcXOArZ0A==
X-Google-Smtp-Source: ABdhPJzwCwsczpZqs31v+OA5xAoeK6ls5BtXAQP/FrhQ7teE2Hf5kKFUvDHc+47GJdtu34n6QDrqlg==
X-Received: by 2002:a63:100e:: with SMTP id f14mr860762pgl.8.1604344361803;
        Mon, 02 Nov 2020 11:12:41 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/11] tools/bnep-tester: Enable hciemu debug
Date:   Mon,  2 Nov 2020 11:12:29 -0800
Message-Id: <20201102191232.1848737-8-luiz.dentz@gmail.com>
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
 tools/bnep-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index dfeb0ed0b..5e4d7fb6d 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -59,7 +59,7 @@ struct rfcomm_server_data {
 	uint16_t data_len;
 };
 
-static void mgmt_debug(const char *str, void *user_data)
+static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
@@ -164,6 +164,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		tester_pre_setup_failed();
 	}
 
+	if (tester_use_debug())
+		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
+
 	tester_print("New hciemu instance created");
 }
 
@@ -179,7 +182,7 @@ static void test_pre_setup(const void *test_data)
 	}
 
 	if (tester_use_debug())
-		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
+		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
-- 
2.26.2

