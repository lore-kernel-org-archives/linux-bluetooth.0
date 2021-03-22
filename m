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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84118C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0F961972
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 07:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVHvv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVHvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 03:51:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C0C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 00:51:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6so27531951qvu.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qEo7eMhd1fs7+hM3w/F7N5TuWClCSuyBcIimRK9297E=;
        b=jRLwnsQcTWT/YgpopUlgNHsdhNx+bun1x76o+Ok8Ovg3MxPWeD9FxXt/uRDJresl/+
         R3rAyaknXpnECEuq+XXIPjK0XNpnlMQoyvuD0FCRhlkmzgPb02beEWHNRj5LkEE+7+5x
         sUKBwaOPvvYidl2x+wxthmnCkFcbUQQJavMla80XQlqJ0W8boMb9HPiQ8KOrFShEnhgh
         +K0B5hpDOpsaX1VKiGkKvgni6Mi34JcQ22SgTEtFysSfG/SjLHgEUKVEaF6Lt6H4Nu+B
         ceV7f45RTG3h4IjpIcm5onmmR7gDyOPvA81Pz9NkBTGhxdOQG2R4NOGjzj/57X4S8JIv
         EsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qEo7eMhd1fs7+hM3w/F7N5TuWClCSuyBcIimRK9297E=;
        b=AKWv2aZ5ncT5bzL+toZDl+sPdKWgpZOyPuGkL+P/CHmh0MiKdSZhPbi9bLVbVgih/X
         L1NxE5KgFQr0cWbVYo2gvTGH+zsvInR+zEqDeyVDOIaZrV9wk1KE+BacthDLh+47nutj
         r3RlduiJxL9uO7nuYFFMbz1dz3j22xV8k9LItEh0MJarcPnWIQNys6HOsWkLGKHjI9yA
         IrcdeSl4GF8vjOuNB4EHkAURJfB/uQQNd3x8XdReyTnJCk1YO7loz7gMQXZxaDofayge
         vFDMJ5NDmXX3YYcnrHGa8iAkcqBCAKkPFy5g7wXDH+W1jkCg5eGJw74mMAg1VTt7SO4k
         Rpkw==
X-Gm-Message-State: AOAM531z8AlIz0Foc5SkC6dLfVA+rSI7vbAmHeeeg5cKoEcw3PergQSK
        h4xJZ4pHo+9aXfQ6H735u3yWoqpYl1g342I5RrBCevVABPFue3H3eeF6kMQJL6hyn2zR0DoNvKc
        W2qMlkN3uOZAm7ZUM9I0pBJPpre3Sc0aQ6qi7wq8KLTFKz8lLvgHbDzL6buX5XdUqB5oZzSUj6a
        fX
X-Google-Smtp-Source: ABdhPJyUVT+ADDHrz1W+3JR27qA05G9ahgoPv9ldULFXUwQLYs031px/RaRC9Bvy6X//nIjWY7Sxc6qqbkBP
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:fdf3:9f7d:e4e3:ccad])
 (user=apusaka job=sendgmr) by 2002:a05:6214:d65:: with SMTP id
 5mr2151448qvs.56.1616399509208; Mon, 22 Mar 2021 00:51:49 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:51:42 +0800
Message-Id: <20210322155118.Bluez.v3.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v3 1/2] adv_monitor: split rssi_parameters into its own struct
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This is an intermediary step for the following merge pattern patch.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 99 ++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 33e7c8454d..131dc80039 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -89,14 +89,7 @@ enum monitor_state {
 	MONITOR_STATE_RELEASED,	/* Dbus Object removed by app */
 };
 
