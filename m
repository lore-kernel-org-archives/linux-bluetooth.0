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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B00C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327DC61052
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 15:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbhHZQAI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhHZQAI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 12:00:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C0C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 08:59:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u1-20020a25ab01000000b0059949024617so456018ybi.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Thb1cLhJ9v9r0nfVCd0JlHvRp2GHWXtZe+Bm1Ldv8kM=;
        b=YO/Ah3Z0siFcPqXaw8cliEXaLojBsqIRT1FThPU37L4Iu45fT4o5ybNQmS+EEXrnnp
         tuMJ0yECvs3lCEzkMKxFHKMxhit4HNvADTFl9EGWAV4JW3LXHUh0XnpLTrZSNDD4j8qk
         452awyn1P4PmgiPclwk7tw1YIEbpIkNXJaFrn2oePlcbDs9cUJoffXqaJGD6TbppnnrT
         TxDeUMgf8eEf+FxQwlsgaelR58Xeer0O161IKMSoSiCuimzMTKVLUy38u4u4yb5c2L4U
         6gILhSIRhpY7N6hm/wIV5F+AXKvIkFzmhw850gW+X0xy80qD/8yYXxmhY9UdwnCzzEcV
         ykLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Thb1cLhJ9v9r0nfVCd0JlHvRp2GHWXtZe+Bm1Ldv8kM=;
        b=MFFUTV6RdLopiagaa9FP7AI81twAKvISs50iccvGNCgGN7NgzMe7tb1pCivZD7zQrs
         k4AY2UZB96vVFbHbBaq11VLjYe/t3EX0y8SzTtInRl0SWZqxmcmZUuxKzKZQ7sRPLSMT
         pcOh8B4EYPAFvrCt7w6VzrfVOJZD56snAtnacdqyBAEn6KQDyEHnDTsiH2OSYzrczOAU
         iMqHM02RcAdr6ZMw/1vMc6BEKUBGpxsNe4ei1UDW9ApZ1fec8WnPBwK3VP6UDXY0bikQ
         B/ZaPY776+6Sx1d7tqS7z8gvOMKqBZySCT+EKLQhuj2sQvs3G+JH07q9DwWcWoBNLLbw
         beMw==
X-Gm-Message-State: AOAM530Xz+fuvRJJI086Q/s8xrkw07q7hA/s9uPMjVrlz93ueqBvkVB3
        RRWGvF4H/i4DRGY2CW/EX8UIZ7FnkZDeUA==
X-Google-Smtp-Source: ABdhPJyGmzozkYxWZNNom3ara1s0/IqeAfBnf9r0t6wBzQNU49FjeXMRqz3Pn5ksvQr2+awBQ+tPupB86PAxlQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:c962:4df3:558d:32ee])
 (user=mmandlik job=sendgmr) by 2002:a25:1b06:: with SMTP id
 b6mr6174264ybb.68.1629993560030; Thu, 26 Aug 2021 08:59:20 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:59:14 -0700
Message-Id: <20210826085906.BlueZ.v1.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [BlueZ PATCH v1] adv_monitor: Clear any running DeviceLost timers on
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
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 src/adapter.c     |  8 ++++++++
 src/adv_monitor.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 src/adv_monitor.h |  2 ++
 3 files changed, 62 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 84bc5a1b0..3af7d1f1a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2872,6 +2872,13 @@ static void clear_discoverable(struct btd_adapter *adapter)
 	set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x00);
 }
 
+static void adv_monitor_notify_power_down(struct btd_adapter *adapter)
+{
+	/* Notify Adv Monitor about power down */
+	if (adapter->adv_monitor_manager)
+		btd_adv_monitor_notify_power_down(adapter->adv_monitor_manager);
+}
+
 static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 						DBusMessageIter *value,
 						GDBusPendingPropertySet id)
@@ -2912,6 +2919,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		len = sizeof(mode);
 
 		if (!mode) {
+			adv_monitor_notify_power_down(adapter);
 			clear_discoverable(adapter);
 			remove_temporary_devices(adapter);
 		}
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..59f307ae9 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -2011,3 +2011,55 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
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
+		DBG("Clearing device lost timer for device %p. "
+				"Calling DeviceLost() on Adv Monitor of "
+				"owner %s at path %s", dev->device,
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
2.33.0.rc2.250.ged5fa647cd-goog

