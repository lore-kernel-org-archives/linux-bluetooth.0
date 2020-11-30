Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A914C63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 19:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE99620789
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMjYl76F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgK3TSh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgK3TSc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 14:18:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EF1C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 11:17:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id hk16so181035pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SYJMHYivYOBe3I8S1oCXC0rYn7YnzODKOMSrd6ug+k=;
        b=SMjYl76FMJNZn5VvWYrC/32msl39mY7nrmrQKRNmWy7TFTtjpMsa4LCALG2bMCqHFk
         uhCvxtmj6pJdGp0c9NqydxcTx/gIAD/QtU3z+7hEuVowrHXz1qgMBI4H57Y6qrsPpjZy
         pmfy2+D5OHAXVg9egCMMC7tpPG5Erzby9chAoVO/pv1m14ionwVs61edkqr+P8AuPCzQ
         0jNz+vJe2IWBHD4ruUuiXxyqfqU6/2sKoIhmIadsZdH6lcd1AvhITi0RrTVL8zpBajAK
         3kkTq+spXzdqmUJFTSyLIbcb5d9SnBNnAjhjR2qpC9YgSg65az6c7G0F6X2nBpbMlJ+N
         IO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SYJMHYivYOBe3I8S1oCXC0rYn7YnzODKOMSrd6ug+k=;
        b=fUWG/NexJx9gj1DaIv6YVdnNCmhu+A+MKr5YzdXYXss3PyWmElMMRVTEsL/N6pWUbg
         9ifTYlD1TWwVOnl8FWqzKp85TbOzx2byQmgdeKUigXI/+QxJK/cBTPYG8YERE2+A6XoD
         RQf12dylO3y7uFsURHKjlw6P7Zygs1jrhcH/dRxTEEXnXDfJy2eMTpiJYUzoEQNcMZur
         koEAxeVE4mKHbYEwslZ5Ep7u7VH8Aguu7XaD0zLoj9JxwFqkgHeaku/vTfOAj4ctLvUO
         bkx/GK8HIHeBE8CbqQvmyZMrusifj7w1uU4FfZ+qWuuKIB6xOGdP45AlSgbbLDqS+Fb5
         pPrQ==
X-Gm-Message-State: AOAM532wu8HBH3/kNG9pjhA7UNrYl6w/7HCZ5ZHiqs9ApFxI0Fg6EKr7
        1VxDzjfoV9JGkuK4zf7jg3HPvdvhGKM=
X-Google-Smtp-Source: ABdhPJyTUuBRMzqPvxWyK/HhbYkPHX/r1/mer83ZwnswSn02tFo982FQzQ2KTSg0tOQ5kjZO3zGKVw==
X-Received: by 2002:a17:90a:d307:: with SMTP id p7mr343612pju.214.1606763871609;
        Mon, 30 Nov 2020 11:17:51 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b21sm199590pji.24.2020.11.30.11.17.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:17:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix crash if setup is freed while reconfiguring
Date:   Mon, 30 Nov 2020 11:17:49 -0800
Message-Id: <20201130191749.1663518-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the crash reported on:

https://github.com/bluez/bluez/issues/60
---
 profiles/audio/a2dp.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f1e4fa990..a333276e0 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -105,6 +105,7 @@ struct a2dp_setup {
 	gboolean start;
 	GSList *cb;
 	GIOChannel *io;
+	guint id;
 	int ref;
 };
 
@@ -207,6 +208,9 @@ static void setup_free(struct a2dp_setup *s)
 		g_io_channel_unref(s->io);
 	}
 
+	if (s->id)
+		g_source_remove(s->id);
+
 	queue_destroy(s->eps, NULL);
 
 	setups = g_slist_remove(setups, s);
@@ -1166,6 +1170,8 @@ static gboolean a2dp_reconfigure(gpointer data)
 	struct avdtp_media_codec_capability *rsep_codec;
 	struct avdtp_service_capability *cap;
 
+	setup->id = 0;
+
 	if (!sep->lsep) {
 		error("no valid local SEP");
 		posix_err = -EINVAL;
@@ -1202,6 +1208,20 @@ failed:
 	return FALSE;
 }
 
+static bool setup_reconfigure(struct a2dp_setup *setup)
+{
+	if (!setup->reconfigure || setup->id)
+		return false;
+
+	DBG("%p", setup);
+
+	setup->id = g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
+
+	setup->reconfigure = FALSE;
+
+	return true;
+}
+
 static struct a2dp_remote_sep *get_remote_sep(struct a2dp_channel *chan,
 						struct avdtp_stream *stream)
 {
@@ -1238,8 +1258,7 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup->rsep)
 		setup->rsep = get_remote_sep(setup->chan, stream);
 
-	if (setup->reconfigure)
-		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
+	setup_reconfigure(setup);
 }
 
 static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -1283,10 +1302,8 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup)
 		return;
 
-	if (setup->reconfigure) {
-		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
+	if (setup_reconfigure(setup))
 		return;
-	}
 
 	setup_unref(setup);
 }
-- 
2.26.2