-struct adv_monitor {
-	struct adv_monitor_app *app;
-	GDBusProxy *proxy;
-	char *path;
-
-	enum monitor_state state;	/* MONITOR_STATE_* */
-	uint16_t monitor_handle;	/* Kernel Monitor Handle */
-
+struct rssi_parameters {
 	int8_t high_rssi;		/* High RSSI threshold */
 	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
 	int8_t low_rssi;		/* Low RSSI threshold */
@@ -105,6 +98,17 @@ struct adv_monitor {
 					 * Currenly unimplemented in user space.
 					 * Used only to pass data to kernel.
 					 */
+};
+
+struct adv_monitor {
+	struct adv_monitor_app *app;
+	GDBusProxy *proxy;
+	char *path;
+
+	enum monitor_state state;	/* MONITOR_STATE_* */
+	uint16_t monitor_handle;	/* Kernel Monitor Handle */
+
+	struct rssi_parameters rssi;	/* RSSI parameter for this monitor */
 	struct queue *devices;		/* List of adv_monitor_device objects */
 
 	enum monitor_type type;		/* MONITOR_TYPE_* */
@@ -158,6 +162,24 @@ const struct adv_monitor_type {
 	{ },
 };
 
+static void rssi_unset(struct rssi_parameters *rssi)
+{
+	rssi->high_rssi = ADV_MONITOR_UNSET_RSSI;
+	rssi->high_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+	rssi->low_rssi = ADV_MONITOR_UNSET_RSSI;
+	rssi->low_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+	rssi->sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+}
+
+static bool rssi_is_unset(const struct rssi_parameters *rssi)
+{
+	return rssi->high_rssi == ADV_MONITOR_UNSET_RSSI &&
+		rssi->low_rssi == ADV_MONITOR_UNSET_RSSI &&
+		rssi->high_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
+		rssi->low_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
+		rssi->sampling_period == ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+}
+
 /* Replies to an app's D-Bus message and unref it */
 static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
 {
@@ -369,11 +391,7 @@ static struct adv_monitor *monitor_new(struct adv_monitor_app *app,
 
 	monitor->state = MONITOR_STATE_NEW;
 
-	monitor->high_rssi = ADV_MONITOR_UNSET_RSSI;
-	monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
-	monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
-	monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
-	monitor->sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+	rssi_unset(&monitor->rssi);
 	monitor->devices = queue_new();
 
 	monitor->type = MONITOR_TYPE_NONE;
@@ -528,19 +546,19 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 	if (sampling_period > ADV_MONITOR_MAX_SAMPLING_PERIOD)
 		goto failed;
 
-	monitor->high_rssi = h_rssi;
-	monitor->low_rssi = l_rssi;
-	monitor->high_rssi_timeout = h_rssi_timeout;
-	monitor->low_rssi_timeout = l_rssi_timeout;
-	monitor->sampling_period = sampling_period;
+	monitor->rssi.high_rssi = h_rssi;
+	monitor->rssi.low_rssi = l_rssi;
+	monitor->rssi.high_rssi_timeout = h_rssi_timeout;
+	monitor->rssi.low_rssi_timeout = l_rssi_timeout;
+	monitor->rssi.sampling_period = sampling_period;
 
 done:
 	DBG("Adv Monitor at %s initiated with high RSSI threshold %d, high "
 		"RSSI threshold timeout %d, low RSSI threshold %d, low RSSI "
 		"threshold timeout %d, sampling period %d", path,
-		monitor->high_rssi, monitor->high_rssi_timeout,
-		monitor->low_rssi, monitor->low_rssi_timeout,
-		monitor->sampling_period);
+		monitor->rssi.high_rssi, monitor->rssi.high_rssi_timeout,
+		monitor->rssi.low_rssi, monitor->rssi.low_rssi_timeout,
+		monitor->rssi.sampling_period);
 
 	return true;
 
@@ -700,15 +718,6 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 	DBG("Adv monitor with handle:0x%04x added", monitor->monitor_handle);
 }
 
-static bool monitor_rssi_is_unset(struct adv_monitor *monitor)
-{
-	return monitor->high_rssi == ADV_MONITOR_UNSET_RSSI &&
-		monitor->low_rssi == ADV_MONITOR_UNSET_RSSI &&
-		monitor->high_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
-		monitor->low_rssi_timeout == ADV_MONITOR_UNSET_TIMEOUT &&
-		monitor->sampling_period == ADV_MONITOR_UNSET_SAMPLING_PERIOD;
-}
-
 /* sends MGMT_OP_ADD_ADV_PATTERNS_MONITOR */
 static bool monitor_send_add_pattern(struct adv_monitor *monitor)
 {
@@ -758,12 +767,12 @@ static bool monitor_send_add_pattern_rssi(struct adv_monitor *monitor)
 	if (!cp)
 		return false;
 
-	cp->rssi.high_threshold = monitor->high_rssi;
+	cp->rssi.high_threshold = monitor->rssi.high_rssi;
 	/* High threshold timeout is unsupported in kernel. Value must be 0. */
 	cp->rssi.high_threshold_timeout = 0;
-	cp->rssi.low_threshold = monitor->low_rssi;
-	cp->rssi.low_threshold_timeout = htobs(monitor->low_rssi_timeout);
-	cp->rssi.sampling_period = monitor->sampling_period;
+	cp->rssi.low_threshold = monitor->rssi.low_rssi;
+	cp->rssi.low_threshold_timeout = htobs(monitor->rssi.low_rssi_timeout);
+	cp->rssi.sampling_period = monitor->rssi.sampling_period;
 
 	for (e = queue_get_entries(monitor->patterns); e; e = e->next) {
 		struct bt_ad_pattern *pattern = e->data;
@@ -822,7 +831,7 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
 	queue_push_tail(app->monitors, monitor);
 
-	if (monitor_rssi_is_unset(monitor))
+	if (rssi_is_unset(&monitor->rssi))
 		monitor_send_add_pattern(monitor);
 	else
 		monitor_send_add_pattern_rssi(monitor);
@@ -1486,7 +1495,7 @@ static bool handle_device_lost_timeout(gpointer user_data)
 		 * If not, report the Device Lost event.
 		 */
 		if (difftime(curr_time, dev->last_seen) >=
-		    monitor->low_rssi_timeout) {
+		    monitor->rssi.low_rssi_timeout) {
 			dev->found = false;
 
 			DBG("Calling DeviceLost() on Adv Monitor of owner %s "
@@ -1513,7 +1522,7 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	 * DeviceFound() event without tracking for the RSSI as the Adv has
 	 * already matched the pattern filter.
 	 */
-	if (monitor_rssi_is_unset(monitor)) {
+	if (rssi_is_unset(&monitor->rssi)) {
 		DBG("Calling DeviceFound() on Adv Monitor of owner %s "
 		    "at path %s", monitor->app->owner, monitor->path);
 
@@ -1544,22 +1553,22 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	 */
 	if (dev->last_seen) {
 		if (difftime(curr_time, dev->last_seen) >
-		    monitor->high_rssi_timeout) {
+		    monitor->rssi.high_rssi_timeout) {
 			dev->high_rssi_first_seen = 0;
 		}
 
 		if (difftime(curr_time, dev->last_seen) >
-		    monitor->low_rssi_timeout) {
+		    monitor->rssi.low_rssi_timeout) {
 			dev->low_rssi_first_seen = 0;
 		}
 	}
 	dev->last_seen = curr_time;
 
 	/* Check for the found devices (if the device is not already found) */
-	if (!dev->found && rssi > monitor->high_rssi) {
+	if (!dev->found && rssi > monitor->rssi.high_rssi) {
 		if (dev->high_rssi_first_seen) {
 			if (difftime(curr_time, dev->high_rssi_first_seen) >=
-			    monitor->high_rssi_timeout) {
+			    monitor->rssi.high_rssi_timeout) {
 				dev->found = true;
 
 				DBG("Calling DeviceFound() on Adv Monitor "
@@ -1582,10 +1591,10 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	 * it doesn't make any sense to report the Device Lost event if the
 	 * device is not found yet)
 	 */
-	if (dev->found && rssi < monitor->low_rssi) {
+	if (dev->found && rssi < monitor->rssi.low_rssi) {
 		if (dev->low_rssi_first_seen) {
 			if (difftime(curr_time, dev->low_rssi_first_seen) >=
-			    monitor->low_rssi_timeout) {
+			    monitor->rssi.low_rssi_timeout) {
 				dev->found = false;
 
 				DBG("Calling DeviceLost() on Adv Monitor "
@@ -1610,8 +1619,8 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	 */
 	if (dev->found) {
 		dev->lost_timer =
-			timeout_add_seconds(monitor->low_rssi_timeout,
+			timeout_add_seconds(monitor->rssi.low_rssi_timeout,
 					    handle_device_lost_timeout, dev,
-							NULL);
+					    NULL);
 	}
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

