Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E31C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C30520738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDyr+hTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHRW3G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRW3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:29:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31521C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:29:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mw10so185944pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kYl3apIlbG/g27MOuyrarzuC+I9/z+Glt//16VTKr8=;
        b=MDyr+hTKeHX+9bEbrFKqHv14MGjhH8fCV6ff+VCyP7KRYFehLvnlCcrSxQ5lWSUaEX
         hOBxlSUwQsx9glNzrysXWaOqjwxMTJv6UYml4Q0LZaehFcQx7SzxzmpkfDPNaKhFUi8C
         HB9L9Rs+yMU4AA7xFY5r5mL0KPFyO6FubWE3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kYl3apIlbG/g27MOuyrarzuC+I9/z+Glt//16VTKr8=;
        b=rYkmiCFXKyUvz1Vo2m4vzkEm0Yx89UouQm60ZbDDquH8JwO+ZU4R5HNeG00RnSZLSN
         ngnOOZm5NhUZpW943KV6idirC3TNhuGsick/tI9lijm8+1r4u0AJLt04vgA09fPqczV+
         hlh/dn9O2c/fGjaQpWXdnyFh908P3zURQEdLQnxPsfIyOmOJo2HE8tpvBjnORcx0Bxy6
         z+h6D/pyaJdIWvnhlEZ4TP22BYpQvZgaawE24zf4tdHA3PgJtSS1xDHJq+UD51nRyg0z
         XPMwMMQpohFzN/kdyw1smfTg8hUp6GaxbGqWcDpaCZejcHq9SehGi6Ly/Pqy4K/JuUdT
         muQQ==
X-Gm-Message-State: AOAM530AoZ04qIUf166aEXV3GlM93UBTA8URtf89Vd3Q9+0GcOWJFKtq
        noUYfGyW3PeHfb1+A3I7HA5cNcpxmkOhxA==
X-Google-Smtp-Source: ABdhPJxfO/DzC94MBjdQi5OaizMKSZfBmvdk2rjDc/in+NWXkACuuiVmURd7wCY4E/KQvwKn4cWI5w==
X-Received: by 2002:a17:902:d907:: with SMTP id c7mr17367789plz.132.1597789744345;
        Tue, 18 Aug 2020 15:29:04 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id mp3sm14137286pjb.0.2020.08.18.15.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:29:03 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v1 4/7] adv_monitor: Implement UnregisterMonitor()
Date:   Tue, 18 Aug 2020 15:26:41 -0700
Message-Id: <20200818152612.BlueZ.v1.4.I335e42ab9a238261c2492c308ce77c959f631483@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
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

 src/adv_monitor.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 3d27ad18b..a9e2e4421 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -216,13 +216,48 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
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
 	{ GDBUS_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, register_monitor) },
 	{ GDBUS_ASYNC_METHOD("UnregisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
-					NULL, NULL) },
+					NULL, unregister_monitor) },
 	{ }
 };
 
-- 
2.26.2

