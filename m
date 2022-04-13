Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA584C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiDMU5W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiDMU5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD367D37
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:54:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso2644246ybs.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NFvbHB/8fDYayZz14ZUldq7zRC0WFipDioxr1FFGnc8=;
        b=JXmR7tv9dLzUL1FVQOJ37L20K9fHt6LSyBAAiUKF0/sskbZKmLouTTS0VuhV5XhF7R
         /Rd7q3GT7gzh5T6A5VQ0izaFLVfCh6nL1pU6LbjiiWcqOWjs6Z1YUl6zvMgxA2aF5ZiB
         p8p3HsMumKCbqw7OZF23Mx5wH7iNjU0sI+e+YXBpxWk6PnsL4P9W9Kw+q3L+exgjNpTx
         eZNFpl9D9NB3KCA3dwcPJrFFPvPFGmd9kzl5/C9Y/wIUTk/nblzzc3CjSYL001Qa7gs9
         Y4h1DpXnvBfbDvbnnhDVq2uDO+b3CfaLALCEOCNF2D6pK3VTwsn+TncC9W+6qlvE4IB+
         ckiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NFvbHB/8fDYayZz14ZUldq7zRC0WFipDioxr1FFGnc8=;
        b=XmxtY7qVqRgIimHjqFR8MHrFUdeWmisBz2FnaQXRcI0urkK64Iaz0ZE17hL0IVnwzd
         RFu95BR4EFblVGNboFKHmCI6n7y+aW6z5Mv7rJqAJqqbIGuKnb/c3m/Q9uhGLhwXtn23
         VOKqJafWsEQDVB+OLveMHXiAU4YXvaHiSqJzzz9N3ZpLQyp8QEMUb7SBQstFOaCBp3Z2
         aPaI5hQ4tWJaF2QHIbbXm1nq5SzbfNs6EpjLzp7CKMlkqwBubBLnYeiHqQ5uopob++o4
         gO01KELlpq2UXhR11C8rrf8TTLQQDLcklch6GyGLdvFEOU8Nc8Vbmy3PFJpYVD5Tm427
         VE0Q==
X-Gm-Message-State: AOAM531IdWevbrEB4z6RtEBJGsFBia/lPU3dGYEeNoBWMTVhYjMggyjl
        bfkH7EvkvhD2sA9YRlRE7nOe21Sm/aUpvg==
X-Google-Smtp-Source: ABdhPJxkZw77sbJjngsiHKUP08bzpX2BBwJQpk7L/YPvQkpnTYXmymi8/8BYuZ9ibUtbEj7ArqZv7pkJTqo7RA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a25:8c01:0:b0:634:712d:3def with SMTP id
 k1-20020a258c01000000b00634712d3defmr643817ybl.343.1649883298631; Wed, 13 Apr
 2022 13:54:58 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:42 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.2.Ie337efd4e92e6cbbf47503c29b67384327d91c73@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 2/9] adv_monitor: Don't send DeviceFound for already
 found devices
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

When monitors with same patterns are merged, BlueZ removes the existing
monitor from the kernel and re-registers it with updated/merged RSSI
parameters. The controller then triggers a new Device Found event for
the device that matches the updated monitor. Don't notify the D-Bus
client again with another DeviceFound for that device.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index a1778248f..a7763df10 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -188,6 +188,11 @@ static void merged_pattern_send_add(
 static void merged_pattern_send_remove(
 			struct adv_monitor_merged_pattern *merged_pattern);
 
+static bool monitor_device_match(const void *a, const void *b);
+static struct adv_monitor_device *monitor_device_create(
+			struct adv_monitor *monitor,
+			struct btd_device *device);
+
 const struct adv_monitor_type {
 	enum monitor_type type;
 	const char *name;
@@ -1555,8 +1560,26 @@ static void notify_device_found_per_monitor(void *data, void *user_data)
 {
 	struct adv_monitor *monitor = data;
 	struct monitored_device_info *info = user_data;
+	struct adv_monitor_device *dev = NULL;
+	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (monitor->merged_pattern->monitor_handle == info->monitor_handle) {
+		dev = queue_find(monitor->devices, monitor_device_match,
+				 info->device);
+		if (!dev) {
+			dev = monitor_device_create(monitor, info->device);
+			if (!dev) {
+				btd_error(adapter_id, "Failed to create "
+					  "Adv Monitor device object.");
+				return;
+			}
+		}
+
+		if (dev->found)
+			return;
+
+		dev->found = true;
+
 		DBG("Calling DeviceFound() on Adv Monitor of owner %s "
 		    "at path %s", monitor->app->owner, monitor->path);
 
@@ -1652,8 +1675,25 @@ static void notify_device_lost_per_monitor(void *data, void *user_data)
 {
 	struct adv_monitor *monitor = data;
 	struct monitored_device_info *info = user_data;
+	struct adv_monitor_device *dev = NULL;
+	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	if (monitor->merged_pattern->monitor_handle == info->monitor_handle) {
+		dev = queue_find(monitor->devices, monitor_device_match,
+				 info->device);
+		if (!dev) {
+			btd_error(adapter_id, "Adv Monitor device object "
+				  "not found.");
+			return;
+		}
+
+		if (!dev->found) {
+			btd_error(adapter_id, "Device not tracked.");
+			return;
+		}
+
+		dev->found = false;
+
 		DBG("Calling DeviceLost() on Adv Monitor of owner %s "
 		    "at path %s", monitor->app->owner, monitor->path);
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

