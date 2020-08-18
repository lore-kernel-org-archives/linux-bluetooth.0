Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0217BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCC42075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mrGQe2t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHRX2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHRX2c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 19:28:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE7DC061343
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so241886pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k57/y/SsN2qwSG5z4+5MymWQ2jeBayi2s6+jtaZ++Vw=;
        b=mrGQe2t7KeMs4Z1NzHb2h5/IguHsfUxjuYsNK6bku6s816GKgQ2ojnWfSvVmpm6deq
         zTLM8tfGCp/1Je4uvAlrDcEwZiJahtHyeehneHcpnJ5t8Q+meHxGw2es+HzxhUGLCi0B
         Z4mcTtgaLN6yMpHVNw7i/9vXF81okVLOSF/V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k57/y/SsN2qwSG5z4+5MymWQ2jeBayi2s6+jtaZ++Vw=;
        b=LFuudMnfC9Yxvd9sScrdwRUgidX8/swqlEdla7x0hZxbYTqqa4IjZwCqgwraTp+oke
         iRtpNTRJtJSsoBraW2zMUsMS2y5zoz3jslLd0cm9dUrcCX5xbTPq08Izx81PIxrDOzxZ
         YcqrbJ0XBsuBYSottiCzLNQsET3nRuRYho2uR+L04LOWOtTbp7M5S7X2u9EvSV9dFI6I
         ErgT7pQYP7wkcZwuyBJ24PmATl6EEdDxveGKq2L2Gk6X7q42Ye05Xug4ISXeKXe9HZ/o
         GnMryP0JAddLwyYs4damYPcT3HVx8ZZzpuy/xuQoKy4XaUN/jYI9aihSyinc4NblevcR
         W1AA==
X-Gm-Message-State: AOAM533welZQyhBYbeQqmvRXJwCATROu/WcmHxCHlNLJ9PyF5OXE5Fpi
        bFVNgaXVeH8owgCtUgmbZtEIEA==
X-Google-Smtp-Source: ABdhPJwk56f+fzm7Lq8Z3SUusSK/WxVHP03g/fi1GF8jyAXVUC4ASuIy/zFLdoc9RYkfy3xIZkSABA==
X-Received: by 2002:a17:90b:803:: with SMTP id bk3mr1804778pjb.57.1597793311771;
        Tue, 18 Aug 2020 16:28:31 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 30sm904747pjz.24.2020.08.18.16.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:28:31 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v2 3/3] policy: Reconnect audio on controller resume
Date:   Tue, 18 Aug 2020 16:28:22 -0700
Message-Id: <20200818162807.Bluez.v2.3.I26efd89de3a70af1cd9775d457d0c10f4aafd4cb@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200818232822.1645054-1-abhishekpandit@chromium.org>
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
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

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Refactored to use policy instead of connecting directly in adapter

 plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
 src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
 src/adapter.h    |  6 +++++
 src/main.c       |  1 +
 src/main.conf    |  9 +++++++
 5 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index de51e58b9..b07a997b9 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -75,6 +75,9 @@ static const int default_intervals[] = { 1, 2, 4, 8, 16, 32, 64 };
 static int *reconnect_intervals = NULL;
 static size_t reconnect_intervals_len = 0;
 
+static const int default_reconnect_delay = 5;
+static int resume_reconnect_delay = 5;
+
 static GSList *reconnects = NULL;
 
 static unsigned int service_id = 0;
@@ -93,6 +96,8 @@ struct policy_data {
 	uint8_t ct_retries;
 	guint tg_timer;
 	uint8_t tg_retries;
+
+	bool reconnect_on_resume;
 };
 
 static struct reconnect_data *reconnect_find(struct btd_device *dev)
@@ -214,6 +219,7 @@ static gboolean policy_connect_sink(gpointer user_data)
 
 	data->sink_timer = 0;
 	data->sink_retries++;
+	data->reconnect_on_resume = false;
 
 	service = btd_device_get_service(data->dev, A2DP_SINK_UUID);
 	if (service != NULL)
@@ -222,16 +228,20 @@ static gboolean policy_connect_sink(gpointer user_data)
 	return FALSE;
 }
 
-static void policy_set_sink_timer(struct policy_data *data)
+static void policy_set_sink_timer_internal(struct policy_data *data, int timeout)
 {
 	if (data->sink_timer > 0)
 		g_source_remove(data->sink_timer);
 
-	data->sink_timer = g_timeout_add_seconds(SINK_RETRY_TIMEOUT,
-							policy_connect_sink,
+	data->sink_timer = g_timeout_add_seconds(timeout, policy_connect_sink,
 							data);
 }
 
+static void policy_set_sink_timer(struct policy_data *data)
+{
+	policy_set_sink_timer_internal(data, SINK_RETRY_TIMEOUT);
+}
+
 static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 						btd_service_state_t new_state)
 {
@@ -743,10 +753,30 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
 static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 {
 	struct reconnect_data *reconnect;
+	struct btd_service *service;
+	struct policy_data *data;
+	bool do_reconnect = false;
 
 	DBG("reason %u", reason);
 
-	if (reason != MGMT_DEV_DISCONN_TIMEOUT)
+	switch(reason) {
+	case MGMT_DEV_DISCONN_LOCAL_HOST:
+	case MGMT_DEV_DISCONN_REMOTE:
+		do_reconnect = true;
+		break;
+	/* Disconnect due to suspend will queue reconnect on resume for a2dp */
+	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
+		service = btd_device_get_service(dev, A2DP_SINK_UUID);
+		if (service && (data = policy_get_data(dev))) {
+			data->reconnect_on_resume = true;
+		}
+		break;
+	/* All other cases do not result in reconnect */
+	default:
+		break;
+	}
+
+	if (!do_reconnect)
 		return;
 
 	reconnect = reconnect_find(dev);
@@ -761,6 +791,23 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 	reconnect_set_timer(reconnect);
 }
 
+static void controller_resume_cb(uint8_t wake_reason, const bdaddr_t *addr,
+					const uint8_t addr_type)
+{
+	struct btd_device *dev;
+	GSList *l;
+
+	/* Check if any devices needed to be reconnected on resume */
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct policy_data *data = l->data;
+
+		if (data->reconnect_on_resume) {
+			policy_set_sink_timer_internal(data,
+						       resume_reconnect_delay);
+		}
+	}
+}
+
 static void conn_fail_cb(struct btd_device *dev, uint8_t status)
 {
 	struct reconnect_data *reconnect;
@@ -854,9 +901,17 @@ static int policy_init(void)
 	auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
 									NULL);
 
