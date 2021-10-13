Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12592C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BBF610D0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhJMMpO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhJMMpL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 08:45:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649CC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:43:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so2952301yba.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7iaQtJpZumerAmlGSXfWt/ljLWop3XfrDNRMtw2mmZw=;
        b=eHTruHBS4d+ZSTw4Sw1eCFlR6LRcnvPX3vqiNWR4rgKpUJEn7c7qkiRVI5XbPmZZgQ
         ulzNOTRcqUV/qpcLGXgBgpQoAKf22bG9NhFEdmDqYNC/sjex7yHudRFsj6/upxJ48GlD
         nx/LBK+CVg5vpr2h884GpA1lQNNiBEvrAsttYlthsEBD9G9LcLMGbWEa6pyz44QSj89+
         AE+CZk2GMvjPvRypB9Qqn4OhOLpfsk3LbtRZvtYAK59i6aHJLs93drNu+7bEHxNOBBGT
         Qp903yc2yewlSOmIyXURcaL9YtzFch4J6UqactXU0q1KUz4w560GXqLPPZrPr3effMCJ
         6Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7iaQtJpZumerAmlGSXfWt/ljLWop3XfrDNRMtw2mmZw=;
        b=tpWN3aW9e4JINOYrx4zpZ0xdYBnTqfaB5Lye3oyFrs4AGYrJp/82q5NhZzExXiD+U6
         CuNBxPIO4D0C2qZZ+RuurLrQNYcgnb507aoERONAqYVTzs9zR2hwCcQ22CbDDRNRnZF9
         nB+eX8uJD+0cGNK3pQDNqMzQgh2Hdu4x72JQuK6oLhB5dCJbCz+cLWe4TC5/k1vQEYYl
         tPtwpuy9j8bK1edTupAuHF6AIhf+gz5WxKmflUce/h7hThduoX1n+Q/CCW0ngOzIyD4e
         jUMPcPVP4Sam5R69HTxNN7H9V9xciR8lU4UfMWGYg+mGsqsxrbzmiZDr04Je+xkzXL0X
         h/ug==
X-Gm-Message-State: AOAM532NOTO97hM4aNsR9W32rZArFcNZBe91KYNlolEneT6efzzop2DF
        RXoKNuh9XsG1dQylN8+MODoaErw6OdvzEQ==
X-Google-Smtp-Source: ABdhPJw5hIHL6xziL8wmAAQeh/vlRaRT8/ReSfSemlKjX6YR6XXkiVZEvp/mXgDe/i7BfCbb0gK6rFMgi4ZMXg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f8a0:57c1:fc2b:3837])
 (user=mmandlik job=sendgmr) by 2002:a25:a346:: with SMTP id
 d64mr35906483ybi.414.1634128987331; Wed, 13 Oct 2021 05:43:07 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:42:10 -0700
In-Reply-To: <20211013124210.1454876-1-mmandlik@google.com>
Message-Id: <20211013053935.BlueZ.v2.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
Mime-Version: 1.0
References: <20211013124210.1454876-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v2 3/3] adv_monitor: Receive the Device Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch registers a callback function to receive Advertisement
Monitor Device Lost event.

Test performed:
- verified by logs that Monitor Device is received from the controller
  and sent to the bluetoothd when the controller starts/stops monitoring
  a bluetooth device.

---

Changes in v2:
- Update function name adv_monitor_tracking_callback() to
  adv_monitor_device_lost_callback() as it will receive only Device Lost
  event.

 src/adv_monitor.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..13042786c 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1531,6 +1531,27 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Processes Adv Monitor tracking event from kernel */
+static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
+					  const void *param, void *user_data)
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
+	DBG("Adv monitor with handle 0x%04x stopped tracking the device %s",
+			handle, addr);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -1555,6 +1576,10 @@ static struct btd_adv_monitor_manager *manager_new(
 			manager->adapter_id, adv_monitor_removed_callback,
 			manager, NULL);
 
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+			manager->adapter_id, adv_monitor_device_lost_callback,
+			manager, NULL);
+
 	return manager;
 }
 
-- 
2.33.0.882.g93a45727a2-goog

