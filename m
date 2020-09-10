Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013F0C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46E7208FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jDFj7+Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIJXRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXRQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:17:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FDC061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:17:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a9so781890pjg.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=554fiM1qbjL10Yr8XVdwM4O4WwfqkbRQmuBHrzW8EqY=;
        b=jDFj7+Ognfqh6YlXUClMycJdh8hQI1W3NpnvuDm/+srgIbLlZORBtb2hyxiZUeaMpO
         sYsW11z6abZO69sm4DlAITpfiQZYtO6Eic/QaQ4ghe9667VibpN3tIrqRFrRdfINUnpi
         nKuYoE4C8nU1Lc+cCD0bxYRHbW6bj2tVbt6S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=554fiM1qbjL10Yr8XVdwM4O4WwfqkbRQmuBHrzW8EqY=;
        b=ZdP0GC8NjaoRtvpTGJpTtObNeI7rf3erCKaQcib2NvVFbEhwv7BtBZRvdJDL0i0J9V
         3kNAiew1wMKbWDU4EUFylBf9v9TlUO4xOt0zNgNDWvw2bt7GqkoymqKQmUjOaQSal40n
         8iazbtDqR7mx2RV2PbH8zXTklYPYohzNinXSxvSkzOk4UipFcBjd7PcUW9El7axUqL7W
         r/j26HOuzfLYMntM2a8T2lrFLieHGNxQ+78Wnb/vHyJ4oLlEL3XGwQO0g/sj4g70B0zM
         InP/PKbgSZ7vgaM8PET3Q79GfeQw9FPNGnLNnD6mm6y23zaCnlfqXIcdpfKNkVQfwqLC
         ujuQ==
X-Gm-Message-State: AOAM531wE82C5NpvCql9ek0TRYmwPab8AeA/w3VglLmS0W//5/Hw0XEp
        Ir7KrCkMt6ACbIIfOXigqlXQcjqHOqpUug==
X-Google-Smtp-Source: ABdhPJytV0wcir94uRBlia9JEBXIB5N8oc88V3cPMpkq+BvMIBI5f6sopivM6H3dWSqwCCqjFnNO1A==
X-Received: by 2002:a17:90b:50f:: with SMTP id r15mr2057467pjz.15.1599779835475;
        Thu, 10 Sep 2020 16:17:15 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k29sm76790pgf.21.2020.09.10.16.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 16:17:14 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 5/8] adv_monitor: Implement UnregisterMonitor()
Date:   Thu, 10 Sep 2020 16:15:50 -0700
Message-Id: <20200910161528.BlueZ.v4.5.I335e42ab9a238261c2492c308ce77c959f631483@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200910161528.BlueZ.v4.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
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
index abc1bf228..c6c538cf1 100644
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

