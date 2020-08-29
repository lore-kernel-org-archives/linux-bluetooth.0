Return-Path: <SRS0=jcZI=CH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D43C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A043207BB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FTd0+jLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgH2BCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgH2BCW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3713C061233
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y6so438183plt.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgVLhgo2q6+uzn37hzuq4exT5rVSGJyUMMk1KlmWH+Y=;
        b=FTd0+jLmC0VFf0yOezHQ5xCRyo+I07pit0tXKVs9dpf+q5R7LA2uw9zjGO4Azu2lFn
         A0y1v8tEOacOM+VIOGOrp9VgDAv52Ahf0/nUlBXqzVC+EqobnkdDZ7xjwYR8CmfSMv+K
         jp3jStLhulHGjipZcoItuOw6N4jPU5rNaVfZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgVLhgo2q6+uzn37hzuq4exT5rVSGJyUMMk1KlmWH+Y=;
        b=NW0etC0vYHg46aONnsnQvO4tAy+x1Sf+EURjOYRjBV/jYFkwsrzad/eLPkbXyszgSE
         D/hn/OH3jplfQp7YiZ+VElbGPng+DsbQPGvfP236ztooZ/eRvA48jOeDINaiMExxjHS+
         bPBrGUzU0yhC2Gu2EsgxXjPvf2+zhGGJNQ5VX2YtyIkF+UhkspUuIA+ZrBmi1htmPq2d
         oKfUNZ/LSPmlq8O+92IORdA5di0SWzsJqr182ISGNSSlhRSlVQcHHE8rikP8V6YtZbPM
         z1V9rlcke80xEAszG2u8BAi+LGnYZ1wDefYCZaDppFBaEfksUruMGej8YUwm6Puhxyg4
         ZbEQ==
X-Gm-Message-State: AOAM53094tdEOlRopRF4z1Ue0pGh2vSIvHc5zCvYSeH1E938sKeSUwZX
        ZL3ZXeDbFECFy7VG7PTuSWvKSg==
X-Google-Smtp-Source: ABdhPJxDHy/Oo0u0LpMqbIu2d36kNLMlYuPkhCKHxJtgyMOETBhMW9Fi+tsZp6A7lXgzkS+dQNApSg==
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr1329325pjo.98.1598662940733;
        Fri, 28 Aug 2020 18:02:20 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id 78sm630360pfv.200.2020.08.28.18.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 18:02:20 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v3 3/3] policy: Reconnect audio on controller resume
Date:   Fri, 28 Aug 2020 18:02:10 -0700
Message-Id: <20200828180157.Bluez.v3.3.I26efd89de3a70af1cd9775d457d0c10f4aafd4cb@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200829010210.871471-1-abhishekpandit@chromium.org>
References: <20200829010210.871471-1-abhishekpandit@chromium.org>
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

Changes in v3:
- Refactored resume notification to use btd_adapter_driver
- Renamed ReconnectAudioDelay to ResumeDelay and set default to 2
- Added A2DP_SINK_UUID to default reconnect list

Changes in v2:
- Refactored to use policy instead of connecting directly in adapter

 plugins/policy.c | 80 +++++++++++++++++++++++++++++++++++++++---------
 src/adapter.c    | 36 ++++++++++++++++++++++
 src/adapter.h    |  2 ++
 src/main.c       |  1 +
 src/main.conf    | 11 ++++++-
 5 files changed, 115 insertions(+), 15 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index de51e58b9..5ab65b991 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -62,10 +62,12 @@ struct reconnect_data {
 	guint timer;
 	bool active;
 	unsigned int attempt;
+	bool on_resume;
 };
 
 static const char *default_reconnect[] = {
-			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID, NULL };
+			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID,
+			A2DP_SINK_UUID, NULL };
 static char **reconnect_uuids = NULL;
 
 static const size_t default_attempts = 7;
@@ -75,6 +77,9 @@ static const int default_intervals[] = { 1, 2, 4, 8, 16, 32, 64 };
 static int *reconnect_intervals = NULL;
 static size_t reconnect_intervals_len = 0;
 
+static const int default_resume_delay = 2;
+static int resume_delay;
+
 static GSList *reconnects = NULL;
 
 static unsigned int service_id = 0;
@@ -711,6 +716,9 @@ static gboolean reconnect_timeout(gpointer data)
 	/* Mark the GSource as invalid */
 	reconnect->timer = 0;
 
