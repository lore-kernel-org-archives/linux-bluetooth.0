Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DCEC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4662083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GifaBBpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIQHL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgIQHL4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:11:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3EEC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:11:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d19so658520pld.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+EJCB6WY4TQKa6gHOsgkF94rPPA4eTIhn24gfOv1nI=;
        b=GifaBBpuFjX6X7JtyOKmFFoqpi/bkFkXctb0DyH/7sa6RMIdidXGyEsi+rmFEJjtex
         hwb5Jb1HppE6dzM4Ubm+z9kcwRsvr9kGtbcwpGp6CfgbvHnAbxn7OgsIcPCqDmGw35sY
         Env5v8nZ+bLw41rFERYtE73ucHAGLirZro4PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+EJCB6WY4TQKa6gHOsgkF94rPPA4eTIhn24gfOv1nI=;
        b=Bs2nWNo4WyyohMcw0aQUiJC60+q4f1BRGI/Wx3jvvz/fIXQBccLIw3gXcIuLtYYwAc
         UzUMODAERaGureS3+6E6KEOyAMgf/Or5j2rYYZPXZDZNnPcpxxP/alTOQbvK8PiaA6Kf
         hyoJUCSVV+ku3EpPS6D5Ej8l2Q5fpJidqdfU5jzz9IKYgircfzO1bIhmt5RprS7I+/lF
         mRSf0gOLe8DtYn6UYZWYhQM1kyZ2+XYJm3nXUosmuKnYSZa6ZK/HgD+8T5WfFAYfQV30
         /ufegCDuMbJgCGA2Rluj7pDINAgTNVvZYItLUKIW8OR1LQoccQahAqlQJUyYfxMvN7Sv
         L/zw==
X-Gm-Message-State: AOAM531XzsswXyvhTn96foq4haLAlXLaBCzJumJvXOYuHMJn4p5lltQL
        WOG8p8R1z08UKmHANnF7GBZYwe8i2Lp7eQ==
X-Google-Smtp-Source: ABdhPJyboupGRuOCEHWaXxCA+qSGVvSbuCz87tNmakvoM8fvm+Bz3X4KW0p4CnNlu6QObrd20GG+lQ==
X-Received: by 2002:a17:90a:9103:: with SMTP id k3mr7247981pjo.4.1600326714960;
        Thu, 17 Sep 2020 00:11:54 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id j26sm933478pgl.91.2020.09.17.00.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:11:54 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 7/8] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Thu, 17 Sep 2020 00:10:43 -0700
Message-Id: <20200917001020.BlueZ.v4.7.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

