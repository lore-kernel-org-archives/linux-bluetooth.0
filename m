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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A5C388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA0C222BA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSZxkdlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKBTMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3D9C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b3so11991595pfo.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/5LxbC8AHpc+T92VJcOJP+JYNMbjkLARoQjE1/pTfi0=;
        b=vSZxkdloKY3bhbSEEyhvlJUA7Ag+qEPAd3FQd3qkzQ8wWXyEoCk7PpMrA5on2qgZch
         sOI/dtqOYEBofrC9u0OGpaNCX+jM/Uujl9hAKawovDJwO//5HtbIK9p25yel1i4w2+Dt
         2Vy43+q8GzDdbHFqZVeVUHgYNUIADOcAt3G+qy2ckXKo66ul8F/RAANszoUf0EJdAKWs
         I7ThecoXGrmTB0BQ5eKUE56VWEjpzrS2Z88Blv8WbqY6UXejXbMR+7ourwl70cdchTr/
         dvvwXkcQA48IciCCfkbGR3f4hE6FULCwfc4KoELzXlGqM96bl+y/jkIoO1FLS7ucMiZg
         VvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5LxbC8AHpc+T92VJcOJP+JYNMbjkLARoQjE1/pTfi0=;
        b=Tf20HVPE6rT9Wv49dMW8m1BzsVTDlchvv05r1a0RR2OQOi2gwWadR3CSuXV+Y9xONv
         wO1jxgjtO0ikUD2BwHOPqm1XgZcXYUpidSJc1RQX4OAqZYZMNYG4E2rBTapnvqJvcmI+
         PO04slTvKQXYb3tqQfDqiwh/PQCo8iOErf8YOzAg7VaKLokBiQgavorGluFZbqMsDPBA
         0BMJD1vbYRs3BORibnbq8nauw/I/3YcX8lN8iUP1jV3tJ1BSj8/mWhv/tBj4M/ci1C9o
         QMyrW6k2HKRtsTkKUNo4ycTzwfbQNzyjTHeg61Fq0o0DI662K9x24vAD/5qOHVLz6loV
         cckg==
X-Gm-Message-State: AOAM531CopzpRE5TDZcN3NjJpCpcOBx7qOisvoWJi/lL0TBiiW0FgCeK
        yhzWS7OKhQSNKUJh0I4v0xUf1myJzpQQ0Q==
X-Google-Smtp-Source: ABdhPJzECqjr6yC5p1vYHwuwN0B4q6L6ria8YY0DQjPWaRKEHSh/ZlUdDXhYjUtjOjt13mRCr6IDCg==
X-Received: by 2002:a17:90a:ea85:: with SMTP id h5mr12625243pjz.26.1604344360838;
        Mon, 02 Nov 2020 11:12:40 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:40 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/11] tools/mgmt-tester: Enable hciemu debug
Date:   Mon,  2 Nov 2020 11:12:28 -0800
Message-Id: <20201102191232.1848737-7-luiz.dentz@gmail.com>
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
 tools/mgmt-tester.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 3b722207f..27a5f0bab 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -57,7 +57,7 @@ struct test_data {
 	int sk;
 };
 
-static void mgmt_debug(const char *str, void *user_data)
+static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
@@ -285,6 +285,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		tester_pre_setup_failed();
 	}
 
+	if (tester_use_debug())
+		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
+
 	if (test && test->setup_le_states)
 		hciemu_set_master_le_states(data->hciemu, test->le_states);
 }
@@ -311,8 +314,8 @@ static void test_pre_setup(const void *test_data)
 	}
 
 	if (tester_use_debug()) {
-		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
-		mgmt_set_debug(data->mgmt_alt, mgmt_debug, "mgmt-alt: ", NULL);
+		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
+		mgmt_set_debug(data->mgmt_alt, print_debug, "mgmt-alt: ", NULL);
 	}
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
-- 
2.26.2

