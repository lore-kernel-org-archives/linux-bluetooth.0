Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14DC43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE38C214D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zani3H6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIQV1e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIQV1e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 17:27:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4969DC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:27:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s14so3346272pju.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+EJCB6WY4TQKa6gHOsgkF94rPPA4eTIhn24gfOv1nI=;
        b=Zani3H6VtsaUJcruJQsYMYEOUqG9tZpNV+x9+oLeYJcY5Hl8dlvq3dZCk2+ttcr3DA
         +x2Bk87hhK9mv7eNUjJRSAyv0mIl/MAzcVpHuGVfSa/MZEDSGOEF+jrrKel4kTk2EcZd
         UecOW+uxl6T4UeRQZ/5/NHxTl6QjaBu2N0xPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+EJCB6WY4TQKa6gHOsgkF94rPPA4eTIhn24gfOv1nI=;
        b=X+XsbwpCTY1WxrDDMzi5WhpekhJrNHwc0VCLynmW99b0kbeZLWQCuGuga5Rq1Upk2M
         yB7+jMX6i/yAbMaT+KHX9xYA8KYUoshjy5zUCY0BINqMNyIebMbj5X9l/yjvI6ZG9HUn
         BWjecKmvLNAmXRmCgN1Cia/YxdsC4EOaHvzyBF1BDSFlH/rG/MKwCtiiTQLCt3lel6os
         WkSbEaKX7mjKCIQ+DEtmvA5jsSGJ5u38HCuL8NGGoIfYgvWHK4PRfh+U8RAkmhRoTkIF
         kKMF7tIsSaakh0cjnq94knmO18iC4gfcwHtJ7G+CQ5jlt9oAPqUUJxEaGHG+rA+Vjdgo
         /CMQ==
X-Gm-Message-State: AOAM530Uh5UctAfkdAAVb0EUwvzGrECezycr9dJpblk1Fym58W/ZSwka
        xE4AhN1Hw+cpu27Y0Nm4cO1sqpGMD2guNg==
X-Google-Smtp-Source: ABdhPJwZwZK40sLv14d+Pa5o2OW2rKyUXFrwhqwx/dqOCwA0fE9szlX4rR6MSLneDZVl7Swt7fhx8A==
X-Received: by 2002:a17:90b:208b:: with SMTP id hb11mr10315623pjb.201.1600378053358;
        Thu, 17 Sep 2020 14:27:33 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y3sm645308pfb.18.2020.09.17.14.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 14:27:32 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 7/8] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Thu, 17 Sep 2020 14:25:41 -0700
Message-Id: <20200917142456.BlueZ.v4.7.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917142456.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917142456.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies the D-Bus call return type to be asynchronous for
RegisterMonitor() method call.

The following test was performed:
- Enter bluetoothctl, exit the console and re-enter the console without
AlreadyExist error for RegisterMonitor() upon bring-up of the console.

Reviewed-by: Howard Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index deaa1894a..b4fe39eff 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -758,6 +758,8 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	app->monitors = queue_new();
 
+	app->reg = dbus_message_ref(msg);
+
 	g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
 
 	/* Note that any property changes on a monitor object would not affect
@@ -769,8 +771,6 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	g_dbus_client_set_ready_watch(app->client, app_ready_cb, app);
 
-	app->reg = dbus_message_ref(msg);
-
 	return app;
 }
 
@@ -864,7 +864,7 @@ static DBusMessage *unregister_monitor(DBusConnection *conn,
 }
 
 static const GDBusMethodTable adv_monitor_methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, register_monitor) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
-- 
2.26.2

