Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B85C2BBD1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE072137B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THOmwBKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIQGVO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQGVL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:21:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74837C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:21:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y1so745935pgk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nI1lwirMpvm4vWon80g2srfXuKwwNNQq9kNumv3r5qY=;
        b=THOmwBKwB518USHayCzZrRr6x/02THcFpkMElLTjp/ufUahUJfK30pwOyJZVXd5qPn
         OnIKrS7HkMPcUt1fKWkIRbKRu5umCUlN8DJhNzNxAbHB5JgqFgP/vzRoQwOLba/bfJbM
         rXMoBpVeor3inCxIIeNmfGQ5G05F/HlYn6P8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nI1lwirMpvm4vWon80g2srfXuKwwNNQq9kNumv3r5qY=;
        b=ZEITvzUR13LKI+X5I78ImR3SiMeLFxGmpMmERzTP6xws7LLbW5wkQQWp3AuIfxB3Q9
         1yvNqGZf8lUeYVPN6jl7MZGxLdIArxINZow7lUvJZzxrwJFOOKT9RkBc4/Tqpo7tucbb
         x+3f0O+93geem6JUXzq+BW7bqxrtJF74yvOJxluOSD8GBo6ywsqIP2qpU1KOwINElTgP
         ++rXL67qvx8Z0x/26i+fGkF10aRpgmcgtK3sfy9dLhEzhlYLRHJ18PIEO+lVKASgUE3s
         as6weLPonyMYi2EO0KLtf/5GYAj07MDpPf59mBoRyF9TdieYKtiu/AWisl9PYvsi8LkB
         mUuQ==
X-Gm-Message-State: AOAM5328QFbm6+koL9vgkaXEXYesT0gqC7H4xBH7EB3bNvyAEL6fVffx
        ySm48waEBOA5b7q1gOl0200AQLBcJj96tA==
X-Google-Smtp-Source: ABdhPJxDpG0XjkjxYIVQTvZGbLfHSPGwHaS7+nvDjI+36+/0QTYfmrxRKoLe68xxm3B4pvN9YbY/tw==
X-Received: by 2002:a63:c543:: with SMTP id g3mr21695867pgd.203.1600323670533;
        Wed, 16 Sep 2020 23:21:10 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id g23sm19264943pfh.133.2020.09.16.23.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 23:21:09 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 6/8] adv_monitor: Implement Add Adv Patterns Monitor cmd handler
Date:   Wed, 16 Sep 2020 23:19:50 -0700
Message-Id: <20200916231935.BlueZ.v2.6.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200916231935.BlueZ.v2.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Howard Chung <howardchung@google.com>

- Send the MGMT_OP command to kernel upon registration of a Adv patterns
monitor.
- Call Activate() or Release() to client depending on the reply from
  kernel

the call through syslog

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 4f86384e9..bce99eace 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -609,11 +609,59 @@ done:
 	return monitor->state != MONITOR_STATE_FAILED;
 }
 
+/* Handles the callback of Add Adv Patterns Monitor command */
+static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_add_adv_patterns_monitor *rp = param;
+	struct adv_monitor *monitor = user_data;
+	uint16_t adapter_id = monitor->app->manager->adapter_id;
+
+	if (status != MGMT_STATUS_SUCCESS || !param) {
+		btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
+				"with status 0x%02x", status);
+		monitor_release(monitor, NULL);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter_id, "Wrong size of Add Adv Patterns Monitor "
+				"response");
+		monitor_release(monitor, NULL);
+		return;
+	}
+
+	monitor->state = MONITOR_STATE_HONORED;
+
+	DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
+		monitor->app->owner, monitor->path);
+
+	g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
+					NULL);
+
+	DBG("Adv Monitor with handle:0x%04x added",
+					le16_to_cpu(rp->monitor_handle));
+}
+
+static void monitor_copy_patterns(void *data, void *user_data)
+{
+	struct btd_adv_monitor_pattern *pattern = data;
+	struct mgmt_cp_add_adv_monitor *cp = user_data;
+
+	if (!pattern)
+		return;
+
+	memcpy(cp->patterns + cp->pattern_count, pattern, sizeof(*pattern));
+	cp->pattern_count++;
+}
+
 /* Handles an Adv Monitor D-Bus proxy added event */
 static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct adv_monitor *monitor;
 	struct adv_monitor_app *app = user_data;
+	struct mgmt_cp_add_adv_monitor *cp = NULL;
+	uint8_t pattern_count, cp_len;
 	uint16_t adapter_id = app->manager->adapter_id;
 	const char *path = g_dbus_proxy_get_path(proxy);
 	const char *iface = g_dbus_proxy_get_interface(proxy);
@@ -646,7 +694,24 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
 	queue_push_tail(app->monitors, monitor);
 
+	pattern_count = queue_length(monitor->patterns);
+	cp_len = sizeof(struct mgmt_cp_add_adv_monitor) +
+			pattern_count * sizeof(struct mgmt_adv_pattern);
+
+	cp = malloc0(cp_len);
+	queue_foreach(monitor->patterns, monitor_copy_patterns, cp);
+
+	if (!mgmt_send(app->manager->mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+			adapter_id, cp_len, cp, add_adv_patterns_monitor_cb,
+			monitor, NULL)) {
+		error("Unable to send Add Adv Patterns Monitor command");
+		goto done;
+	}
+
 	DBG("Adv Monitor allocated for the object at path %s", path);
+
+done:
+	free(cp);
 }
 
 /* Handles the removal of an Adv Monitor D-Bus proxy */
@@ -1064,7 +1129,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
 	struct adv_monitor *monitor = data;
 	struct adv_content_filter_info *info = user_data;
 
-	if (!monitor && monitor->state != MONITOR_STATE_HONORED)
+	if (!monitor || monitor->state != MONITOR_STATE_HONORED)
 		return;
 
 	/* Reset the intermediate matched status */
-- 
2.26.2

