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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5023C433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 03:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7A461936
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 03:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC3DpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhC3Dos (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Mar 2021 23:44:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC4C061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 20:44:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j26so11464558pgj.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iUU42/wyCyhmQ9ZVZQvaqUXOuRMxAdi9nPh5VeFLEyk=;
        b=PEprXZYqFb9GifYLYhSl5elTAmG8G7KUQ8hiXWPD3TG9X6+TbBsj8g56sce86/A6vg
         NEBYB4nKXyofI67Cj41fJOaP77eJKllRSTT5anh5LURRn8kJQfPs96qxT2Cr6bnwLwzV
         P23mymIdQGxqnJBW+mFLXMwwJ2sExoe3NZ6KwnBgnPXYBc1PMEe33Keu9boojkME7HyE
         1S/dj434TEnLjkTXPm9WQJwlKhs0jaRoGqeoGUhJt5bUO+ttxR/bKbIb8b0w5aHFNIde
         grHxKBBSVWu4FBGEC90+WHzOeyB+VNpFlim97YFD1ObvmSwyaR3vVf/AKMY7T7EXJ2f+
         nBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iUU42/wyCyhmQ9ZVZQvaqUXOuRMxAdi9nPh5VeFLEyk=;
        b=AYIfcfgYm20UCRbEtDxKRaggjpYkRWbKUld162k0twXOX9IZxQACRF++UopWmy4oY+
         u2OhcqnathXl+X9yrVf6Wt6LmjkDPLytxzwH4Gl+orX5/58pW4R+2zGCf0G2/zvWA6C0
         jheQZ+U2XHM46uRkU+/LlU9DTwPm+gt5+eTGRHjM26bfnABrxAVFriY+l1GY8QTvKEJ3
         bFvDEuE7+6WGNlY44hQrPFOAoGqtEjhzWUFBoC+cLJYvUB5B9uBOsl/k7SIklCOfTA6H
         daad00B4XYFiZcpMUhCEz95IwBoOuLtKig9TA1K89oKsIP8LOXnvyAz0AqRMa1rOgKfg
         SC/w==
X-Gm-Message-State: AOAM532IAMaoeYq7UL2S51oH0nF88+vNJhm6vmn2OupTtcakN5acroG+
        M71XBDinhyH8t0qxwF/2wJz6UfiKEWVNr21vd1V/iTKsLA6Lov2A8kBZiOgTjaMZXmdou/atraW
        vdehNEsMWAZvevc6wyRUChUuDnArX0JpMKUyIAsWZZfPGW26MnRE1cP0RlEOj3GfRiLASFGtRjE
        Oq
X-Google-Smtp-Source: ABdhPJwymReb+E2Rh2G6LJ8l4fjXfYaYsBt1r9QW88L+XRx3xAnZHamn8W7Bv/uBj0bkJg+knB0mVwPVfd7i
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7941:e3e2:4e34:3f89])
 (user=apusaka job=sendgmr) by 2002:a17:90b:fcb:: with SMTP id
 gd11mr326513pjb.0.1617075886868; Mon, 29 Mar 2021 20:44:46 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:44:35 +0800
In-Reply-To: <20210330114413.Bluez.v5.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Message-Id: <20210330114413.Bluez.v5.2.I2aa61d391caefc5b67213911b5ef02b2ce191633@changeid>
Mime-Version: 1.0
References: <20210330114413.Bluez.v5.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH v5 2/2] adv_monitor: merge monitors with the same pattern
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

Some bluetooth chipset (e.g. Intel) doesn't support MSFT extension
monitors with the same pattern. In order to make them work, and also
to generally make their task easier, we merge monitors with the same
pattern in the userspace. Therefore, each monitor sent to the kernel
will all have different patterns.

If the merged monitor have different RSSI parameter, we would choose
the most lenient parameter of the two, since we can still do
additional filtering in the userspace. This way, we wouldn't miss any
information and can still get the benefit of offloading the filtering.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v5:
* Activate monitor at once if pattern exists and is not queued
* Add check for next_state when deciding pattern 'sameness'
* Fix some "&&" to "||" when checking for monitor nullness and state

Changes in v4:
* Fix parameter data type warning in merged_pattern_is_equal

Changes in v3:
* Use queue_find instead of defining merged_pattern_find

