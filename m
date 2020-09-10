Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE493C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEE6208A9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DLUP4Jqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIJXRb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXRa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:17:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D43C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:17:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b17so783032pji.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+vA4llepriglkR7TLKcIvpKkfU9TuzTMON9/uPXqmc=;
        b=DLUP4Jqm0YlmbFegDepNnIcPaFzMHYIT8vOTtZLjKy+k3PJADc0a7mEVv1EetQr2zS
         5bI80/KmS2JqQ75P/ClKp9LP4H+sZAEbSA19ARvAIVZwNO4act4u78fgKrYS73SU4vVN
         PQxR7VGut3SAMQjDkiRpHABzaNe8OBg+Q04CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+vA4llepriglkR7TLKcIvpKkfU9TuzTMON9/uPXqmc=;
        b=goUGaNXcE0FWQd47LuJk80wAJoUsuDCxs55VElPpUa67F8oE0fEm+yjAJQfdwBQs5b
         MjHQpbEgkHrNaskdNI2HxSHGHzMPxB9YFg7K1HYFFYDIMjg8rgtfQa7q/gktAExtuBfv
         Y9ooiUlLE/JBnaILd0TESd6eD3VqHpRwxc8eEfgqkyiNC/BByCAOHBal6ObLIYxeVVQ0
         OkiKtx7lCxWcrOS6kM4xRo9E1Ay03o7qG+c1ag7rfjvxqPDBRUJaIahiFAkv/N/1ZNEi
         O1sOQzj9VADAhkfnTGR2My+zYI62Q4UwDyxM8UTVgub4q1OHLViB4QJ45NEOro/g0M/S
         wdYg==
X-Gm-Message-State: AOAM533HH5Ll8c1H/ubxl2IiXL5oxf3n/CWgdf2pafChgboEj4aY3Hdk
        I3g+60USUpVsM4f/eN9Ndb6lgFY53yRshw==
X-Google-Smtp-Source: ABdhPJxZ5+LCJX19/os0kHAw4AcQHGv3tzBLXHw+RjCi5yrzcZ4MZElgvYas5ho1XAwmtYS04doF3g==
X-Received: by 2002:a17:90a:e98d:: with SMTP id v13mr2069082pjy.79.1599779849063;
        Thu, 10 Sep 2020 16:17:29 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k29sm76790pgf.21.2020.09.10.16.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 16:17:28 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 6/8] adv_monitor: Handle D-Bus client ready events
Date:   Thu, 10 Sep 2020 16:15:52 -0700
Message-Id: <20200910161528.BlueZ.v4.6.Id5b1ced1530cb21559bc1dcf29d8764b0c7df825@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a handler of client ready events. The handler replies to the
RegisterMonitor() method call.

The following tests were performed.
- Call RegisterMonitor() and expect to receive a return.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index c6c538cf1..8ef13512a 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -123,9 +123,22 @@ static void app_disconnect_cb(DBusConnection *conn, void *user_data)
 		app_destroy(app);
 }
 
+/* Handles the ready signal of Adv Monitor app */
+static void app_ready_cb(GDBusClient *client, void *user_data)
+{
+	struct adv_monitor_app *app = user_data;
+	uint16_t adapter_id = app->manager->adapter_id;
+
+	btd_info(adapter_id, "Path %s reserved for Adv Monitor app %s",
+			app->path, app->owner);
+
+	app_reply_msg(app, dbus_message_new_method_return(app->reg));
+}
+
 /* Creates an app object, initiates it and sets D-Bus event handlers */
 static struct adv_monitor_app *app_create(DBusConnection *conn,
-					const char *sender, const char *path,
+					DBusMessage *msg, const char *sender,
+					const char *path,
 					struct btd_adv_monitor_manager *manager)
 {
 	struct adv_monitor_app *app;
@@ -150,7 +163,9 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
 	g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
-	g_dbus_client_set_ready_watch(app->client, NULL, NULL);
+	g_dbus_client_set_ready_watch(app->client, app_ready_cb, app);
+
+	app->reg = dbus_message_ref(msg);
 
 	return app;
 }
@@ -195,7 +210,7 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
 	if (queue_find(manager->apps, app_match, &match))
 		return btd_error_already_exists(msg);
 
-	app = app_create(conn, match.owner, match.path, manager);
+	app = app_create(conn, msg, match.owner, match.path, manager);
 	if (!app) {
 		btd_error(manager->adapter_id,
 				"Failed to reserve %s for Adv Monitor app %s",
@@ -206,10 +221,7 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
 
 	queue_push_tail(manager->apps, app);
 
-	btd_info(manager->adapter_id, "Path %s reserved for Adv Monitor app %s",
-			match.path, match.owner);
-
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 /* Handles UnregisterMonitor D-Bus call */
-- 
2.26.2

