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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FEC00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432EC22280
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD2RhUpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKBTMn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A31C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:43 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id x13so11603908pgp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=crIjpBLX3zf442PLoXns/F6GX0fRHqJTvt6ye9N9+kc=;
        b=CD2RhUpjzs3X8t6qKhqfblVYRLP13+CLc9LnHewN7Jz47afNpo8hn+aS2otYMT4t70
         zpGTEzbA5hiWHiipN3gNg8EIFt+BlbdwJ5Q6XRCfM3h/GKy9w73sH6ZhDdsZ5bi+giZa
         9z7z/HTBqrCHcZCbQg9sWpdp88creY87nULUZsiee5HrqzqIv7aXBM0O7NgFYncX/KfR
         UYLtRJ1UlURb4eErGByDOFU5VKSGMFJ5CaLYzoDPG8UPjPOhEGVD9AaX0zFg9EStId/N
         FfoeBpwMyWiENKfuRJdn/nyUfDu8vTE10vG3shdE3YRgDDpFsPxu/2+RXyBZcvv8iq+W
         iTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crIjpBLX3zf442PLoXns/F6GX0fRHqJTvt6ye9N9+kc=;
        b=Kl11So1N1ktOcb9Dluilm+vzxXGDpObfL6LB97NgDxO9PtWDtR/laFt1XwWxVCnLEB
         M4B7k87Fr5g5f8n3QKIRTv22iwhmar7S1BEo4LnOAWGITGFEiJCWxQ8WYNFpCQL5G0qP
         XJ/sUDqEbDGFdLLtRnB5lQitP43ThKTo4jv46gTPrFdszaTMPsU+htmWp4oFJhYxmVOu
         zduUELsyOJetb/L1Ff3BDuhT7vOw/A/q30rCjmj7+syTnDdthUsIKD/AmjGsrjpvF8fy
         BhRNH9yiNL/WoJR8DQ5kdF9GFd7IQQ0Bqfq1zbExEk6LEj0fdUWrmvw0HwwkmrWKAha0
         v6lw==
X-Gm-Message-State: AOAM5306m2w5JY9Re/6m0nVKn4gzijAvhtlR62bohDBOTLBCR43dCT27
        wfdi/kcY/z+pKbKCFTAP6h0jnZ8siK32Zg==
X-Google-Smtp-Source: ABdhPJy8USXlLaaf/qsD1VPGRJkiCiVX3h7+SnYTd7GwSwbZNdhBCW+2If6vAAtitjy7NADezZP69Q==
X-Received: by 2002:a63:c154:: with SMTP id p20mr14791686pgi.252.1604344362785;
        Mon, 02 Nov 2020 11:12:42 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/11] tools/rfcomm-tester: Enable hciemu debug
Date:   Mon,  2 Nov 2020 11:12:30 -0800
Message-Id: <20201102191232.1848737-9-luiz.dentz@gmail.com>
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
 tools/rfcomm-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index dcf19ecd2..9bae5b9d5 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
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

