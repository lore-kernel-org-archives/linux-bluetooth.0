Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56052C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbiCUBiu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbiCUBiu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E4DD97C
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l19-20020a252513000000b00629235aacb2so11055218ybl.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2nmhRNWH/fk87U5vGxnIXXLDZ1M4aQ9tVgpNuh+z2ZU=;
        b=cbDc6t1hC258uMQYWKSs/Q3hfTrdNwU5pBdSqrrppW+R0sMYf/7lLcw/GoVcriBIyV
         WkC9jUsN2jvZqn+5vDjuEvOgi+NYcNWgWc2VmdvaUeaieyl7i7DW9XsIfEyXdxbFm9MA
         IB3lMbNxPSgVFDRx1NyWoVvzx1k0VEbsiQ4+VCFj0Gy83ssL6Ep5ir6tgiy3GKPOsAUg
         A/nVYNWh5EPu0aNyzKeZueWcf7hhtsqkQ3eUmwiR7+VkJ7L2LN0n+kyUanPdDl0u1tZF
         SZjdq0uAMKRDVX4B1xUbkK3g9ogN56IeMQMpOm3QFL2XE+WEGyeeUmdHwRY6diPvQHc1
         f6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2nmhRNWH/fk87U5vGxnIXXLDZ1M4aQ9tVgpNuh+z2ZU=;
        b=mkLd8ggyE6+UaMbrzV6/YlwC8Aq1GmwzQkDO+90myWW1DzU4qSPX+j8eqop0JtbRI7
         K6yyq7nyMCOecD7wWtFFKCPJREBCAzYrHiNmOaYGShtEH8RqOUGo1tN8m6irkEaEltAo
         HbIxuqhbyysXcCeuV0umtZqCPVKPJp0ZsgGPy6hpYoXy0VWeG+UJEI6UXS7qF56bsINu
         7nzw4SNotmgu454i4wsSTeg7/yD2oA53n18udQqDV0a/JLzCwMM7h71zU4MAi5miSB2T
         E6qxnL24eyKDW/gS4T9AdUcZdKSMw8zT8y3xBSz4a7m7+d7TOxsxYIC3VLfwerpOG6qt
         u84A==
X-Gm-Message-State: AOAM533CoclZByKdr10m129AfWctxYBY3i02tvdmgAdwHBLjQafKwCDo
        y/Wu7WUZ94yx+UcWiJ1vgIqLNeer3iFXjw==
X-Google-Smtp-Source: ABdhPJwNyWCteB7/2R5ghO6byrYkMho+qgGEqRcBF/pCn4PcHqmDgUI0XTds/oWhNE+4b7wYvcVoVBX4KU3oow==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a5b:689:0:b0:61d:9014:bbbe with SMTP id
 j9-20020a5b0689000000b0061d9014bbbemr20476564ybq.34.1647826645451; Sun, 20
 Mar 2022 18:37:25 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:37:02 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.8.Ia97a9544495c94781c0391c0ec5a01273a278d18@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 8/9] client: Display the AdvMonitor Release reason
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
2.35.1.894.gb6a874cedc-goog

