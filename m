Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C6C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C8B2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bW5Iw/vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIQHLt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIQHLp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:11:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B75AC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:11:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y1so820422pgk.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXANRElz/qKLo+YPc/C/DfIhCrjha/xK9SJq8ld3Zj4=;
        b=bW5Iw/vqKkEA4l5FHtbwoJDv+D76RItaw3xlrppATUyWw7hs22EjQnVigtFnlznoPa
         5antFM5KrFFkEYSBHEk+HuBfrzfUDej8pw2vwPMRmEDR+EMSUaLoGeNdhe+vOesJH7R9
         cAKPmZRxjh0ZUwDXsUIdiWHyYh+OMY+FpubBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXANRElz/qKLo+YPc/C/DfIhCrjha/xK9SJq8ld3Zj4=;
        b=j4/zymIHTJRSrsFKcdOg7jBvmMEFjoVi8CwQ927gd4sTigj0Oa2Dkl73aUj+ITDgCH
         C1YIvhvIkJo4JDcux6FszIYhATdH120vV13HoXbrdo6bU6kv+qJjsMKihBrw+pikzSqO
         GEAw8d+WW10vm8Je/zZTguNUJAN6wp92eg17hPD1O4gtR9ztEeQ18kX5mO1GSzB7HfHq
         bzHzN3PitfFu4uhAd88TqBc4kI2uyP4oJ05uXsg6QA0UCMDiuY0A7BA6qcnYXkpphjGh
         XaPs6YkqWcUNd+w6dr5Bcd9aavBQOxaanP8JQzdhWfMKHLIWIaGLZSV+6APGLnYQsf/B
         F3Sw==
X-Gm-Message-State: AOAM532i9Q5v0ZEli1Y4TcyZbzedob+CMuvJQe+v8oCoZ1SfpSCfZ54Q
        CjisaGo5ol3DpkNeWtoMZvojPsmmnN/ROA==
X-Google-Smtp-Source: ABdhPJy5mTj/3YOTN3YiJ2C5EptuBHmiJRAcCbDDb36vydCXONr6xkWB48A5w8VjxvewK4/PV4Hziw==
X-Received: by 2002:a62:7c82:0:b029:13c:1611:66b9 with SMTP id x124-20020a627c820000b029013c161166b9mr25094985pfc.4.1600326704726;
        Thu, 17 Sep 2020 00:11:44 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id j26sm933478pgl.91.2020.09.17.00.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 00:11:44 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4 6/8] adv_monitor: Implement Add Adv Patterns Monitor cmd handler
Date:   Thu, 17 Sep 2020 00:10:41 -0700
Message-Id: <20200917001020.BlueZ.v4.6.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20200917001020.BlueZ.v4.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index 211094c89..deaa1894a 100644
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
@@ -1063,7 +1128,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
 	struct adv_monitor *monitor = data;
 	struct adv_content_filter_info *info = user_data;
 
-	if (!monitor && monitor->state != MONITOR_STATE_HONORED)
+	if (!monitor || monitor->state != MONITOR_STATE_HONORED)
 		return;
 
 	/* Reset the intermediate matched status */
-- 
2.26.2

