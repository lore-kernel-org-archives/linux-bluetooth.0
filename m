Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988BDC71155
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 03:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C52422203
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 03:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgLCDry (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 22:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLCDry (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 22:47:54 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B163C061A4E
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 19:47:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x20so527670pfm.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 19:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jKE1fzmF+1i6YEqkOcdAvk/VjuKcJZEF7TWgZDzeRlo=;
        b=eQy3b8dngbaYYpnvVxTCYLE9hUW+QkrA7SQzZYb30yFvT68rvfVNdT7ts+nG8TXreJ
         il8TYEKPmu66eilJ/pF6ahJ05uASTldcOFhbqxEdeDb2V3FPKNh3TStWHCXS/2HKTpjs
         /Zn15XA9z2GGdOnhteurrxluVI0SBF3uk6aGiRwd4JCD5RyuYcsf7t4ftNI234X3V4fP
         zApXtoJgbhARyP2Lg1Wgx5kp8Za7CUgd1+Pci/znbbx/zSCGuExG7J1g99j8mCtLkvkA
         W81CAz/XpUNniHCyHTcgKH7YADWqT7ebqqOJ8vn/jnV1rC3r/wEPPyGaG1we5BYNInvU
         PDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jKE1fzmF+1i6YEqkOcdAvk/VjuKcJZEF7TWgZDzeRlo=;
        b=gsNjgqZe1VO+MxDDgCq6XcJp9QnZlP9iok3kRuyFoD7d7RVrTCzzEH38Z0i2Dr6LgY
         LQfDijEYPKcbOafWXtmaSjeTGlywz7l83tW6e/me2MD14WlfbDb+np7pA7X9wuyaPZjK
         FJrkOBlkKWXcnc/+tyIG5wwBqnIFsOJrfugwNvuSzd5l0VmsyrKiw7/P9b6HkCML4yRR
         gMkAXs3xT0pLn8VQvHejBClXKZ26sxZQyqTMeQNaVr7Ld1zYeoNZ7u1/VH/lJW5ft9IP
         S4Ws7Xyg7fXGr3r4Ax1s0zGcfhewOzD2P6KNfxASd27OWYAU/SjBBRwBfC8xYDVX21JE
         8wOw==
X-Gm-Message-State: AOAM533i5WTham4F+GFNifCAeLL8u8QhtodT0MwCv5DGbhgsrMNvCUus
        Ta8idApTcM9zPKWNaK5380kj1pfgFYg+aw==
X-Google-Smtp-Source: ABdhPJxl0kNDdZBJ1+zNs/Q9O2/dGDMzRElOnZAz2IbR3iY6/XM0MR+V17fL7d/EuLUquGeD1weybT6fcM6SPg==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr507561pja.0.1606967233700; Wed, 02 Dec 2020 19:47:13 -0800 (PST)
Date:   Wed,  2 Dec 2020 19:46:52 -0800
In-Reply-To: <20201202194547.bluez.v2.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
Message-Id: <20201202194547.bluez.v2.2.Ic1f25ec863fe218390cfbe5e5252f787a4475d3b@changeid>
Mime-Version: 1.0
References: <20201202194547.bluez.v2.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v2 2/2] client: Use correct root path for RegisterMonitor
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, sonnysasaka@chromium.org,
        mcchou@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetoothctl uses "/" as the app root path. So, use the same
app root path while invoking RegisterMonitor method. This will
also ensure that InterfacesAdded/InterfacesRemoved signals are
emitted on the correct app root path.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: sonnysasaka@chromium.org
Reviewed-by: mcchou@chromium.org

---

Changes in v2:
- per discussion, discarded gdbus library changes and fixed bluetoothctl
  code to use correct root path i.e. "/" while invoking RegisterMonitor

 client/adv_monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 8e81857af..f62e9f444 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -270,7 +270,7 @@ void adv_monitor_remove_manager(DBusConnection *conn)
 
 static void register_setup(DBusMessageIter *iter, void *user_data)
 {
-	const char *path = ADV_MONITOR_APP_PATH;
+	const char *path = "/";
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 }
@@ -293,7 +293,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 
 static void unregister_setup(DBusMessageIter *iter, void *user_data)
 {
-	const char *path = ADV_MONITOR_APP_PATH;
+	const char *path = "/";
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 }
-- 
2.29.2.454.gaff20da3a2-goog

