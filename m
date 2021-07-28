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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED366C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D3E60240
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhG1NQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NQA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250AC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t101-20020a25aaee0000b0290578c0c455b2so2766697ybi.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7edK40cZnbgtgLANdMuyepBsOSk6qB2TDi4Pn5PpTyw=;
        b=Od7MgcumYt0KOUlJyJNmq8fACOSs2CE+5j71UFOU/YCvZRTjh/WG0k90PAw8fan+L+
         pmeL8jt7WPH4q5C6bovT/69PzzflxMKX9U7Pl0Fw1Yb1TAVG/vGjPPRxUP3ANuvfi/JU
         YN1MerMq/st7FY7307UtTQdgewq/MW027eIJVlQUQ5vfl1LHnHtBkulN7YQs9dPnjA13
         QDN7/DqGEd0PEMlmw4keBAkadI+U66AWwvxCZrCsxW50l28hvLOc9wGUId9tJES50Phh
         hqvPyvNVXii15GZG1K0oVLsWqtmqHMi87SeuKay1cHaWV+pUhicD8IU60bbRofh2vvrD
         M7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7edK40cZnbgtgLANdMuyepBsOSk6qB2TDi4Pn5PpTyw=;
        b=WJcOXeeyP5NaQQoVj8YFFdwdIE3fYp4ngdt5X/I8XAHeA/BxLOBgeEKYJv0PmR8gGB
         11JvwavucwekkOXO12IMUNQJP2zv7RbtEKX0esqEbP5GfR+Tcq68ue2eADVcdAScfZr1
         xSFEbJVMBfJsBDYnfqcHgxBlgRuovOzY08zByjToHsDgBTNUwp+jbYjmajxUD5WUWpz0
         qSOnkuZNGM9zn++Py8cLWMzkvhv6HN1wYwGX6Su/m5aIWcBLSwypcWpHhy6bR1eQWGCR
         N8yuLutDkb3Q98xsverwc8OQaQfOwd+YcNnmOg9P1L7/mByG5+Ynh1lZ0MnZcMKJY2dx
         gxcg==
X-Gm-Message-State: AOAM531cvsfz82/+ZM+38EF3wu/Gt6RFS8xFmujNhIeNEmtZ9G8yTUtp
        z6PexEU0X/U7I7k7rcx6hdcQ8zONkuFd/tZgYXhWyYIgAzTxIe+5OOujZZYS7CZaJoSjmqXTUTa
        Jpa71o1oq11GWtfL1dfsc+fIX7MxbZpFFzh4z4kvdHK7zqo7TUs3eVkYQGf7IxZWVqg3HRzpvuJ
        TNvUrbtSsg1W4=
X-Google-Smtp-Source: ABdhPJy4UiPsH489nUk4utxwlfE5YzwcGjm0+wPKt2SeAbGpsQftg+S8Q+NKdYTWMBMtT42LonJEs3Q/QmSeReJDLA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a25:d1c4:: with SMTP id
 i187mr4813620ybg.200.1627478158415; Wed, 28 Jul 2021 06:15:58 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:20 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 04/13] core: block not allowed UUID connect in auth
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
The following test steps were performed after enabling admin_policy
plugin:
1. Set ServiceAllowList to ["1234"].
2. Turn on a paired classic keyboard. Verify it can not be connected.
3. Set ServiceAllowList to
   ["1800","1801","180A","180F","1812"]
4. Turn off and turn on the keyboard. Verift it can be connected.

(no changes since v1)

 src/adapter.c |  5 +++++
 src/profile.c | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c7fe27d19..6c8096147 100644
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
index 60d17b6ae..58500c747 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1249,6 +1249,11 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 
 	DBG("incoming connect from %s", addr);
 
+	if (btd_adapter_is_uuid_allowed(adapter_find(&src), uuid)) {
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
@@ -1285,6 +1291,12 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 	}
 
+	if (btd_adapter_is_uuid_allowed(adapter_find(&src), ext->uuid)) {
+		info("UUID %s is not allowed. Igoring the connection",
+								ext->uuid);
+		return;
+	}
+
 	conn = create_conn(server, io, &src, &dst);
 	if (conn == NULL)
 		return;
-- 
2.32.0.432.gabb21c7263-goog