Changes in v2:
* Remove unnecessary variable

 src/adv_monitor.c | 657 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 530 insertions(+), 127 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 131dc80039..2dde8f0343 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -62,6 +62,7 @@ struct btd_adv_monitor_manager {
 	uint8_t max_num_patterns;
 
 	struct queue *apps;	/* apps who registered for Adv monitoring */
+	struct queue *merged_patterns;
 };
 
 struct adv_monitor_app {
@@ -89,6 +90,12 @@ enum monitor_state {
 	MONITOR_STATE_RELEASED,	/* Dbus Object removed by app */
 };
 
+enum merged_pattern_state {
+	MERGED_PATTERN_STATE_ADDING,	/* Adding pattern to kernel */
+	MERGED_PATTERN_STATE_REMOVING,	/* Removing pattern from kernel */
+	MERGED_PATTERN_STATE_STABLE,	/* Idle */
+};
+
 struct rssi_parameters {
 	int8_t high_rssi;		/* High RSSI threshold */
 	uint16_t high_rssi_timeout;	/* High RSSI threshold timeout */
@@ -106,13 +113,30 @@ struct adv_monitor {
 	char *path;
 
 	enum monitor_state state;	/* MONITOR_STATE_* */
-	uint16_t monitor_handle;	/* Kernel Monitor Handle */
 
 	struct rssi_parameters rssi;	/* RSSI parameter for this monitor */
+	struct adv_monitor_merged_pattern *merged_pattern;
+
 	struct queue *devices;		/* List of adv_monitor_device objects */
+};
 
+/* Some chipsets doesn't support multiple monitors with the same pattern.
+ * To solve that and to generally ease their task, we merge monitors with the
+ * same pattern, so those monitors will only be sent once to the kernel.
+ */
+struct adv_monitor_merged_pattern {
+	struct btd_adv_monitor_manager *manager;
+	uint16_t monitor_handle;	/* Kernel Monitor Handle */
+	struct rssi_parameters rssi;	/* Merged RSSI parameter for |monitors|,
+					 * this will be sent to the kernel.
+					 */
+	struct queue *monitors;		/* List of adv_monitor objects which
+					 * have this pattern
+					 */
 	enum monitor_type type;		/* MONITOR_TYPE_* */
 	struct queue *patterns;		/* List of bt_ad_pattern objects */
+	enum merged_pattern_state current_state; /* MERGED_PATTERN_STATE_* */
+	enum merged_pattern_state next_state;	 /* MERGED_PATTERN_STATE_* */
 };
 
 /* Some data like last_seen, timer/timeout values need to be maintained
@@ -154,6 +178,11 @@ static void monitor_device_free(void *data);
 static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 					struct btd_device *device, int8_t rssi);
 
+static void merged_pattern_send_add(
+			struct adv_monitor_merged_pattern *merged_pattern);
+static void merged_pattern_send_remove(
+			struct adv_monitor_merged_pattern *merged_pattern);
+
 const struct adv_monitor_type {
 	enum monitor_type type;
 	const char *name;
@@ -199,6 +228,262 @@ static void pattern_free(void *data)
 	free(pattern);
 }
 
+static void merged_pattern_free(void *data)
+{
+	struct adv_monitor_merged_pattern *merged_pattern = data;
+
+	queue_destroy(merged_pattern->patterns, pattern_free);
+	queue_destroy(merged_pattern->monitors, NULL);
+
+	if (merged_pattern->manager)
+		queue_remove(merged_pattern->manager->merged_patterns,
+							merged_pattern);
+	free(merged_pattern);
+}
+
+/* Returns the smaller of the two integers |a| and |b| which is not equal to the
+ * |unset| value. If both are unset, return unset.
+ */
+static int get_smaller_not_unset(int a, int b, int unset)
+{
+	if (a == unset)
+		return b;
+	if (b == unset)
+		return a;
+
+	return a < b ? a : b;
+}
+
+/* Merges two RSSI parameters, return the result. The result is chosen to be
+ * whichever is more lenient of the two inputs, so we can pass that to the
+ * kernel and still do additional filtering in the user space without loss of
+ * information while still receiving benefit from offloading some filtering to
+ * the hardware.
+ * It is allowed for |a|, |b|, and |merged| to point to the same object.
+ */
+static void merge_rssi(const struct rssi_parameters *a,
+			const struct rssi_parameters *b,
+			struct rssi_parameters *merged)
+{
+	/* For low rssi, low_timeout, and high_rssi, choose the minimum of the
+	 * two values. Filtering the higher values is done on userspace.
+	 */
+	merged->low_rssi = get_smaller_not_unset(a->low_rssi, b->low_rssi,
+						ADV_MONITOR_UNSET_RSSI);
+	merged->high_rssi = get_smaller_not_unset(a->high_rssi, b->high_rssi,
+						ADV_MONITOR_UNSET_RSSI);
+	merged->low_rssi_timeout = get_smaller_not_unset(a->low_rssi_timeout,
+						b->low_rssi_timeout,
+						ADV_MONITOR_UNSET_TIMEOUT);
+
+	/* High timeout doesn't matter for now, it will be zeroed when it is
+	 * forwarded to kernel anyway.
+	 */
+	merged->high_rssi_timeout = 0;
+
+	/* Sampling period is not implemented yet in userspace. There is no
+	 * good value if the two values are different, so just choose 0 for
+	 * always reporting, to avoid missing packets.
+	 */
+	if (a->sampling_period != b->sampling_period)
+		merged->sampling_period = 0;
+	else
+		merged->sampling_period = a->sampling_period;
+}
+
+/* Two merged_pattern are considered equal if all the following are true:
+ * (1) both has the same monitor_type
+ * (2) both has exactly the same pattern in the same order
+ * Therefore, patterns A+B and B+A are considered different, as well as patterns
+ * A and A+A. This shouldn't cause any issue, but solving this issue is a
+ * potential improvement.
+ */
+static bool merged_pattern_is_equal(const void *data, const void *match_data)
+{
+	const struct adv_monitor_merged_pattern *a = data;
+	const struct adv_monitor_merged_pattern *b = match_data;
+	const struct queue_entry *a_entry, *b_entry;
+	struct bt_ad_pattern *a_data, *b_data;
+
+	if (a->type != b->type)
+		return false;
+
+	if (queue_length(a->patterns) != queue_length(b->patterns))
+		return false;
+
+	a_entry = queue_get_entries(a->patterns);
+	b_entry = queue_get_entries(b->patterns);
+
+	while (a_entry) {
+		a_data = a_entry->data;
+		b_data = b_entry->data;
+
+		if (a_data->type != b_data->type ||
+		    a_data->offset != b_data->offset ||
+		    a_data->len != b_data->len ||
+		    memcmp(a_data->data, b_data->data, a_data->len) != 0)
+			return false;
+
+		a_entry = a_entry->next;
+		b_entry = b_entry->next;
+	}
+
+	return true;
+}
+
+static char *get_merged_pattern_state_name(enum merged_pattern_state state)
+{
+	switch (state) {
+	case MERGED_PATTERN_STATE_ADDING:
+		return "Adding";
+	case MERGED_PATTERN_STATE_REMOVING:
+		return "Removing";
+	case MERGED_PATTERN_STATE_STABLE:
+		return "Stable";
+	}
+
+	return NULL;
+}
+
+/* Adds a new merged pattern */
+static void merged_pattern_add(
+			struct adv_monitor_merged_pattern *merged_pattern)
+{
+	/* This is only called when no merged_pattern found. Therefore, the
+	 * state must be stable.
+	 */
+	if (merged_pattern->current_state != MERGED_PATTERN_STATE_STABLE) {
+		btd_error(merged_pattern->manager->adapter_id,
+			"Add merged_pattern request when state is not stable");
+		return;
+	}
+
+	merged_pattern->current_state = MERGED_PATTERN_STATE_ADDING;
+	merged_pattern_send_add(merged_pattern);
+
+	DBG("Monitor state: %s -> %s",
+		get_merged_pattern_state_name(merged_pattern->current_state),
+		get_merged_pattern_state_name(merged_pattern->next_state));
+}
+
+/* Removes merged pattern, or queues for removal if busy */
+static void merged_pattern_remove(
+			struct adv_monitor_merged_pattern *merged_pattern)
+{
+	rssi_unset(&merged_pattern->rssi);
+
+	/* If we currently are removing, cancel subsequent ADD command if any */
+	if (merged_pattern->current_state == MERGED_PATTERN_STATE_REMOVING) {
+		merged_pattern->next_state = MERGED_PATTERN_STATE_STABLE;
+		goto print_state;
+	}
+
+	/* If stable, we can proceed with removal right away */
+	if (merged_pattern->current_state == MERGED_PATTERN_STATE_STABLE) {
+		merged_pattern->current_state = MERGED_PATTERN_STATE_REMOVING;
+		merged_pattern_send_remove(merged_pattern);
+	} else {
+		/* otherwise queue the removal */
+		merged_pattern->next_state = MERGED_PATTERN_STATE_REMOVING;
+	}
+
+print_state:
+	DBG("Monitor state: %s -> %s",
+		get_merged_pattern_state_name(merged_pattern->current_state),
+		get_merged_pattern_state_name(merged_pattern->next_state));
+}
+
+/* Replaces (removes and re-adds) merged pattern, or queues it if busy */
+static void merged_pattern_replace(
+			struct adv_monitor_merged_pattern *merged_pattern,
+			const struct rssi_parameters *rssi)
+{
+	/* If the RSSI are the same then nothing needs to be done, except on
+	 * the case where pattern is being removed. In that case, we need to
+	 * re-add the pattern.
+	 * high_rssi_timeout is purposedly left out in the comparison since
+	 * the value is ignored upon submission to kernel.
+	 */
+	if (merged_pattern->rssi.high_rssi == rssi->high_rssi &&
+	    merged_pattern->rssi.low_rssi == rssi->low_rssi &&
+	    merged_pattern->rssi.low_rssi_timeout == rssi->low_rssi_timeout &&
+	    merged_pattern->rssi.sampling_period == rssi->sampling_period &&
+	    merged_pattern->current_state != MERGED_PATTERN_STATE_REMOVING &&
+	    merged_pattern->next_state != MERGED_PATTERN_STATE_REMOVING)
+		return;
+
+	merged_pattern->rssi = *rssi;
+
+	/* If stable, we can proceed with replacement. */
+	if (merged_pattern->current_state == MERGED_PATTERN_STATE_STABLE) {
+		/* Replacement is done by first removing, then re-adding */
+		merged_pattern->current_state = MERGED_PATTERN_STATE_REMOVING;
+		merged_pattern->next_state = MERGED_PATTERN_STATE_ADDING;
+		merged_pattern_send_remove(merged_pattern);
+	} else {
+		/* otherwise queue the replacement */
+		merged_pattern->next_state = MERGED_PATTERN_STATE_ADDING;
+	}
+
+	DBG("Monitor state: %s -> %s",
+		get_merged_pattern_state_name(merged_pattern->current_state),
+		get_merged_pattern_state_name(merged_pattern->next_state));
+}
+
+/* Current_state of merged_pattern is done, proceed to the next_state */
+static void merged_pattern_process_next_step(
+					struct adv_monitor_merged_pattern *mp)
+{
+	if (mp->current_state == MERGED_PATTERN_STATE_STABLE) {
+		btd_error(mp->manager->adapter_id,
+				"Merged pattern invalid current state");
+		return;
+	}
+
+	if (mp->current_state == MERGED_PATTERN_STATE_REMOVING) {
+		/* We might need to follow-up with re-adding the pattern */
+		if (mp->next_state == MERGED_PATTERN_STATE_ADDING) {
+			mp->current_state = MERGED_PATTERN_STATE_ADDING;
+			mp->next_state = MERGED_PATTERN_STATE_STABLE;
+			merged_pattern_send_add(mp);
+			goto print_state;
+		}
+
+		/* We should never end up with remove-remove sequence */
+		if (mp->next_state == MERGED_PATTERN_STATE_REMOVING)
+			btd_error(mp->manager->adapter_id,
+				"Merged pattern can't be removed again");
+
+		/* No more operations */
+		mp->current_state = MERGED_PATTERN_STATE_STABLE;
+		mp->next_state = MERGED_PATTERN_STATE_STABLE;
+		goto print_state;
+	}
+
+	/* current_state == MERGED_PATTERN_STATE_ADDING */
+	if (mp->next_state == MERGED_PATTERN_STATE_REMOVING) {
+		mp->current_state = MERGED_PATTERN_STATE_REMOVING;
+		mp->next_state = MERGED_PATTERN_STATE_STABLE;
+		merged_pattern_send_remove(mp);
+		goto print_state;
+	} else if (mp->next_state == MERGED_PATTERN_STATE_ADDING) {
+		/* To re-add a just added pattern, we need to remove it first */
+		mp->current_state = MERGED_PATTERN_STATE_REMOVING;
+		mp->next_state = MERGED_PATTERN_STATE_ADDING;
+		merged_pattern_send_remove(mp);
+		goto print_state;
+	}
+
+	/* No more operations */
+	mp->current_state = MERGED_PATTERN_STATE_STABLE;
+	mp->next_state = MERGED_PATTERN_STATE_STABLE;
+
+print_state:
+	DBG("Monitor state: %s -> %s",
+			get_merged_pattern_state_name(mp->current_state),
+			get_merged_pattern_state_name(mp->next_state));
+}
+
 /* Frees a monitor object */
 static void monitor_free(struct adv_monitor *monitor)
 {
@@ -208,8 +493,6 @@ static void monitor_free(struct adv_monitor *monitor)
 	queue_destroy(monitor->devices, monitor_device_free);
 	monitor->devices = NULL;
 
-	queue_destroy(monitor->patterns, pattern_free);
-
 	free(monitor);
 }
 
@@ -218,10 +501,12 @@ static void monitor_release(struct adv_monitor *monitor)
 {
 	/* Release() method on a monitor can be called when -
 	 * 1. monitor initialization failed
-	 * 2. app calls UnregisterMonitor and monitors held by app are released
+	 * 2. app calls UnregisterMonitor and monitors held by app are released,
+	 *    it may or may not be activated at this point
 	 * 3. monitor is removed by kernel
 	 */
 	if (monitor->state != MONITOR_STATE_FAILED &&
+	    monitor->state != MONITOR_STATE_INITED &&
 	    monitor->state != MONITOR_STATE_ACTIVE &&
 	    monitor->state != MONITOR_STATE_REMOVED) {
 		return;
@@ -234,53 +519,56 @@ static void monitor_release(struct adv_monitor *monitor)
 					NULL);
 }
 
-/* Handles the callback of Remove Adv Monitor command */
-static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
-				const void *param, void *user_data)
-{
-	const struct mgmt_rp_remove_adv_monitor *rp = param;
-
-	if (status != MGMT_STATUS_SUCCESS || !param) {
-		error("Failed to Remove Adv Monitor with status 0x%02x",
-				status);
-		return;
-	}
-
-	if (length < sizeof(*rp)) {
-		error("Wrong size of Remove Adv Monitor response");
-		return;
-	}
-
-	DBG("Adv monitor with handle:0x%04x removed from kernel",
-		le16_to_cpu(rp->monitor_handle));
-}
-
-/* Sends Remove Adv Monitor command to the kernel */
+/* Removes monitor from the merged_pattern. This would result in removing it
+ * from the kernel if there is only one such monitor with that pattern.
+ */
 static void monitor_remove(struct adv_monitor *monitor)
 {
 	struct adv_monitor_app *app = monitor->app;
 	uint16_t adapter_id = app->manager->adapter_id;
-	struct mgmt_cp_remove_adv_monitor cp;
+	struct adv_monitor_merged_pattern *merged_pattern;
+	const struct queue_entry *e;
+	struct rssi_parameters rssi;
 
 	/* Monitor from kernel can be removed when -
-	 * 1. already activated monitor object is deleted by app
+	 * 1. monitor object is deleted by app - may or may not be activated
 	 * 2. app is destroyed and monitors held by app are marked as released
 	 */
-	if (monitor->state != MONITOR_STATE_ACTIVE &&
+	if (monitor->state != MONITOR_STATE_INITED &&
+	    monitor->state != MONITOR_STATE_ACTIVE &&
 	    monitor->state != MONITOR_STATE_RELEASED) {
 		return;
 	}
 
 	monitor->state = MONITOR_STATE_REMOVED;
 
-	cp.monitor_handle = cpu_to_le16(monitor->monitor_handle);
-
-	if (!mgmt_send(app->manager->mgmt, MGMT_OP_REMOVE_ADV_MONITOR,
-			adapter_id, sizeof(cp), &cp, remove_adv_monitor_cb,
-			app->manager, NULL)) {
+	if (!monitor->merged_pattern) {
 		btd_error(adapter_id,
-				"Unable to send Remove Advt Monitor command");
+			"Merged_pattern not found when removing monitor");
+		return;
+	}
+
+	merged_pattern = monitor->merged_pattern;
+	monitor->merged_pattern = NULL;
+	queue_remove(merged_pattern->monitors, monitor);
+
+	/* No more monitors - just remove the pattern entirely */
+	if (queue_length(merged_pattern->monitors) == 0) {
+		merged_pattern_remove(merged_pattern);
+		return;
 	}
+
+	/* Calculate the merge result of the RSSIs of the monitors with the
+	 * same pattern, minus the monitor being removed.
+	 */
+	rssi_unset(&rssi);
+	for (e = queue_get_entries(merged_pattern->monitors); e; e = e->next) {
+		struct adv_monitor *m = e->data;
+
+		merge_rssi(&rssi, &m->rssi, &rssi);
+	}
+
+	merged_pattern_replace(merged_pattern, &rssi);
 }
 
 /* Destroys monitor object */
@@ -334,12 +622,30 @@ static void monitor_state_released(void *data, void *user_data)
 {
 	struct adv_monitor *monitor = data;
 
-	if (!monitor && monitor->state != MONITOR_STATE_ACTIVE)
+	if (!monitor || monitor->state != MONITOR_STATE_INITED
+				&& monitor->state != MONITOR_STATE_ACTIVE)
 		return;
 
 	monitor->state = MONITOR_STATE_RELEASED;
 }
 
+/* Updates monitor state to 'active' */
+static void monitor_state_active(void *data, void *user_data)
+{
+	struct adv_monitor *monitor = data;
+
+	if (!monitor || monitor->state != MONITOR_STATE_INITED)
+		return;
+
+	monitor->state = MONITOR_STATE_ACTIVE;
+
+	DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
+		monitor->app->owner, monitor->path);
+
+	g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL,
+				NULL, NULL, NULL);
+}
+
 /* Handles a D-Bus disconnection event of an app */
 static void app_disconnect_cb(DBusConnection *conn, void *user_data)
 {
@@ -394,9 +700,6 @@ static struct adv_monitor *monitor_new(struct adv_monitor_app *app,
 	rssi_unset(&monitor->rssi);
 	monitor->devices = queue_new();
 
-	monitor->type = MONITOR_TYPE_NONE;
-	monitor->patterns = NULL;
-
 	return monitor;
 }
 
@@ -439,7 +742,7 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
 
 	for (t = supported_types; t->name; t++) {
 		if (strcmp(t->name, type_str) == 0) {
-			monitor->type = t->type;
+			monitor->merged_pattern->type = t->type;
 			return true;
 		}
 	}
@@ -560,6 +863,8 @@ done:
 		monitor->rssi.low_rssi, monitor->rssi.low_rssi_timeout,
 		monitor->rssi.sampling_period);
 
