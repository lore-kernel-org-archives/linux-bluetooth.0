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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479E4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2982260F02
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhG2M2Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbhG2M2Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2005C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso1014738ybm.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L6lNNaSX6qQORZqT2VoBUMM9LUS7LaDIzlSN+vZ3p6I=;
        b=GMCnMOCRaAO7Za/aFmII2fUUSdrjgf6nkctSrs0AV0SllUrTuFvhahUbqIyc+W9Nz4
         7ZRfxK+xIPb4SEgERTEevHRfi0lfgycgW/kp2/3LElPo0kEHNU2BFFsAsPKT7mNHVxVN
         OEBtGbi5GAdPCGWRRgcnXwrKyguqvH0bA4IafZfc3hBU+8rrZomEoHeBLOVbB0a9amn+
         O1D6BRUyZhyyNqzQ+hK/piHJeZK5LqQvWyuBAll2EYWqKJrhFvzqEp+7ZRmvvauVGUB5
         xalWOaSpMNbrW/Z7obmDGzty1HanDTB5MYKXh4M2EaFCl3ie+WshIdPPU0ieEmF/vt6g
         oNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L6lNNaSX6qQORZqT2VoBUMM9LUS7LaDIzlSN+vZ3p6I=;
        b=osK93m97Lu9jYZ6ovc8mi+jWp8mb6GAGladOd534TsKOfpqEbSKTAlW9XSU9bFxZGX
         1VYYvM/ubnkPTWd8A8oTx+eombIlR2Jt0XQGRorKtBXgqmq+YQhtF7XAa6PG1K7fsp5i
         RFCq+ODfzJxG5M4ReH5WMHCx6U3Ya3jGYW7r1nFTfGFmICJLOxgqqeE5cX6KbkUJJblC
         6CC55wknkt6z2R8j2hi/enBGILF8HgdbYftjoq7tvdGTeM00sNjK2tqFMA3hjJQeiA7v
         62KHwfQsHAGEqxxOoYE/PN0ZaTbG8efnIfwXJswMvoxDgUJZ+rUZgy0GVQQvudH7Cv6r
         v5CA==
X-Gm-Message-State: AOAM5332F8lan7Wv5Of3fJD+Fbxq2mBqVnSNePzo++VvVvwmI3u0GW2q
        VTAMolMZpevCgZu9+ewsE11B3G2gNXwAERpDqNFcT/pFANKzB5G7gkL1uLizQ5G2pY4pXxQyktX
        lU8B1OlnvSwuJdxbW0mevsPIur1UBT7kpBdpVjUc4X64ezMY4/U+Mk7kjalHnsqnHrBcyOvOb2s
        5rytKGcTMQDmM=
X-Google-Smtp-Source: ABdhPJx6OQbn7Qt8uMKvsNgIQvZYnd3zKkJR2utbw3ynber2PB2qmhKbum9LCFMho3B5YekZLzMaNX2L6hFjvqO5Ew==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:ac64:: with SMTP id
 r36mr6282842ybd.369.1627561700132; Thu, 29 Jul 2021 05:28:20 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:42 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 04/13] core: block not allowed UUID connect in auth
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

