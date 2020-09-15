Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3559C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7882193E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4iPadvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgIORoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgIORl6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 13:41:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9B0C061788
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so166250pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K68OMwlpExv+H2CPFTDq3E7u55gF4Q0V8948rZscVcY=;
        b=K4iPadvg0nNgSbx6It9gMhlMf8f3iAUys9Jl6j7LYXIlIvdjbXFt2Gsla5ytYqS0Z2
         KwWR1KmWId7wMR44ZW0EghB1L8nFOskYcaUFgkkv/RUmCCzC/4zICqtFgbvVx2q/7zDE
         TTTdmrVU5Umn6U1ix4G3Azv+gJ/05M9AmZBnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K68OMwlpExv+H2CPFTDq3E7u55gF4Q0V8948rZscVcY=;
        b=AgwuxRsFP5RfDUt+cFkc0+NyZqqweAw+mdBR9ldFuGewpwiHcm2OWTeAi/H1ZpVoum
         1ZBwjYujR1u5X2qp8dLHdxgoKWPHIxK4dpicogBbptPmqgrTgPowUBX3T4U8CVB3sq+z
         gxnJapGxodhrhKABa+OOpI58nQOls+nVOrhwhEKDh0p1mEBiOuKuFwV0Syn3aVkPdYwl
         W5UEKbh9bTLaPQXWIZKQymMRICjdWuHtALAnZqrwv0SBK4otIrYVmI8d0WdHZ/CjfYIR
         Sjcsv4q9npZ41Hi7MVnt9/WmZD3jToCAEtti2uO7bNDK0q6OvcUcanRXYm0k8p2a6sOx
         J3gA==
X-Gm-Message-State: AOAM5337vKhGBtB6So2Cl54G20Lgdlh3MuScOKpUomUne4UORxmCAGgW
        vXvssg8e3lGlg6Is9wNz+PFUkQ==
X-Google-Smtp-Source: ABdhPJwc68XJZ8R6iQvfVf8UExhHudfNU97Pet9GhVy5uDvY3ltTqkxf80GZUXznPoCphv5OvrSTBA==
X-Received: by 2002:a17:90a:1548:: with SMTP id y8mr423325pja.113.1600191717370;
        Tue, 15 Sep 2020 10:41:57 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id y29sm15490232pfq.207.2020.09.15.10.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:41:56 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v5 1/4] adapter: Refactor kernel feature globals
Date:   Tue, 15 Sep 2020 10:41:43 -0700
Message-Id: <20200915104127.Bluez.v5.1.Ib9712d2bf5d4b3f90c5bc835742aea8c7cd239e4@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915174146.1693687-1-abhishekpandit@chromium.org>
References: <20200915174146.1693687-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move all the kernel specific feature globals into a single
kernel_features bitfield and replace all uses with the bitfield instead.
---

