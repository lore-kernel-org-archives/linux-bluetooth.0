Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6874C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiHCUY6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiHCUY5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 16:24:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BD53D25
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 13:24:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f46b4759bso151188157b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=MG4NVz9yj2aFOgp1HtlyEgPmRnBQqcRnRDU4maqxDLs=;
        b=ac+Kon2BynLX4PUenHyxIDUcn1exeZCxVb3lFiCKZxJGscBLaZVq1IS4i8FPji9GSs
         bPhe0/gEK3wWy3S/IUzPCtZc15S/x/0Qa+tsyQpNdPyJeuQKn4bsns/qb5XNKJ0SE4cc
         BqSQecGZRufHziIFY7/jtCvQjU4p8FDdabjc2X/Tkcli6ZEg7sntef9yedlmVpTseUiW
         VcH5HDzJNK3+ZLdx7K7rgeHIE110gCCu5t24Rh+XwnfnDJCwx8q2pq7wHdO+2y961y2O
         TvxmZg9cx00v9XHwi46QDtHpv6k8qfLYhpjvUB50CMpM0dWKv+mmxaYUMtWmiMbfixBv
         G5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=MG4NVz9yj2aFOgp1HtlyEgPmRnBQqcRnRDU4maqxDLs=;
        b=VanSE72VV7oVgjimTJ6SWU2mf5kqLhQKJjNn4TrXeLmEOrMQd2S7e9+PI9VycOv4O+
         +ak4kYRUlrmjN6iYzCeZIJRZ40e1aSbbcQjtqvI7UtRQZonPn8o5//1rEVa9kA4kqnwM
         9maTIQV0yRyN+BrDXskjdw1bjYu68+xaxIUTSlnOILK/OCHuTKi49mlv9uyTG9nwH5ey
         5ZBBJ498DmjhLsyFyK4RXjOIdBIsnOw4+9zUO74lZVrpiyiQDaL8YQnjyA8/xH8JYtgy
         JMfvI0qrGyCYxsPw8mYCJZB2mbT4qtlG9gtqXCsG3GhhMo4KfDOWXjdm9P2CiKUIGhpV
         S6kw==
X-Gm-Message-State: ACgBeo06SZE5M2qxGdAwx5E3Ap7MbJ6GQe10HWlZs/8G6oe1ADrgoAOb
        ElQVqWONaN/s2aI7CGjssOzrujflBRaTxw==
X-Google-Smtp-Source: AA6agR6GOPUFJ2JZIHMbSya1BU/k700ZrXqbkMFCe1qQAwlRA+7nAqEtawU8/N9SY3T/bidZ3WK/nCw2KgfNhA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:6eae:dfce:5d69:e05f])
 (user=mmandlik job=sendgmr) by 2002:a0d:e8c1:0:b0:322:e31a:9c4a with SMTP id
 r184-20020a0de8c1000000b00322e31a9c4amr24937744ywe.334.1659558295388; Wed, 03
 Aug 2022 13:24:55 -0700 (PDT)
Date:   Wed,  3 Aug 2022 13:24:50 -0700
Message-Id: <20220803132319.1.I5acde3b5af78dbd2ea078d5eb4158d23b496ac87@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 1/2] Bluetooth: Disable AdvMonitor SamplingPeriod while active scan
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some controllers apply Sampling Period even while active scanning.
So, to keep the behavior consistent across all controllers, don't
use Sampling Period during active scanning to force the controller
to report all advertisements even if it matches the monitor.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

 net/bluetooth/hci_sync.c |  6 ++++++
 net/bluetooth/msft.c     | 45 +++++++++++++++++++++++++++++++++++++---
 net/bluetooth/msft.h     |  2 ++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e6d804b82b67..cb0c219ebe1c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4649,6 +4649,9 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 	if (use_ll_privacy(hdev))
 		hci_resume_advertising_sync(hdev);
 
+	/* Sampling Period is disabled while active scanning, re-enable it */
+	msft_set_active_scan(hdev, false);
+
 	/* No further actions needed for LE-only discovery */
 	if (d->type == DISCOV_TYPE_LE)
 		return 0;
@@ -5139,6 +5142,9 @@ int hci_start_discovery_sync(struct hci_dev *hdev)
 	if (err)
 		return err;
 
