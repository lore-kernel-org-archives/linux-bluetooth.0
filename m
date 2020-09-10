Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5785C2BB84
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAAE207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/G21twh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIJEmr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJEmq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:42:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D63C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:42:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d16so289621pll.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgoIVPRWXVNntcbMbldt7TpPEHI4+Eh2hW+gjZOt2Js=;
        b=c/G21twhE3vqjwC7Mil15+hpuCfBHlF/bSWjwhf0tDlfBOKffQDVIoXoBeevLzZnOB
         ezo7Zc20aIX4bC24CtGa9p2GbHQnt407Hc/cZQTw+dv7CsoSF9A5kssGwAIbO116PsXk
         DmoP3DWMigoYyzebiew3auQpzlyxYctvkaOHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgoIVPRWXVNntcbMbldt7TpPEHI4+Eh2hW+gjZOt2Js=;
        b=lgDaBAmVwtzVAmiJOmdrj4bg4kUefRkgB1xgP0cF+bTE4YdF7ltixboUzlZ0NzBo5G
         +wljfrpk/6P2J35/+20QLoY1U1piIVryV8wYSiPPw75Vb6uLiMWnM0jz2PL99fkMGQvY
         LZYXcR7mzzt7E1J32JTzhW7Oi3gqlS0BpcnGd4ltJW+zZJ0fgM+2+GHsQOujY6bhUThE
         +ZBMdX/KEYxQMF0Y8SEs+GTQxdjKfe35RzU7EM0vHqkEhI3+2lhIWqtmU5tcUNB9FtK/
         msuBrnRqI8GU1lyYaIN/qBweDBg+9aNgNuQPYU1nheCcqwLFsDVhPITiPRj1Ay3aF2U4
         QU3w==
X-Gm-Message-State: AOAM531DHw/PT/MNtbaMGcvDUe5LdmEhNfFUIA7/6c2/HkJDWQKIYNK6
        sCh1q3Y7uJN2ulYU1u8RrZGJKoXB8lO0RA==
X-Google-Smtp-Source: ABdhPJzZgcg7AuKV+NvveWUxz++oRUMA3zuyB+nk06Gc/+jY/MqJnDYgK4e9DfVJM/4bxbSX9rmBsA==
X-Received: by 2002:a17:902:8d8f:b029:d0:cc02:8527 with SMTP id v15-20020a1709028d8fb02900d0cc028527mr3881909plo.33.1599712965143;
        Wed, 09 Sep 2020 21:42:45 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id k4sm644888pjl.10.2020.09.09.21.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:42:44 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 4/7] adv_monitor: Implement UnregisterMonitor()
Date:   Wed,  9 Sep 2020 21:41:30 -0700
Message-Id: <20200909214058.BlueZ.v3.4.I335e42ab9a238261c2492c308ce77c959f631483@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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
index b8b55d2fc..1a38e6994 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -213,13 +213,48 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
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

