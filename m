Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD82DC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6068020791
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G4msOv00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgJ1XIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgJ1XHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:07:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA00C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:07:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so369910pll.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drdqwJoWpvQRBGbW7XyM9wUffENd+fD30055WmYqe3s=;
        b=G4msOv00qzt1HhKuQD3m7duXsvlOUfxT5WesNjuTdK7xqePa7BECYTiCOQMTKl12k5
         UcL6uqI86j5PwLps1Jih4Q6Csc3OA+2dGMston0eNllx5YX/7LZErOdH2AhE7iferopJ
         2VDPTlZnAtwKNiTkaXyjV+8fb4jH/fPXqkjIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drdqwJoWpvQRBGbW7XyM9wUffENd+fD30055WmYqe3s=;
        b=YBslK5gNcs1GXbFOzIr0iUIL86vmzYIbcuvenRhQcQ4Vcx7QD6cVFx8Q4yRShXHIFw
         R88oNeUB+FiwLWT4jV+9pOfFxFsHFgychE/rcDatZYlhZaVkYPV1myCp4IPkIYWeo+r8
         MuckwAok9146CJJRaR7en1IwWKH3t+ZQjgTNlEj7SxmZvospfmgXCsM2Qk5ddEQzMzIc
         ZxkdCkRC7+ArIgatK0lPT4vzVf33p2Qxb1Uf5RmMH3nsMnMrhjOvi/inLllyXFjJNv+G
         svxtjrjO41wjnVyAKLlW6Wm6kc4FPLIr6dwxvfv2y9odRf0oLIVtYjGzqCT6rTIs/ms7
         yPzQ==
X-Gm-Message-State: AOAM532qoheir3kiSCxaZ8l4aBqHPAulSqR4/Nim90rymml6tSsdk1Iu
        7HJbOCUlfdHhu1jB5KYLxbyPd7z6k6s9TQ==
X-Google-Smtp-Source: ABdhPJzJC5O2dssXD0SvwSxrxQT8/FML/XNxglZVIVRou1ndjW5buu0hFpPZqepVj2OJspkAtF1FfQ==
X-Received: by 2002:a17:902:9889:b029:d6:5337:a758 with SMTP id s9-20020a1709029889b02900d65337a758mr1244986plp.28.1603926449858;
        Wed, 28 Oct 2020 16:07:29 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y137sm644134pfc.77.2020.10.28.16.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:07:29 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 5/7] adv_monitor: Implement Add Adv Patterns Monitor cmd handler
Date:   Wed, 28 Oct 2020 16:05:34 -0700
Message-Id: <20201028160433.BlueZ.v7.5.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

Changes in v7:
- Rename MONITOR_STATE_HONORED to MONITOR_STATE_ACTIVE
- Rebase on the adoption of bt_ad_pattern

 src/adv_monitor.c | 69 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 9a04da6e1..9d2a400a3 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -78,7 +78,7 @@ enum monitor_state {
 	MONITOR_STATE_NEW,	/* New but not yet init'ed with actual values */
 	MONITOR_STATE_FAILED,	/* Failed to be init'ed */
 	MONITOR_STATE_INITED,	/* Init'ed but not yet sent to kernel */
-	MONITOR_STATE_HONORED,	/* Accepted by kernel */
+	MONITOR_STATE_ACTIVE,	/* Accepted by kernel */
 };
 
 struct adv_monitor {
@@ -545,11 +545,59 @@ done:
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
+	monitor->state = MONITOR_STATE_ACTIVE;
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
+	struct bt_ad_pattern *pattern = data;
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
@@ -582,7 +630,24 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
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
@@ -946,7 +1011,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
 		return;
 	}
 
-	if (monitor->state != MONITOR_STATE_HONORED)
+	if (monitor->state != MONITOR_STATE_ACTIVE)
 		return;
 
 	if (monitor->type == MONITOR_TYPE_OR_PATTERNS &&
-- 
2.26.2

