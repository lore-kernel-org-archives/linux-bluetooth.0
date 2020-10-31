Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9DC00A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4A7208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gxPM4jB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgJaAy7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaAy7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 20:54:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131CC0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:54:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a3so157741pjh.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZl3oN00arRcB58FBKAJ5c/slPFqplS5wnLF/UKMxhY=;
        b=gxPM4jB/KDfsNp7nG1JfjGSV7C4YlJfdE/xqs8+BtTxTUx71ehfLKviJWoAYM6hhNe
         +5qXdoSVQVPf+8A8w6/QRhZvbgO8Z/nwYnYieyPCHQXxLjmTVLxaO2tXK3QZwYbbBxXv
         Wk0WKWey2KBpPK/RMEu2QY9VhZBSWE6I8QuUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZl3oN00arRcB58FBKAJ5c/slPFqplS5wnLF/UKMxhY=;
        b=ZouHNc13nbFp/QRGylqwiIl8rX8D/NLdDnGixGvNCLeHg4IfsLHZEwaPdBBYrvw1K0
         fvuTlK/nhUPC65DAis8AJ5tVVFqrC8fEKamerIpLoNRohYYELA2tPg3/8WiDUgQ7Laww
         GQ/cWIs4A0iXXLdhto1b+kVjqpzBRk6XndS0OUGp8fXeQha9FGnDBzo7DXRyDkSVxgZJ
         nlj+LnPRfGfeYhDeYlMI6x+QLCkKyGY0fCHfHtGbzc36EujQDc0+78q95k5gITdm23Y/
         VGjUlxylEHrM8qbCoTHnWq1Q4hsFcs+DJjWKt4lOAsoFAFRSKOxjlhHllGh9HE4pdQJo
         cUjA==
X-Gm-Message-State: AOAM5326AjT5aTGDmRz8n39Vrpbl25Fyg8gDSRvSC1ocW4t035YV5ATw
        jSvKN8SawKF7p4jHcgtCksrBupwx2cer/A==
X-Google-Smtp-Source: ABdhPJzUu2Xx8enU857WMjcBo66SJNxdZ1uM4OjcWsJdVPHXGer6amLTre1IrHeY25jkHvl8k8Dtlg==
X-Received: by 2002:a17:902:b111:b029:d4:cf7c:2ff1 with SMTP id q17-20020a170902b111b02900d4cf7c2ff1mr11699802plr.59.1604105696857;
        Fri, 30 Oct 2020 17:54:56 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id p22sm4394292pju.48.2020.10.30.17.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 17:54:56 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v8 5/6] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Fri, 30 Oct 2020 17:52:54 -0700
Message-Id: <20201030175219.BlueZ.v8.5.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
References: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
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
index 9d2a400a3..dbc3b2a92 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -694,6 +694,8 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	app->monitors = queue_new();
 
+	app->reg = dbus_message_ref(msg);
+
 	g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
 
 	/* Note that any property changes on a monitor object would not affect
@@ -705,8 +707,6 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
 
 	g_dbus_client_set_ready_watch(app->client, app_ready_cb, app);
 
-	app->reg = dbus_message_ref(msg);
-
 	return app;
 }
 
@@ -800,7 +800,7 @@ static DBusMessage *unregister_monitor(DBusConnection *conn,
 }
 
 static const GDBusMethodTable adv_monitor_methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, register_monitor) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
-- 
2.26.2

