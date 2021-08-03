Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA0C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9621960F70
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhHCIX3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhHCIX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:29 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58338C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:18 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v15-20020a0ccd8f0000b0290335f005a486so16732010qvm.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b/tp9qPc1ZnMdrHLzMJAUnrnMira869jxfHG/TPZ/u8=;
        b=eX5g7CI39Yw9dOOJQ4DBbU5Y7XVHQmIo9DdetNyjg92hvJoDBF5ZafnJEERW/TPsEt
         0fBEY328lttlok2KW/B2bMXBpiGJFWE59oZ4oqPIxpHGBAvyt3WkaPidTrYHZq5RHpEs
         lde9UwqFsCL7gDrx3HePTFWGZlSK+MUpA0EWzoabVsf3yHdYlDQhPalLqZPun1d/0OJg
         R1FAw9bUhQgN4m6fHWFujH62pVauHj2TbF/SN7p5735UQcQZeaU5W+jYoH7FWD4bNqN6
         msU+1R6ZPUiv8xibeqprexvU9wAp9b+8lLCRUd8Fcin9QZzZrHYOof6/vO8pQhCtW8HI
         pKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b/tp9qPc1ZnMdrHLzMJAUnrnMira869jxfHG/TPZ/u8=;
        b=YowYXpuQ7umHL2BFWENXnn9/7BKQ8oygMuZnbG0k63ON/gRWrEzo/kD7OsUJ7pOMoe
         gb6cR+p1fh1/5FUogzUmc5ly9cvAnYTBjvXJT09gmoME7+VcYSSyQC/2DshhdlJt7E+A
         B+hdWKHOsVJxQAbN8UsPb0uio5EqPDKd69bX109598zbXxBskmSqNgshMzBG89d1n5sY
         B8REaiydb1qE4W52m/s+pdHo6zxtEWwfrnJY4d6tmvJmyNwsemRaAhp9AZT9ItruNAX2
         VGATspDinoGET+G0Mi4KsrXeNN2rMokCZ5Asmb+I8IOYm4yCCxRXX8z38JC/CDjpRwPE
         NVmg==
X-Gm-Message-State: AOAM530PjS8jdcx+dAo9pJohFzXPYpgWwJNccZpFnQt/P+LncZO2MkmR
        hmq90arzvO7tvWXbYhM4bmhsaVIVvBt89yAEQ6h2X1YzgU7O0TNWSb0qHyjXil8BiWjJk1Jm4an
        IGJxwrGXhe5LdQQ4gOALi1mLf4j/H1GWLIlcCMkhza9SLaUgQA12Ryq7r3EwF6u+2cM9NP5AbQV
        ZFLaMquKf4zs8=
X-Google-Smtp-Source: ABdhPJzhQFPshVIQXq4fgs7L5cEL6i1vX/TWl28nnrspMONtjI4r+8IXcH8VWF8jw0aTHLLCU+vXTHhvwgPbBQzSeQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1bcf:: with SMTP id
 m15mr11584530qvc.62.1627978997338; Tue, 03 Aug 2021 01:23:17 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:28 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 04/13] core: block not allowed UUID connect in auth
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

