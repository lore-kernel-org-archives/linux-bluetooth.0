Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D022C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiCUBif (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiCUBie (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF8DD971
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d726bd83a2so114617437b3.20
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gh24cwy+hhvqTY6yTcGM/Wqmblsr/GhZPwqYp8ln8eg=;
        b=V8qDSeI6DY3pOvq1KclyWn1njbsum7PTYm6R2wnEsg64bDTgyUVVqYbCi8vfzPVRGN
         hYQvfukAr0qj/LcWTRIzJar/7K9oh101LJd7O9/+Tv21kt43HNRpAQY/xP0TJDFxF3J4
         7hEjfv59o4sDn0ndVVT8qmj/CrxGj7T75jvDMd6tCerPyTIBfi35cEq2I+ySLuWjG5li
         Rr2Aa2L9+Rell5p4xt8vnJG+QQMqnV+Dws+PvPlCBkik7CoC3NxAajaJ5SRxHfGp/Byv
         W96hzsxLPAPb5UdEHzwimmLac7ITE8BMvvpV1ptSBir08/Pk4gbt/o7zuaznWD/aZXbe
         Ruiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gh24cwy+hhvqTY6yTcGM/Wqmblsr/GhZPwqYp8ln8eg=;
        b=r6u8XkX8MI7zwMRodV457dz7GU7mIAjpwst27pEsfopq6wSYhCXuq6SXSF9L5jPoty
         j9av3CF8ZjJjxC7bCCuTY8ZC4oNul16/oesdI7/jo6nvupPxoyYnsYcZ3Ub3xhilqsT9
         BUv7f/D/syAnYjngOLwu9ZTpKvC2gLtJDFs1d82IrR8SMq0L3W16SL3bGIGNBV77fjkn
         XwTTgAMtbnHoDKz9FrfVF7TWB4cy3kR6rZJQGk8JqZVgqV8BmXCgFVZQMRzq4HP8kYxD
         mFthNu1Gkodu770YxmE7+MDGDj1Nag6HdSxzz0zyefA4hgVatCiyQej2COxIoYMx8/WO
         wdkg==
X-Gm-Message-State: AOAM530LRxhRw0R1OPhxEIY6Wlr3pjtCJvwoQiNeesBZm8UBlaUlfV2C
        5VqhnRQnPtik7Bk9NzX8Ql/bXzDNfuYvCQ==
X-Google-Smtp-Source: ABdhPJzR03d1BmWhedO56PFRQHMn5FVHjd/CBdF5e6NvSvm0FWZA5BgpOd4CgNRV18d4ipl7VlROR8/LH5JrDg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a81:1182:0:b0:2dc:4e58:da41 with SMTP id
 124-20020a811182000000b002dc4e58da41mr21588794ywr.268.1647826629894; Sun, 20
 Mar 2022 18:37:09 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:36:56 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.2.Ie337efd4e92e6cbbf47503c29b67384327d91c73@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 2/9] adv_monitor: Don't send DeviceFound for already
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
2.35.1.894.gb6a874cedc-goog

