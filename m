Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D30C004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 07:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3836820C01
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 07:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Tv57ur/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEGH1O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 03:27:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38152 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGH1N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 03:27:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id u21so4216534lja.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAidHhMzBZ+iM46CKWucyue860X6DkNYcd9Jj/R+8JA=;
        b=Tv57ur/GuwVDUH4QWnpkM4mQI2xKWyhRy9x6aJiKr0zp9MXwxWiG9xgGszKwaEwzHO
         4FKRUKQwDRTlnbqEhEUzNdbbwIC3YhbaeXgRNl0Qx3NEkZP2DsS5tJ0avoRgxRhpNLlU
         AnO+D7IfUbyiEwbbZBztR7Qf3mUWSHy7IsJ4DrRcfAxcio54fhLJ8GoEH0CPH296lk4O
         BLNN1ooqcowg+3cBWDISakvRoU+WRqPl5Zy47wIdVYO6klTuHWD/qqhu/l70tQn/9gyL
         mNPBRfaaKZIOseRLsZUO8UWNICMcAEQc/eUFKcF92Vrc8vLpC1REPf1DNrRBnm6yhbQv
         3xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAidHhMzBZ+iM46CKWucyue860X6DkNYcd9Jj/R+8JA=;
        b=ITMkZxDhqXEiptYOqlgDA2dzMOpzY8Agei8wu/6JrgrxBqSoTwAy/xCiln7vTsZyKL
         1sIv4HaXSGQoXelFFn9mDRsPrXhkpgiGei74EGGv9oDNBYJ1wLGSuYpVxoLaUZhiziVz
         Znovo1YuYlAmn/2QGLGk6ozFAzKbAqs/XDkAI8G0uvPwRSVwRRn85nogid9lBTCJCTN5
         TVhO2r8G567c8AfNYPay3EmwoAt5sxKd3huPmKBjmAryQmZ/W88mzYDOFNeKWmkP6I6M
         cXgvLxB4CFh7KNYsF4FlstWhxC3Ykh3ozteQkdK3Ew2/8lEZCSTpWqLM6+SxXstLK/LG
         e2aw==
X-Gm-Message-State: APjAAAUaLwnRvf+LxFheB/Au8Jwx3X1+6ECIWucUSC/dnJphx0x1N+Fq
        H6GAd1aCH10SgpshqgXwU7t3BIS1cRt38g==
X-Google-Smtp-Source: APXvYqweElzHxFmCp1ueXw9hSJmi1mR1XdhBu5N+twI0Jewuah66HczgjZ85qW4H7WSQ7DZkzkuNZA==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr16480825lja.193.1557214031392;
        Tue, 07 May 2019 00:27:11 -0700 (PDT)
Received: from scytale.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id s125sm1621964lfe.57.2019.05.07.00.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 00:27:10 -0700 (PDT)
From:   "=?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?=" 
        <jakub.witowski@silvair.com>
X-Google-Original-From: =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakub Witowski <jakub.witowski@silvair.com>,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH] mesh: Fixed log MIC usage in segmented messages
Date:   Tue,  7 May 2019 09:27:02 +0200
Message-Id: <20190507072702.27144-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Witowski <jakub.witowski@silvair.com>

Contrary to the comment, implementation used a 8-byte MIC even if this
generated an additional segment.
---
 mesh/model.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index a632d80e1..0b3ea4094 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -40,6 +40,8 @@
 #include "mesh/util.h"
 #include "mesh/model.h"
 
+#define CEILDIV(val, div) (((val) / (div)) + ((val) % (div) != 0))
+
 struct mesh_model {
 	const struct mesh_model_ops *cbs;
 	void *user_data;
@@ -451,7 +453,7 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 
 	/* Use large MIC if it doesn't affect segmentation */
 	if (msg_len > 11 && msg_len <= 376) {
-		if ((out_len / 12) == ((out_len + 4) / 12)) {
+		if (CEILDIV(out_len, 12) == CEILDIV(out_len + 4, 12)) {
 			szmic = true;
 			out_len = msg_len + sizeof(uint64_t);
 		}
-- 
2.19.1

