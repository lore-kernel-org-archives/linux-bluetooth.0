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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25442C00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB3C223C6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQb24HA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKBTMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA62C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:40 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id k9so9923598pgt.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=p6zFEWWjrbnIsNveDFpaCjXAaAfiaBx/ZmPp8bu4Hvw=;
        b=hQb24HA3tSpCKfnpxOXqxizsIMsGDSNKUIUifnBKUuHkZ58VXDqXirLuaEBB7lFFiG
         nP1eStdD7K2cdqss4J5kY5yn7ctRe5SWM0kYX7XEQQ0B8lDCWLmWcajWCmUeMzQvnOLc
         OIQKo9k3PbAKD9jV9FLf0+ShrotV+kALP6PS5pDYfet0GZ8CUJn5KRX2NDEnGk7h48gf
         XEuwvZsRNORk3/MF5Sxd5sVcBDynRKRee+qR0lIH8gh0ss7Ko1cUEUhxGI0dufKsT11V
         ey7MNgzOT9olxvJoVnErmqN/0j39XrciN208yRapurQHRtgKGztkxXIDAcz1JIJnqDOa
         J7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6zFEWWjrbnIsNveDFpaCjXAaAfiaBx/ZmPp8bu4Hvw=;
        b=PzvLLhVIqJR7Tc56wrxF5SsqLIb8zD6qYjMB2f47cY1psO6/fTOtjP2eCNp7I5L09b
         p2WveIqfjXMl5WE4CgVMGqQbvGh4QShMOhlkdwT2mlbzSEEwVqjqWfKcxlfoOUXsq2OT
         ZPaprJ83gxL9pH8CCcGTHO8Ew+1WKFnz3mI+3gJ0WnfDbRxW8JEAlFuCSaZIu9rXhBv1
         5HOzoqSOSLHFVZSPH6SqsjH7BdplmeZjNjw2mWWdHgBAU8gyLCzCK5Znesery5cv2x8Y
         Jk4LulThy+fSjDwwI/cUGoa+Ek2J3JHHbH8U5n7i+fYyNRzzxDiHNkjYUeeeLUrTs/Kh
         4l6Q==
X-Gm-Message-State: AOAM533Vc+OK8kEmeDqTprJs3NyyHElDvPJUzOZRXwd14tqaSeWncL6e
        e0LzdIZrBuRMeClOgWlTX4KnBr1GNmDwng==
X-Google-Smtp-Source: ABdhPJw3646l6h95ky9/GEETBWP3hz22VOnlZ9mSGEG2LjzG8O9685gNawwIY4fC3oTCCCPop/n7Nw==
X-Received: by 2002:a63:5c5e:: with SMTP id n30mr14280998pgm.54.1604344360011;
        Mon, 02 Nov 2020 11:12:40 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/11] tools/l2cap-tester: Enable hciemu debug
Date:   Mon,  2 Nov 2020 11:12:27 -0800
Message-Id: <20201102191232.1848737-6-luiz.dentz@gmail.com>
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
 tools/l2cap-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 42d2b5615..ff641ba1d 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -85,7 +85,7 @@ struct l2cap_data {
 	bool shut_sock_wr;
 };
 
-static void mgmt_debug(const char *str, void *user_data)
+static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
@@ -190,6 +190,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		tester_pre_setup_failed();
 	}
 
+	if (tester_use_debug())
+		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
+
 	tester_print("New hciemu instance created");
 }
 
@@ -205,7 +208,7 @@ static void test_pre_setup(const void *test_data)
 	}
 
 	if (tester_use_debug())
-		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
+		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
-- 
2.26.2

