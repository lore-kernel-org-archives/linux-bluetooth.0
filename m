Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40FFC433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F96239E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhANHqB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbhANHqA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 02:46:00 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C416C061795
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:14 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id e25so3858494qka.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SLgtvjC0Lljm2k1u30XsWToHzEp9zSGY0oxQ92lNWm4=;
        b=K9JnFIT0/IrNwHJRZ1E0QmU1RVB/tbRQRMXNEyGOcy+1f5ot17RVY7YqLdiymhjxhm
         1BWclkBpYPi53CqEmeJwh/KVZzjhxEWICQjIi+y0uyui3eNyVyZQK2XdGOPus1ldWp09
         Xngpi1oUf6NRiGHevTVn5YDdogeVQtrTo0BR0sT71jVuVmZ50eW2Sg+RUJBq46+5o8aI
         My1qfLTc4o75XhAGuoLZUNl5bPB5L3Yey2Z+oXixAFx5verD5hi6LmdIy3Ib/yxcScqx
         hN7hHgEohbOXTnbCptyJxWMuikY6tX9qs45AsgLoeDwMuNvZH1ItHPpY4BjT0M9UomY3
         xXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SLgtvjC0Lljm2k1u30XsWToHzEp9zSGY0oxQ92lNWm4=;
        b=pmOf60CVHoI4YrUzccbzmMSAETLtWeQ/dl9CWo1CNA9XtMB+6zUbq/IuGD48vTbzH6
         gHt9bpnld8KqCZqbt4S2eKujqc1NBn92+6MS8lQ9809ubAAz5fN9qowN979R1fJa6s6X
         JCAAAr2dyejS9ojt5Zfvnzvd2EohaxTjlbXTIfFp+Xhkrbs3U81O+dZ+/AfdDyNFg0lN
         eH/e8U6+pfT/FokVsu48FdIpOeDzi3phOtR/+5GAxrdy1KOKf0X02MNSdK1DIb4Seq+Y
         OtFhsCJhFZtFr5qEhw8iRqL8jWtzmWjLI4V0xMOelWULupk2GMUPn4yTn5DdTZ/BHc2E
         gy1w==
X-Gm-Message-State: AOAM532azsNPyeybCv/o3Ec+huHkhFBQNJLkfEVZTDBaX7Zkty+kYjcf
        w2PaTCVSQITUTz+g0Oyyv7Gg/wNbMQbTBejsTYrRNWrI8w1JrQHTD8++9vt17vgPO7/A7PDlBdW
        E1TwvqhrJ9nDYhG80NPA2dMtvw2HijWwkAlMoVXlFV7sfo7JRyT5N9CA04KF9ms8Fp1oQewJc3t
        m2
X-Google-Smtp-Source: ABdhPJxVYFhBA8UO+DHrlKVnVUy1k8dlZvzSig2nDdWGA/Rffs3CG+Ko9am6df4D4Kc/BVPDtsmwZFiTRM+Z
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:8304:: with SMTP id
 j4mr6032763qva.18.1610610313536; Wed, 13 Jan 2021 23:45:13 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:44:55 +0800
In-Reply-To: <20210114074458.3399055-1-apusaka@google.com>
Message-Id: <20210114154405.Bluez.v3.2.I9a37334cdf4a6eaadc1850f5a777e724e9a7081c@changeid>
Mime-Version: 1.0
References: <20210114074458.3399055-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v3 2/5] src/adv_monitor: add monitor with rssi support
 for mgmt
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Using the new opcode MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI to
monitor advertisement according to some RSSI criteria.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

Changes in v3:
* split the struct RSSIThresholdsAndTimers

 src/adv_monitor.c | 267 ++++++++++++++++++++++++++++++----------------
 1 file changed, 174 insertions(+), 93 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 5a0498ec2e..54751db0b5 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -41,9 +41,14 @@
 #define ADV_MONITOR_UNSET_RSSI		127	/* dBm */
 #define ADV_MONITOR_MAX_RSSI		20	/* dBm */
 #define ADV_MONITOR_MIN_RSSI		-127	/* dBm */
