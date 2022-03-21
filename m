Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52E3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbiCUBis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiCUBiq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AACE17C437
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e5d456d198so69619757b3.23
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=odBF3cajz4i7C33x4dHnygWlrAUv00Xw9OFqKIfJfoo=;
        b=W8q6N9EkQqviChZaxi/Zk4YgBWeZXnwAgrLZJYeMc0fuRhIfOyEZQNfSz7MAhAUNFp
         sx5TJBmBaNfOMyM9DCXoRv6N+RLofd3YOJ72/oJJbfwBKYMeimSg6XgYT5/5l/XILdEl
         JB/wx/5p5f9GtXuYyvNK2cMjIYsv6wSAA+YokgI8P7ItVIo2EQ4jeIUeb6tPnpVT/K8B
         C7BV75C8u46yvEufL1k4Hll9i5J1q1tY4uu8u1qBwNkoFqSOCSeQHaskx4JdjjInRTlo
         2OVoCbtzOxXkXRLO5Nvg7c6s7ARAcnHPJFNj3NgL1DWpStmp44z4pb4wEmnlCffFTI9R
         PJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=odBF3cajz4i7C33x4dHnygWlrAUv00Xw9OFqKIfJfoo=;
        b=d1Mx7F8vuFQ717txo2z5u9e60gwU6V5WOZ56oNzuKzPMejmWhcy6kLidmBlu1wqP9M
         YIA44zyV102pXYiuy0tw1E3+V0MFx+HRW8Vgfoku3d34cZhLrzYPUw/KkoMejLBt2zlm
         coY1JLBwdqbXo55vfaFK6oaSWpiZUa6T08YVIJJ5XQ3WX5eJwxqBnRKVcahWBQIgtNFt
         xgiJPf9sVOsy80UAmX3Ch7A6LaKy/r91PKrJLsGCuc8vZOb+mNt2AsGma6WqrYNE39yK
         a/gCgo0Hi+CnlvyCtQEvtjPI4tWi/uyuXr0FL3uDsa59G0xMgXKcqbMTCL2cj7cgDn2a
         9Vig==
X-Gm-Message-State: AOAM532OlsaBub7eu+/xtDvYG/KYt9VE68kgxHF0sofL8dlRw9Z/mFd+
        MKh/vUuGfBDtNt2OkO25SHM/F66twTtgLw==
X-Google-Smtp-Source: ABdhPJylH7FYNdX5N6Zj7hZbR0Hj+qCPsALpWPT3096Dzbi/A4d9p60g41YsrM6hwQRPIbFVc7Lkvgke0J+P+A==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a0d:d7c3:0:b0:2e5:8fc6:ed98 with SMTP id
 z186-20020a0dd7c3000000b002e58fc6ed98mr21743104ywd.206.1647826640389; Sun, 20
 Mar 2022 18:37:20 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:37:00 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.6.Idb90bd382a52c8c0bc6fb5d936a9d5e5afac1fb5@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 6/9] adv_monitor: Do not merge monitors with
 non-overlapping RSSI
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

Merging two monitors with different RSSI thresholds is not possible
if their RSSI ranges do not overlap.

Example:
         Monitor 1: -40 -80         Result: Merge with updated RSSI
         Monitor 2: -60 -100                thresholds -60 -100

         Monitor 1: -40 -100        Result: Merge with updated RSSI
         Monitor 2: -60 -80                 thresholds -60 -100

         Monitor 1: -40 -60         Result: Do not merge
         Monitor 2: -80 -100

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/adv_monitor.c | 58 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 77b8ea10d..85231557e 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -251,6 +251,46 @@ static void merged_pattern_free(void *data)
 	free(merged_pattern);
 }
 
+/* Checks if merging monitors with different RSSI Thresh is possible or not */
+static bool merge_is_possible(
+			struct adv_monitor_merged_pattern *existing_pattern,
+			struct adv_monitor *monitor)
+{
+	const struct queue_entry *q_entry;
+	struct adv_monitor *q_data;
+
+	/* Merging two monitors with different RSSI thresholds is not possible
+	 * if their RSSI ranges do not overlap.
+	 */
+
+	q_entry = queue_get_entries(existing_pattern->monitors);
+
+	while (q_entry) {
+		q_data = q_entry->data;
+
+		if (q_data->rssi.low_rssi >= monitor->rssi.high_rssi ||
+		    monitor->rssi.low_rssi >= q_data->rssi.high_rssi)
+			goto fail;
+
+		q_entry = q_entry->next;
+	}
+
+	return true;
+
+fail:
+	monitor->state = MONITOR_STATE_FAILED;
+	merged_pattern_free(monitor->merged_pattern);
+	monitor->merged_pattern = NULL;
+
+	btd_error(monitor->app->manager->adapter_id,
+			"Adv Monitor at path %s is in conflict with "
+			"an existing Adv Monitor at path %s",
+			g_dbus_proxy_get_path(monitor->proxy),
+			g_dbus_proxy_get_path(q_data->proxy));
+
+	return false;
+}
+
 /* Returns the smaller of the two integers |a| and |b| which is not equal to the
  * |unset| value. If both are unset, return unset.
  */
@@ -291,14 +331,9 @@ static void merge_rssi(const struct rssi_parameters *a,
 	 */
 	merged->high_rssi_timeout = 0;
 
-	/* Sampling period is not implemented yet in userspace. There is no
-	 * good value if the two values are different, so just choose 0 for
-	 * always reporting, to avoid missing packets.
-	 */
-	if (a->sampling_period != b->sampling_period)
-		merged->sampling_period = 0;
-	else
-		merged->sampling_period = a->sampling_period;
+	merged->sampling_period = get_smaller_not_unset(a->sampling_period,
+					b->sampling_period,
+					ADV_MONITOR_UNSET_SAMPLING_PERIOD);
 }
 
 /* Two merged_pattern are considered equal if all the following are true:
@@ -1249,6 +1284,13 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 						monitor->merged_pattern);
 		merged_pattern_add(monitor->merged_pattern);
 	} else {
+		if (!merge_is_possible(existing_pattern, monitor)) {
+			monitor_destroy(monitor);
+			DBG("Adv Monitor at path %s released due to existing "
+				"monitor", path);
+			return;
+		}
+
 		/* Since there is a matching pattern, abandon the one we have */
 		merged_pattern_free(monitor->merged_pattern);
 		monitor->merged_pattern = existing_pattern;
-- 
2.35.1.894.gb6a874cedc-goog

