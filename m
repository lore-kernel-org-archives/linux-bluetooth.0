Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C41CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BBF610A2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhHBGNV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhHBGNU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B6C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v71-20020a252f4a0000b029055b51419c7dso17971281ybv.23
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L6lNNaSX6qQORZqT2VoBUMM9LUS7LaDIzlSN+vZ3p6I=;
        b=ddkLMzzNl3oi3sd5UJx1c7+EXItedK9/+8CUUNGsnphjIWU7+Nhitaxv+FfulDUD3X
         qFOem8iviLclDogPvc5Tk1UKO4COECPtcj1yri2IDOoUSbgVjMcGYhdN4bCBZ9sfM/g1
         d6hPLw77jqxDYAVRVgn8MRn9fuetwIoMZ5G4jWht5IsSA164qQUn4hwvQejyQfpSyy7s
         3Om5Wy8JfrUPAQ4GEZqrRpNtqs79+RFPMQBpDHvKj6r1vYel68zoRFPEf7oUF4jwjtii
         zcVV3u6w3FoimzUn9HkBM18bKQBZMZNw/oOCgM5L+9JVfgJJMeg7Vn5/GAkYcJ6xvr49
         ztaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L6lNNaSX6qQORZqT2VoBUMM9LUS7LaDIzlSN+vZ3p6I=;
        b=hwMNKlwk20aAAQwTl74JY5/b526IfzOi3BOgEeHNV82Z3nfXvsqvWhZ1s0N9EuHNZN
         f0mpi1V74uyBon/kks8/0eWNU0DUnvIfXkXTuOT2DYyR8yXpvuQ1NqvfXKHs6ZgvRpG3
         zSALWY8nwInYN6gJS3sOs/OKNQ6w2MXArXauMYKjaCXSMtngrehfEb93RagdM0MO3wzP
         voIYEuRTLrrAT5XuY3/8zXuWoaxPhwtratL2/RQryE+I6wC0hh5x9yOppcg3zxKWABo3
         1nahumzWq/kxjypHianUUh6Lyo0kTCe4duxcHSnT/UIN3EJ+P9q9dVeyTu3rEGVF1z+a
         InRQ==
X-Gm-Message-State: AOAM5326R6nubrY6X1/PzYNRIWBJpav4STFkYOv22VO+N0M9JEm+gVKJ
        zEaj6Qsn4ugWyXM03N6HUCg68mwm7/crK6QGLM1Az6MTV5hRJmMZccwYiaTD30SoigIITmpkM2b
        3aO7oYf/akTIJNk56SgifpDXshtppwdgd1658Vb8wqZVLqbP1cd6opX4GBNIYk78NMsDQf9ImKV
        6AfSs5RcpTWZM=
X-Google-Smtp-Source: ABdhPJzEi2reB2QkvRgXPspCDMxn06vRFSQNnLuHJbCRdmzu1xM34ZD7AntW2N9QgHsdrGYLBOWUxDXBd6OFTj6f1g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a25:af81:: with SMTP id
 g1mr18498936ybh.172.1627884790844; Sun, 01 Aug 2021 23:13:10 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:41 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.4.Ia4dc489979e4bf7ffa3421199b1b9fd8d7f00bbc@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 04/13] core: block not allowed UUID connect in auth
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

