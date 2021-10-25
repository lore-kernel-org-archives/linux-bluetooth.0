Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4186C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF50B60273
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhJYT30 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhJYT1U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 15:27:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1EC043184
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q6-20020a17090a178600b001a272c28654so169685pja.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KA0vcFs8GMNeJbdjaa0VOz2jygYh3Ceu3BJ2ggMcAVk=;
        b=TphYencw+erf8SWCQNvltwUVqR7FohLGcs0NwDDiT8dnsXFz4VAPs7+beR7I5auKrm
         Sxze54ddoYGt+yW8Zsv8udGRaKXB8dIENh0LjR2uKA/qa/Q0nINDvXhJh0ZmYkZ730pF
         tCD4PeAha5iAm82ZcCQLT6LoWeOK1Yf/LJC4nmH9OxxzRVrXh5HKZ0sZGq71rdgTomnC
         CO4WFjutBWiYq11qHvwbSJoTLYh2TPUsbZCzx7/H4M96+1R14fFRMj6bh5iaqG/69VA6
         LcfQulK82k5ATWpNnHUOUYxxO+9SWn+rHoPZRjWr7SkH5iKyZvFv/y8vkoGzEjqPeM7I
         A5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KA0vcFs8GMNeJbdjaa0VOz2jygYh3Ceu3BJ2ggMcAVk=;
        b=NT5ON3eIGjOpPcDPTLPk+22dEEs7qhUqJonEm1eKyS370jhbRgdVqHwcALlPjE1dpP
         ZEK/H/SeIh2EJxOSiq3X2hsl4VScxE8wm/X2UfGwH1pX3AACdEkqWiWHm7AgFkP5U3DS
         ++yV1bULdGXNR8prwscj+dBbsG6GLhrpoVesS123GQ3rafPaPTKaouiqX0XvImSJvJJJ
         dqdzPjXJPRhaI/GD8k10vcWZ6rIQMubufl0T6RxArRBE2Qns7o+lBAr+k55J7LxW4BYH
         Lr/9lbG5le5ZOBkBGgwcqs9jJBYDMJLz9U93A8YKFPd7eS/ytJ2N9mStbcezLq7Sv/Q6
         cRfg==
X-Gm-Message-State: AOAM532NdPaV0uoj3OMGH9Gzp6gvsa2VSqwssGKgejjC0gZk7StiUHw1
        mTuGQMzE4GbVQUSD2UTf8obrVlPL0BYKPA==
X-Google-Smtp-Source: ABdhPJzbz19X3XGnB05TX1hu6AbLUk50BIqnqaIj10zH00r8BSzPHijZLJ9A9E9LH4/ZihivjT3svoJo+HpFNQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e7c3:c740:ce43:5358])
 (user=mmandlik job=sendgmr) by 2002:a63:2cf:: with SMTP id
 198mr15131067pgc.274.1635189516170; Mon, 25 Oct 2021 12:18:36 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:18:11 -0700
In-Reply-To: <20211025191811.3575708-1-mmandlik@google.com>
Message-Id: <20211025121343.BlueZ.v4.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
Mime-Version: 1.0
References: <20211025191811.3575708-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [BlueZ PATCH v4 3/3] adv_monitor: Receive the Device Found/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch registers callback finctions to receive the Advertisement
Monitor Device Found and Device Lost events.

Test performed:
- verified by logs that the MSFT Monitor Device is received from the
  controller and the bluetoothd is notified whenever the controller
  starts/stops monitoring a device.

---

Changes in v4:
- Add Advertisement Monitor Device Found event.

Changes in v3:
- Fix indentation of the adv_monitor_device_lost_callback() name and
  it's arguments.

Changes in v2:
- Update function name adv_monitor_tracking_callback() to
  adv_monitor_device_lost_callback() as it will receive only Device Lost
  event.

 src/adv_monitor.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..2aae5d372 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1531,6 +1531,48 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Processes Adv Monitor Device Found event from kernel */
+static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_device_found *ev = param;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	const uint16_t adapter_id = manager->adapter_id;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Device Found event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("Adv Monitor with handle 0x%04x started tracking the device %s",
+			handle, addr);
+}
+
+/* Processes Adv Monitor Device Lost event from kernel */
+static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_device_lost *ev = param;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	const uint16_t adapter_id = manager->adapter_id;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Device Lost event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("Adv Monitor with handle 0x%04x stopped tracking the device %s",
+			handle, addr);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -1555,6 +1597,14 @@ static struct btd_adv_monitor_manager *manager_new(
 			manager->adapter_id, adv_monitor_removed_callback,
 			manager, NULL);
 
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
+			manager->adapter_id, adv_monitor_device_found_callback,
+			manager, NULL);
+
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+			manager->adapter_id, adv_monitor_device_lost_callback,
+			manager, NULL);
+
 	return manager;
 }
 
-- 
2.33.0.1079.g6e70778dc9-goog

