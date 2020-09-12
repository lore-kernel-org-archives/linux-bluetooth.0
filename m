Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9598CC43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E891214F1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2BUGv4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgILGxH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgILGxG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:53:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF0AC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:53:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z17so230737pgc.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLAHje7mxdYZVFhm6OOBd+D/Egwin3uGosM21JIKgVI=;
        b=f2BUGv4XG8xOly4EQ+suED7Nxz1XFP4+LsAdkLCHV1pMPS8Xaqey/L1mJl0xc0vVtx
         o8igdXXLZiNQ1jE5dN00chMa+I+h5skznJcDib0MXMeLOGYbNsidXX9q4wHUPXebMIuR
         q2Ko94Alt18p4mhOTtzssWOMZSFzWfiYhyPjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLAHje7mxdYZVFhm6OOBd+D/Egwin3uGosM21JIKgVI=;
        b=N7FsGO1JQcQe7mqvLGJmIlO+0M6/HOAu9zCZ2M9pVkfgAsxLiAIL9ks7iwdeJEY68J
         wLKHFPnO+8og5KPtvE3uVRDfUN9mysPkh+ki5DpmT4x/wguZ2L67/9dtLlXP5rzWz5G0
         SCUZkQZr//tutoFkRspqTHfGyiyLmscvHxwkt77BdY+CuFR2SyRhd2h1zwRdL5y7PFUy
         PqCQDFBcKFiieIJkPw8tYPYA0MaqacDck0OLJ7Qr2ebt8eTndSfS42F16Ugvf8K0D5gG
         +usj+Wt0Vz4LUd1G1DVh0ujzsquYuPqe9/dl1D6m40UzZqjHWJPM2S1cqNhAzbmS8MEb
         Ymxw==
X-Gm-Message-State: AOAM532fKKjo3ZCjYmBsLPp0dvRn6PEOwGvmiDfcnn0B6b+zMKStsImS
        XjxfAt+/YYu211Q7KpD1x/yLAEuOOAY4yQ==
X-Google-Smtp-Source: ABdhPJy7dl2yoraHrrg6dnNgElYilg9VMJSr/2OwWaqvuQ7Lfqubd5EjNUmXxSp0VCZsPmolJVlDoQ==
X-Received: by 2002:a62:17cd:0:b029:13c:1611:652b with SMTP id 196-20020a6217cd0000b029013c1611652bmr5413095pfx.11.1599893584795;
        Fri, 11 Sep 2020 23:53:04 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id hg16sm3440913pjb.37.2020.09.11.23.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:53:04 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 6/8] adv_monitor: Handle D-Bus client ready events
Date:   Fri, 11 Sep 2020 23:51:29 -0700
Message-Id: <20200911235104.BlueZ.v5.6.Id5b1ced1530cb21559bc1dcf29d8764b0c7df825@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
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
index d9c5c7262..b42a47b9c 100644
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

