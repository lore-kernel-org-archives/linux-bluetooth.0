Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527BFC4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B7760F35
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhHCLoo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbhHCLnz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:43:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D3C06179A
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 16-20020a250b100000b029055791ebe1e6so22761898ybl.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b/tp9qPc1ZnMdrHLzMJAUnrnMira869jxfHG/TPZ/u8=;
        b=VF23ZivbdSXYTWGC/enst2V8RDUXp+yMyWQ2hYPR0AWuA7mrN/Kt9r7X2B5ZDZzAbk
         b8pNeKodvsgvMEhv/pz5b5hlEcOc/xz6THxia0UlotSWEoJH4P5X19evJozF78k5tNbC
         re3FmkJjNc1DOBQ9RFahnhBJ9KKZ/x6XsuwdzzNXWLvLxWMzR9LNbSzd2Sy/qSKk/g+8
         wxh5ap6CSq1TZ4W6ZHSZbcTzlEndvb8w5DjPIMPygiaU12VicxBltPqhyrZ3DA7pbcP0
         6P6oP1v71cLRxpcuaToUdWLaSSLWraUF2qfMsCFE1tDrmaxcJnbQ0uBuqNcYIe+FGvoc
         Itgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b/tp9qPc1ZnMdrHLzMJAUnrnMira869jxfHG/TPZ/u8=;
        b=M/hE0urAwtH17ME5ik5Xxnvs0bxw8Icw53yqkGQR0Bq+bMgEhXrpAon03SO9P4958A
         zyhF5QMdFIUyP2u9HwRoKq0bxIbPV0L6aCITI6WNoIQfodQsno/rtLX5Wouf+icK1Xhq
         PbNhC9eSs/WegaOIKHehFsw7/oo/7bho01wIuyjZipLHjFWGxRX2AQIIu9Cun3jiH/Ev
         ADqBIh+Bf966glhm735BNMQanO2h5ek/XDX3D8Ht5yhcPoYw9KSERAnlQ6hyB81KFTer
         fTGVTQLTBUWddK3l2EMPVti7vJHeUhdHce31Q+0R1ZMA827FZ0XqrJqTVr5jpkVrRwgp
         I/5Q==
X-Gm-Message-State: AOAM533FTSH427+pAoR52BzdM0UYw4n2LDXptzyrYSrlTq8OAiTcPdwo
        kuSLvwKVOr0Gcj+cly8uYD5UAqpo5r1EJASwUA+rLDc+tPr/MQJBgeIpwewXECqF4HvhAopiaMQ
        4FXlwM4qXwbogB+VG5st/K+de80AiLvbonl2FRnk930cUnTfDyg4M2TQHX2YC6OQzonVjlwW8Bm
        e3ha23Dqvlm7I=
X-Google-Smtp-Source: ABdhPJzeqWkVg1gUrkboVkOih2ykrZe5Ug0o1IJkJQhZR3mtNKsNKiWJ+LajPFhUaMuJjX37/yyk1fwgDdcjivIrMg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:bec2:: with SMTP id
 k2mr28804346ybm.234.1627991021403; Tue, 03 Aug 2021 04:43:41 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:08 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 04/13] core: block not allowed UUID connect in auth
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This ensures any incoming profile connection will be blocked if its UUID
is not allowed by the following assumption:

1. Each system profile asks adapter authorization when seeing a incoming
   connection.
2. Each external profile checks if its UUID is allowed by adapter when
   seeing a incoming connection.
---
The following test steps were performed after enabling admin plugin:
1. Set ServiceAllowList to ["1234"].
2. Turn on a paired classic keyboard. Verify it can not be connected.
3. Set ServiceAllowList to
   ["1800","1801","180A","180F","1812"]
4. Turn off and turn on the keyboard. Verift it can be connected.

(no changes since v1)

 src/adapter.c |  5 +++++
 src/profile.c | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 0ca4b4f6ff56..3c2008285fbd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7182,6 +7182,11 @@ static gboolean process_auth_queue(gpointer user_data)
 		if (auth->svc_id > 0)
 			return FALSE;
 
+		if (!btd_adapter_is_uuid_allowed(adapter, auth->uuid)) {
+			auth->cb(&err, auth->user_data);
+			goto next;
+		}
+
 		if (device_is_trusted(device) == TRUE) {
 			auth->cb(NULL, auth->user_data);
 			goto next;
diff --git a/src/profile.c b/src/profile.c
index 60d17b6ae657..e1bebf1ee19c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1249,6 +1249,11 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 
 	DBG("incoming connect from %s", addr);
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), uuid)) {
+		info("UUID %s is not allowed. Igoring the connection", uuid);
+		return;
+	}
+
 	conn = create_conn(server, io, &src, &dst);
 	if (conn == NULL)
 		return;
@@ -1272,6 +1277,7 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 	struct ext_profile *ext = server->ext;
 	GError *gerr = NULL;
 	struct ext_io *conn;
+	const char *uuid = ext->service ? ext->service : ext->uuid;
 	bdaddr_t src, dst;
 
 	bt_io_get(io, &gerr,
@@ -1285,6 +1291,11 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 	}
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), uuid)) {
+		info("UUID %s is not allowed. Igoring the connection", uuid);
+		return;
+	}
+
 	conn = create_conn(server, io, &src, &dst);
 	if (conn == NULL)
 		return;
-- 
2.32.0.554.ge1b32706d8-goog

