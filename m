Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B97C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BD22078D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 04:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hg94jSRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIQEbj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQEbi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 00:31:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7D0C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:31:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r19so457274pls.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=daf2BKPAlz2gjCKtI6e7fRoHHFts5ohWp7Y5onbVEMw=;
        b=Hg94jSRxB93Bf3QUq5EqQJOgpMoYUXxTZ4GZszy0HgFWjUy1d8qtN4CxZ0fTzlLMk8
         Ob3TJ1XzaXUs3Lhpm284ZT+hOfF2uREFmK7IhthdeeuM8P4U96A+zl1zl1mjeCM3lsUN
         mAV4xvnALEINayHu3e4RZA0zC7uhuBjpu1vqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=daf2BKPAlz2gjCKtI6e7fRoHHFts5ohWp7Y5onbVEMw=;
        b=IhrN7AnJAJw1GUnKDT3LjktzO7gdO3CqWTzuUHzB7JV35+zWVa89LOn6ruSLe8yfbj
         L6KBRx1dV2EHI0O0TzfALvd6My1ts472MpBxa4whQTbO30iIPxEW31vtzvDRdrZN+2Vv
         rRqD3yr7G9yQZaA749IgcDkwMGztChoSZJ9RXIYcIlH30B1ZaxodU3JFDSTUhfkaWasH
         G+jiWalZ5yXgRe3cEtg4n16iO23bmaGUHkgERenA5RstrskHrLH6faN3Y+UG45TJhv78
         sJmbfG1kdf4IHcRHHxdVCZj+8UXOeJxGd8qHgK7iahSpN8Rp7sVddlX5vl1gyDNF+vbh
         /B3Q==
X-Gm-Message-State: AOAM533mk4zxuvnKsBDW7eQIsKodkfe/QUBO9ZfilFkLwT6ssB2qd1Pp
        mZbXBE6s8nj1/wbO0hk90IiOJykO2lRaDQ==
X-Google-Smtp-Source: ABdhPJwlQo3pqW45z8q09vDedKqvHdnSwAUCZpaX3n6orI+wn81wenClMCJ6BAWwQQOdAxjLsiK4sg==
X-Received: by 2002:a17:902:b103:b029:d1:e5e7:be06 with SMTP id q3-20020a170902b103b02900d1e5e7be06mr9410808plr.57.1600317095317;
        Wed, 16 Sep 2020 21:31:35 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id 99sm4169562pjo.40.2020.09.16.21.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 21:31:34 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 7/8] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Wed, 16 Sep 2020 21:29:57 -0700
Message-Id: <20200916212926.BlueZ.v1.7.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916212926.BlueZ.v1.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

