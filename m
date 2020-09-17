Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147DFC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD4021D41
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FF2N56Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgIQHGr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgIQHGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:06:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835BC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:06:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j34so811692pgi.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+EJCB6WY4TQKa6gHOsgkF94rPPA4eTIhn24gfOv1nI=;
        b=FF2N56PeIxVmnF0nGltOa7r6EMHha58z7gvoJwo7mWCQvJtkmgIdJkq+qLADDM1zNL
         QAkRpePyXvdBSBtA/2w8BmSnWeVuG8LpiIGsIOlD1qnMQ/D3exppan5R1XgrfGn59lkb
         QAgjQERN6iF3VsS8STtpcU9jHBMvnChdsnknI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+EJCB6WY4TQKa6gHOsgkF94rPPA4eTIhn24gfOv1nI=;
        b=Hv7RlNibDtSwrSIi/mKFfbWMZ6nN4MriVldrAviWngmS7hRrSaL2VrNUoGI/Sg2EBz
         ltKoBv/swTNqSkstWhaoTxxIVUt1sb8/o4oFER7/4Yqm7/zeoJQb25U1vFVR2IkSUYBt
         xazBpoF7CgueukZB6SsEWOKM1wCso0D34/Mi5qE17BBgKSEtRaIVvGG4M75PF9l9RHGY
         k+5ZtMTWv/Pn+jiWqkcgtq/Sw09h6snxIRMwrnocoGjQWKHcbFNln3r9tEINGjrmgJY9
         xthA6WoANhES8cniwEwVreGeiswSo1gwsM25hXbysKFPq7HPu9DB2zG+Xhe3J9yyFAh4
         ZPpQ==
X-Gm-Message-State: AOAM53204N+y8E9o7P2G3/AwUXrs5hCJJ2WZaFEEDTfuuBLg2WTRk+E8
        jUxian+U2fNhLyvpb3MZ1pU92k8/j1iBhA==
X-Google-Smtp-Source: ABdhPJxaxXAPMJwgOVtYfC2bOjtHTHJ/6SnYQZuOFUwcNEEaIlNcw06Uj8kP/FClvULzQNUARTCm9w==
X-Received: by 2002:a63:30c:: with SMTP id 12mr21539115pgd.66.1600326393586;
        Thu, 17 Sep 2020 00:06:33 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y197sm5407372pfc.220.2020.09.17.00.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:06:32 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 7/8] adv_monitor: Fix return type of RegisterMonitor() method
Date:   Thu, 17 Sep 2020 00:05:05 -0700
Message-Id: <20200917000448.BlueZ.v3.7.Ic8dbe9115e82704b4c0c860eee27ad897db13237@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917000448.BlueZ.v3.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917000448.BlueZ.v3.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

