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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EEEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1703C60F59
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhG2DNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhG2DNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:13:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D02C0613C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g11-20020a25ae4b0000b02905792fb55b0bso5361914ybe.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G5IamTG342V1nmPJafUnZ8zf6U37HSJ+F3rr7RIrFY8=;
        b=TZ3q/cgA8wCUkrUtapDLp0xgmERoagirdoL3gCKQ/dbfYK1xEzzKy1SpW5gemKkyPe
         nPKL2y8JfUIbfJep4QXwAzjZuO3MWbQRios0Ww9EQaTf34xwtuX1llahDNwp8+tWF8e7
         rQnOde9lOGBmNY7vP6ig2llNoxr5ujbICAVf22ggXIm1k6XT9BBDfuH3TOzwysmRFkZV
         QwUk242GFb1OIYwQOJ4hWPO3FzP53Cp7aSCSUij78Ifin2TXiPHOwT7mNI6bxmKWbIZl
         zo6AdPTWPrHBLLkzVl9oWqBGUX/FwPg0FRZTlmjTwUiOD6E7rMl861Z6PalX719i2a+P
         d4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G5IamTG342V1nmPJafUnZ8zf6U37HSJ+F3rr7RIrFY8=;
        b=rXbvJV/y9h8hpAYM6HwwH2qX4xdbuHmUQQOIc5eapsK2xq/0GF9oUG10Auqh49aAuV
         o11toHa37o+ebJSoicydbbT0q3L3TkJWcLN9Lo3unKwlZLXYS0vkf2Fvjw/EKulfa/Oq
         +0fS/mFeIoDir1Vdrw51oX52pSZDHOJzHAQQcW3ycVBnyNi7SScjllcfwz17//NPgq7x
         lzFXpdB9AfMXRQ4dAbTXnpN7t2Q2jRSoJXjVuXxjMYnyqZ0+5SLv0P98rylp7XhyqrQl
         ulh2frXoYj9vZ4Dhbddo3cBSzh5ms1rs83Bdv4d1/pJcbb1aeQcGSfL7oQoKDYiwCCUD
         Z7Ew==
X-Gm-Message-State: AOAM532Gw9lXYvz2e3zVFIrQpD1vdMvmkyG3selGnJrHplYJH74ge9AD
        SHJOUQgFzYYnsPzK3FNczXXizTKj6Z+QivlPazgHeU1h/EVIdx6qGYZDE5FeJbvqzz/YROo3nNb
        sGRdpUYrFpXIJAX8tvzomSW+PSAuZKnB5ci6saOkvVG5RpEA/e4ukoPFWj1M0CMVQ7te9tyTJid
        +YU4UHZ/wGJmE=
X-Google-Smtp-Source: ABdhPJxio2ALnxr7WRDhCQGpIm7d10tj6VjOqlXzxXBaAvFx7Be6mjJuwWiVhYlM2HaGWFmF0X42plhKcPgptYSnYA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:28a:: with SMTP id
 132mr4147120ybc.458.1627528424277; Wed, 28 Jul 2021 20:13:44 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:50 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 04/13] core: block not allowed UUID connect in auth
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
 src/profile.c | 12 ++++++++++++
 2 files changed, 17 insertions(+)

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
index 60d17b6ae657..58500c74746d 100644
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
2.32.0.554.ge1b32706d8-goog

