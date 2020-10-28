Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B78DC4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C074D20791
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMmZr8zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbgJ1XI3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgJ1XHu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:07:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65387C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:07:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 13so723188pfy.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZl3oN00arRcB58FBKAJ5c/slPFqplS5wnLF/UKMxhY=;
        b=BMmZr8zqE5f3ko1+ErUYbvvE1qPZ/3mkwTJIjnfitTxPzQiQCc+zu4KrOdFet/yN5S
         NkZ/yyJlWhPCzpYK7HxTjqfiYT91meILHuLdWUV8IxoGBlZ0OAJeEheFLXWXc9rWt3P9
         Rn0Ojsmvt3Iwq8ylhVmXGGIaP2Ecb6kcNcOT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZl3oN00arRcB58FBKAJ5c/slPFqplS5wnLF/UKMxhY=;
        b=BsExcHJ2lrAFjKdPfLxukAoc3g5UCngiiHW87IRTxI8GTB9omSYzj4OaIlLIkXQ+Vc
         MXJoB88vt2K/IUprIwyBElPcV9vlyg7U7aYACfEimmcAzMmIFN7mHi1rrhpH8BpgXbPo
         y6pBUm57eO5d1qzM/kmowV7LG3rdU8Qp8a4DyroQvAVUPzvd6FENK8gZ2BU8VZV+8nMS
         dk/EvTjO60P1+ly0qA6lTZNF0AuWtzt1vGBh2ZUZ66icexrMmOT+GzdF6/FbCjb3Xrim
         ZgBBCligjn/O0RYDV1tU236NFCAJMwlVOXgtSAC3gw/U9p1CYH42t1KlmslOAq0fDcrD
         2cSQ==
X-Gm-Message-State: AOAM532tvzCuDOXkiVQRGjBk49BtveQbEVnelviafgK41Qe/i73WWzCu
        A5sOAO+tj9gv13leKbf2bmZPWcJ+HxEs+A==
X-Google-Smtp-Source: ABdhPJyCQHiTTYL5SfnDvlx6RN9wRp+xwdn8cQi5FX0fO4oCtfJjalWkFhsPb2IGPAG/mTk3PC7crQ==
X-Received: by 2002:a17:90b:16c2:: with SMTP id iy2mr1176971pjb.172.1603926468313;
        Wed, 28 Oct 2020 16:07:48 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y137sm644134pfc.77.2020.10.28.16.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:07:47 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 6/7] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Wed, 28 Oct 2020 16:05:36 -0700
Message-Id: <20201028160433.BlueZ.v7.6.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