+	monitor->merged_pattern->rssi = monitor->rssi;
+
 	return true;
 
 failed:
@@ -586,14 +891,14 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 		return false;
 	}
 
-	monitor->patterns = queue_new();
-
 	if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_ARRAY ||
 		dbus_message_iter_get_element_type(&array) !=
 		DBUS_TYPE_STRUCT) {
 		goto failed;
 	}
 
+	monitor->merged_pattern->patterns = queue_new();
+
 	dbus_message_iter_recurse(&array, &array_iter);
 
 	while (dbus_message_iter_get_arg_type(&array_iter) ==
@@ -637,21 +942,18 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 		if (!pattern)
 			goto failed;
 
-		queue_push_tail(monitor->patterns, pattern);
+		queue_push_tail(monitor->merged_pattern->patterns, pattern);
 
 		dbus_message_iter_next(&array_iter);
 	}
 
 	/* There must be at least one pattern. */
-	if (queue_isempty(monitor->patterns))
+	if (queue_isempty(monitor->merged_pattern->patterns))
 		goto failed;
 
 	return true;
 
 failed:
-	queue_destroy(monitor->patterns, pattern_free);
-	monitor->patterns = NULL;
-
 	btd_error(adapter_id, "Invalid argument of property Patterns of the "
 			"Adv Monitor at path %s", path);
 
