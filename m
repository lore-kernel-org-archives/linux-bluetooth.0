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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A6C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 02:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F57619C4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 02:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhF1Cjq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jun 2021 22:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1Cjq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jun 2021 22:39:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DEFC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 19:37:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u12-20020a17090abb0cb029016ee12ec9a1so10169003pjr.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MwMqaF6KHjKax+s/NmkxoLDiKUl97GggGRlOq0iov10=;
        b=OCHYf6/PKaQnZnPn+VhqK1lHwCuadWuye44gQyd1xmcDoO2Je9MyapuCv3F81t8JJO
         JzRTjv355PK8Ayap8OizgkbcozPFBby2YtVVhRY1/c3oCMHlDZ3NRySZdllxwRzKSxlB
         uf1fisO2Ta2GcFAgoqVmcin6E3Ztl1sFdzMohsemh2ac/u88KDHnFhTPXFw3H6A0bWjy
         McyOAEEV92BWW6iJK2Z3zYGdndHXsQ9zHmX+qdRlh5OKkWBiPEU2sNPxZynSmy+Ac5Ou
         4aAyBwH9/f5MM4qbhaUaA7pAlKjLlApiSZ+49+t6zY2O2O6ILUxFsvX7116ZEjx8t11U
         IIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MwMqaF6KHjKax+s/NmkxoLDiKUl97GggGRlOq0iov10=;
        b=gGWEuNlezJqczmhbFVFrIUrzpNa/n4v2WisqX/n5HLPUrTZVxl7HYn1/yigDPgnsqJ
         OYYQ3VgFZQ+s0KWriX54cvFPfHiRc/svVdoj1D9LV6KsrVhmczg2+qryjx1SWDhlVnPR
         Tsg1pHqNna3nQZokg08QDdnutRPv4hJcniP/Xzzl4jZMOe2+OPGqBskd6ovaupG9IQlv
         cFMGfY4JVmr+SeMy981csIIM2/x7X9rtsLLn2/s4HFPV4uqiIk+w4VuuaWqsVVsR46YJ
         ANbmElnepKm/Jv+ker0a3QoWbodU63utOSAVDBk/kJn75dlMLdnQUzYXfIVJ6W8+PPXB
         DPHw==
X-Gm-Message-State: AOAM531MNSWIeJAIjIpGWXkrQ8vJI86uVUd1CnEmAtrU/0FsHS7FRTPh
        fPA/abwm2r8kh9XX2AfA4jbC49ZrYEcjS2VNglXkVbgclKTzH7pvacPzwVMmgsLsL6n71J7nkRh
        X0FTcZSeumuXrQXNDEoQiyw9hRNBsU0iYFnjpsXLEbAwl8+OHMJIYYNF9J/P7gOaTZIzwvBPJtl
        3AgoNLaHaPxvw=
X-Google-Smtp-Source: ABdhPJyu/sjW/HvMAaKMEzDdkVZALX3KXxXfRmgoJ3eOHJyuam6EIzI0mZfWCIR3fDjThM0fwoSZIN2wTn9nNnk6uA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:1cb9:1290:1b4b:4db2])
 (user=howardchung job=sendgmr) by 2002:a62:9242:0:b029:300:6fb1:38b7 with
 SMTP id o63-20020a6292420000b02903006fb138b7mr22221948pfd.80.1624847837600;
 Sun, 27 Jun 2021 19:37:17 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:37:12 +0800
Message-Id: <20210628103655.Bluez.v1.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1] src/adv_monitor: Remove checking in device lost timeout
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
or remove the timer whenever an advertisement is recevied.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mcchou@chromium.org
Reviewed-by: mmandlik@chromium.org
---

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

