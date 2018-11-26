Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB55EC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D54B20664
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku57ZuRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D54B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeK0DTY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:19:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36044 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeK0DTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 22:19:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so13997980lfg.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ot85p1DqlAnB7QvjXGobLVk4h0+Ls2fZucMjXw8baEA=;
        b=Ku57ZuRckIkyq6HpLbEaggEVk63ApHtLrhanH/3jOA4wWo2WsxdPa62UG6HJ2cttIk
         8umeGG7yNWwWfG+B+YjzB+rhT8DMA7nL60KQkWgnybQ6Oyj9q+lMBgzopOKFflCWHa0+
         QBmygNYFW6ZdI8DdyrxqqTrKA8Xy21r8dk3z+neafs5Fm9D5l9jUWbiZvKvalmsWXstf
         BVJOHb1TF4RzX6vbWSVl8ybRa5C+VSbbwTZuLIHbESmhvGYwgVZTY0DllhHH8WInKnCh
         OO8y+cYt0CiHJkwvG33GAhZWWe4ymYOpOc0R4GsDwSNzroRyMeXminlB2WnAcC8MoZi5
         i4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ot85p1DqlAnB7QvjXGobLVk4h0+Ls2fZucMjXw8baEA=;
        b=X9hyhZvp1PT1j+3ItIE33Vyfcvm7tu9sU5v3YPHUR9Qul8CPB9RJdl+Roz1X3cw50l
         38VczshLS1Eo/kmj4ShRcWd3Gqh0XSaRIfisEzTYTJMNP+GDJs8wAfnh+tq5mxVZzHKu
         CCjJzDS93QihGrO/+tzaAswmE04SoxnmesEfYvSxGs8Wn6kEgtgndiZs+Q3OXam4QSL3
         08sJ94XjkTXAoRCu8Jb1kSjrzkOpsedGjhEiThX15DgY1fR783hy8pNulVgGTW0FGsZW
         ISXi0VI+QXPdgzpnMbfotgtJ7Qt7dcY3RVret04xcAtLvmsBPxWnHPJqEbXshqKsOjKb
         V5sg==
X-Gm-Message-State: AGRZ1gLKQMfRcmrfspkqzn0w29hYrE/lUCa5RkEqN+Aakn06NcuMZIbV
        o1kNDOqEUzaeUAx6a7k+r71Blz5x
X-Google-Smtp-Source: AJdET5dfJNHQcNT9xaDI1aRQfsvtkKK9PmlTIYpcNncVHSEi1f8O64RUBJei3wg7gPmr53iXFg3Z9A==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr15636622lfe.127.1543249487414;
        Mon, 26 Nov 2018 08:24:47 -0800 (PST)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id g70-v6sm120787ljg.92.2018.11.26.08.24.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:24:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] shared/timeout-glib: Check 0 id when removing timeout
Date:   Mon, 26 Nov 2018 18:24:38 +0200
Message-Id: <20181126162438.27872-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126162438.27872-1-luiz.dentz@gmail.com>
References: <20181126162438.27872-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the id is 0 that makes it is invalid already.
---
 src/shared/timeout-glib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/timeout-glib.c b/src/shared/timeout-glib.c
index 4163bced7..fd71ca430 100644
--- a/src/shared/timeout-glib.c
+++ b/src/shared/timeout-glib.c
@@ -71,8 +71,12 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 
 void timeout_remove(unsigned int id)
 {
-	GSource *source = g_main_context_find_source_by_id(NULL, id);
+	GSource *source;
 
+	if (!id)
+		return;
+
+	source = g_main_context_find_source_by_id(NULL, id);
 	if (source)
 		g_source_destroy(source);
 }
-- 
2.17.2

