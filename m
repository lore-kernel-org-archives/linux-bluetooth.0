Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F3C00A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667AF208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZWxAOq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgJaAyi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaAyh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 20:54:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1FC0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:54:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j18so6745593pfa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vbm2G0CMB9LM7u+swDDvdXCapbs/ILYy5Hy3KLSMPmg=;
        b=FZWxAOq0RxWCvVLNbbh6yafIrVPD3E/rKvYX80Aqn0x0HxnfL4HyvVshFZrSThbfu+
         QIohAS/O06CuGLnSU3XVSS1MduFJQdWc/MwzhSH051eZEy0BG/mSXAC2SIh6TIKKajB9
         zbYFf3gqKW31OGfGBf74tEdltH8pseV/S2FAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vbm2G0CMB9LM7u+swDDvdXCapbs/ILYy5Hy3KLSMPmg=;
        b=s1wbrMY0mC6Aq4z1xeSgEA61FQxKZZITIWkiJ9DqZFLGOFJVQ3/EfxI5l7HsTznTqK
         9B5h/lcWeR1BWzKdPKzLWRNBXucvCZUl+h7hkk0ERjC2X5botmXIHKvimTAm9p43EoFU
         cOG0mtuQEe6sK+55x2Kx9qm6+PYpuMl+jfEXSUTsKrT9RSWKRqMIJgiKF1+nMmgvIiD3
         tTfUsjjiGt10bBZbwExXO0TFpT9yrhdDkwALHg9nsPN2S+wZEbSYM06DsYFPuznIlyCB
         Cth6AcjncJdk4PXW2tLPMP958r/HglCsVIDIqSB5/KcffxwOXafh+jNnVKJgfSgEIW70
         G+xw==
X-Gm-Message-State: AOAM533cXjUgq+qo+miM+VfBNleIe81BxyJ+DZRcDQMpXGNYmhyadouy
        dQbUi8Bp4OfFA3TLB3lc/6C2eBKCCB2+wA==
X-Google-Smtp-Source: ABdhPJyMXo5OqbKUJB2Kjug4XIbqjs+Uwyn/sCwSLaTZI+S3dXQ54hcem6kY4/KT9VQA1Zhv9APKSA==
X-Received: by 2002:a63:ea0f:: with SMTP id c15mr4286796pgi.367.1604105677045;
        Fri, 30 Oct 2020 17:54:37 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id p22sm4394292pju.48.2020.10.30.17.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 17:54:36 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v8 4/6] adv_monitor: mplement Add Adv Patterns Monitor cmd handler
Date:   Fri, 30 Oct 2020 17:52:52 -0700
Message-Id: <20201030175219.BlueZ.v8.4.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
References: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
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

(no changes since v7)

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

