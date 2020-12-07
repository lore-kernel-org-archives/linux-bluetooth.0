Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 23:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D3A23A21
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 23:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgLGXuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLGXuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 18:50:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA2C061794
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 15:49:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w6so12025619pfu.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 15:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3YIwM7mYkyUVpty+kMtQnJwEE0duGyP7ZHq0qANzv8=;
        b=oAkZf7WXj43wInABPTj1onV1M1ryZk391gJGd6a7I+zP3fRoKS00MmFpM34UdfQZz8
         ppeKorZsUV3EgugY47hWyZFBdiMpGUcW0mEv+zNs7Bf+h8TD5itznMVkAr0i2SIP97sF
         C38/rwnUw8EI1m7uhzHjIoXmTdctj+7Q42QN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3YIwM7mYkyUVpty+kMtQnJwEE0duGyP7ZHq0qANzv8=;
        b=Y7mG2wXO3RqB+YzuOuGi0VH8+YTkNi86FAlpLaT1AQ+os3aeX4+bvoWSeJvjpcGRll
         tcFNGU4EkbnIX4Bclz+bHCQSjf03fkMIm8UmX35LCXgCeNWN1Lm2lBEoD9rGMyR2s9Uz
         dINv60aqJDNDY73FdM7wqBKHDEW4YlXz1dbntE0OHlyTOL+/FKTJcuUREdjwRtA+8xsn
         CsS8ELu4/Bw5jDdlFb8etkoK/phFUhzzrouJGXQwZVaOxxnkpcEAcCSf5WPwY2eEqdF8
         fyrgyH4bjfSvPJ25DEhzBvDWM9zQ7gYqaKyseO9HnaPwqeePiJlb2Nm2xLt7eVWj9gal
         lP6w==
X-Gm-Message-State: AOAM5328o3wIc1umpi7AnOhuEmTrmLSBesEvxPeWiMaVyuBW4kqU9mKw
        kPH4CBeZ+NUWEhOZSSQQ+67LSA==
X-Google-Smtp-Source: ABdhPJx5wMCmumZIJlo2pLJNzm8/PmhR+5shoE5QHZM0jkZN09cidrw0pbKHBhl+ebpz2Ek63YtQ2A==
X-Received: by 2002:a17:902:123:b029:da:420e:aab0 with SMTP id 32-20020a1709020123b02900da420eaab0mr19182465plb.30.1607384973611;
        Mon, 07 Dec 2020 15:49:33 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id g16sm15062041pfb.201.2020.12.07.15.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:49:33 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [bluez PATCH 1/1] policy: Refactor reconnect policy for resume
Date:   Mon,  7 Dec 2020 15:49:24 -0800
Message-Id: <20201207154903.bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201207234924.140606-1-abhishekpandit@chromium.org>
References: <20201207234924.140606-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Airpods incorrectly emit a connection timeout as the disconnect reason
when a different device connects to it and triggers the automatic
reconnection by mistake. See hci trace below:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Timeout (0x08)
@ MGMT Event: Device Disconnected (0x000c) plen 8
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
@ MGMT Event: Device Disconnected (0x000c) plen 8
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
@ MGMT Event: Device Disconnected (0x000c) plen 8
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
@ MGMT Event: Device Disconnected (0x000c) plen 8
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13
        Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Create Connection (0x01|0x0005) ncmd 1

To fix this behavior, separate the ReconnectUUIDs into services that
reconnect on timeout and on resume. This ensures that the a2dp-sink
profile reconnects are correctly applied only on resume from suspend and
adds the option to reconnect other profiles automatically on resume.

Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 plugins/policy.c | 72 ++++++++++++++++++++++++++++++++++++------------
 src/main.conf    |  9 +++++-
 2 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index ba9e1be02..a3cc3445e 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -44,19 +44,22 @@
 
 struct reconnect_data {
 	struct btd_device *dev;
-	bool reconnect;
+	bool on_timeout;
+	bool on_resume;
 	GSList *services;
 	guint timer;
 	bool active;
 	unsigned int attempt;
-	bool on_resume;
+	bool mark_on_suspend;
 };
 
 static const char *default_reconnect[] = {
-			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID,
-			A2DP_SINK_UUID, NULL };
+			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID, NULL };
 static char **reconnect_uuids = NULL;
 
