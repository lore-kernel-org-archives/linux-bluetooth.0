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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9DAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 05:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878CE64F6C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 05:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhCSFzQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Mar 2021 01:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhCSFyq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Mar 2021 01:54:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9EC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 22:54:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g17so51296521ybh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 22:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mL3YYovyB/l343U0PDCwGr514dSEZQFQn1NsDm1cNG8=;
        b=UV8hxlaUhxShPNG9eNUex2cBOOqaUZe1aIYUYHZYVVffUVwoc81wPqMFp8oQkdApGa
         TqEK+XFOn5lMDsjFg+T/nJvH/nRXLAmXKLSeh1IyrOEwZHNNPtzWqQpGOHhFbXUgY7jj
         47sl4yf7235BCXTqg7RKjuBfH2/ygzNVCEgUbz8vYRjYTan/p+kRd6RqajE/UADiFryA
         RvxtphDfsNfmv8OyoQv4zf/DqQq/KJOpZ/8tVWaVUbfF7mfiXLshmyBP+hXlAoIwKC1g
         LGa0mkWkkxZihGxl2zF6s+inmT7nJqKi1kNaU6XPTLZnkxTSrcTuwTKmtTQbLuMRhGp9
         XkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mL3YYovyB/l343U0PDCwGr514dSEZQFQn1NsDm1cNG8=;
        b=t2X7va/A5sp+osao+jVGrNppI1gF6aNCg7Yu5ah/hVjoBtdLb3IU5MrUf1pkXHpiTm
         Ss7ozO3IXjH5YdQ+x1BYNy5ZJgMapOfmeMMbNXUb+XSuWDwKxHD44ktZePFvA/HCKrUg
         if+ofHe00AyWjTJkD+KgUD40X0YwUcDwioyWOp3gHJ8BHaMOYIPtSxeeHswAcZ5sOFNP
         x73aW1GrgIsHqs50/Kq/mmCF23dZ3NnushJU4e7LokbIOz0OagQwvHrlT7JKNNmor1PL
         2pgFcvpEsp4Bjj2hmAqzsAdYilk4b+zDmwbLCVP/N6+9v80aWcNFTKSbGO17FOtfKHcW
         xiMQ==
X-Gm-Message-State: AOAM531I4Wvsd5eCRUMgi5PrhQyB2EiZdFzIxee8F+Mco2YFHZbcuCoB
        R7lhwVOyKGKTZoS5X3Fh2fhZq2Hr+Ae/9GK0g4kwj20eP3McI3tOAUU8xNwDOwBEUMXEepuhBQj
        b0XCYinTvfZsWPHLrTZpAtB2MYRkqltuIjruEaYkhe1eX5jMMaqjH+6C7/GPAzd03vhAXuQjAC3
        wZ
X-Google-Smtp-Source: ABdhPJyWGbW9mis2aUE97MEfAJ+4hLcbLT27YQYB5Pj39xT7mSLBC5U94uUTn2dqPiqWuZNfQMnKbj002nr8
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:10ee:e87b:4f94:9c1a])
 (user=apusaka job=sendgmr) by 2002:a25:d084:: with SMTP id
 h126mr4456398ybg.163.1616133285098; Thu, 18 Mar 2021 22:54:45 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:54:29 +0800
Message-Id: <20210319135138.Bluez.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH 1/2] adv_monitor: split rssi_parameters into its own struct
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

