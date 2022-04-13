Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B6DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiDMU5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiDMU5g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7966A42B
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j129-20020a252387000000b00641e1faafecso1104086ybj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ToBf+7mtBanEu81Kg9w4akkrF/i1NSYG5hBhnuGKQfI=;
        b=nlhzqlMaI53SN8ujbr6O9lAl2xeSnl4iwnVt+K/5nJoRK7vdd34lTEgJWEPtPqVeqa
         NHg2EE+ScwzlcytKYMrLOnYt03S6//3Lxc+lWLegpNSD95TCIHME/NhiEcowKSXOVYJY
         N71ek2dSdjGNyx4+OWGb4VhSzrD/blYY4RL+KIapRX7WpoE8StPZhuy1fpP1DbWAYgQa
         sJ2mXN3Iw+5sAxp2Wxs/3BDuScMiTP0yVsyYPvespuBPNf8oniOyCVwuhhEp/QkiaMRq
         2TEkqgggdKLK3NrhEe0tRXJbPuxha2yQ1vQwa0wTvumBdhgjJWtgKvavtaw7yXMKIfus
         YzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ToBf+7mtBanEu81Kg9w4akkrF/i1NSYG5hBhnuGKQfI=;
        b=lCp4lT7Ee4MLWpfqsaKXYVrwHZOP3woFcX9SQAmLLZUz52Lt3b2OCb/DI9yYtTpuFs
         DUG9PC4bp3nv+q1DNJ8HACHkBiw+VXI46ogUHrpUW0lRW8x10yiVsQom+nPHuUzLVYwc
         MMw0W/b5nksAbDfhLzBVEebFXWLCKwy9Ap/02dH+00as0ctqdK3Qg6KfDUZjRkzGGejK
         OCh4CPVjmXfKPK6wybwxkkF9GiBHvGxetdqi9Z9FdeFIWH1NssfoVCAkjs4S+uRGibN3
         P5ElLcRpME0TP77HwRDbPLANd48o77rTT8mfNhh9iz1lSvvrVhspwoAb4shy/Ia1KuO+
         oPrg==
X-Gm-Message-State: AOAM531jqW+LG/FE3AhqLx37leo4IDOayO9ZLZwUpXJvVXKkcyCS/xlv
        01hGZcQ1d43UmHqhcKbP4u3yUOiDtEb1TA==
X-Google-Smtp-Source: ABdhPJx6imY2z0QJrVBt365Yz44cWodYhKfD538t6pIEzurhHf87S7zjIozfZ7AENN7UH864gpGe8yBHOlRVgw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a25:e78a:0:b0:641:dbf0:5027 with SMTP id
 e132-20020a25e78a000000b00641dbf05027mr653844ybh.242.1649883313691; Wed, 13
 Apr 2022 13:55:13 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:48 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.8.Ia97a9544495c94781c0391c0ec5a01273a278d18@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 8/9] client: Display the AdvMonitor Release reason
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetoothd returns the release reason when a monitor is released. Read
the release reason received as part of the Release event and print it
using the bluetoothctl.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 client/adv_monitor.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 792379fc4..6ee9d2b42 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -72,9 +72,13 @@ static DBusMessage *release_adv_monitor(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct adv_monitor *adv_monitor = user_data;
+	int8_t release_reason;
 
-	bt_shell_printf("Advertisement monitor %d released\n",
-							adv_monitor->idx);
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_BYTE, &release_reason,
+							DBUS_TYPE_INVALID);
+	bt_shell_printf("Advertisement monitor %d released (reason: %d)\n",
+							adv_monitor->idx,
+							release_reason);
 	remove_adv_monitor(adv_monitor, conn);
 
 	return dbus_message_new_method_return(msg);
@@ -117,7 +121,8 @@ static DBusMessage *device_lost_adv_monitor(DBusConnection *conn,
 }
 
 static const GDBusMethodTable adv_monitor_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release_adv_monitor) },
+	{ GDBUS_ASYNC_METHOD("Release", GDBUS_ARGS({"reason", "y"}),
+			NULL, release_adv_monitor) },
 	{ GDBUS_ASYNC_METHOD("Activate", NULL, NULL, activate_adv_monitor) },
 	{ GDBUS_ASYNC_METHOD("DeviceFound", GDBUS_ARGS({ "device", "o" }),
 			NULL, device_found_adv_monitor) },
-- 
2.36.0.rc0.470.gd361397f0d-goog

