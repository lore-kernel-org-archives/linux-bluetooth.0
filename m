Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68023C4363D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E94820760
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QwO8Wc6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJGAP1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAP1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 20:15:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F5C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 17:15:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so283596pfo.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWArlwbHv99ZzLIO1dJaR2h3CeomTTAhobkHNdlwLGY=;
        b=QwO8Wc6bBuxVfeC4wZguadxlFtdjLWtsDPFO+VAWRb2wJ82F7UjowJr9S+GtE5mYef
         Xa7ryNI7N5Hwwc5YtbC/HhjabiWb0eBRQO0chkJ3gs+51iyYkNk3f6GX94TZKh1G9l1E
         KZN82X8kBoU2QcLPoUA8B1Z6aQVOxz9MjpTtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWArlwbHv99ZzLIO1dJaR2h3CeomTTAhobkHNdlwLGY=;
        b=R1jo4M95CLycMnSxDXZU/tP1eGeElXG0tkO5gdZzgwMs7eT363SH3S5qsukBJyl/eJ
         /wvu++O9ZBiZgq/4KSH8k7Ig+UHjfdgmLjhJ7qdehhFPEgqPOdYvLf/2GYE8nbJUxppm
         dX96sudh77uOMyBykg2U5kAEd4BYXA61NAMN5q4mNGt05XsgLjTanOd0TcD8EbEaYjfk
         N4mK9cXBOJ5Ha17xJob8tiT/6Cr5wSNV5bVD8z0PNZqbAwzuL5Ueoz/A6JUJN09J8wN7
         PuU2FSscuyRgdEoGeuldzeg7vK9d/hxe7gj2JVH7c8sW9b+Kp0zbxctZuYobj34PxoZe
         HSLQ==
X-Gm-Message-State: AOAM532R6MFIf9IEHZfR5nzQB+pgABDNcn1l5hHOwgwnVJg8DlqeVG7Z
        eehzi1SAuwVs7sSfohD4KqKWQFbqiO0W3w==
X-Google-Smtp-Source: ABdhPJwq1nq/fc3ztgN9wLJg8HcJO94c0R4pdJHSfDPCBTtOHQAMI/R+sE7dYcuWTe9cZydt9omGwQ==
X-Received: by 2002:a63:77c4:: with SMTP id s187mr610939pgc.303.1602029725487;
        Tue, 06 Oct 2020 17:15:25 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id s13sm329722pgo.56.2020.10.06.17.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 17:15:24 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 5/6] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Tue,  6 Oct 2020 17:14:14 -0700
Message-Id: <20201006171333.BlueZ.v6.5.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index 582cc9a46..33edbf00c 100644
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

