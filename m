Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93224C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF98246CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 23:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lhy85aur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKRXoI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRXoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:07 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861AEC0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 15:44:07 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so1918807pll.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfKp0r4v8KnHJMFIsfD8HVI4xTIgCH6NiDoEg1v+fx4=;
        b=Lhy85aur6ZtATaH4lMCvfHShYvSTGUd2rdwP41a6bLZ7s+KRY59Trub1cY+9uEsD2/
         xecK2ZvoziQ/+MfCVOFcA4+9YUMUBWZLEN7jLNepCP6799YapzJIo5yI0j4igCuMeGZb
         /v0KkHpxKepHoUoRVN+RYY2Srq4SA/vqsFguM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfKp0r4v8KnHJMFIsfD8HVI4xTIgCH6NiDoEg1v+fx4=;
        b=UUEVwbbRoMbvrGW8o9oUVcab/nWLL2uqx/QalFzU6aiwsxVO7olC1m1xhzbvYcsx6r
         JM9CaNw9ZrABngXdzFmcBRocOBAf2B2KtVS+2i2YWngZbsahgcbjNAung8bS3xSUQmeP
         9VNL8JnKb8iabVnwykRtVtD+wd2LYdEmrdQNbapemz25kXFUKrvIZpT4yRYI9jvxerDm
         +5LULxDEXm47Vub0rCkfTxhZcBqEqwh4N1tjhpnfp3uGVYcGTE4sLYpfbkJkNnSYi/9a
         OJ/H4aBix9cNvv984Ctmu/kmSCY+obIazEIJaL2IgwcAib8YAKymCSA90akFrRbqVYCz
         9Zaw==
X-Gm-Message-State: AOAM531ceZZG9D7PxO4HgFt17P6Yx28RElADyXqJREUB6eBIoUktDEVM
        XnjUSOOnkiwCViViLEBk3rQbDg==
X-Google-Smtp-Source: ABdhPJwwaHEZy70mLOkmnmMTTboXZBQPl6Emv6az9gRrpwahfvoJjzfc3++alZHHSbv+M50V5DcIpg==
X-Received: by 2002:a17:902:a5c5:b029:d9:d27d:a1ce with SMTP id t5-20020a170902a5c5b02900d9d27da1cemr2701575plq.78.1605743047090;
        Wed, 18 Nov 2020 15:44:07 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id f6sm21437435pgi.70.2020.11.18.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:06 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        danielwinkler@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/3] Bluetooth: Add quirk to power down on suspend