+	/* Mark any reconnect on resume as handled */
+	reconnect->on_resume = false;
+
 	err = btd_device_connect_services(reconnect->dev, reconnect->services);
 	if (err < 0) {
 		error("Reconnecting services failed: %s (%d)",
@@ -724,14 +732,17 @@ static gboolean reconnect_timeout(gpointer data)
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
@@ -743,10 +754,14 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
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
@@ -755,10 +770,40 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 
 	reconnect_reset(reconnect);
 
-	DBG("Device %s identified for auto-reconnection",
-							device_get_path(dev));
+	DBG("Device %s identified for auto-reconnection", device_get_path(dev));
 
-	reconnect_set_timer(reconnect);
+	switch(reason)
+	{
+	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
+		if (btd_device_get_service(dev, A2DP_SINK_UUID)) {
+			reconnect->on_resume = true;
+			DBG("%s configured to reconnect on resume",
+			    device_get_path(dev));
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
+static void policy_adapter_resume(struct btd_adapter *adapter,
+				  uint8_t wake_reason, const bdaddr_t *addr,
+				  const uint8_t addr_type)
+{
+	GSList *l;
+
+	/* Check if any devices needed to be reconnected on resume */
+	for (l = reconnects; l; l = g_slist_next(l)) {
+		struct reconnect_data *reconnect = l->data;
+
+		if (reconnect->on_resume) {
+			reconnect_set_timer(reconnect, resume_delay);
+		}
+	}
 }
 
 static void conn_fail_cb(struct btd_device *dev, uint8_t status)
@@ -786,14 +831,15 @@ static void conn_fail_cb(struct btd_device *dev, uint8_t status)
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
@@ -801,6 +847,7 @@ static int policy_adapter_probe(struct btd_adapter *adapter)
 static struct btd_adapter_driver policy_driver = {
 	.name	= "policy",
 	.probe	= policy_adapter_probe,
+	.resume = policy_adapter_resume,
 };
 
 static int policy_init(void)
@@ -854,14 +901,20 @@ static int policy_init(void)
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
@@ -882,8 +935,7 @@ static void policy_exit(void)
 
 	btd_service_remove_state_cb(service_id);
 
-	if (auto_enable)
-		btd_unregister_adapter_driver(&policy_driver);
+	btd_unregister_adapter_driver(&policy_driver);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(policy, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/src/adapter.c b/src/adapter.c
index 1435e2bd7..bf355bfa7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8776,6 +8776,37 @@ static void connected_callback(uint16_t index, uint16_t length,
 	eir_data_free(&eir_data);
 }
 
+static void controller_resume_notify(struct btd_adapter *adapter,
+				     const uint8_t wake_reason,
+				     const bdaddr_t *addr,
+				     const uint8_t addr_type)
+{
+	GSList *l;
+
+	for (l = adapter->drivers; l; l = g_slist_next(l)) {
+		struct btd_adapter_driver *driver = l->data;
+		if (driver->resume)
+			driver->resume(adapter, wake_reason, addr, addr_type);
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
+	info("Controller resume with wake event 0x%x", ev->wake_reason);
+
+	controller_resume_notify(adapter, ev->wake_reason, &ev->addr.bdaddr,
+				 ev->addr.type);
+}
+
 static void device_blocked_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9399,6 +9430,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
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
index f8ac20261..b81ef6a04 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -113,6 +113,8 @@ struct btd_adapter_driver {
 	const char *name;
 	int (*probe) (struct btd_adapter *adapter);
 	void (*remove) (struct btd_adapter *adapter);
+	void (*resume)(struct btd_adapter *adapter, uint8_t wake_reason,
+		       const bdaddr_t *addr, const uint8_t addr_type);
 };
 
 typedef void (*service_auth_cb) (DBusError *derr, void *user_data);
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
index 42f7e41c5..9f882e65a 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -186,7 +186,7 @@
 # timeout). The policy plugin should contain a sane set of values by
 # default, but this list can be overridden here. By setting the list to
 # empty the reconnection feature gets disabled.
-#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb
+#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb,0000110b-0000-1000-8000-00805f9b34fb
 
 # ReconnectAttempts define the number of attempts to reconnect after a link
 # lost. Setting the value to 0 disables reconnecting feature.
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
2.28.0.402.g5ffc5be6b7-goog

