Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC14C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846B32078B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3AM/fAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgIJEiG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIJEhf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:37:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733DC061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:37:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a8so297953plm.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTPWYPs/pjfsOoexcMwgn/tJlgN2sDx7AxjUE535+Hc=;
        b=a3AM/fAEvDT9fjJrsUlYOmHaBfNbDK68CJ0TIj6TX3aEOxmcT4w5ABZ12U9Tv1WC0A
         HxgOZNMjwZIwZvRVBGtEILVSsygcU+p1QeMiAZvNMABrH/l6rmdxUJzadp76WRdkN5bo
         gTKon61Vv6G0jVa+/vN3OArrZLaEEenU6F1f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTPWYPs/pjfsOoexcMwgn/tJlgN2sDx7AxjUE535+Hc=;
        b=XZ5N3Jd1sCMWLOdQHoKC+GpNNY7UQdH1Uqe/NARuUyEsJpMJiYiBexnPQGvs7lBfSI
         AR9QH3a34CGvqI6IjEASRq8xUXNlJBXv+qEmFeF2p8/srQtpOU6dMy4w8NN7p6zilJgm
         JM9BgTYwafjDDDITBivZmxpPhchj6taaX73lLB1YhvDc+7hX+iGUntOB1IhOpakOPh0D
         xQ+ETqzh/uAtdq16/1LAIBJhZ59mi+d4CKVC/gzWtPbq78z0uI5dvKwmTRrxtN9J5LDh
         LomyCgUsKI7UOiaaC86l8FD0NxjAj2C/01COF/CyIDR+ncPm6kK2cJHsN6RRUMrBzKxe
         abdQ==
X-Gm-Message-State: AOAM5306CBrJD1vBP7BD2dSuMM5FT5pazBIQGk9gCghNzrQXH9jx8tOz
        fCNb3Qt1keNwUtX7PotcKN411jtccVoVfA==
X-Google-Smtp-Source: ABdhPJybrvAeQhhlWBWpKUugjFJ87Etrb9+dC25d/Tj0QTZSg5hFXimg+6YjY7n1AVPXLMQmOeAXEA==
X-Received: by 2002:a17:902:bf4c:: with SMTP id u12mr3686542pls.97.1599712649397;
        Wed, 09 Sep 2020 21:37:29 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y4sm4149820pfq.215.2020.09.09.21.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:37:28 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 5/7] PRE-UPSTREAM: adv_monitor: Handle D-Bus client ready events
Date:   Wed,  9 Sep 2020 21:35:40 -0700
Message-Id: <20200909213423.BlueZ.v2.5.Id5b1ced1530cb21559bc1dcf29d8764b0c7df825@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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
index 1a38e6994..23fdc9b14 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -124,9 +124,22 @@ static void app_disconnect_cb(DBusConnection *conn, void *user_data)
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
@@ -151,7 +164,9 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
 	g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
-	g_dbus_client_set_ready_watch(app->client, NULL, NULL);
+	g_dbus_client_set_ready_watch(app->client, app_ready_cb, app);
+
+	app->reg = dbus_message_ref(msg);
 
 	return app;
 }
@@ -196,7 +211,7 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
 	if (queue_find(manager->apps, app_match, &match))
 		return btd_error_already_exists(msg);
 
-	app = app_create(conn, match.owner, match.path, manager);
+	app = app_create(conn, msg, match.owner, match.path, manager);
 	if (!app) {
 		btd_error(manager->adapter_id,
 				"Failed to reserve %s for Adv Monitor app %s",
@@ -207,10 +222,7 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
 
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

