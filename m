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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC37C64E8A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764692158C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgLBBVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgLBBVX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 20:21:23 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D642DC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 17:20:42 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id z8so26778qti.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 17:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pOsqAx9KPl4W/43b5WZZwrQMoJvSXKzPYsLT4nmTWgA=;
        b=XD9SZa61GnAQqQK3Mc++en5Sv5YwcHSe7c1SANnLV5XJOJJcofV7M6DehA29A5WOxK
         Vb43lkOkze4kKwO40CO/AQRo5zE7ZCjNl9sdLXepyrWcop54V5/ZLfEt1Qx3sWblu0ek
         YYDjV6ftyD0K+/ouFZUB6J8Wo7KRSzMfDoXmXxkM4toj5FwOl+jjxaJo+UEdQirPWmLo
         5vK/pXiWmuX8RqlnKXW9w+ObEg9yRM2D7k2pDb5dcoy59mOoCoXMbgsz/f68o9t3HdHN
         6RXjSiwLibTqT0g4RIzjANaJZvudOAN52SZiR7HXZYTFWRJMvIJhNXXBXDqsFaNaC+r4
         JEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pOsqAx9KPl4W/43b5WZZwrQMoJvSXKzPYsLT4nmTWgA=;
        b=BYJKS92ii/rECQg8LaSPMDfvLVWwmbXTqItT7b9KDapGrLKCdaH8v/3kn7ym5tP3xb
         JwiaSIoxuL4woYRlNHQp7A1PlWDPMcAs3Q13Um8NDuOPYOVMqrGDoATEzSUrSfNiceFu
         0ItXgMaq7pzOYo3ApdK0jZanKNxjnB0tEbUNlwYNc7YvVpK9MvkjUCJs2JMhiuiEQGXa
         2GppG9TVNvKOMQqoEybkge0TXHB1P2JRIzdsbm3tsZN6Fbfs0GsNQX+tcF2NZKrPf5T/
         7AsPtcBE2JS0BQThk41W1TzGE+zvA55YdGgcLxRelZIFzzpGR8j2GSClseA+SDM2rBST
         /VJA==
X-Gm-Message-State: AOAM530kya5oOUwbwKR4nY/vJqC3R32Wpf9dWBCHzUPl21KrJiEDD/Kg
        Wm1KHOt7mfHTAtX1yIXz25pYFuC4G6RAEQ==
X-Google-Smtp-Source: ABdhPJyVL/ypNHdHQWLO0bg2KQrnFvyngw+lNT5zbg9WYwDz9KNU7tpq7CuJCc3auSWtArEZwEFBUAh6tSsQug==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a0c:a802:: with SMTP id
 w2mr304834qva.9.1606872041972; Tue, 01 Dec 2020 17:20:41 -0800 (PST)
Date:   Tue,  1 Dec 2020 17:19:28 -0800
In-Reply-To: <20201202011930.2130671-1-mmandlik@google.com>
Message-Id: <20201201171838.bluez.v1.1.Idce75740a54d8a860450da8a7a21d55777c87ae9@changeid>
Mime-Version: 1.0
References: <20201202011930.2130671-1-mmandlik@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v1 1/3] adv_monitor: Register client app with app-base-path
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

When a client app is registered with g_dbus_client_new(), bluez root
path, i.e. '/', is used as the app root path and signal watches are
added at the root path.

Because of this, InterfacesAdded/InterfacesRemoved signals emitted by
app while creating/removing advertisement monitor objects at app root
path are not received by bluetoothd.

Use g_dbus_client_new_full() to register client app with correct app
root path.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: sonnysasaka@chromium.org
Reviewed-by: howardchung@google.com
Reviewed-by: mcchou@chromium.org
---

 src/adv_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index fc058dbf1..a5bc61c48 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -775,7 +775,7 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 	app->manager = manager;
 	app->reg = NULL;
 
-	app->client = g_dbus_client_new(conn, sender, path);
+	app->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!app->client) {
 		app_destroy(app);
 		return NULL;
-- 
2.29.2.454.gaff20da3a2-goog