-#define ADV_MONITOR_UNSET_TIMER		0	/* second */
-#define ADV_MONITOR_MIN_TIMER		1	/* second */
-#define ADV_MONITOR_MAX_TIMER		300	/* second */
+#define ADV_MONITOR_UNSET_TIMEOUT	0	/* second */
+#define ADV_MONITOR_MIN_TIMEOUT		1	/* second */
+#define ADV_MONITOR_MAX_TIMEOUT		300	/* second */
+#define ADV_MONITOR_DEFAULT_LOW_TIMEOUT	5	/* second */
+#define ADV_MONITOR_DEFAULT_HIGH_TIMEOUT 10	/* second */
+#define ADV_MONITOR_UNSET_SAMPLING_PERIOD 256	/* 100 ms */
+#define ADV_MONITOR_MAX_SAMPLING_PERIOD	255	/* 100 ms */
+#define ADV_MONITOR_DEFAULT_SAMPLING_PERIOD 0	/* 100 ms */
 
 struct btd_adv_monitor_manager {
 	struct btd_adapter *adapter;
@@ -95,6 +100,10 @@ struct adv_monitor {
 	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
 	int8_t low_rssi;		/* Low RSSI threshold */
 	uint16_t low_rssi_timeout;	/* Low RSSI threshold timeout */
+	uint16_t sampling_period;	/* Merge packets in the same timeslot.
+					 * Currenly unimplemented in user space.
+					 * Used only to pass data to kernel.
+					 */
 	struct queue *devices;		/* List of adv_monitor_device objects */
 
 	enum monitor_type type;		/* MONITOR_TYPE_* */
@@ -360,9 +369,10 @@ static struct adv_monitor *monitor_new(struct adv_monitor_app *app,
 	monitor->state = MONITOR_STATE_NEW;
 
 	monitor->high_rssi = ADV_MONITOR_UNSET_RSSI;
-	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
+	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
 	monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
-	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
+	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+	monitor->sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
 	monitor->devices = queue_new();
 
 	monitor->type = MONITOR_TYPE_NONE;
@@ -423,103 +433,119 @@ failed:
 	return false;
 }
 
-/* Retrieves RSSIThresholdsAndTimers from the remote Adv Monitor object,
+/* Retrieves RSSI thresholds and timeouts from the remote Adv Monitor object,
  * verifies the values and update the local Adv Monitor
  */
 static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 					const char *path)
 {
-	DBusMessageIter prop_struct, iter;
-	int16_t h_rssi, l_rssi;
-	uint16_t h_rssi_timer, l_rssi_timer;
+	DBusMessageIter iter;
+	GDBusProxy *proxy = monitor->proxy;
+	int16_t h_rssi = ADV_MONITOR_UNSET_RSSI;
+	int16_t l_rssi = ADV_MONITOR_UNSET_RSSI;
+	uint16_t h_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+	uint16_t l_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+	int16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
-	/* Property RSSIThresholdsAndTimers is optional */
-	if (!g_dbus_proxy_get_property(monitor->proxy,
-					"RSSIThresholdsAndTimers",
-					&prop_struct)) {
-		DBG("Adv Monitor at path %s provides no RSSI thresholds and "
-			"timeouts", path);
-		return true;
+	/* Extract RSSIHighThreshold */
+	if (g_dbus_proxy_get_property(proxy, "RSSIHighThreshold", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT16)
+			goto failed;
+		dbus_message_iter_get_basic(&iter, &h_rssi);
 	}
 
-	if (dbus_message_iter_get_arg_type(&prop_struct) != DBUS_TYPE_STRUCT)
-		goto failed;
-
-	dbus_message_iter_recurse(&prop_struct, &iter);
-
-	/* Extract HighRSSIThreshold */
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT16)
-		goto failed;
-	dbus_message_iter_get_basic(&iter, &h_rssi);
-	if (!dbus_message_iter_next(&iter))
-		goto failed;
+	/* Extract RSSIHighTimeout */
+	if (g_dbus_proxy_get_property(proxy, "RSSIHighTimeout", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto failed;
+		dbus_message_iter_get_basic(&iter, &h_rssi_timeout);
+	}
 
-	/* Extract HighRSSIThresholdTimer */
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
-		goto failed;
-	dbus_message_iter_get_basic(&iter, &h_rssi_timer);
-	if (!dbus_message_iter_next(&iter))
-		goto failed;
+	/* Extract RSSILowThreshold */
+	if (g_dbus_proxy_get_property(proxy, "RSSILowThreshold", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT16)
+			goto failed;
+		dbus_message_iter_get_basic(&iter, &l_rssi);
+	}
 
-	/* Extract LowRSSIThreshold */
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT16)
-		goto failed;
-	dbus_message_iter_get_basic(&iter, &l_rssi);
-	if (!dbus_message_iter_next(&iter))
-		goto failed;
+	/* Extract RSSILowTimeout */
+	if (g_dbus_proxy_get_property(proxy, "RSSILowTimeout", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto failed;
+		dbus_message_iter_get_basic(&iter, &l_rssi_timeout);
+	}
 
-	/* Extract LowRSSIThresholdTimer */
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
-		goto failed;
-	dbus_message_iter_get_basic(&iter, &l_rssi_timer);
+	/* Extract RSSISamplingPeriod */
+	if (g_dbus_proxy_get_property(proxy, "RSSISamplingPeriod", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto failed;
+		dbus_message_iter_get_basic(&iter, &sampling_period);
+	}
 
-	/* Verify the values of RSSIs and their timers. For simplicity, we
-	 * enforce the all-or-none rule to these fields. In other words, either
-	 * all are set to the unset values or all are set within valid ranges.
+	/* Verify the values of RSSIs and their timeouts. All fields should be
+	 * either set to the unset values or are set within valid ranges.
+	 * If the fields are only partially set, we would try our best to fill
+	 * in with some sane values.
 	 */
 	if (h_rssi == ADV_MONITOR_UNSET_RSSI &&
 		l_rssi == ADV_MONITOR_UNSET_RSSI &&
-		h_rssi_timer == ADV_MONITOR_UNSET_TIMER &&
-		l_rssi_timer == ADV_MONITOR_UNSET_TIMER) {
+		h_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
+		l_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
+		sampling_period == ADV_MONITOR_UNSET_SAMPLING_PERIOD) {
 		goto done;
 	}
 
+	if (l_rssi == ADV_MONITOR_UNSET_RSSI)
+		l_rssi = ADV_MONITOR_MIN_RSSI;
+
+	if (h_rssi == ADV_MONITOR_UNSET_RSSI)
+		h_rssi = l_rssi;
+
+	if (l_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT)
+		l_rssi_timeout = ADV_MONITOR_DEFAULT_LOW_TIMEOUT;
+
+	if (h_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT)
+		h_rssi_timeout = ADV_MONITOR_DEFAULT_HIGH_TIMEOUT;
+
+	if (sampling_period == ADV_MONITOR_UNSET_SAMPLING_PERIOD)
+		sampling_period = ADV_MONITOR_DEFAULT_SAMPLING_PERIOD;
+
 	if (h_rssi < ADV_MONITOR_MIN_RSSI || h_rssi > ADV_MONITOR_MAX_RSSI ||
 		l_rssi < ADV_MONITOR_MIN_RSSI ||
-		l_rssi > ADV_MONITOR_MAX_RSSI || h_rssi <= l_rssi) {
+		l_rssi > ADV_MONITOR_MAX_RSSI || h_rssi < l_rssi) {
 		goto failed;
 	}
 
-	if (h_rssi_timer < ADV_MONITOR_MIN_TIMER ||
-		h_rssi_timer > ADV_MONITOR_MAX_TIMER ||
-		l_rssi_timer < ADV_MONITOR_MIN_TIMER ||
-		l_rssi_timer > ADV_MONITOR_MAX_TIMER) {
+	if (h_rssi_timeout < ADV_MONITOR_MIN_TIMEOUT ||
+		h_rssi_timeout > ADV_MONITOR_MAX_TIMEOUT ||
+		l_rssi_timeout < ADV_MONITOR_MIN_TIMEOUT ||
+		l_rssi_timeout > ADV_MONITOR_MAX_TIMEOUT) {
 		goto failed;
 	}
 
+	if (sampling_period > ADV_MONITOR_MAX_SAMPLING_PERIOD)
+		goto failed;
+
 	monitor->high_rssi = h_rssi;
 	monitor->low_rssi = l_rssi;
-	monitor->high_rssi_timeout = h_rssi_timer;
-	monitor->low_rssi_timeout = l_rssi_timer;
+	monitor->high_rssi_timeout = h_rssi_timeout;
+	monitor->low_rssi_timeout = l_rssi_timeout;
+	monitor->sampling_period = sampling_period;
 
 done:
 	DBG("Adv Monitor at %s initiated with high RSSI threshold %d, high "
 		"RSSI threshold timeout %d, low RSSI threshold %d, low RSSI "
-		"threshold timeout %d", path, monitor->high_rssi,
-		monitor->high_rssi_timeout, monitor->low_rssi,
-		monitor->low_rssi_timeout);
+		"threshold timeout %d, sampling period %d", path,
+		monitor->high_rssi, monitor->high_rssi_timeout,
+		monitor->low_rssi, monitor->low_rssi_timeout,
+		monitor->sampling_period);
 
 	return true;
 
 failed:
-	monitor->high_rssi = ADV_MONITOR_UNSET_RSSI;
-	monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
-	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
-	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
-
 	btd_error(adapter_id,
-			"Invalid argument of property RSSIThresholdsAndTimers "
+			"Invalid argument of RSSI thresholds and timeouts "
 			"of the Adv Monitor at path %s",
 			path);
 
@@ -673,16 +699,88 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	DBG("Adv monitor with handle:0x%04x added", monitor->monitor_handle);
 }
 
-static void monitor_copy_patterns(void *data, void *user_data)
+static bool monitor_rssi_is_unset(struct adv_monitor *monitor)
 {
-	struct bt_ad_pattern *pattern = data;
-	struct mgmt_cp_add_adv_monitor *cp = user_data;
+	return monitor->high_rssi == ADV_MONITOR_UNSET_RSSI &&
+		monitor->low_rssi == ADV_MONITOR_UNSET_RSSI &&
+		monitor->high_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
+		monitor->low_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
+		monitor->sampling_period == ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+}
 
-	if (!pattern)
-		return;
+/* sends MGMT_OP_ADD_ADV_PATTERNS_MONITOR */
+static bool monitor_send_add_pattern(struct adv_monitor *monitor)
+{
+	struct mgmt_cp_add_adv_monitor *cp = NULL;
+	uint8_t pattern_count, cp_len;
+	const struct queue_entry *e;
+	bool success = true;
+
+	pattern_count = queue_length(monitor->patterns);
+	cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);
 
-	memcpy(cp->patterns + cp->pattern_count, pattern, sizeof(*pattern));
-	cp->pattern_count++;
+	cp = malloc0(cp_len);
+	if (!cp)
+		return false;
+
+	for (e = queue_get_entries(monitor->patterns); e; e = e->next) {
+		struct bt_ad_pattern *pattern = e->data;
+
+		memcpy(&cp->patterns[cp->pattern_count++], pattern,
+							sizeof(*pattern));
+	}
+
+	if (!mgmt_send(monitor->app->manager->mgmt,
+			MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+			monitor->app->manager->adapter_id, cp_len, cp,
+			add_adv_patterns_monitor_cb, monitor, NULL)) {
+		error("Unable to send Add Adv Patterns Monitor command");
+		success = false;
+	}
+
+	free(cp);
+	return success;
+}
+
+/* sends MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI */
+static bool monitor_send_add_pattern_rssi(struct adv_monitor *monitor)
+{
+	struct mgmt_cp_add_adv_patterns_monitor_rssi *cp = NULL;
+	uint8_t pattern_count, cp_len;
+	const struct queue_entry *e;
+	bool success = true;
+
+	pattern_count = queue_length(monitor->patterns);
+	cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);
+
+	cp = malloc0(cp_len);
+	if (!cp)
+		return false;
+
+	cp->rssi.high_threshold = monitor->high_rssi;
+	/* High threshold timeout is unsupported in kernel. Value must be 0. */
+	cp->rssi.high_threshold_timeout = 0;
+	cp->rssi.low_threshold = monitor->low_rssi;
+	cp->rssi.low_threshold_timeout = htobs(monitor->low_rssi_timeout);
+	cp->rssi.sampling_period = monitor->sampling_period;
+
+	for (e = queue_get_entries(monitor->patterns); e; e = e->next) {
+		struct bt_ad_pattern *pattern = e->data;
+
+		memcpy(&cp->patterns[cp->pattern_count++], pattern,
+							sizeof(*pattern));
+	}
+
+	if (!mgmt_send(monitor->app->manager->mgmt,
+			MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI,
+			monitor->app->manager->adapter_id, cp_len, cp,
+			add_adv_patterns_monitor_cb, monitor, NULL)) {
+		error("Unable to send Add Adv Patterns Monitor RSSI command");
+		success = false;
+	}
+
+	free(cp);
+	return success;
 }
 
 /* Handles an Adv Monitor D-Bus proxy added event */
@@ -690,8 +788,6 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct adv_monitor *monitor;
 	struct adv_monitor_app *app = user_data;
-	struct mgmt_cp_add_adv_monitor *cp = NULL;
-	uint8_t pattern_count, cp_len;
 	uint16_t adapter_id = app->manager->adapter_id;
 	const char *path = g_dbus_proxy_get_path(proxy);
 	const char *iface = g_dbus_proxy_get_interface(proxy);
@@ -725,24 +821,12 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
 	queue_push_tail(app->monitors, monitor);
 
-	pattern_count = queue_length(monitor->patterns);
-	cp_len = sizeof(struct mgmt_cp_add_adv_monitor) +
-			pattern_count * sizeof(struct mgmt_adv_pattern);
-
-	cp = malloc0(cp_len);
-	queue_foreach(monitor->patterns, monitor_copy_patterns, cp);
-
-	if (!mgmt_send(app->manager->mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
-			adapter_id, cp_len, cp, add_adv_patterns_monitor_cb,
-			monitor, NULL)) {
-		error("Unable to send Add Adv Patterns Monitor command");
-		goto done;
-	}
+	if (monitor_rssi_is_unset(monitor))
+		monitor_send_add_pattern(monitor);
+	else
+		monitor_send_add_pattern_rssi(monitor);
 
 	DBG("Adv Monitor allocated for the object at path %s", path);
-
-done:
-	free(cp);
 }
 
 /* Handles the removal of an Adv Monitor D-Bus proxy */
@@ -1428,10 +1512,7 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	 * DeviceFound() event without tracking for the RSSI as the Adv has
 	 * already matched the pattern filter.
 	 */
-	if (monitor->high_rssi == ADV_MONITOR_UNSET_RSSI &&
-		monitor->low_rssi == ADV_MONITOR_UNSET_RSSI &&
-		monitor->high_rssi_timeout == ADV_MONITOR_UNSET_TIMER &&
-		monitor->low_rssi_timeout == ADV_MONITOR_UNSET_TIMER) {
+	if (monitor_rssi_is_unset(monitor)) {
 		DBG("Calling DeviceFound() on Adv Monitor of owner %s "
 		    "at path %s", monitor->app->owner, monitor->path);
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

