Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD6EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD77D208E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nysth9fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIORmX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgIORmB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 13:42:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DDBC06178C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:42:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so2345398pfp.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Lb3TTPN31sY7TtlFDspcb6ha7dyHPbWFWNXvetWXH4=;
        b=Nysth9fd/ZV6IC4NHMhMej61IFXdbe2fQXQBsN40g28Lf2dOBUSoGAYX1ci0mia8Xv
         Ogg5au63B8NiuDT889dycIMGI+5KI/H6tSDNhhtDkeBcEF4Ti0kbdJVkbYvbyakcNJ3k
         vvJpJtkQQDeSKU4nFqG2PYe+JoYQ11EsQwETk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Lb3TTPN31sY7TtlFDspcb6ha7dyHPbWFWNXvetWXH4=;
        b=hGtPyXb7+yMEYnx1EDQX9ztYd9zkvouqfm6x48X9cz27LHWubeA9eEcNYkyD3JhBzU
         jDDuleNATZZVrsB7OPWAxC4SH+3FHZvBmspIbddztz3qs6mEew+ZzMYbOZTj/b4xLtgW
         Q7nw9qiJtwogvWB1we5pVRIm8CWBJh18r3liZWgJStGtN1kYoLO5/k3/nuTBJWxCe2aO
         PuZ5JVkptxaLsGeY6HWp5ZTRK/5yaYzgl66mSnNwg43EWrUIoFMvpsvj8boe7quRRjQA
         yZRU+ScSq0iF4+yvRqObJHYaQkuNQ1m9kZdsHx5ltku5eH8q38RrIVLsxrQ2bt7huRLl
         KXZw==
X-Gm-Message-State: AOAM532Rg1quqjbDKEFajNoM7IWZdxnWD3lC48emM91rOaYdV+SkyJic
        ku6uFRBcT8IikgxXftSZ9ioiJg==
X-Google-Smtp-Source: ABdhPJySXv6MhYQq8gmSLar8/L0BArCo0bDPe8Fe04nb+Z5EY51eLuDgXS//A4YMvD3gcaGzKD+h+w==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr15353887pgr.20.1600191720565;
        Tue, 15 Sep 2020 10:42:00 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id y29sm15490232pfq.207.2020.09.15.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:42:00 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v5 4/4] policy: Reconnect audio on controller resume
Date:   Tue, 15 Sep 2020 10:41:46 -0700
Message-Id: <20200915104127.Bluez.v5.4.I26efd89de3a70af1cd9775d457d0c10f4aafd4cb@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915174146.1693687-1-abhishekpandit@chromium.org>
References: <20200915174146.1693687-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During system suspend, all peer devices are disconnected. On resume, HID
devices will reconnect but audio devices stay disconnected. As a quality
of life improvement, mark audio devices that were disconnected due to
suspend and attempt to reconnect them when the controller resumes (after
a delay for better co-existence with Wi-Fi).
---

Changes in v5: None
Changes in v4:
- Set reconnect timer in disconnect if resume events aren't supported
- Only set reconnect timer if adapter matches current notification
- Refactor changes in src/adapter to its own commit
- Refactor enabling A2DP_SINK_UUID into its own commit

Changes in v3:
- Refactored resume notification to use btd_adapter_driver
- Renamed ReconnectAudioDelay to ResumeDelay and set default to 2
- Added A2DP_SINK_UUID to default reconnect list