+	resume_reconnect_delay = g_key_file_get_integer(
+			conf, "Policy", "ReconnectAudioDelay", &gerr);
+
+	if (gerr) {
+		g_clear_error(&gerr);
+		resume_reconnect_delay = default_reconnect_delay;
+	}
 done:
 	if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
 		btd_add_disconnect_cb(disconnect_cb);
+		btd_add_controller_resume_cb(controller_resume_cb);
 		btd_add_conn_fail_cb(conn_fail_cb);
 	}
 
@@ -869,6 +924,7 @@ done:
 static void policy_exit(void)
 {
 	btd_remove_disconnect_cb(disconnect_cb);
+	btd_remove_controller_resume_cb(controller_resume_cb);
 	btd_remove_conn_fail_cb(conn_fail_cb);
 
 	if (reconnect_uuids)
diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..7526feb9e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -139,6 +139,7 @@ static GSList *adapter_drivers = NULL;
 
 static GSList *disconnect_list = NULL;
 static GSList *conn_fail_list = NULL;
+static GSList *controller_resume_list = NULL;
 
 struct link_key_info {
 	bdaddr_t bdaddr;
@@ -8766,6 +8767,45 @@ static void connected_callback(uint16_t index, uint16_t length,
 	eir_data_free(&eir_data);
 }
 
+static void controller_resume_notify(const uint8_t wake_reason,
+					const bdaddr_t *addr,
+					const uint8_t addr_type)
+{
+	GSList *l;
+
+	for (l = controller_resume_list; l; l = g_slist_next(l)) {
+		btd_controller_resume_cb resume_cb = l->data;
+		resume_cb(wake_reason, addr, addr_type);
+	}
+}
+
+static void controller_resume_callback(uint16_t index, uint16_t length,
+				       const void *param, void *user_data)
+{
+	const struct mgmt_ev_controller_resume *ev = param;
+	struct btd_adapter *adapter = user_data;
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id, "Too small device resume event");
+		return;
+	}
+
+	DBG("Controller resume with wake event 0x%x", ev->wake_reason);
+
+	controller_resume_notify(ev->wake_reason, &ev->addr.bdaddr,
+				 ev->addr.type);
+}
+
+void btd_add_controller_resume_cb(btd_controller_resume_cb func)
+{
+	controller_resume_list = g_slist_append(controller_resume_list, func);
+}
+
+void btd_remove_controller_resume_cb(btd_controller_resume_cb func)
+{
+	controller_resume_list = g_slist_remove(controller_resume_list, func);
+}
+
 static void device_blocked_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9389,6 +9429,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						user_passkey_notify_callback,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_CONTROLLER_RESUME,
+						adapter->dev_id,
+						controller_resume_callback,
+						adapter, NULL);
+
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..5527e4205 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -67,6 +67,12 @@ typedef void (*btd_conn_fail_cb) (struct btd_device *device, uint8_t status);
 void btd_add_conn_fail_cb(btd_conn_fail_cb func);
 void btd_remove_conn_fail_cb(btd_conn_fail_cb func);
 
+typedef void (*btd_controller_resume_cb)(const uint8_t wake_reason,
+					const bdaddr_t *addr,
+					const uint8_t addr_type);
+void btd_add_controller_resume_cb(btd_controller_resume_cb func);
+void btd_remove_controller_resume_cb(btd_controller_resume_cb func);
+
 struct btd_adapter *adapter_find(const bdaddr_t *sba);
 struct btd_adapter *adapter_find_by_id(int id);
 void adapter_foreach(adapter_cb func, gpointer user_data);
diff --git a/src/main.c b/src/main.c
index 2c083de67..a1c3e7e9f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -131,6 +131,7 @@ static const char *policy_options[] = {
 	"ReconnectAttempts",
 	"ReconnectIntervals",
 	"AutoEnable",
+	"ReconnectAudioDelay",
 	NULL
 };
 
diff --git a/src/main.conf b/src/main.conf
index f41203b96..8d74a2aec 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -198,3 +198,12 @@
 # This includes adapters present on start as well as adapters that are plugged
 # in later on. Defaults to 'false'.
 #AutoEnable=false
+
+# Audio devices that were disconnected due to suspend will be reconnected on
+# resume. ReconnectAudioDelay determines the delay between when the controller
+# resumes from suspend and a connection attempt is made. A longer delay can be
+# better for co-existence with Wi-Fi.
+# The value is in seconds.
+# Default: 5
+#ReconnectAudioDelay = 5
+
-- 
2.28.0.297.g1956fa8f8d-goog

