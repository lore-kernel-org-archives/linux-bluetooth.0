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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 03:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5985E6193A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 03:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhC3Doo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhC3Dom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Mar 2021 23:44:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C08C061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 20:44:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 10so806389ybx.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 20:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fDdUnG1btjDRhbr46RufasH/jjaun0Sc2srPDeLum20=;
        b=anTg8mYrq3HI7q635g555hDAiqtVANwmXL3KDC6bUScO38s/Gpbm2xco0Z/IVZec+b
         JV5G+P/sgHVsVYLCldY4MVUk8lrB/Jy74hwMqv4d9elrsQeXSoNq7twYyOPFryzsrADS
         bhT0D02jDhAGRj6M3vbWEsfOOYzAskLgYvAcpHq9imUe5W4VsXGACY3GqPmV2ydm0LKX
         2Cw2j/f370Sl8PvkjEYCnlVJNG4nBeIwaINRga5ERmEUaRHa12dfYeWtryXiedRJJ3vs
         GPReABF4cIYmq+Zncid9lC19X1a7zYY9tifsMVw+f2mfg9LkA+qpGlwS/pOrSnyGm98J
         uHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fDdUnG1btjDRhbr46RufasH/jjaun0Sc2srPDeLum20=;
        b=hlxljStEjUImuIKnPpKOzmCX/ux2WwZkle6CpwmIyXjHhrAHePHx97FH/XVnUwOMfs
         AW64pUE7+SUQWrVMbpntPfOfT0gIYSgmFGOzGYMe/gasyKQle7+1RiaSVSwvUSqTO8xP
         SKSO/BO2OMaCCjR5GTZdfz94QlfZ4EfrCGOC150UnEICaTWPaZqUNp6H9OxZylcK0iE5
         XAAVA9oRakbuMKWpERFu50+hQgDh2qabdGco7w9/mPt+cws7rRVMrdt7OldF6Eo5QLEu
         MCocIEf38zJ6M8lKfnahjiA4wxdue76IbWQUg6gW4hztKZX03WLX2g0EnASYTj53OaM9
         5Ffw==
X-Gm-Message-State: AOAM531MJXCYUDG+0sn9W1+9dWLzM3XvMm8q/XBErhUmt3HZTxQNqNA1
        5kkfTQdN99gUuAvc5Dfkwc1WrD9jE/73VJ7c8h78P7YTxvzfF2HStp23AcNXBOuf7Iy82rNMWDF
        STmJ76SQdzbNsz9SHj0gVMBPzuzQBxRS9sT2gl7CsfC7fw7owArVEQJIXhOXIVg8IsNIyhzouzj
        ST
X-Google-Smtp-Source: ABdhPJxdWHltfvlDdElKS0Gj8i62ha3hbXwzqxAadfqIr+6xgTBxTkh+h/itV04cC3++T+dVLA+98mbE+qWR
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7941:e3e2:4e34:3f89])
 (user=apusaka job=sendgmr) by 2002:a25:d58:: with SMTP id 85mr40598187ybn.450.1617075881099;
 Mon, 29 Mar 2021 20:44:41 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:44:34 +0800
Message-Id: <20210330114413.Bluez.v5.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH v5 1/2] adv_monitor: split rssi_parameters into its own struct
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
2.31.0.291.g576ba9dcdaf-goog

