Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23811C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA183221E9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgLBBVc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgLBBVc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 20:21:32 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C5C0617A7
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 17:20:52 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 9so174788plj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 17:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CpXBnYqZVf1ocOTpPEpGgiZ2rfyq5U/PDU+HX0vtfpk=;
        b=fbo5CxtSUH2N/fwJxFrh2UVjMKn5QJDUzuh3ZmkD4QFmfKwWU61U45aVciSDJT1pQh
         tuMh7+LSooMsEn8LtEE+cHFs8IOYK3oy2TuBKNZAuz2esHt8eCArCGqOvAxw2+zN/Fvf
         Dp4VzTjF3zIZPtb8/ig2jXbf25FIbWXziEQpIO9hBv7FTUrL4VvTlNHU6bKc1UQh4lKJ
         X50F+iEM9aM4wc7Q+yWfMtRYshQ04WrA8+uboS1Q3p/uAVcDlWY9kZHNiC7QEQZcENkf
         o4/u20TX1berXR2JTaH6KIIDMd/1BVaYSJ2lMZVPo3W6oLT/47dv15ho2OrhThAeiBE0
         V6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CpXBnYqZVf1ocOTpPEpGgiZ2rfyq5U/PDU+HX0vtfpk=;
        b=YIs2Ch5zx0E4R+iRU20JifjBW7OoTb0spHvWcCXzge35lp6QfH403LbCYbbIrOh/vm
         8FFdETPhT/cokCALCRNdzidHaDClEKS/TLjZAxkcvb4mdCs33dK+g0XWy8RRhRqruPDX
         M+kdfkAt8WYGDqy+mENiLTbkyj9281vfGG4LM3ycB2gMuEa4ZKGfQdJgxV0aGLcJXqFZ
         zpL57X+RuSdB5zCyKZB7b7LPr3nPDEqQXsaxLQX4XHzv+1EyH2d0MjehzDkm/hyveQnY
         SgcoG8MPGDCcSkZkQu4uiRxMeEgA5hgnWiWNtNZT+4mUkZoRb+afLNaZwGeJyUtgOpVk
         2+Tg==
X-Gm-Message-State: AOAM530pY3hIUYljC3VTs8/0edmEGxMOsHuotULWWJu0RA9hONDfbW3C
        4CQlIgo9YW5H1WaVi8xuqskoxQ1hep9/jw==
X-Google-Smtp-Source: ABdhPJxl9C4Jzxx/9BmyMUbe5xx4cVr6nqzqj9hrs03H5PiFhFHKvIUQSL+ne8E7aRyJbfflljv9fQ87Wvcdmg==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:460a:: with SMTP id
 w10mr50603pjg.1.1606872051318; Tue, 01 Dec 2020 17:20:51 -0800 (PST)
Date:   Tue,  1 Dec 2020 17:19:30 -0800
In-Reply-To: <20201202011930.2130671-1-mmandlik@google.com>
Message-Id: <20201201171838.bluez.v1.3.Ic1f25ec863fe218390cfbe5e5252f787a4475d3b@changeid>
Mime-Version: 1.0
References: <20201202011930.2130671-1-mmandlik@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v1 3/3] client: Fix add advertisement monitor
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, sonnysasaka@chromium.org,
        howardchung@google.com, mcchou@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes bluetoothctl add-monitor to emit
InterfacesAdded/InterfacesRemoved signals correctly.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: sonnysasaka@chromium.org
Reviewed-by: howardchung@google.com
Reviewed-by: mcchou@chromium.org

---

 client/adv_monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 8e81857af..1d1745831 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -602,8 +602,9 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
 	adv_monitor->patterns = patterns;
 	adv_monitor->path = g_strdup_printf("%s/%hhu", ADV_MONITOR_APP_PATH,
 								adv_mon_idx);
-	if (g_dbus_register_interface(conn, adv_monitor->path,
+	if (g_dbus_register_interface_full(conn, adv_monitor->path,
 					ADV_MONITOR_INTERFACE,
+					ADV_MONITOR_APP_PATH,
 					adv_monitor_methods, NULL,
 					adv_monitor_props, adv_monitor,
 					free_adv_monitor) == FALSE) {
-- 
2.29.2.454.gaff20da3a2-goog

