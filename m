Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536DC636CE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2FD613DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 12:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhGQM60 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhGQM60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 08:58:26 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F95C06175F
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 05:55:29 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4GRp4J30DBzQk4Q;
        Sat, 17 Jul 2021 14:55:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1626526526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJTd8Ag9AUA/DUCMCpCYgEYp2542ROreiuRyAbhz4MM=;
        b=ZnHbBY/VL4RjAFJU/wLTKjL+57Rd3L8f3Cr+CehCJNFZShgbAWi0S544V7m6Ji0ekTjulo
        EEFu7dWhnFqagcVbYT1bOhjjAc5raqrsWBds+NgsvYNZFqWKZGzO2+TeLUhDRwgv4nq3Zy
        iL56G8Vtemf2Lyn1CYwQmpp2FO3vgu4WXTwjzKnzrici9K2UV+IFBOxpkgYb8RTToWt1Jx
        r3xbSfVJzsx39W06qmNyQ8hK9vI0e03sXK54qIKkCQduj2dj6UIIA1CBBjSqA5nEOwYOb8
        BA1FV2Hikozkk379QI3tkEtsInExkx0SMT50u6K7xsiF0poG5uIG1BHtMaoFIQ==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id BXX4s9RunaIY; Sat, 17 Jul 2021 14:55:25 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Hannu Mallat <hmallat@gmail.com>,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 4/4] obexd: phonebook: Workaround for PTS client not sending mandatory apparams
Date:   Sat, 17 Jul 2021 14:55:08 +0200
Message-Id: <20210717125508.29186-4-me@dylanvanassche.be>
In-Reply-To: <20210717125508.29186-1-me@dylanvanassche.be>
References: <20210717125508.29186-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 569F81819
X-Rspamd-UID: 43d196
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Hannu Mallat <hmallat@gmail.com>

Some PTS clients do not send all the mandatory apparams
when retrieving the phonebook. Clients such as car multimedia systems
cannot be fixed, therefore working around this issue by inserting
default apparams which makes these clients work as well.

Cherry-picked from https://github.com/sailfishos/bluez5/commit/e8001df26e1964ddb98d02ad27ab8f909ffe2f17

Co-authored-by: Dylan Van Assche <me@dylanvanassche.be>
Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
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

