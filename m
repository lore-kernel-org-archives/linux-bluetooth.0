Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE9EC4363D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4657120760
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 00:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RHG4Ef2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJGAPO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAPN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 20:15:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C8C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 17:15:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d6so85002plo.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xFbsQt7QSfdThIVO9V8CS0xb2S+SQXYSOQ607Jphq0c=;
        b=RHG4Ef2pJHG7EvWzrKlzZfg4G8oeTgCfFmBOhX6qdJWHhp9doB/zgAgy93/3h4AoRO
         t5pWAAQPhoaBJsn+btLeRUIkrSPcD2fk6Db1VNHp5K7Q6OqBjayi4++Xgl3649C5gTxF
         2E5wQwCB5ByCpuR4siF/aRYKnVOTuOUwkHt3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFbsQt7QSfdThIVO9V8CS0xb2S+SQXYSOQ607Jphq0c=;
        b=pYcGOGlTEwk4M/siSAs8Ado1D8xfwd2+uHmfuovYt99VjVOdutkP4BvwtsImWs6k6g
         m2jAqI7PHRr29xd+p8w4JcwU8XIUxvj39RzafPBBx//0inCqVBTIp84JM6iffRtkIm11
         Aj5j2IFt0fmIReYwzypD5ijlzd6WSTYhJw2EqEwI44K8cxAousMd+CteHgR2FWfiUoeB
         09J+iYIuPvDV6usZCn3+OJyDh875s31QEhJ16gf0yXjlvnCTnimdFYbC//8XLRU4frxM
         lHQAiZQUCfFfS1faagaf/kGP1ftGk7Cot26t+HlnIOO4ZC77FdkiTCYcTRbsWHrAwR35
         TkSQ==
X-Gm-Message-State: AOAM531I6apQm7V7s1TCERoSTmP3MRsPdSnphsyrWgKcQUCC/JGb5cxw
        3tarJDTCLIUDahcN/VKjOUEohr7LG6unig==
X-Google-Smtp-Source: ABdhPJx+5JJwGIZpCzfv4VOyBh5Mh06eR4ECAbFgHfiKgBbh3pP4zhRMOoy0GgQ/KDqkQudnB01jxw==
X-Received: by 2002:a17:90a:c28f:: with SMTP id f15mr512824pjt.143.1602029711400;
        Tue, 06 Oct 2020 17:15:11 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id s13sm329722pgo.56.2020.10.06.17.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 17:15:10 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 4/6] adv_monitor: Implement Add Adv Patterns Monitor cmd handler
Date:   Tue,  6 Oct 2020 17:14:12 -0700
Message-Id: <20201006171333.BlueZ.v6.4.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
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
index fcb127cd4..582cc9a46 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -588,11 +588,59 @@ done:
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
@@ -625,7 +673,24 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
 
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
@@ -1036,7 +1101,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
 	struct adv_monitor *monitor = data;
 	struct adv_content_filter_info *info = user_data;
 
-	if (!monitor && monitor->state != MONITOR_STATE_HONORED)
+	if (!monitor || monitor->state != MONITOR_STATE_HONORED)
 		return;
 
 	/* Reset the intermediate matched status */
-- 
2.26.2

