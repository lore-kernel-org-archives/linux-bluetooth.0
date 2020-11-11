Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58379C56201
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB002076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiHl9Rrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgKLBdP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgKKXG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:06:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B680C061A48
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:33 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r186so2515822pgr.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nmK9sTU3Y2ZaVXAhCNryT5bZnp8+Duh8MrQV2hMbzXs=;
        b=KiHl9RrsD+wlut3vZGF7w3E9JYOWvjq9p4LWVH8jtyHZ2Y8xw8ZSKD2BtPdlMZj15x
         gE7sqpVJ7OzaHdR8L9ZMdjzdn7LJedUz/t09KMR2xKgNJqI7JVe6JiJUwTnaISJFyple
         KXvkjzZ3PBmTtvFD1lSr5K+EC0RQgdjRSSrtnITTi+H4FrMS5HcHvRAPqOU3dRbTDcZj
         fimi/YCEXD2RmAUicEGN/cr0WjOgyrtX5AGAlwFLK8vwzL/WjSxIqOQL03mgaHN/wJJh
         QPIbunirMItS/2dsME452Yl0HP/UbpbvOJxQPmLwlYbYHxOoOWBS8kL4gKwBZcMRtuQV
         rmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmK9sTU3Y2ZaVXAhCNryT5bZnp8+Duh8MrQV2hMbzXs=;
        b=V9BGy5zghrze4mK7rcOVns83EJKwE1Aer7DXFpoQ/oeJVWYw20pYy23oePha+Vlozt
         q2CtLShfVnMJ5U1PfOC377pA4VnaWzDWrninHnvyZ4R9OpRK6dlgBAGZRkro50ChtRbM
         U/1zKKZPfQBV2yBFyd1z+08Mw5LLnbaX+WyAGogiHHxDyQJSgMlhwVmeAtxUz1WQaBP0
         7rAXjS7BAKkEEoy+P2gz1wkbR3gayQycjsE3y40ZGLk7JvEkhwWKGTGgIVOTIsbO7t1S
         Nun0OELLPw8p0peYtTtdYDHSrxzVlMGDUoPTWT/r9QoCGYOt9MAPliEMAjFAPtuCCged
         RDMw==
X-Gm-Message-State: AOAM530xhRrOlNLzX63R1SPWiJteClRes5j0Yx57C/PX8jF+OlhrCS5g
        7kciHy93Xthutbte7NM3SRErMF2waxIRMQ==
X-Google-Smtp-Source: ABdhPJz+9MN6fSv19A9U8ZT4mJ8rPZynaF1HjfX+tsHESnb8S6haDB4VUcFrg5iKmoKi8j3D2o9vpQ==
X-Received: by 2002:aa7:83c9:0:b029:158:11ce:4672 with SMTP id j9-20020aa783c90000b029015811ce4672mr24916131pfn.23.1605135872567;
        Wed, 11 Nov 2020 15:04:32 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] mgmt-tester: Print unexpected command responses
Date:   Wed, 11 Nov 2020 15:04:18 -0800
Message-Id: <20201111230421.3364932-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the difference between the command response and the
expected command response to make it easier to debug.
---
 tools/mgmt-tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a5bfa1ce1..bb8eb578c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6315,6 +6315,9 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 		if (expect_param && expect_len > 0 &&
 					memcmp(param, expect_param, length)) {
 			tester_warn("Unexpected cmd response parameter value");
+			util_hexdump('>', param, length, print_debug, "");
+			util_hexdump('!', expect_param, length, print_debug,
+								"");
 			tester_test_failed();
 			return;
 		}
-- 
2.26.2

