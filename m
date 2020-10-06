Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867DCC4363D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 00:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405CD2076B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 00:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/GTK4tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgJFAua (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 20:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAu3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 20:50:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2020 17:50:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so8037408pfb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 17:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNRgRSderdSS3/6xE9zj19rptSYxh7kkWx+s2FGxQsU=;
        b=k/GTK4tQ63QibfmqIa43pUmMrnc6GD441aeYjV0IqJWl/jXToNZIE4audNeVDkqjhy
         gDyYXtV61vzvyqfJGY9lN4VXsENHKISZusHA/zG8AXJiJTpStcG+/K0yLsgxrR5bcrx5
         TlSXaomULkP4HJOTViJHoV/tzIROEpe8sNdBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNRgRSderdSS3/6xE9zj19rptSYxh7kkWx+s2FGxQsU=;
        b=p7ZZ1zah0w81Hd3NpeDiItWKnQGWfBTNRBMSwV9X1yOvHsglHrFvGcUlRGBh5shuQB
         7xI30DvvtqHr1fJZsV26Oi5knJEbP4bYakSKAeF7MqRO8BG7eLSnVFg5I7NCpr1RxXNN
         kC3/cXyIZ+Wn9p+MpB6+m6jo9roQjlQC7l8Ic6DGirpbXDKKHOeRkK07rP90Gq2WQsIE
         6eblWP03W9Pw27LNiwtl9K0yl2H2E+uOYxU8ihnQEOBJ3jvdE/eFYdtMIpOREQuajA6z
         1VMxqX9t7ohA/tXPtXoFZfwYSjhxdOn8kw5ZoUr9UFEEEu/xQJAGU/hqu19/zQxj8OdA
         e+bA==
X-Gm-Message-State: AOAM530OQWq2vgH4E6ojCi+UltncbY9gayDSsD6vVk23MjOErDNZlch3
        NE0rG6EmjM566Qjk9ADIQtMoMgqiZYGP8g==
X-Google-Smtp-Source: ABdhPJzQrn461FWrd6TZmoneKWACE//whoxHMrM+Xlp5SSlDqepT0Irvjealw3gycdOOQQBtnIItfg==
X-Received: by 2002:a63:e445:: with SMTP id i5mr1829198pgk.185.1601945428984;
        Mon, 05 Oct 2020 17:50:28 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id h2sm776947pjv.4.2020.10.05.17.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:50:28 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 5/6] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Mon,  5 Oct 2020 17:48:08 -0700
Message-Id: <20201005174640.BlueZ.v5.5.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index d5caf4dd3..f56c2cab2 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -737,6 +737,8 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	app->monitors = queue_new();
 
+	app->reg = dbus_message_ref(msg);
+
 	g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
 
 	/* Note that any property changes on a monitor object would not affect
@@ -748,8 +750,6 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	g_dbus_client_set_ready_watch(app->client, app_ready_cb, app);
 
-	app->reg = dbus_message_ref(msg);
-
 	return app;
 }
 
@@ -843,7 +843,7 @@ static DBusMessage *unregister_monitor(DBusConnection *conn,
 }
 
 static const GDBusMethodTable adv_monitor_methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, register_monitor) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
-- 
2.26.2

