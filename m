Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiCUBin (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343988AbiCUBik (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E0DD97D
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc1ce31261so114074767b3.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eCqYJR6Vta2NjxcLrsGvMmxUCWwhAPgPhCQWWuHd4Y4=;
        b=kz0Uc6pZ7z4oLTmSdIDcAxIKp1pbbb8D5r/MwgpHRds1vvkua53D+Tapa9acxdG7eo
         tY1J4TK9mgLoMW7YdmNAARBLQ+cmmUnwsfQGR5Orzljogr+cqAW8NdfgldrJ+t4d/54d
         B7U+Yrf01aUwh720VEnGdyxfzHlA5L+RUlOewVehAcyum7v1FIXvbh5rsAFKnDfZJRpu
         88Kx7yAQoYkWssLF6STLKYjxHG8kf9xlHyvGXPsph0fbcg9VxSYznuAFr/80p+Ca+r//
         cEkLeRE6TXo4JlGsJI73qX65krYTK5X/DUCqP9tnO0Tkai3zCaft9BEwqlQM18SBm2SC
         sXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eCqYJR6Vta2NjxcLrsGvMmxUCWwhAPgPhCQWWuHd4Y4=;
        b=MfedlTa5e2AX8Ybop2WxvcCP0qPmLLBviSf9h4wEn9gEqlGxoGQrhN33tdbHSXN+B9
         vLJnVKJwnhJqU9NChBjYyqM7S+PXy4853NF9GVfm09bOfhcTRd6dOlHYcIa93Pc0hBVJ
         Qs8XNcC2guHC+7DjPrw0pq4iZgxrsEmu598Hfvi4PUgw5o/2pG47h7rn9kqP5b6vyyaY
         6nyMw9ZuDc0CmyBGyluskkfAa0Zp3ZaAulCZ5JtZQr6SWnKYn1iUe68li0D4pEXmBYuZ
         7IzNKwTE1eEH28pRKJKc0uheoCBDFQAGYXrpzJ91d+CwsVVVmeXdbZDtdLFRVlLMs2x5
         FPrg==
X-Gm-Message-State: AOAM530BpGjhvrsBwX97ZPhdz1ki5h7UpwgvCw5Qy1wKsOZvSN35T4s8
        1u6Q8SL9V7XURfNWSvaeuKN3xBlAFFinqQ==
X-Google-Smtp-Source: ABdhPJwlVva+cXpU8GCm3W74m4FHHVElpESBgCFqe5Al87O5c4+HbNbu7wvt5hP1rN6okuaKF5NjxdBvR4BmRw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a25:d684:0:b0:633:68be:a431 with SMTP id
 n126-20020a25d684000000b0063368bea431mr19728582ybg.555.1647826635086; Sun, 20
 Mar 2022 18:37:15 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:36:58 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.4.I81b6c0f613e08fe2cabd5c6b16ed68c2116e359d@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 4/9] adv_monitor: Do not remove the device while monitoring
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

Bluetoothd clears temporary devices if they are not seen for 30 seconds.
When controller offloading is enabled and SamplingPeriod is set to 0xFF,
the controller sends only one advertisement report per device during the
monitoring period. In such a case, don't remove the temporary devices if
they are being monitored.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/adv_monitor.c |  4 ++++
 src/device.c      | 22 +++++++++++++++++++++-
 src/device.h      |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 35d9bc9c8..77b8ea10d 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1663,6 +1663,8 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 			return;
 		}
 
+		btd_device_set_monitored(info.device, true);
+
 		/* Check for matched monitor in all apps */
 		info.monitor_handle = handle;
 		queue_foreach(manager->apps, notify_device_found_per_app,
@@ -1745,6 +1747,8 @@ static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
 	/* Check for matched monitor in all apps */
 	info.monitor_handle = handle;
 	queue_foreach(manager->apps, notify_device_lost_per_app, &info);
+
+	btd_device_set_monitored(info.device, false);
 }
 
 /* Allocates a manager object */
diff --git a/src/device.c b/src/device.c
index 3992f9a0c..00d0cc2fb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -218,6 +218,7 @@ struct btd_device {
 	GSList		*services;		/* List of btd_service */
 	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
+	bool		monitored;		/* Tracked by Adv Monitor */
 	bool		temporary;
 	bool		connectable;
 	unsigned int	disconn_timer;
@@ -3206,11 +3207,30 @@ static bool device_disappeared(gpointer user_data)
 
 	dev->temporary_timer = 0;
 
-	btd_adapter_remove_device(dev->adapter, dev);
+	/* Do not remove the device if it is being tracked by an Advertisement
+	 * Monitor. It will be removed when the Advertisement Monitor stops
+	 * tracking that device.
+	 */
+	if (!dev->monitored)
+		btd_adapter_remove_device(dev->adapter, dev);
 
 	return FALSE;
 }
 
+void btd_device_set_monitored(struct btd_device *device, bool monitored)
+{
+	if (!device)
+		return;
+
+	device->monitored = monitored;
+
+	/* If the device is not being monitored and the temporary_timer has
+	 * already expired, it indicates that the device can be removed.
+	 */
+	if (!monitored && device->temporary && !device->temporary_timer)
+		device_disappeared(device);
+}
+
 static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 {
 	clear_temporary_timer(dev);
diff --git a/src/device.h b/src/device.h
index 071576d6b..0a4103747 100644
--- a/src/device.h
+++ b/src/device.h
@@ -87,6 +87,7 @@ bool device_is_connectable(struct btd_device *device);
 bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 gboolean device_is_trusted(struct btd_device *device);
+void btd_device_set_monitored(struct btd_device *device, bool monitored);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
 void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
 void btd_device_set_temporary(struct btd_device *device, bool temporary);
-- 
2.35.1.894.gb6a874cedc-goog

