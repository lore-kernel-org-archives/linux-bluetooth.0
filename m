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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCACC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8932371F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbhAOLwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbhAOLwc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 06:52:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F810C061794
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e137so5958766ybf.16
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ielgrcP49LHH1VpB3/ARC5cdWx2B3nQRImOXhZrClJk=;
        b=tfgbQeqEh07mZwFgWeb0868RHURUwTkPSNjNgye1SEkD8/5Z9yB0fll2MG+q0tQMM6
         EGroXb4Ja75ngyUjOM3/jiGhYnczncZL+y7nH0LctaOv12FqenT6REk54Cg3uAFOLAeu
         NzWPRLzFpt+jef7XSFZiS4nwnQ7CtFr64eaQsiaALbmbeK5mQRXEVROhg4BzKtIx4zXY
         KWIaPMlSQVCJ/qAPYiVB6BD5uHzesWMyYTLn6KkVsnI73vo05gRpMjaZCjqt0ANGVxm1
         FEa89/MVrtjYJdb2f+j9KMWgznsByXjDAmiWJvwp6gNnf9KYWJKEYnCeq4gsyBBhhmR8
         ppYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ielgrcP49LHH1VpB3/ARC5cdWx2B3nQRImOXhZrClJk=;
        b=E6wcBHLBIa+yFiZEQ4d712fjAL91BvjIerIPfPZ2iOOmIhMFTFO1a6GcDwjgnIunq4
         0AfoX/cWgrolpBNzn1NLh9N7i4MmtwXK7gU9FGXi1nruzEIF2NbjPdUWJbTEvmsdzbj8
         ySW7ciu62wQqYFlGxwgMEMxcAP2Q3AhzWfhqyObAQRaXsmfE4gX2kIuVGRAPUYAXF9vN
         1EZ9Ba+47NUUIGHOQzbpDqEAs1lFWDbXUmin+MoDrm9OzUfr0kNIh2As3WnKMcZXo5Dk
         +aE/xIpcdGl651MTSMYGnDmciStiB6L2yZr21WleXvDu3Jrwlu5l9MSXv3CsyWjIxOZl
         LnEg==
X-Gm-Message-State: AOAM533E1n1sYx1X4JDUzTUteb39Ef8ghMc7UzgAckuxPhJjNS4ojBx5
        wtYHdco7rLZ08lacXlSY27VKjddBPc/5nqrBJ8cZT86CrFiyFBMca4XgB9smeFjS9sIdUeNceZU
        +ViRgfP1QmGHoJoytip4Zij3cfMbciR7gLYYI69Mx9TSd3Ms2A1rC4z5706HJLKuyX68rbQu6FX
        QY
X-Google-Smtp-Source: ABdhPJwu3iZkpWnzqEsOtMQZuQRpDcfft6+gGO5oWcJRX3jNVHJ2QKJM9tRAyWFxGZ9VU57gBfvMnXOI/ljJ
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:6f86:: with SMTP id
 k128mr16946615ybc.313.1610711511783; Fri, 15 Jan 2021 03:51:51 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:50:39 +0800
In-Reply-To: <20210115115036.3973761-1-apusaka@google.com>
Message-Id: <20210115194853.Bluez.v4.3.I9a37334cdf4a6eaadc1850f5a777e724e9a7081c@changeid>
Mime-Version: 1.0
References: <20210115115036.3973761-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [Bluez PATCH v4 3/6] src/adv_monitor: add monitor with rssi support
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

(no changes since v3)

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
2.30.0.296.g2bfb1c46d8-goog