+	/* Disable Sampling Period while active scanning */
+	msft_set_active_scan(hdev, true);
+
 	bt_dev_dbg(hdev, "timeout %u ms", jiffies_to_msecs(timeout));
 
 	/* When service discovery is used and the controller has a
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index bee6a4c656be..f63c911b210c 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -101,6 +101,7 @@ struct msft_data {
 	struct list_head handle_map;
 	__u8 resuming;
 	__u8 suspending;
+	__u8 active_scan;
 	__u8 filter_enabled;
 };
 
@@ -333,14 +334,14 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 }
 
 /* This function requires the caller holds hci_req_sync_lock */
-int msft_suspend_sync(struct hci_dev *hdev)
+static void remove_all_monitors(struct hci_dev *hdev)
 {
 	struct msft_data *msft = hdev->msft_data;
 	struct adv_monitor *monitor;
 	int handle = 0;
 
 	if (!msft || !msft_monitor_supported(hdev))
-		return 0;
+		return;
 
 	msft->suspending = true;
 
@@ -356,6 +357,12 @@ int msft_suspend_sync(struct hci_dev *hdev)
 
 	/* All monitors have been removed */
 	msft->suspending = false;
+}
+
+/* This function requires the caller holds hci_req_sync_lock */
+int msft_suspend_sync(struct hci_dev *hdev)
+{
+	remove_all_monitors(hdev);
 
 	return 0;
 }
@@ -392,6 +399,7 @@ static bool msft_monitor_pattern_valid(struct adv_monitor *monitor)
 static int msft_add_monitor_sync(struct hci_dev *hdev,
 				 struct adv_monitor *monitor)
 {
+	struct msft_data *msft = hdev->msft_data;
 	struct msft_cp_le_monitor_advertisement *cp;
 	struct msft_le_monitor_advertisement_pattern_data *pattern_data;
 	struct msft_le_monitor_advertisement_pattern *pattern;
@@ -417,7 +425,16 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 	cp->rssi_high = monitor->rssi.high_threshold;
 	cp->rssi_low = monitor->rssi.low_threshold;
 	cp->rssi_low_interval = (u8)monitor->rssi.low_threshold_timeout;
-	cp->rssi_sampling_period = monitor->rssi.sampling_period;
+
+	/* Some controllers apply Sampling Period even while active scanning.
+	 * So, to keep the behavior consistent across all controllers, don't
+	 * use Sampling Period during active scanning to force the controller
+	 * to report all advertisements even if it matches the monitor.
+	 */
+	if (msft->active_scan)
+		cp->rssi_sampling_period = 0;
+	else
+		cp->rssi_sampling_period = monitor->rssi.sampling_period;
 
 	cp->cond_type = MSFT_MONITOR_ADVERTISEMENT_TYPE_PATTERN;
 
@@ -815,6 +832,28 @@ void msft_req_add_set_filter_enable(struct hci_request *req, bool enable)
 	hci_req_add(req, hdev->msft_opcode, sizeof(cp), &cp);
 }
 
+/* This function requires the caller holds hci_req_sync_lock */
+void msft_set_active_scan(struct hci_dev *hdev, bool enable)
+{
+	struct msft_data *msft = hdev->msft_data;
+
+	if (!msft)
+		return;
+
+	/* Remove all monitors */
+	remove_all_monitors(hdev);
+
+	/* Clear all tracked devices */
+	hci_dev_lock(hdev);
+	hdev->advmon_pend_notify = false;
+	msft_monitor_device_del(hdev, 0, NULL, 0, true);
+	hci_dev_unlock(hdev);
+
+	/* Update active scan and reregister all monitors */
+	msft->active_scan = enable;
+	reregister_monitor(hdev);
+}
+
 int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 {
 	struct hci_request req;
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 2a63205b377b..7dfd866dacc4 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -22,6 +22,7 @@ __u64 msft_get_features(struct hci_dev *hdev);
 int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor *monitor);
 int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor);
 void msft_req_add_set_filter_enable(struct hci_request *req, bool enable);
+void msft_set_active_scan(struct hci_dev *hdev, bool enable);
 int msft_set_filter_enable(struct hci_dev *hdev, bool enable);
 int msft_suspend_sync(struct hci_dev *hdev);
 int msft_resume_sync(struct hci_dev *hdev);
@@ -55,6 +56,7 @@ static inline int msft_remove_monitor(struct hci_dev *hdev,
 
 static inline void msft_req_add_set_filter_enable(struct hci_request *req,
 						  bool enable) {}
+static inline void msft_set_active_scan(struct hci_dev *hdev, bool enable) {}
 static inline int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 {
 	return -EOPNOTSUPP;
-- 
2.37.1.455.g008518b4e5-goog

