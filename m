Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9AFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiDMU5u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiDMU5b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6719D71EEB
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ec0490dc1bso26718477b3.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0lBl5MKCkM7Tt+RyKRaq77MJ8KNp3O7zGBlqRNQca14=;
        b=A7+mMeLUdwcNR3VngEVpWmqNg2t3FS7xPQz3tJysUu/3lHjgEQq7v9/bh65U4pG/Ub
         ZKy5QjNvEQIN7axzQpIV499GR+zfZC7OziBxRqi0OTXkMBD4HEODv5Zw0425OncVK63Z
         poQgPsCv/IMWWaL0d2hm71964Y0knVlK35oiosdw0Y4somMYmbT3QEry2IiMFeJEAN07
         6VxqbDzRW8Y0nsEW7G/Op758k713/T+ZdVl+hoJd2cIg2dju3QlTlXhrESlG92S7tk3s
         UZnxWbcFQQG9kbjxq1w6OkkYVdoB7HYs3kMl4iErRdcJ9FKXij6x3zGdIjhxrFsiGzqf
         RzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0lBl5MKCkM7Tt+RyKRaq77MJ8KNp3O7zGBlqRNQca14=;
        b=6ObiTzoZE4IkLRqqY4/GOceNbateTnON3NdU7bcX4FM9i1+fNcaV+Fwsg/vMPqeyaU
         W6b3pthKvBenGKFmCEn08Im11mPjb6MnBvW2LVt3900a2k16owaipdOdsUSuNFoHqgrY
         IDOaWWIUmT5tMv4qfPDB+ML4nDYztSLHmZSoQwqU53CHgnXRTi0SBZZoZ1tPsVFpMzpX
         UbO/CHmOaSBhlcW8spH1XsFmsPzi5K0/BKOfvNv73Zfy4+SGG8ECqvHt2gbYnzaT/46d
         NXCssNPEz8Gb804fiNcYQXisqvZxK6Y1w8dpfJykQxWL+QQ8HxztEsU/uL6DJlCbqmPy
         qZNQ==
X-Gm-Message-State: AOAM533Ut2nURlCLho/T+c7OERZWzX/X8WRvXQzcEU0/+N8x6NY3+vhO
        CklLtNLvyHOP8nlxoBKuwXmalyimv7vnVA==
X-Google-Smtp-Source: ABdhPJy5daEXqAA7nbgU9JqPfKkBcdJDXXB3fpspfh14Tv75dUtAvah95R0EE/7h3MGpdyfbl+5m2zjWvM1C9A==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a25:ced1:0:b0:640:df7f:398 with SMTP id
 x200-20020a25ced1000000b00640df7f0398mr696044ybe.162.1649883308663; Wed, 13
 Apr 2022 13:55:08 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:46 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.6.Idb90bd382a52c8c0bc6fb5d936a9d5e5afac1fb5@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 6/9] adv_monitor: Do not merge monitors with
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

(no changes since v1)

 src/adv_monitor.c | 58 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index c01f8b154..d88e1bbbb 100644
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
2.36.0.rc0.470.gd361397f0d-goog