+static const char *default_reconnect_resume[] = { A2DP_SINK_UUID, NULL };
+static char **reconnect_resume_uuids = NULL;
+
 static const size_t default_attempts = 7;
 static size_t reconnect_attempts = 0;
 
@@ -551,14 +554,14 @@ static void reconnect_reset(struct reconnect_data *reconnect)
 	}
 }
 
-static bool reconnect_match(const char *uuid)
+static bool reconnect_match_internal(const char *uuid, char **matchlist)
 {
 	char **str;
 
-	if (!reconnect_uuids)
+	if (!matchlist)
 		return false;
 
-	for (str = reconnect_uuids; *str; str++) {
+	for (str = matchlist; *str; str++) {
 		if (!bt_uuid_strcmp(uuid, *str))
 			return true;
 	}
@@ -566,6 +569,16 @@ static bool reconnect_match(const char *uuid)
 	return false;
 }
 
+static bool reconnect_match(const char *uuid)
+{
+	return reconnect_match_internal(uuid, reconnect_uuids);
+}
+
+static bool reconnect_resume_match(const char *uuid)
+{
+	return reconnect_match_internal(uuid, reconnect_resume_uuids);
+}
+
 static struct reconnect_data *reconnect_add(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
@@ -687,10 +700,15 @@ static void service_cb(struct btd_service *service,
 	 * be the first profile that's connected so we might have an
 	 * entry but with the reconnect flag set to false.
 	 */
-	if (!reconnect->reconnect)
-		reconnect->reconnect = reconnect_match(profile->remote_uuid);
+	if (!reconnect->on_timeout)
+		reconnect->on_timeout = reconnect_match(profile->remote_uuid);
+
+	if (!reconnect->on_resume)
+		reconnect->on_resume =
+			reconnect_resume_match(profile->remote_uuid);
 
-	DBG("Added %s reconnect %u", profile->name, reconnect->reconnect);
+	DBG("Added %s reconnect on timeout(%u), resume(%u)",
+		profile->name, reconnect->on_timeout, reconnect->on_resume);
 }
 
 static gboolean reconnect_timeout(gpointer data)
@@ -704,7 +722,7 @@ static gboolean reconnect_timeout(gpointer data)
 	reconnect->timer = 0;
 
 	/* Mark any reconnect on resume as handled */
-	reconnect->on_resume = false;
+	reconnect->mark_on_suspend = false;
 
 	err = btd_device_connect_services(reconnect->dev, reconnect->services);
 	if (err < 0) {
@@ -750,7 +768,7 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 		return;
 
 	reconnect = reconnect_find(dev);
-	if (!reconnect || !reconnect->reconnect)
+	if (!reconnect || !(reconnect->on_timeout || reconnect->on_resume))
 		return;
 
 	reconnect_reset(reconnect);
@@ -759,11 +777,11 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 
 	switch (reason) {
 	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
-		if (btd_device_get_service(dev, A2DP_SINK_UUID)) {
+		if (reconnect->on_resume) {
 			DBG("%s configured to reconnect on resume",
 				device_get_path(dev));
 
-			reconnect->on_resume = true;
+			reconnect->mark_on_suspend = true;
 
 			/* If the kernel supports resume events, it is
 			 * preferable to set the reconnect timer there as it is
@@ -774,7 +792,8 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
 		}
 		break;
 	case MGMT_DEV_DISCONN_TIMEOUT:
-		reconnect_set_timer(reconnect, -1);
+		if (reconnect->on_timeout)
+			reconnect_set_timer(reconnect, -1);
 		break;
 	default:
 		DBG("Developer error. Reason = %d", reason);
@@ -790,7 +809,7 @@ static void policy_adapter_resume(struct btd_adapter *adapter)
 	for (l = reconnects; l; l = g_slist_next(l)) {
 		struct reconnect_data *reconnect = l->data;
 
-		if (reconnect->on_resume &&
+		if (reconnect->mark_on_suspend &&
 		    device_get_adapter(reconnect->dev) == adapter) {
 			reconnect_set_timer(reconnect, resume_delay);
 		}
@@ -804,7 +823,7 @@ static void conn_fail_cb(struct btd_device *dev, uint8_t status)
 	DBG("status %u", status);
 
 	reconnect = reconnect_find(dev);
-	if (!reconnect || !reconnect->reconnect)
+	if (!reconnect || !(reconnect->on_timeout || reconnect->on_resume))
 		return;
 
 	if (!reconnect->active)
@@ -845,6 +864,7 @@ static int policy_init(void)
 {
 	GError *gerr = NULL;
 	GKeyFile *conf;
+	bool has_reconnect_uuids;
 
 	service_id = btd_service_add_state_cb(service_cb, NULL);
 
@@ -892,6 +912,15 @@ static int policy_init(void)
 	auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
 									NULL);
 
+	reconnect_resume_uuids = g_key_file_get_string_list(
+		conf, "Policy", "ReconnectResumeUUIDs", NULL, &gerr);
+
+	if (gerr) {
+		g_clear_error(&gerr);
+		reconnect_resume_uuids =
+			g_strdupv((char **)default_reconnect_resume);
+	}
+
 	resume_delay = g_key_file_get_integer(
 			conf, "Policy", "ResumeDelay", &gerr);
 
@@ -900,7 +929,11 @@ static int policy_init(void)
 		resume_delay = default_resume_delay;
 	}
 done:
-	if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
+	has_reconnect_uuids =
+		(reconnect_uuids && reconnect_uuids[0]) ||
+		(reconnect_resume_uuids && reconnect_resume_uuids[0]);
+
+	if (reconnect_attempts && has_reconnect_uuids) {
 		btd_add_disconnect_cb(disconnect_cb);
 		btd_add_conn_fail_cb(conn_fail_cb);
 	}
@@ -918,6 +951,9 @@ static void policy_exit(void)
 	if (reconnect_uuids)
 		g_strfreev(reconnect_uuids);
 
+	if (reconnect_resume_uuids)
+		g_strfreev(reconnect_resume_uuids);
+
 	g_free(reconnect_intervals);
 
 	g_slist_free_full(reconnects, reconnect_destroy);
diff --git a/src/main.conf b/src/main.conf
index ad36638b7..6f66acb14 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -220,7 +220,7 @@
 # timeout). The policy plugin should contain a sane set of values by
 # default, but this list can be overridden here. By setting the list to
 # empty the reconnection feature gets disabled.
-#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb,0000110b-0000-1000-8000-00805f9b34fb
+#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb
 
 # ReconnectAttempts define the number of attempts to reconnect after a link
 # lost. Setting the value to 0 disables reconnecting feature.
@@ -237,6 +237,13 @@
 # in later on. Defaults to 'false'.
 #AutoEnable=false
 
+# The ReconnectResumeUUIDs defines the set of remote services that should try
+# to be reconnected after resume from suspend if they were connected before
+# suspend. If a device is disconnected due to suspend, it will be queued for
+# reconnect on resume first using the ResumeDelay value and then the remaining
+# values in ReconnectIntervals.
+#ReconnectResumeUUIDs=0000110b-0000-1000-8000-00805f9b34fb
+
 # Audio devices that were disconnected due to suspend will be reconnected on
 # resume. ResumeDelay determines the delay between when the controller
 # resumes from suspend and a connection attempt is made. A longer delay is
-- 
2.29.2.576.ga3fc446d84-goog

