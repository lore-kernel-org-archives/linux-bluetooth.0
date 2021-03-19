Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B83C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71E764F6A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 07:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhCSH4T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Mar 2021 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhCSH4E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Mar 2021 03:56:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1AC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Mar 2021 00:56:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l83so4978998ybf.22
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Mar 2021 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qEo7eMhd1fs7+hM3w/F7N5TuWClCSuyBcIimRK9297E=;
        b=qPCwRQOa9CD0ZgxjVhn7A0iOP12oNdNo2ndxVVcsbd3/LGpNcgLAvZqLoz122bweIs
         HlY80YA7hJLDzQdhyXXv+0xJVAWzpGHprKMUaMyMebr1i5e7yxSf4+vRbaceTZ9QhM18
         75qRQO+M1OHuukJVBg+6DmjXeYB+DZDZlJW34OHQ/O8mXJrJdn3NPK1fxUoRNnjn7sIW
         LBA2IeIEsVl8FxwkwMwdKKyTADcYwj44s2I/xkwLnj57nRP0Q3h69/Ls0rvF41ZCzQtj
         Frzeo0hMHYyhHk0hr//cy0YPbKhNJdVCs2FcMS7l3dmWecSduicaigvxtFqwAjkLw4dp
         0oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qEo7eMhd1fs7+hM3w/F7N5TuWClCSuyBcIimRK9297E=;
        b=jrQqFo4edE4TualKIrgYjYbJHTA6Sm9BQZNrAPJyu4MQdmfcfPepZ8C/aMO+v4fGzC
         bmgzy+jk/jbjMGFy+8mRNPWO1TVDV1bBDgKeWytXYJBnoElpe4i0aTB5LXjR4LoTkma/
         18a6dIkOliHdnryfA/BZ065YfvjrNwKiqtCOVuLoI2DF64bAx2UApMIDMthjyh1vxtXg
         kZ2EpHkAQBgf+JoAzmc+/a2GnOc+LUECV03wYP7zm1of46ok+nvRAR4Xaf97CmbSdTgM
         qT0epM3FTGGfhcF/3QsQhhzPzyWmB/o8QCV9n9ojOyxEQIMaDp2C+9WZqBBvEhef0xmt
         yvLw==
X-Gm-Message-State: AOAM532/YrIz+CWOnamkVx+3moRswrTIkAPY8V4l/oCECZGAAuTQgQGE
        Q4PSVYp0H5PJeRAneJjmqHI6IcFMADGRQZd9BE0tkD2AQDBvR8Ib7tW13qwJ3+zk8r+nHFffTbr
        afHwpYZRLbZJWHCN8XzwrDAwpWu869CTaV+Xz+lhweG2DoG5pYWpuXGPhVKAWTnhepk0/c6N39g
        Ke
X-Google-Smtp-Source: ABdhPJx4IbdFTJgbRwYFFkMrSExeVa6fZ3b6Ii2i1OZnjBiIkyvzJMqHEpo1BREvDkNth5pILnhWyew8wCxA
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:10ee:e87b:4f94:9c1a])
 (user=apusaka job=sendgmr) by 2002:a25:b94b:: with SMTP id
 s11mr4978454ybm.232.1616140560995; Fri, 19 Mar 2021 00:56:00 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:55:52 +0800
Message-Id: <20210319155542.Bluez.v2.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v2 1/2] adv_monitor: split rssi_parameters into its own struct
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

