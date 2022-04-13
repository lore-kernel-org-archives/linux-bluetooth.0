Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9846FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiDMU51 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiDMU50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350A853718
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e642be1a51so25990967b3.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5QHuP0OaOqm2MvcLs33y6b/W3BiqwZkboBia8uB9AUA=;
        b=h3q3T3AM+ajBi5C/WQRDPdSFRViPIbkpjE1kaEFHChNiTGShVpCvuXk28+rd0tbRwd
         OH8HcSh86JZ7WfqF3tTx7HZwyhnPNsWY7AT5JqRyEFSeTRFEOEUU5UKm/TpFYL73IG9G
         jH6MMztu/POxny81xOHMY6VFG9WDdsMF3UQi0de5KIKlI5m7nQNcLykaFvdAk0RtHj6f
         KvVWKmeO2j5OYww4uLy9FeFuwhcPA68Kl1WSyp2As2f20f4YfgSYnOSqZe6oGPag/7O+
         36oBUGtdJwkl0nQ13CAArl78zmfyRbpNIfYeCS3o2fwtyjMxOgGD0mJbyKAfI+4RKNTJ
         kvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5QHuP0OaOqm2MvcLs33y6b/W3BiqwZkboBia8uB9AUA=;
        b=yFN0mi8AcUWa3D4iQ5ORL5aJsbS/NGYee4fx0QZMr2sNJqeGgDx8pFEJ0E6dPtOnSW
         XroeMt1/2kLBifAegFxkxSHiHJWyQvvYIoQatq+0in+WIfNnycGM9+7+lvpjZTpcGs7K
         oBUp+LLKPJ5KdGeuSh4bju0HmEcfJsFScj/4aBeWOTbziXnEHYzGDFo946jH2cKZrKvj
         HUuhBah3CWi6xi79C7pVU2sn67m20YB2swYcuKSF3wqxPeUKqIz8BlQxFQp8w8ONTo6Y
         e9UBbFlovrP94LNp3gS4gTkh0gpATpeyVZsbtJEUOhjj0gWYfAK0ZqNV5+9bPFvVq9PM
         WpDQ==
X-Gm-Message-State: AOAM530wndcEXHxi0efLEwJix6uEGNMh8eJdOpYkx3ofYRvYmZKZVUTx
        82yz8NqkMDQC53fgATAid8SHn1DwrsQxqQ==
X-Google-Smtp-Source: ABdhPJyrYzQbT91a77NYngH8bf0N87BL8hI9IYWXpz3XEgwcGdD/dUE2qMutQAgPWUTrlH+ifZOlTSmDh/bPIQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a5b:78f:0:b0:63d:936b:1a4 with SMTP id
 b15-20020a5b078f000000b0063d936b01a4mr687187ybq.29.1649883303495; Wed, 13 Apr
 2022 13:55:03 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:44 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.4.I81b6c0f613e08fe2cabd5c6b16ed68c2116e359d@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 4/9] adv_monitor: Do not remove the device while monitoring
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

(no changes since v1)

 src/adv_monitor.c |  4 ++++
 src/device.c      | 22 +++++++++++++++++++++-
 src/device.h      |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 18ce839e9..c01f8b154 100644
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
2.36.0.rc0.470.gd361397f0d-goog