Changes in v2:
- Refactored to use policy instead of connecting directly in adapter

 plugins/policy.c | 84 ++++++++++++++++++++++++++++++++++++++++--------
 src/main.c       |  1 +
 src/main.conf    |  9 ++++++
 3 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index c18ca8d1f..6bd389518 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -62,6 +62,7 @@ struct reconnect_data {
 	guint timer;
 	bool active;
 	unsigned int attempt;
+	bool on_resume;
 };
 
 static const char *default_reconnect[] = {
@@ -76,6 +77,9 @@ static const int default_intervals[] = { 1, 2, 4, 8, 16, 32, 64 };
 static int *reconnect_intervals = NULL;
 static size_t reconnect_intervals_len = 0;
 
+static const int default_resume_delay = 2;
+static int resume_delay;
+
 static GSList *reconnects = NULL;
 
 static unsigned int service_id = 0;
@@ -712,6 +716,9 @@ static gboolean reconnect_timeout(gpointer data)
 	/* Mark the GSource as invalid */
 	reconnect->timer = 0;
 
+	/* Mark any reconnect on resume as handled */
+	reconnect->on_resume = false;
+
 	err = btd_device_connect_services(reconnect->dev, reconnect->services);
 	if (err < 0) {
 		error("Reconnecting services failed: %s (%d)",
@@ -725,14 +732,17 @@ static gboolean reconnect_timeout(gpointer data)
 	return FALSE;
 }
 
-static void reconnect_set_timer(struct reconnect_data *reconnect)
+static void reconnect_set_timer(struct reconnect_data *reconnect, int timeout)
 {
-	static int timeout = 0;
+	static int interval_timeout = 0;
 
 	reconnect->active = true;
 
 	if (reconnect->attempt < reconnect_intervals_len)
-		timeout = reconnect_intervals[reconnect->attempt];
+		interval_timeout = reconnect_intervals[reconnect->attempt];
+
+	if (timeout < 0)
+		timeout = interval_timeout;
 
 	DBG("attempt %u/%zu %d seconds", reconnect->attempt + 1,
 						reconnect_attempts, timeout);
@@ -744,10 +754,14 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
 static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 {
 	struct reconnect_data *reconnect;
+	struct btd_service *service;
+	struct policy_data *data;
 
 	DBG("reason %u", reason);
 
-	if (reason != MGMT_DEV_DISCONN_TIMEOUT)
+	/* Only attempt reconnect for the following reasons */
+	if (reason != MGMT_DEV_DISCONN_TIMEOUT &&
+	    reason != MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND)
 		return;
 
 	reconnect = reconnect_find(dev);
@@ -756,10 +770,47 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 
 	reconnect_reset(reconnect);
 
-	DBG("Device %s identified for auto-reconnection",
-							device_get_path(dev));
+	DBG("Device %s identified for auto-reconnection", device_get_path(dev));
+
+	switch(reason)
+	{
+	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
+		if (btd_device_get_service(dev, A2DP_SINK_UUID)) {
+			DBG("%s configured to reconnect on resume",
+				device_get_path(dev));
 
-	reconnect_set_timer(reconnect);
+			reconnect->on_resume = true;
+
+			/* If the kernel supports resume events, it is
+			 * preferable to set the reconnect timer there as it is
+			 * a more predictable delay.
+			 */
+			if (!has_kernel_features(KERNEL_HAS_RESUME_EVT))
+				reconnect_set_timer(reconnect, resume_delay);
+		}
+		break;
+	case MGMT_DEV_DISCONN_TIMEOUT:
+		reconnect_set_timer(reconnect, -1);
+		break;
+	default:
+		DBG("Developer error. Reason = %d", reason);
+		break;
+	}
+}
+
+static void policy_adapter_resume(struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	/* Check if devices on this adapter need to be reconnected on resume */
+	for (l = reconnects; l; l = g_slist_next(l)) {
+		struct reconnect_data *reconnect = l->data;
+
+		if (reconnect->on_resume &&
+		    device_get_adapter(reconnect->dev) == adapter) {
+			reconnect_set_timer(reconnect, resume_delay);
+		}
+	}
 }
 
 static void conn_fail_cb(struct btd_device *dev, uint8_t status)
@@ -787,14 +838,15 @@ static void conn_fail_cb(struct btd_device *dev, uint8_t status)
 		return;
 	}
 
-	reconnect_set_timer(reconnect);
+	reconnect_set_timer(reconnect, -1);
 }
 
 static int policy_adapter_probe(struct btd_adapter *adapter)
 {
 	DBG("");
 
-	btd_adapter_restore_powered(adapter);
+	if (auto_enable)
+		btd_adapter_restore_powered(adapter);
 
 	return 0;
 }
@@ -802,6 +854,7 @@ static int policy_adapter_probe(struct btd_adapter *adapter)
 static struct btd_adapter_driver policy_driver = {
 	.name	= "policy",
 	.probe	= policy_adapter_probe,
+	.resume = policy_adapter_resume,
 };
 
 static int policy_init(void)
@@ -855,14 +908,20 @@ static int policy_init(void)
 	auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
 									NULL);
 
+	resume_delay = g_key_file_get_integer(
+			conf, "Policy", "ResumeDelay", &gerr);
+
+	if (gerr) {
+		g_clear_error(&gerr);
+		resume_delay = default_resume_delay;
+	}
 done:
 	if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
 		btd_add_disconnect_cb(disconnect_cb);
 		btd_add_conn_fail_cb(conn_fail_cb);
 	}
 
-	if (auto_enable)
-		btd_register_adapter_driver(&policy_driver);
+	btd_register_adapter_driver(&policy_driver);
 
 	return 0;
 }
@@ -883,8 +942,7 @@ static void policy_exit(void)
 
 	btd_service_remove_state_cb(service_id);
 
-	if (auto_enable)
-		btd_unregister_adapter_driver(&policy_driver);
+	btd_unregister_adapter_driver(&policy_driver);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(policy, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/src/main.c b/src/main.c
index b37c32948..038f867b5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -131,6 +131,7 @@ static const char *policy_options[] = {
 	"ReconnectAttempts",
 	"ReconnectIntervals",
 	"AutoEnable",
+	"ResumeDelay",
 	NULL
 };
 
diff --git a/src/main.conf b/src/main.conf
index e1d77cc47..9f882e65a 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -202,3 +202,12 @@
 # This includes adapters present on start as well as adapters that are plugged
 # in later on. Defaults to 'false'.
 #AutoEnable=false
+
+# Audio devices that were disconnected due to suspend will be reconnected on
+# resume. ResumeDelay determines the delay between when the controller
+# resumes from suspend and a connection attempt is made. A longer delay is
+# better for better co-existence with Wi-Fi.
+# The value is in seconds.
+# Default: 2
+#ResumeDelay = 2
+
-- 
2.28.0.618.gf4bc123cb7-goog

