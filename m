Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E4C43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05123214F1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/rj1/rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgILGw6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgILGwx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:52:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4DC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:52:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o20so8829070pfp.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz85lM3MNsgaNxHaUhiGB5YmYwpOvI1NblLuzVVsi74=;
        b=E/rj1/rW1EwGdypeIse8DXXZycqbfWcJBU8Z6TVggfdll6OvXrWbJcGO0s6PNDrjFy
         WF78aGQTmEh3oYpqyKPlakQOOKU/xKsqCnUWQvHEKZNJxFDQW7auyFqlXdOyTICfYkBd
         I5EC/XyumkRvmdvL9U8s2YfTHA0ahlFgs7IlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz85lM3MNsgaNxHaUhiGB5YmYwpOvI1NblLuzVVsi74=;
        b=tfy17P4gI0aKBSGDgLqpu3fa3K5lu1WgPu/qiSeLxBFw6xkOzbmmJiZqkHrSspPedH
         LlUjUjGioht84StVisOypbJiWQa/It6gLJFb+AbeiPt1Fp1fhbUPaNqsqQFaEp0bygSb
         O1sLsIBq4BYSc4OD8VqoqRIlqpyEfwRZltvJFjl8TNQEaXCANx1+pbs4YMZrJ6yebR3z
         EQgLktQDqKjOey8DkcaXeZsJNRymMjkrBN9I6XTKfwwUoL0FOiejp3taqGIdurob5/lg
         gIn5ogNoJRHoJvIVf0JMAf6SWw76X2LFE0C/gg2NB7Yv0a57uTjhYcNcjrGLvmiXCJ6W
         GH2g==
X-Gm-Message-State: AOAM532H23aQV63mAssOQtEQuGWLjB0Ks+fa7dgutpzG2c5SdTeuM3kB
        NesV0z4bEOxWVOVlzWuCk3UAHy5J4GFYPQ==
X-Google-Smtp-Source: ABdhPJyNwZicRhOncWZidW0IshWhLKC0hFakxuzKsMTef8yFTp/dz4b0VZEr9VOSf4V7hJ0Q9I/lag==
X-Received: by 2002:aa7:8051:0:b029:13e:d13d:a04e with SMTP id y17-20020aa780510000b029013ed13da04emr5154821pfm.20.1599893570578;
        Fri, 11 Sep 2020 23:52:50 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id hg16sm3440913pjb.37.2020.09.11.23.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:52:49 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 5/8] adv_monitor: Implement UnregisterMonitor()
Date:   Fri, 11 Sep 2020 23:51:27 -0700
Message-Id: <20200911235104.BlueZ.v5.5.I335e42ab9a238261c2492c308ce77c959f631483@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the UnregisterMonitor() method handler of ADV monitor
manager interface.

The following tests were performed.
- Issue a UnregisterMonitor() call with a nonexistent path and expect
org.bluez.Error.DoesNotExist as the return.
- Issue a UnregisterMonitor() call with a invalid path and expect
org.bluez.Error.InvalidArguments as the return.
- Issue RegisterMonitor() with a path, issue UnregisterMonitor() and
expect a successful method call return.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index b9bffe9ba..d9c5c7262 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -212,13 +212,48 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+/* Handles UnregisterMonitor D-Bus call */
+static DBusMessage *unregister_monitor(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBusMessageIter args;
+	struct app_match_data match;
+	struct adv_monitor_app *app;
+	struct btd_adv_monitor_manager *manager = user_data;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &match.path);
+
+	if (!strlen(match.path) || !g_str_has_prefix(match.path, "/"))
+		return btd_error_invalid_args(msg);
+
+	match.owner = dbus_message_get_sender(msg);
+
+	app = queue_find(manager->apps, app_match, &match);
+	if (!app)
+		return btd_error_does_not_exist(msg);
+
+	queue_remove(manager->apps, app);
+	app_destroy(app);
+
+	btd_info(manager->adapter_id, "Path %s removed along with Adv Monitor "
+			"app %s", match.path, match.owner);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adv_monitor_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, register_monitor) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
-					NULL, NULL) },
+					NULL, unregister_monitor) },
 	{ }
 };
 
-- 
2.26.2

