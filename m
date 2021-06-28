Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B7C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 03:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32E461C17
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhF1DiP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jun 2021 23:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1DiO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jun 2021 23:38:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FCC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 20:35:48 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p5-20020a0ccb850000b029025849db65e9so16560762qvk.23
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nUfWSVXlxqrci7L2BYARvL2e9n2uiBy5IWoK/e7aOSE=;
        b=tMxHNsmNB6vHCuhku4YhiiFyGbBf563yCcYeNguoLl5nzeaCu6eFbnM59zga0nPDce
         aVrtNyuY5rea9NtepeXkk8xQReWQGXhBzYk0EgHOkNRX0CoP1IqIG9DqjEijPn/2T5y/
         v2neTEMkziGKAdqRtn3IeiOxKmRxxWaXpYwAjn+rT/nK6MNltvA4bqh7+dhIPmeITqXo
         a6E5/C0CEQ+eJfbcznxy/xX/QjoN0RF2HGuTr6IKhN1eUuY07qNOvAT7mm96lBuqERfn
         vlgH6DFcNN4DETR5vFwr3dT16gdyOsGE5Lis2/OlaWnYZClOezt1u2yDzEJ9SVEacdmY
         H6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nUfWSVXlxqrci7L2BYARvL2e9n2uiBy5IWoK/e7aOSE=;
        b=hbQhbHhNNUDpWb3BaKMs3kmhDdtLO7egCVRusW0n/68F17/I6umbsqQoK4794610Kx
         vclT9OpE5al5UHiz7MC2DXbY8mK6XMBi43Duz8VkaOQOnrZyiEzEYAFzTskWbH8Qnaqf
         A3R7QQSaRmw990ltyrUW4LiPwNV2BvKpv2M3qkpnPLQtK5v3GnHFtvaOG0o6rruknOUA
         7LMb75cEfA1I3pSX2+LPlrcSIqJMyiuk1EQ0cefamq2le/uNxguJq5wmvPHhW2ZuTK/6
         RF0YAB0qVfSX0/aEfXuSoMDSbsS/7ptBRaC5DbdZdxyBff1/RPrRk7i/8OIMQApHoYLE
         YKOQ==
X-Gm-Message-State: AOAM5320DdUYHvPSDuXqtDKjy+gjDxlN5BjIFJ7i2x0GZ+MIOCI6sqR1
        ILxWtbhYl72uG6RC7ojxAW79jrwi5T8SlcE0woGmiPU5bI4cxol81zPXUqH+lGHkJTwhZOh2Ly8
        cKWvnInTN2wZMDbuxCl6x7wWh7sPMG6eg+Jl3X5lubLB+Y9zP9Pk/bH9IBIKG54VkzGRjC9DxK8
        7GtSGa9UcB4PA=
X-Google-Smtp-Source: ABdhPJwfc0KNl9rvkH3Tzec71ilTI5GA/++OyuWeAYxlch924yQ4kPyEqZ+VvV96KATa3oH/i0l6cZv5FlqQhX3WOg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:1cb9:1290:1b4b:4db2])
 (user=howardchung job=sendgmr) by 2002:a05:6214:174a:: with SMTP id
 dc10mr23646274qvb.62.1624851347446; Sun, 27 Jun 2021 20:35:47 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:35:42 +0800
Message-Id: <20210628113535.Bluez.v2.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v2] src/adv_monitor: Remove checking in device lost timeout
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>, apusaka@chromium.org,
        mcchou@chromium.org, mmandlik@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

The time check in device lost timeout could cause DeviceLost never being
reported because of the following reasons:

1. Timer created in timeout_add_seconds, which calls
   g_timeout_add_seconds_full internally, can be fired one second
   earlier than |timeout| seconds.
2. When handle_device_lost_timeout is invoked early, time diff between
   |curr_time| and |last_seen| could be less than |low_rssi_timeout|. In
   this case, since handle_device_lost always returns FALSE, the
   timer will be removed, but DeviceLost has not been reported yet.
3. If we never receives any advertisement from that peer since then,
   DeviceLost will never be reported.

We can remove the checking in handle_device_lost_time because we restart
or remove the timer whenever an advertisement is received.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mcchou@chromium.org
Reviewed-by: mmandlik@chromium.org
---

Changes in v2:
- Fix spelling errors

 src/adv_monitor.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 17f1777eb1da..715ac5904b9a 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1884,31 +1884,16 @@ static bool handle_device_lost_timeout(gpointer user_data)
 {
 	struct adv_monitor_device *dev = user_data;
 	struct adv_monitor *monitor = dev->monitor;
-	time_t curr_time = time(NULL);
 
-	DBG("Device Lost timeout triggered for device %p "
-	    "for the Adv Monitor at path %s", dev->device, monitor->path);
+	DBG("Device Lost timeout triggered for device %p. Calling DeviceLost() "
+	    "on Adv Monitor of owner %s at path %s", dev->device,
+					    monitor->app->owner, monitor->path);
 
+	g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
+				 report_device_state_setup,
+				 NULL, dev->device, NULL);
 	dev->lost_timer = 0;
 
-	if (dev->found && dev->last_seen) {
-		/* We were tracking for the Low RSSI filter. Check if there is
-		 * any Adv received after the timeout function is invoked.
-		 * If not, report the Device Lost event.
-		 */
-		if (difftime(curr_time, dev->last_seen) >=
-		    monitor->rssi.low_rssi_timeout) {
-			dev->found = false;
-
-			DBG("Calling DeviceLost() on Adv Monitor of owner %s "
-			    "at path %s", monitor->app->owner, monitor->path);
-
-			g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
-						 report_device_state_setup,
-						 NULL, dev->device, NULL);
-		}
-	}
-
 	return FALSE;
 }
 
-- 
2.32.0.93.g670b81a890-goog

