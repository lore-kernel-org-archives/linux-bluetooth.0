Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67650C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E780207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S12pr/60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgIJEnI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJEnG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:43:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96231C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:43:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u13so3586764pgh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTPWYPs/pjfsOoexcMwgn/tJlgN2sDx7AxjUE535+Hc=;
        b=S12pr/60AGJ8cBIcJ8HaItq3gfbeKYmBPVMMHUWJp0i8mt7Yqymj6bMA4mejpAq2Nu
         fwnejG9Bb3szmber0LOaHfC6xDT0mr5F4/FZVtFanLOtEaxzuBjr+Bw6rbWOD3FwwQea
         u184kylDi07tEBhL8DZWDBdBv73xIbmlTFYKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTPWYPs/pjfsOoexcMwgn/tJlgN2sDx7AxjUE535+Hc=;
        b=uQUZx0Q0TXtHEA6LZ6GIv7q0ncRhdlLRACqr1phym1gF3l9T2DFWfW/cnwKI4TmTuF
         8sFKEjKgrilS70HRMdKcn0Rtu8EiLk8vFUeev2JDAmIJvNUn4+6bDqbkwZ60YEsWvfre
         d6C5UCWdIriSrIEU12tuGC4LJ0hkH9Mog8zh+1AKuYD4WTx0G1OuNfu5bKcq3Z4l/XLC
         /QgkakShXstDoAZ/3o/CYQhzdpaKh0geyzAYV0cYkF1AFQZwZUEtUGSYYcyZYP5BAyLI
         SmYMn3m0ahGEQQuoImNcB7kb2lbIpq/3EA/t0Cuucm25Nw9RguVTFHMN8SKv2+96wQRd
         vuNA==
X-Gm-Message-State: AOAM530yZm7oQQ6abwqoQL7cPkVpwUINJ0hKnu1ual2xYGx1lT7pSmIu
        LgolgTtjlNTdSPJP+IhiMRruUQ/tEBnNfA==
X-Google-Smtp-Source: ABdhPJy3JA7rv/2gF/ChM7cIVMenNLeB3nbt0KjYYLmnLtVKDdsPNZoDIv0Wi4PTb7rxUJltJk7H7A==
X-Received: by 2002:a63:d4a:: with SMTP id 10mr2963901pgn.175.1599712980461;
        Wed, 09 Sep 2020 21:43:00 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k4sm644888pjl.10.2020.09.09.21.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:42:59 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 5/7] adv_monitor: Handle D-Bus client ready events
Date:   Wed,  9 Sep 2020 21:41:32 -0700
Message-Id: <20200909214058.BlueZ.v3.5.Id5b1ced1530cb21559bc1dcf29d8764b0c7df825@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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