Date:   Wed, 18 Nov 2020 15:43:51 -0800
Message-Id: <20201118154349.2.Ia5f019f5309cc9f2be9070484a001dc7ddaca354@changeid>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201118234352.2138694-1-abhishekpandit@chromium.org>
References: <20201118234352.2138694-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some older controllers fail to enter a quiescent state reliably when
supporting remote wake. For those cases, add a quirk that will power
down the controller when suspending and power it back up when resuming.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 include/net/bluetooth/hci.h      |  7 +++++
 include/net/bluetooth/hci_core.h |  4 +++
 net/bluetooth/hci_core.c         | 48 ++++++++++++++++++++++++++++++--
 net/bluetooth/hci_request.c      | 26 ++++++++++++++++-
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c8e67042a3b14c..88d5c9554e4840 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -238,6 +238,13 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
+
+	/* When this quirk is set, the adapter will be powered down during
+	 * system suspend and powerd up on resume. This should be used on
+	 * controllers that don't behave well during suspend, either causing
+	 * spurious wakeups or not entering a suspend state reliably.
+	 */
+	HCI_QUIRK_POWER_DOWN_SYSTEM_SUSPEND,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ff32d5a856f17f..e7dc6e3efbf246 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -90,6 +90,7 @@ struct discovery_state {
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
+#define SUSPEND_POWER_DOWN_TIMEOUT	msecs_to_jiffies(1000)
 
 enum suspend_tasks {
 	SUSPEND_PAUSE_DISCOVERY,
@@ -112,6 +113,9 @@ enum suspended_state {
 	BT_RUNNING = 0,
 	BT_SUSPEND_DISCONNECT,
 	BT_SUSPEND_CONFIGURE_WAKE,
+	BT_SUSPEND_DO_POWER_DOWN,
+	BT_SUSPEND_DO_POWER_UP,
+	BT_SUSPEND_POWERED_DOWN,	/* Powered down prior to suspend */
 };
 
 struct hci_conn_hash {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8e90850d6d769e..d73e097d3ce16b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3562,6 +3562,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		container_of(nb, struct hci_dev, suspend_notifier);
 	int ret = 0;
 	u8 state = BT_RUNNING;
+	bool powered;
 
 	/* If powering down, wait for completion. */
 	if (mgmt_powering_down(hdev)) {
@@ -3571,8 +3572,51 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 			goto done;
 	}
 
-	/* Suspend notifier should only act on events when powered. */
-	if (!hdev_is_powered(hdev))
+	powered = hdev_is_powered(hdev);
+
+	/* Update the suspend state when entering suspend if the system is
+	 * currently powered off or if it is powered on but was previously
+	 * powered off.
+	 */
+	if (action == PM_SUSPEND_PREPARE) {
+		/* Must hold dev lock when modifying suspend state. */
+		hci_dev_lock(hdev);
+		if (powered && hdev->suspend_state == BT_SUSPEND_POWERED_DOWN)
+			hdev->suspend_state = BT_RUNNING;
+		else if (!powered &&
+			 hdev->suspend_state != BT_SUSPEND_POWERED_DOWN)
+			hdev->suspend_state = BT_SUSPEND_POWERED_DOWN;
+
+		hci_dev_unlock(hdev);
+	}
+
+	/* When the power down quirk is set, we power down the adapter when
+	 * suspending and power it up when resuming. If the adapter was already
+	 * powered down before suspend, we don't do anything here.
+	 */
+	if (test_bit(HCI_QUIRK_POWER_DOWN_SYSTEM_SUSPEND, &hdev->quirks) &&
+	    hdev->suspend_state != BT_SUSPEND_POWERED_DOWN) {
+		if (action == PM_SUSPEND_PREPARE && powered) {
+			state = BT_SUSPEND_DO_POWER_DOWN;
+			ret = hci_change_suspend_state(hdev, state);
+
+			/* Emit that we're powering down for suspend */
+			hci_clear_wake_reason(hdev);
+			mgmt_suspending(hdev, state);
+			goto done;
+		} else if (action == PM_POST_SUSPEND && !powered) {
+			/* Emit that we're resuming before powering up. */
+			mgmt_resuming(hdev, hdev->wake_reason, &hdev->wake_addr,
+				      hdev->wake_addr_type);
+
+			state = BT_SUSPEND_DO_POWER_UP;
+			ret = hci_change_suspend_state(hdev, state);
+			goto done;
+		}
+	}
+
+	/* Skip to end if we weren't powered. */
+	if (!powered)
 		goto done;
 
 	if (action == PM_SUSPEND_PREPARE) {
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 048d4db9d4ea53..804bd0652edd1c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1194,6 +1194,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 	struct hci_request req;
 	u8 page_scan;
 	int disconnect_counter;
+	int err;
 
 	if (next == hdev->suspend_state) {
 		bt_dev_dbg(hdev, "Same state before and after: %d", next);
@@ -1273,7 +1274,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		/* Pause scan changes again. */
 		hdev->scanning_paused = true;
 		hci_req_run(&req, suspend_req_complete);
-	} else {
+	} else if (next == BT_RUNNING) {
 		hdev->suspended = false;
 		hdev->scanning_paused = false;
 
@@ -1306,6 +1307,29 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		}
 
 		hci_req_run(&req, suspend_req_complete);
+	} else if (next == BT_SUSPEND_DO_POWER_DOWN) {
+		hdev->suspended = true;
+		hdev->scanning_paused = true;
+
+		err = hci_clean_up_state(hdev);
+
+		if (!err)
+			queue_delayed_work(hdev->req_workqueue,
+					   &hdev->power_off,
+					   SUSPEND_POWER_DOWN_TIMEOUT);
+
+		if (err == -ENODATA) {
+			cancel_delayed_work(&hdev->power_off);
+			queue_work(hdev->req_workqueue, &hdev->power_off.work);
+			err = 0;
+		}
+
+		set_bit(SUSPEND_POWERING_DOWN, hdev->suspend_tasks);
+	} else if (next == BT_SUSPEND_DO_POWER_UP) {
+		hdev->suspended = false;
+		hdev->scanning_paused = false;
+
+		queue_work(hdev->req_workqueue, &hdev->power_on);
 	}
 
 	hdev->suspend_state = next;
-- 
2.29.2.299.gdc1121823c-goog