@@ -659,26 +961,99 @@ failed:
 }
 
 /* Processes the content of the remote Adv Monitor */
-static bool monitor_process(struct adv_monitor *monitor,
-				struct adv_monitor_app *app)
+static bool monitor_process(struct adv_monitor *monitor)
 {
 	const char *path = g_dbus_proxy_get_path(monitor->proxy);
 
 	monitor->state = MONITOR_STATE_FAILED;
 
+	monitor->merged_pattern = malloc0(sizeof(*monitor->merged_pattern));
+	monitor->merged_pattern->current_state = MERGED_PATTERN_STATE_STABLE;
+	monitor->merged_pattern->next_state = MERGED_PATTERN_STATE_STABLE;
+
 	if (!parse_monitor_type(monitor, path))
-		goto done;
+		goto fail;
 
 	if (!parse_rssi_and_timeout(monitor, path))
-		goto done;
+		goto fail;
+
+	if (monitor->merged_pattern->type != MONITOR_TYPE_OR_PATTERNS ||
+					!parse_patterns(monitor, path))
+		goto fail;
+
+	monitor->state = MONITOR_STATE_INITED;
+	monitor->merged_pattern->monitors = queue_new();
+	queue_push_tail(monitor->merged_pattern->monitors, monitor);
+
+	return true;
+
+fail:
+	merged_pattern_free(monitor->merged_pattern);
+	monitor->merged_pattern = NULL;
+	return false;
+}
+
+static void merged_pattern_destroy_monitors(
+			struct adv_monitor_merged_pattern *merged_pattern)
+{
+	const struct queue_entry *e;
+
+	for (e = queue_get_entries(merged_pattern->monitors); e; e = e->next) {
+		struct adv_monitor *monitor = e->data;
 
-	if (monitor->type == MONITOR_TYPE_OR_PATTERNS &&
-		parse_patterns(monitor, path)) {
-		monitor->state = MONITOR_STATE_INITED;
+		monitor->merged_pattern = NULL;
+		monitor_destroy(monitor);
 	}
+}
 
-done:
-	return monitor->state != MONITOR_STATE_FAILED;
+/* Handles the callback of Remove Adv Monitor command */
+static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
+				const void *param, void *user_data)
+{
+	const struct mgmt_rp_remove_adv_monitor *rp = param;
+	struct adv_monitor_merged_pattern *merged_pattern = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS || !param) {
+		error("Failed to Remove Adv Monitor with status 0x%02x",
+				status);
+		goto fail;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of Remove Adv Monitor response");
+		goto fail;
+	}
+
+	DBG("Adv monitor with handle:0x%04x removed from kernel",
+		le16_to_cpu(rp->monitor_handle));
+
+	merged_pattern_process_next_step(merged_pattern);
+
+	if (merged_pattern->current_state == MERGED_PATTERN_STATE_STABLE)
+		merged_pattern_free(merged_pattern);
+
+	return;
+
+fail:
+	merged_pattern_destroy_monitors(merged_pattern);
+	merged_pattern_free(merged_pattern);
+}
+
+/* sends MGMT_OP_REMOVE_ADV_MONITOR */
+static void merged_pattern_send_remove(
+			struct adv_monitor_merged_pattern *merged_pattern)
+{
+	struct mgmt_cp_remove_adv_monitor cp;
+	struct btd_adv_monitor_manager *manager = merged_pattern->manager;
+
+	cp.monitor_handle = cpu_to_le16(merged_pattern->monitor_handle);
+
+	if (!mgmt_send(manager->mgmt, MGMT_OP_REMOVE_ADV_MONITOR,
+			manager->adapter_id, sizeof(cp), &cp,
+			remove_adv_monitor_cb, merged_pattern, NULL)) {
+		btd_error(merged_pattern->manager->adapter_id,
+				"Unable to send Remove Advt Monitor command");
+	}
 }
 
 /* Handles the callback of Add Adv Patterns Monitor command */
