Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372CAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 02:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066BB61131
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 02:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhIJCHA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 22:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhIJCG7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 22:06:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7281C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 19:05:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so473574yba.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DWdbNSd1AKLRQ8h4Zr7iZeZxO2SSFD0jOU845Jc4Lrg=;
        b=KzU2CsrRw84wC+a1dtr+hda5YZitg5DwTlZ9KHbCOBc6g+qXhBjMfOplnmOTU1xT1W
         XAXwIasOdgMXXetGG851ZfbzS30PS0l7KHrzllHh5Xa+wa0AfWFibuYbvBzigBm9clI8
         z6lUIhXCm9bmWB/npi6dQ5ELdFrsfzIT0EPhVMDJ7yjQ/wN/RipcmsqE0uJe9jYmNerk
         JrYR5nEidhqPYUV5IJfHYe4RErtKB4ylyfrX4pybjZiGrAbs7JahB35sMBrS2H60aWig
         GSp1zaVbXk6EC1mLU+6msMXCjIOJj+mCUP4OhVkK/3sDSECID4BYVhWAuWE5Gu+tHD+z
         b/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DWdbNSd1AKLRQ8h4Zr7iZeZxO2SSFD0jOU845Jc4Lrg=;
        b=oNVB3ke6a+hnDS6dLWbfa6wkgDhXsYKSeRRT/L/hPhfw5MJFBMKHjeEmHdIE6Or9jU
         FSqeH3VxrT3tcXrlorYQylt7UtQjCIaP5s3qLEfL5FHFcWt+W2uSFKPEUEpsUevoGO5R
         8XpXIZ2509FFJahtKkRVvWkxzMWGekttomym/wVK+M3ihy72AUdw1TLO7aVqUyA9a6CE
         QW8fAE0dK6dKmeZYu/ABu5eHC9fMiha7sj5uJdUhCIlrECaIk94j/jn64u2k1K/SywnE
         hvuTO3JUfU8KKDVHNEeQXd/Sd5mOZ1tN51ZUh5uVgPAw7BNr2wCkrCfZG/bI/0g8ZR/U
         R46g==
X-Gm-Message-State: AOAM533/iafGmRtdnsBdOgdap1EIQdTxdLr8vEljkQrDUfAum2JrSfaW
        6wyESdD7GdolW35sNWBisjD52tQ8o3uXJA==
X-Google-Smtp-Source: ABdhPJzMcZ5CSacu8jvqX/p7limDuiZzl0jZKX0jnP2/Ia3sL5BrIcOaHdUyYnMIMJGciozOKkSPtBkCxtIrmw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:dee9:aec5:bbc1:a71e])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:1247:: with SMTP id
 t7mr8072339ybu.285.1631239548877; Thu, 09 Sep 2021 19:05:48 -0700 (PDT)
Date:   Thu,  9 Sep 2021 19:05:36 -0700
Message-Id: <20210909190503.BlueZ.v2.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [BlueZ PATCH v2] adv_monitor: Clear any running DeviceLost timers on
 power down
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, mcchou@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch clears any running Adv Monitor DeviceLost timers on bt power
down. It'll also invoke DeviceLost event if the device is already found
and is being tracked for the DeviceLost event.

Verified this by adding a monitor using bluetoothctl and confirming that
the DeviceLost event is getting triggered for already found device in
case of bt power down.

Reviewed-by: mcchou@google.com
---

Changes in v2:
- Removed the wrapper in adapter.c, updated the debug log.

 src/adapter.c     |  2 ++
 src/adv_monitor.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 src/adv_monitor.h |  2 ++
 3 files changed, 55 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 84bc5a1b0..5ddc5eee6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2912,6 +2912,8 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		len = sizeof(mode);
 
 		if (!mode) {
+			btd_adv_monitor_notify_power_down(
+					adapter->adv_monitor_manager);
 			clear_discoverable(adapter);
 			remove_temporary_devices(adapter);
 		}
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..39094c10d 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -2011,3 +2011,54 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 					    NULL);
 	}
 }
+
+/* Clears running DeviceLost timer for a given device */
+static void clear_device_lost_timer(void *data, void *user_data)
+{
+	struct adv_monitor_device *dev = data;
+	struct adv_monitor *monitor = NULL;
+
+	if (dev->lost_timer) {
+		timeout_remove(dev->lost_timer);
+		dev->lost_timer = 0;
+
+		monitor = dev->monitor;
+
+		DBG("Calling DeviceLost() for device %p on Adv Monitor "
+				"of owner %s at path %s", dev->device,
+				monitor->app->owner, monitor->path);
+
+		g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
+				report_device_state_setup,
+				NULL, dev->device, NULL);
+	}
+}
+
+/* Clears running DeviceLost timers from each monitor */
+static void clear_lost_timers_from_monitor(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+
+	queue_foreach(monitor->devices, clear_device_lost_timer, NULL);
+}
+
+/* Clears running DeviceLost timers from each app */
+static void clear_lost_timers_from_app(void *data, void *user_data)
+{
+	struct adv_monitor_app *app = data;
+
+	queue_foreach(app->monitors, clear_lost_timers_from_monitor, NULL);
+}
+
+/* Handles bt power down scenario */
+void btd_adv_monitor_notify_power_down(struct btd_adv_monitor_manager *manager)
+{
+	if (!manager) {
+		error("Unexpected NULL btd_adv_monitor_manager object upon "
+				"power down");
+		return;
+	}
+
+	/* Clear any running DeviceLost timers in case of power down */
+	queue_foreach(manager->apps, clear_lost_timers_from_app, NULL);
+}
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index 2b4f68abf..20da012d4 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -38,4 +38,6 @@ void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
 void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
 				   struct btd_device *device);
 
+void btd_adv_monitor_notify_power_down(struct btd_adv_monitor_manager *manager);
+
 #endif /* __ADV_MONITOR_H */
-- 
2.33.0.309.g3052b89438-goog

