Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69F86103B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhG2I5W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhG2I5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A4C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i15-20020a05620a150fb02903b960837cbfso3409415qkk.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L6lNNaSX6qQORZqT2VoBUMM9LUS7LaDIzlSN+vZ3p6I=;
        b=c73T+KCVvuO348nhl1ZSt2/M1lCRZ8yIF2Ercba12KugbybD+4G1jn4sfxf9hAMgeU
         Ws+zf0wo2VHbdoZdJm0XrVLKlEbsjLbQ3ZaTvlZEjjHYEKL5BzipGPYds0N6eO+j8cPg
         /L4KI7EL7PsfgxFRIRF3DFIpHCHl8An/yHx9YEGtHkfvnVLaB9mcwUwVULs2hAeVpQ3y
         I0rC0JkXsWcUICD54b9Q0jDOWoUmcm+HocJ5d5R0zBeXu3Om8kvQPiFH7a55pSpBl+Xo
         u51BxWvMSVmhEek6T0OKerWg/swkOHWfAyG5cZMV74RLF83qTfqDaTRIJ4VxPiTvZGV2
         I6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L6lNNaSX6qQORZqT2VoBUMM9LUS7LaDIzlSN+vZ3p6I=;
        b=Z/apjt+tSO6rkDsRsUy5NMsd5GlJ0T1XuPLvlzSzG/zfpiJHXOj6oJ9uv1Dv5zlwtY
         LDCNAoEWL9Kq5XBblJKqX0+A9t4XNEtgDX8ePTw3Nl51tSDIDNUiZ+yDgk/C/zrHPCGr
         1TAk0pehvUKVQWvX4Pa+66MXEpQfmDwatCB+WE35xXKIRNfwvjyzz++hS0e3RN55cId4
         C8CIOPOctArL8ZwLlZQfbYAgQYSGKw69HLzYJxA6DLuIvMi6HoFr08TwL7o7Jm3j3mAw
         g+80Bq0tDLNv2mqj97t3f8xarjG5k9MzAExAH9NPfOb/b7Bxy8BwFxGkixxLwuL5iuro
         aeDQ==
X-Gm-Message-State: AOAM531aAI+6fjFJxgu3DTONMdJOJQM9o/SSIRzvjRR9eI/Lh1P/8VRh
        8C/sseuga13DSHujB/GVYwZRXnoYRrxX11qbSOcLjXqU2ymgrM9EYWfAt9E1gDYNFxBBecJcywF
        /LZm0e9QTDXAJ2PjUyGxzNoLeckGNOCoqhHZik7fX9ihNfaagiEM/qqDhMw/SyjWAU6hVfPbW4v
        QJ9eqcQhOo0SA=
X-Google-Smtp-Source: ABdhPJxugD664Mv+Sbmyn5dY+fChi5d4GBQQm8Wfg3/NPNyF583+PFKsCdVGXitmZ6clnLXtQ/7hZyPu9+7iONiqOg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:178d:: with SMTP id
 ct13mr3945724qvb.22.1627549038116; Thu, 29 Jul 2021 01:57:18 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:42 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 04/13] core: block not allowed UUID connect in auth
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
index c7fe27d19a5d..6c8096147bdd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7118,6 +7118,11 @@ static gboolean process_auth_queue(gpointer user_data)
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