@@ -686,64 +1061,68 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_add_adv_patterns_monitor *rp = param;
-	struct adv_monitor *monitor = user_data;
-	uint16_t adapter_id = monitor->app->manager->adapter_id;
+	struct adv_monitor_merged_pattern *merged_pattern = user_data;
+	uint16_t adapter_id = merged_pattern->manager->adapter_id;
+	const struct queue_entry *e;
 
 	if (status != MGMT_STATUS_SUCCESS || !param) {
 		btd_error(adapter_id,
 				"Failed to Add Adv Patterns Monitor with status"
 				" 0x%02x", status);
-		monitor->state = MONITOR_STATE_FAILED;
-		monitor_destroy(monitor);
-		return;
+		goto fail;
 	}
 
 	if (length < sizeof(*rp)) {
 		btd_error(adapter_id, "Wrong size of Add Adv Patterns Monitor "
 				"response");
-		monitor->state = MONITOR_STATE_FAILED;
-		monitor_destroy(monitor);
-		return;
+		goto fail;
 	}
 
-	monitor->monitor_handle = le16_to_cpu(rp->monitor_handle);
-	monitor->state = MONITOR_STATE_ACTIVE;
+	merged_pattern->monitor_handle = le16_to_cpu(rp->monitor_handle);
+	DBG("Adv monitor with handle:0x%04x added",
+						merged_pattern->monitor_handle);
 
