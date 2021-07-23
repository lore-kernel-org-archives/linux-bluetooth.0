Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE14AC43214
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9120060EB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhGWNSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhGWNSY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 09:18:24 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7891AC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 06:58:58 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4GWWBm73sYzQjBM;
        Fri, 23 Jul 2021 15:58:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1627048735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqbpAGcd49pYp2w1BblwMuGhH6qZvIOz8MUBv68fiFI=;
        b=XWOIHfK50ZuWtsUPtewXJcr2UiikzFGHrroXaeT/OvMP1bF3LBcvuQ1gFgGj/hpxwRCiBE
        bWWQQiPEEy9Ajw3Ate+jeCU/MASKWi5D7ARA6YOR26JeV9xyd/a7hBsMuAL60pZDGT/s/w
        b9oMzZs5wykf7PvdDOf5Qyb6TXAfvOdmox57nD4WKaO9DTJafgOe6Ioi1WxsgeVKqsNMhE
        K4YmI2UyL+VgrH45BzjOHRFiyTMc2Q2Mybh8gmIgM7PIHFXby0ZOZXHnKo6u2eFghFt8rl
        k9RsSkWAc8eNsK3P6WxHATfLqG9ooxWjxxrr25r9xYz0y0QpO3n3CXw133Mcug==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id SvvYvM_GF8Cv; Fri, 23 Jul 2021 15:58:54 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Hannu Mallat <hmallat@gmail.com>
Subject: [PATCH BlueZ 4/4] obexd: phonebook: Set default apparams for PTS clients
Date:   Fri, 23 Jul 2021 15:58:24 +0200
Message-Id: <20210723135824.8032-5-me@dylanvanassche.be>
In-Reply-To: <20210723135824.8032-1-me@dylanvanassche.be>
References: <20210723135824.8032-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3976918C6
X-Rspamd-UID: d8e3da
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Hannu Mallat <hmallat@gmail.com>

Some PTS clients do not send all the mandatory apparams
when retrieving the phonebook. Clients such as car multimedia systems
cannot be fixed, therefore working around this issue by inserting
default apparams which makes these clients work as well.
---
 obexd/plugins/pbap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index efae92cd8..ab5236316 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -511,6 +511,21 @@ static int pbap_get(struct obex_session *os, void *user_data)
 		rsize = 0;
 	}
 
+	/* Workaround for PTS client not sending mandatory apparams */
+	if (!rsize && g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
+		static const uint8_t default_apparams[] = {
+			0x04, 0x02, 0xff, 0xff
+		};
+		buffer = default_apparams;
+		rsize = sizeof(default_apparams);
+	} else if (!rsize && g_ascii_strcasecmp(type, VCARDENTRY_TYPE) == 0) {
+		static const uint8_t default_apparams[] = {
+			0x07, 0x01, 0x00
+		};
+		buffer = default_apparams;
+		rsize = sizeof(default_apparams);
+	}
+
 	params = parse_aparam(buffer, rsize);
 	if (params == NULL)
 		return -EBADR;
-- 
2.32.0

