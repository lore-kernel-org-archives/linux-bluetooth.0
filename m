Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74364C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0372137B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axSQUbfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIQGVZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQGVW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:21:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945DC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:21:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so694501pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfbzG45/ZVPfYtToxz75HKregAJxFeEORwOPk5JyveQ=;
        b=axSQUbfyl9x3BKPvQg2jJ3Ksay0a3BAIYeOe8Yrle7yEPBSq2vlysygzIO4jNNOE7V
         PZWHYREG/LbBBUGDAYuDctfolhRjELn7fj35SCoU+MMRokBoPAw4nJUlgbdgXfSR3vQN
         o9XrlDW2zvrGGBiOBnAucQ7Xq+J+fZACJWxN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfbzG45/ZVPfYtToxz75HKregAJxFeEORwOPk5JyveQ=;
        b=VmxItUPHTAK+FJCrtt0GqE1mypV9nYn4/XzQin7121XWR9oMzaKpruZYLK9AtIqJDw
         jNb4f4FsF+LBA9kUsrS2UaZeGpoDkJl8Yrv3/OqA7nGt72AnYqOYYagop4QKro1wjNuN
         gtr3pmLGwI1mGdLOYKAVkVBxRlk8+5bSVjt4o4z1N3FFCkNqwQwOx/jsm0iQOSPV9pMZ
         x7AwxqYINb4i9OSI6oPhLHO24TTNM5Kzdh1TTorw5YeKOkD6Xu/lr+bPweu5ggETiLI4
         +CGvdg7nZMoinLXdsprIviS5kdIvSKp2fNHTg+losdgrAjQPyTHRctutd6zUuhd+Bo5C
         DLXw==
X-Gm-Message-State: AOAM531i6uwdfkkE6j+P8kl7pfLl7DKKQmClF4nivfIArOzLzmicm3bp
        gbjKz4EUpsRDFsKX/b3RVX1NdnZPH/JATQ==
X-Google-Smtp-Source: ABdhPJzJw1cyvl6uNDprStCioRfBpLRgwLsRU164kN/g6Dl/VjaL6zhzlxbv+TtL4lhKXpZG5Pe3CA==
X-Received: by 2002:a17:902:a585:b029:d0:afd3:d851 with SMTP id az5-20020a170902a585b02900d0afd3d851mr27942255plb.2.1600323681292;
        Wed, 16 Sep 2020 23:21:21 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id g23sm19264943pfh.133.2020.09.16.23.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 23:21:20 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 7/8] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Wed, 16 Sep 2020 23:19:52 -0700
Message-Id: <20200916231935.BlueZ.v2.7.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index bce99eace..6dfb777b2 100644
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