-	DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
-		monitor->app->owner, monitor->path);
+	merged_pattern_process_next_step(merged_pattern);
 
-	g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
-					NULL);
+	if (merged_pattern->current_state != MERGED_PATTERN_STATE_STABLE)
+		return;
+
+	queue_foreach(merged_pattern->monitors, monitor_state_active, NULL);
+
+	return;
 
-	DBG("Adv monitor with handle:0x%04x added", monitor->monitor_handle);
+fail:
+	merged_pattern_destroy_monitors(merged_pattern);
+	merged_pattern_free(merged_pattern);
 }
 
 /* sends MGMT_OP_ADD_ADV_PATTERNS_MONITOR */
-static bool monitor_send_add_pattern(struct adv_monitor *monitor)
+static bool merged_pattern_send_add_pattern(
+			struct adv_monitor_merged_pattern *merged_pattern)
 {
 	struct mgmt_cp_add_adv_monitor *cp = NULL;
 	uint8_t pattern_count, cp_len;
 	const struct queue_entry *e;
 	bool success = true;
 
-	pattern_count = queue_length(monitor->patterns);
+	pattern_count = queue_length(merged_pattern->patterns);
 	cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);
 
 	cp = malloc0(cp_len);
 	if (!cp)
 		return false;
 
-	for (e = queue_get_entries(monitor->patterns); e; e = e->next) {
+	for (e = queue_get_entries(merged_pattern->patterns); e; e = e->next) {
 		struct bt_ad_pattern *pattern = e->data;
 
 		memcpy(&cp->patterns[cp->pattern_count++], pattern,
 							sizeof(*pattern));
 	}
 
-	if (!mgmt_send(monitor->app->manager->mgmt,
+	if (!mgmt_send(merged_pattern->manager->mgmt,
 			MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
-			monitor->app->manager->adapter_id, cp_len, cp,
-			add_adv_patterns_monitor_cb, monitor, NULL)) {
+			merged_pattern->manager->adapter_id, cp_len, cp,
+			add_adv_patterns_monitor_cb, merged_pattern, NULL)) {
 		error("Unable to send Add Adv Patterns Monitor command");
 		success = false;
 	}
@@ -753,38 +1132,40 @@ static bool monitor_send_add_pattern(struct adv_monitor *monitor)
 }
 
 /* sends MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI */
-static bool monitor_send_add_pattern_rssi(struct adv_monitor *monitor)
+static bool merged_pattern_send_add_pattern_rssi(
+			struct adv_monitor_merged_pattern *merged_pattern)
 {
 	struct mgmt_cp_add_adv_patterns_monitor_rssi *cp = NULL;
 	uint8_t pattern_count, cp_len;
 	const struct queue_entry *e;
 	bool success = true;
 
-	pattern_count = queue_length(monitor->patterns);
+	pattern_count = queue_length(merged_pattern->patterns);
 	cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);
 
 	cp = malloc0(cp_len);
 	if (!cp)
 		return false;
 
-	cp->rssi.high_threshold = monitor->rssi.high_rssi;
+	cp->rssi.high_threshold = merged_pattern->rssi.high_rssi;
 	/* High threshold timeout is unsupported in kernel. Value must be 0. */
 	cp->rssi.high_threshold_timeout = 0;
-	cp->rssi.low_threshold = monitor->rssi.low_rssi;
-	cp->rssi.low_threshold_timeout = htobs(monitor->rssi.low_rssi_timeout);
-	cp->rssi.sampling_period = monitor->rssi.sampling_period;
+	cp->rssi.low_threshold = merged_pattern->rssi.low_rssi;
+	cp->rssi.low_threshold_timeout =
+				htobs(merged_pattern->rssi.low_rssi_timeout);
+	cp->rssi.sampling_period = merged_pattern->rssi.sampling_period;
 
-	for (e = queue_get_entries(monitor->patterns); e; e = e->next) {
+	for (e = queue_get_entries(merged_pattern->patterns); e; e = e->next) {
 		struct bt_ad_pattern *pattern = e->data;
 
 		memcpy(&cp->patterns[cp->pattern_count++], pattern,
 							sizeof(*pattern));
 	}
 
-	if (!mgmt_send(monitor->app->manager->mgmt,
+	if (!mgmt_send(merged_pattern->manager->mgmt,
 			MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI,
-			monitor->app->manager->adapter_id, cp_len, cp,
-			add_adv_patterns_monitor_cb, monitor, NULL)) {
+			merged_pattern->manager->adapter_id, cp_len, cp,
+			add_adv_patterns_monitor_cb, merged_pattern, NULL)) {
 		error("Unable to send Add Adv Patterns Monitor RSSI command");
 		success = false;
 	}
@@ -793,14 +1174,26 @@ static bool monitor_send_add_pattern_rssi(struct adv_monitor *monitor)
 	return success;
 }
 
+/* Sends mgmt command to kernel for adding monitor */
+static void merged_pattern_send_add(
+			struct adv_monitor_merged_pattern *merged_pattern)
+{
+	if (rssi_is_unset(&merged_pattern->rssi))
+		merged_pattern_send_add_pattern(merged_pattern);
+	else
+		merged_pattern_send_add_pattern_rssi(merged_pattern);
+}
+
 /* Handles an Adv Monitor D-Bus proxy added event */
 static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct adv_monitor *monitor;
 	struct adv_monitor_app *app = user_data;
+	struct adv_monitor_merged_pattern *existing_pattern;
 	uint16_t adapter_id = app->manager->adapter_id;
 	const char *path = g_dbus_proxy_get_path(proxy);
 	const char *iface = g_dbus_proxy_get_interface(proxy);
+	struct rssi_parameters rssi;
 
 	if (strcmp(iface, ADV_MONITOR_INTERFACE) != 0 ||
 		!g_str_has_prefix(path, app->path)) {
@@ -822,7 +1215,7 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 		return;
 	}
 
-	if (!monitor_process(monitor, app)) {
+	if (!monitor_process(monitor)) {
 		monitor_destroy(monitor);
 		DBG("Adv Monitor at path %s released due to invalid content",
 			path);
@@ -831,10 +1224,29 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
 	queue_push_tail(app->monitors, monitor);
 
-	if (rssi_is_unset(&monitor->rssi))
-		monitor_send_add_pattern(monitor);
-	else
-		monitor_send_add_pattern_rssi(monitor);
+	existing_pattern = queue_find(monitor->app->manager->merged_patterns,
+					merged_pattern_is_equal,
+					monitor->merged_pattern);
+
+	if (!existing_pattern) {
+		monitor->merged_pattern->manager = monitor->app->manager;
+		queue_push_tail(monitor->app->manager->merged_patterns,
+						monitor->merged_pattern);
+		merged_pattern_add(monitor->merged_pattern);
+	} else {
+		/* Since there is a matching pattern, abandon the one we have */
+		merged_pattern_free(monitor->merged_pattern);
+		monitor->merged_pattern = existing_pattern;
+		queue_push_tail(existing_pattern->monitors, monitor);
+
+		merge_rssi(&existing_pattern->rssi, &monitor->rssi, &rssi);
+		merged_pattern_replace(existing_pattern, &rssi);
+
+		/* Stable means request is not forwarded to kernel */
+		if (existing_pattern->current_state ==
+						MERGED_PATTERN_STATE_STABLE)
+			monitor_state_active(monitor, NULL);
+	}
 
 	DBG("Adv Monitor allocated for the object at path %s", path);
 }
@@ -1064,54 +1476,38 @@ static const GDBusPropertyTable adv_monitor_properties[] = {
 	{ }
 };
 
-/* Matches a monitor based on its handle */
-static bool removed_monitor_match(const void *data, const void *user_data)
-{
-	const uint16_t *handle = user_data;
-	const struct adv_monitor *monitor = data;
-
-	if (!data || !handle)
-		return false;
-
-	return monitor->monitor_handle == *handle;
-}
-
 /* Updates monitor state to 'removed' */
 static void monitor_state_removed(void *data, void *user_data)
 {
 	struct adv_monitor *monitor = data;
 
-	if (!monitor && monitor->state != MONITOR_STATE_ACTIVE)
+	if (!monitor || monitor->state != MONITOR_STATE_INITED
+				&& monitor->state != MONITOR_STATE_ACTIVE)
 		return;
 
 	monitor->state = MONITOR_STATE_REMOVED;
-
-	DBG("Adv monitor with handle:0x%04x removed by kernel",
-		monitor->monitor_handle);
+	monitor->merged_pattern = NULL;
 }
 
-/* Remove the matched monitor and reports the removal to the app */
-static void app_remove_monitor(void *data, void *user_data)
+/* Remove the matched merged_pattern and remove the monitors */
+static void remove_merged_pattern(void *data, void *user_data)
 {
-	struct adv_monitor_app *app = data;
-	struct adv_monitor *monitor;
+	struct adv_monitor_merged_pattern *merged_pattern = data;
 	uint16_t *handle = user_data;
 
-	if (handle && *handle == 0) {
-		/* handle = 0 indicates kernel has removed all monitors */
-		queue_foreach(app->monitors, monitor_state_removed, NULL);
-		queue_destroy(app->monitors, monitor_destroy);
+	if (!handle)
+		return;
 
+	/* handle = 0 indicates kernel has removed all monitors */
+	if (handle != 0 && *handle != merged_pattern->monitor_handle)
 		return;
-	}
 
-	monitor = queue_find(app->monitors, removed_monitor_match, handle);
-	if (monitor) {
-		DBG("Adv Monitor at path %s removed", monitor->path);
+	DBG("Adv monitor with handle:0x%04x removed by kernel",
+		merged_pattern->monitor_handle);
 
-		monitor_state_removed(monitor, NULL);
-		monitor_destroy(monitor);
-	}
+	queue_foreach(merged_pattern->monitors, monitor_state_removed, NULL);
+	queue_destroy(merged_pattern->monitors, monitor_destroy);
+	merged_pattern_free(merged_pattern);
 }
 
 /* Processes Adv Monitor removed event from kernel */
@@ -1129,8 +1525,8 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	/* Traverse the apps to find the monitor */
-	queue_foreach(manager->apps, app_remove_monitor, &handle);
+	/* Traverse the merged_patterns to find matching pattern */
+	queue_foreach(manager->merged_patterns, remove_merged_pattern, &handle);
 
 	DBG("Adv Monitor removed event with handle 0x%04x processed",
 		ev->monitor_handle);
@@ -1154,6 +1550,7 @@ static struct btd_adv_monitor_manager *manager_new(
 	manager->mgmt = mgmt_ref(mgmt);
 	manager->adapter_id = btd_adapter_get_index(adapter);
 	manager->apps = queue_new();
+	manager->merged_patterns = queue_new();
 
 	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_REMOVED,
 			manager->adapter_id, adv_monitor_removed_callback,
@@ -1168,6 +1565,7 @@ static void manager_free(struct btd_adv_monitor_manager *manager)
 	mgmt_unref(manager->mgmt);
 
 	queue_destroy(manager->apps, app_destroy);
+	queue_destroy(manager->merged_patterns, merged_pattern_free);
 
 	free(manager);
 }
@@ -1274,6 +1672,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
 {
 	struct adv_monitor *monitor = data;
 	struct adv_content_filter_info *info = user_data;
+	struct queue *patterns;
 
 	if (!monitor) {
 		error("Unexpected NULL adv_monitor object upon match");
@@ -1283,8 +1682,12 @@ static void adv_match_per_monitor(void *data, void *user_data)
 	if (monitor->state != MONITOR_STATE_ACTIVE)
 		return;
 
-	if (monitor->type == MONITOR_TYPE_OR_PATTERNS &&
-		bt_ad_pattern_match(info->ad, monitor->patterns)) {
+	if (!monitor->merged_pattern)
+		return;
+
+	patterns = monitor->merged_pattern->patterns;
+	if (monitor->merged_pattern->type == MONITOR_TYPE_OR_PATTERNS &&
+				bt_ad_pattern_match(info->ad, patterns)) {
 		goto matched;
 	}
 
-- 
2.31.0.291.g576ba9dcdaf-goog