Changes in v5:
- Remove use of !! in has_kernel_features

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/adapter.c | 59 ++++++++++++++++++++++++++-------------------------
 src/adapter.h |  9 ++++++++
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1435e2bd7..88b5202d9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -116,13 +116,7 @@ static const struct mgmt_blocked_key_info blocked_keys[] = {
 
 static DBusConnection *dbus_conn = NULL;
 
-static bool kernel_conn_control = false;
-
-static bool kernel_blocked_keys_supported = false;
-
-static bool kernel_set_system_config = false;
-
-static bool kernel_exp_features = false;
+static uint32_t kernel_features = 0;
 
 static GList *adapter_list = NULL;
 static unsigned int adapter_remaining = 0;
@@ -678,7 +672,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
 
 	DBG("sending set mode command for index %u", adapter->dev_id);
 
-	if (kernel_conn_control) {
+	if (has_kernel_features(KERNEL_CONN_CONTROL)) {
 		if (mode)
 			set_mode(adapter, MGMT_OP_SET_CONNECTABLE, mode);
 		else
@@ -1334,7 +1328,7 @@ static void trigger_passive_scanning(struct btd_adapter *adapter)
 	 * no need to start any discovery. The kernel will keep scanning
 	 * as long as devices are in its auto-connection list.
 	 */
-	if (kernel_conn_control)
+	if (has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	/*
@@ -1385,7 +1379,7 @@ static void stop_passive_scanning_complete(uint8_t status, uint16_t length,
 	 * no need to stop any discovery. The kernel will handle the
 	 * auto-connection by itself.
 	 */
-	if (kernel_conn_control)
+	if (has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	/*
@@ -2816,7 +2810,7 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 
 static void clear_discoverable(struct btd_adapter *adapter)
 {
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	if (!(adapter->current_settings & MGMT_SETTING_DISCOVERABLE))
@@ -2876,7 +2870,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 		break;
 	case MGMT_SETTING_DISCOVERABLE:
-		if (kernel_conn_control) {
+		if (has_kernel_features(KERNEL_CONN_CONTROL)) {
 			if (mode) {
 				set_mode(adapter, MGMT_OP_SET_CONNECTABLE,
 									mode);
@@ -4193,7 +4187,8 @@ static void load_default_system_params(struct btd_adapter *adapter)
 	size_t len = 0;
 	unsigned int err;
 
-	if (!main_opts.default_params.num_entries || !kernel_set_system_config)
+	if (!main_opts.default_params.num_entries ||
+	    !has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
 		return;
 
 	params = malloc0(sizeof(*params) *
@@ -4878,7 +4873,7 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
 	 * adapter_auto_connect_add() function is used to maintain what to
 	 * connect.
 	 */
-	if (kernel_conn_control)
+	if (has_kernel_features(KERNEL_CONN_CONTROL))
 		return 0;
 
 	if (g_slist_find(adapter->connect_list, device)) {
@@ -4918,7 +4913,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 	if (device == adapter->connect_le)
 		adapter->connect_le = NULL;
 
-	if (kernel_conn_control)
+	if (has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	if (!g_slist_find(adapter->connect_list, device)) {
@@ -4980,7 +4975,7 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
 {
 	struct mgmt_cp_add_device cp;
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
@@ -5019,7 +5014,7 @@ void adapter_whitelist_remove(struct btd_adapter *adapter, struct btd_device *de
 {
 	struct mgmt_cp_remove_device cp;
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
@@ -5075,7 +5070,7 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 	uint8_t bdaddr_type;
 	unsigned int id;
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	if (g_slist_find(adapter->connect_list, device)) {
@@ -5147,7 +5142,7 @@ void adapter_set_device_wakeable(struct btd_adapter *adapter,
 	const bdaddr_t *bdaddr;
 	uint8_t bdaddr_type;
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	bdaddr = device_get_address(device);
@@ -5224,7 +5219,7 @@ void adapter_auto_connect_remove(struct btd_adapter *adapter,
 	uint8_t bdaddr_type;
 	unsigned int id;
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	if (!g_slist_find(adapter->connect_list, device)) {
@@ -6764,7 +6759,7 @@ connect_le:
 	 * If kernel background scan is used then the kernel is
 	 * responsible for connecting.
 	 */
-	if (kernel_conn_control)
+	if (has_kernel_features(KERNEL_CONN_CONTROL))
 		return;
 
 	/*
@@ -8964,7 +8959,7 @@ static int clear_devices(struct btd_adapter *adapter)
 {
 	struct mgmt_cp_remove_device cp;
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -9282,7 +9277,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
 
-	if (kernel_exp_features)
+	if (has_kernel_features(KERNEL_EXP_FEATURES))
 		read_exp_features(adapter);
 
 	err = adapter_register(adapter);
@@ -9403,7 +9398,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_name(adapter, btd_adapter_get_name(adapter));
 
-	if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
+	if (has_kernel_features(KERNEL_BLOCKED_KEYS_SUPPORTED) &&
+	    !set_blocked_keys(adapter)) {
 		btd_error(adapter->dev_id,
 				"Failed to set blocked keys for index %u",
 				adapter->dev_id);
@@ -9414,7 +9410,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
 
-	if (!kernel_conn_control)
+	if (!has_kernel_features(KERNEL_CONN_CONTROL))
 		set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
 	else if (adapter->current_settings & MGMT_SETTING_CONNECTABLE)
 		set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x00);
@@ -9590,19 +9586,19 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 		switch (op) {
 		case MGMT_OP_ADD_DEVICE:
 			DBG("enabling kernel-side connection control");
-			kernel_conn_control = true;
+			kernel_features |= KERNEL_CONN_CONTROL;
 			break;
 		case MGMT_OP_SET_BLOCKED_KEYS:
 			DBG("kernel supports the set_blocked_keys op");
-			kernel_blocked_keys_supported = true;
+			kernel_features |= KERNEL_BLOCKED_KEYS_SUPPORTED;
 			break;
 		case MGMT_OP_SET_DEF_SYSTEM_CONFIG:
 			DBG("kernel supports set system confic");
-			kernel_set_system_config = true;
+			kernel_features |= KERNEL_SET_SYSTEM_CONFIG;
 			break;
 		case MGMT_OP_READ_EXP_FEATURES_INFO:
 			DBG("kernel supports exp features");
-			kernel_exp_features = true;
+			kernel_features |= KERNEL_EXP_FEATURES;
 			break;
 		default:
 			break;
@@ -9768,3 +9764,8 @@ bool btd_le_connect_before_pairing(void)
 
 	return false;
 }
+
+bool has_kernel_features(uint32_t features)
+{
+	return (kernel_features & features);
+}
diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..b0ed4915f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -233,3 +233,12 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void *data);
 
 bool btd_le_connect_before_pairing(void);
+
+enum kernel_features {
+	KERNEL_CONN_CONTROL		= 1 << 0,
+	KERNEL_BLOCKED_KEYS_SUPPORTED	= 1 << 1,
+	KERNEL_SET_SYSTEM_CONFIG	= 1 << 2,
+	KERNEL_EXP_FEATURES		= 1 << 3,
+};
+
+bool has_kernel_features(uint32_t feature);
-- 
2.28.0.618.gf4bc123cb7-goog

