Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842EDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6206960E97
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhHQBDO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 21:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhHQBDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 21:03:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35E1C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso3319543pjy.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O7xvZav06DvhskWvbUYgzJEuxANuGfsYOeOIV0XGBAY=;
        b=kAP+Jti+mQmeTKiyzgIOp58EdS1ywC/3q8uaGBEaBtKmtLSIwKOQYPyVfd0gn/3qf+
         6pQNWCWlL8qOMokUqP9KzfvvYquGS9SZ5S7+K+bwCjxwH6Q2BJGPo5xwKiMUmpDMmJrT
         pOG6HsJHlQF2DGYJuAdYVg7gUh4Q89STOO6DaW9Xt5s9yPYEEci0h6iVjJ0wELZvh1Ly
         Vx3hMggab3Bwm04f4CfhJ379nvIrKj7gYAoegRSwTTczt9AZnO1oJidszth3BWwFo9/j
         VfSJI1eWheX/6ybgd7+M3TJ1KLV7Xl5XkM05bDlboYIDNJkoJIubaYJGoBtFwCJaQc61
         Dyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7xvZav06DvhskWvbUYgzJEuxANuGfsYOeOIV0XGBAY=;
        b=CwQrO3odJ8JPlnGMf5Zy7lU7qrN+5fPYHP7Vq3KfzNaUVOVvYdoch8XhS6fwjTdBV8
         +ZbxAho3hsW9O1gPZoAsnL6OzVpUc3P3GuSEKHAjft0CXScpwlc0Nl4zePYIUtL92m+P
         jSumZUyK3KsvJRQbt0qUk0oFhQgEkxbNOd75VWNTJk2Z1itEj/rVRGyKuO83FvDKkNc2
         5rvllvuRpKa7xK2610Er+5FcLtf1x4M6qakYVRm7w4e3uuWuVfQElNSyBgaYXmuG1cUJ
         Y8auLItL34gkTONRJnQXSTmMxd3go/uXT/8ZaZToJnUlzh0JBPUtK/nFqwjclfPIhK6l
         CMMA==
X-Gm-Message-State: AOAM532Ik4ofYftJVG4S9AroNzxBI9MokDt2/8s1gtaT3VYCk306hwtj
        xMpjE53sbSduONYZqkrnyeYYEqVA+fM=
X-Google-Smtp-Source: ABdhPJw3CzLgOHvhFOJRKZcDdhnVWQ5HVjIPuktZMxOrjhawGyYR2PYXq+xlJI/AEW46wrPmsEq5IA==
X-Received: by 2002:aa7:81cb:0:b0:3e1:90df:fbf8 with SMTP id c11-20020aa781cb000000b003e190dffbf8mr924540pfn.8.1629162161199;
        Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q26sm347137pff.174.2021.08.16.18.02.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:02:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] adapter: Implement Experimental property
Date:   Mon, 16 Aug 2021 18:02:36 -0700
Message-Id: <20210817010237.1792589-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817010237.1792589-1-luiz.dentz@gmail.com>
References: <20210817010237.1792589-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements Experimental property which indicates the list of UUIDs
that represents the experimental features currently enabled.
---
 src/adapter.c | 149 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 40 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ddd896751..076600645 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -102,6 +102,30 @@ static const struct mgmt_blocked_key_info blocked_keys[] = {
 		 0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
 };
 
+/* d4992530-b9ec-469f-ab01-6c481c47da1c */
+static const uint8_t debug_uuid[16] = {
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
+	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
+};
+
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const uint8_t le_simult_central_peripheral_uuid[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
+/* 330859bc-7506-492d-9370-9a6f0614037f */
+static const uint8_t quality_report_uuid[16] = {
+	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
+	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
+};
+
+/* 15c0a148-c273-11ea-b3de-0242ac130004 */
+static const uint8_t rpa_resolution_uuid[16] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static uint32_t kernel_features = 0;
@@ -285,8 +309,7 @@ struct btd_adapter {
 
 	bool is_default;		/* true if adapter is default one */
 
-	bool le_simult_roles_supported;
-	bool quality_report_supported;
+	struct queue *exps;
 };
 
 typedef enum {
@@ -3250,7 +3273,8 @@ static gboolean property_get_roles(const GDBusPropertyTable *property,
 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
 	}
 
-	if (adapter->le_simult_roles_supported) {
+	if (queue_find(adapter->exps, NULL,
+				le_simult_central_peripheral_uuid)) {
 		const char *str = "central-peripheral";
 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
 	}
@@ -3260,6 +3284,48 @@ static gboolean property_get_roles(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void property_append_experimental(void *data, void *user_data)
+{
+	uint8_t *feature = data;
+	DBusMessageIter *iter = user_data;
+	uint128_t value;
+	bt_uuid_t uuid;
+	char str[MAX_LEN_UUID_STR + 1];
+	char *ptr;
+
+	bswap_128(feature, &value);
+	bt_uuid128_create(&uuid, value);
+	bt_uuid_to_string(&uuid, str, sizeof(str));
+
+	ptr = str;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+}
+
+static gboolean property_get_experimental(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	queue_foreach(adapter->exps, property_append_experimental, &entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static gboolean property_experimental_exits(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	return !queue_isempty(adapter->exps);
+}
+
 static DBusMessage *remove_device(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -3619,6 +3685,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
 	{ "Roles", "as", property_get_roles },
+	{ "Experimental", "as", property_get_experimental, NULL,
+					property_experimental_exits },
 	{ }
 };
 
@@ -5526,6 +5594,7 @@ static void adapter_free(gpointer user_data)
 
 	g_queue_foreach(adapter->auths, free_service_auth, NULL);
 	g_queue_free(adapter->auths);
+	queue_destroy(adapter->exps, NULL);
 
 	/*
 	 * Unregister all handlers for this specific index since
@@ -6496,6 +6565,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	DBG("Pairable timeout: %u seconds", adapter->pairable_timeout);
 
 	adapter->auths = g_queue_new();
+	adapter->exps = queue_new();
 
 	return btd_adapter_ref(adapter);
 }
@@ -9394,38 +9464,22 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 	.func = _func, \
 }
 
-/* d4992530-b9ec-469f-ab01-6c481c47da1c */
-static const uint8_t debug_uuid[16] = {
-	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
-	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
-};
-
-/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
-static const uint8_t le_simult_central_peripheral_uuid[16] = {
-	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
-	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
-};
-
-/* 330859bc-7506-492d-9370-9a6f0614037f */
-static const uint8_t quality_report_uuid[16] = {
-	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
-	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
-};
-
-/* 15c0a148-c273-11ea-b3de-0242ac130004 */
-static const uint8_t rpa_resolution_uuid[16] = {
-	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
-	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
-};
-
 static void set_exp_debug_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
-	if (status != 0)
+	struct btd_adapter *adapter = user_data;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+
+	if (status != 0) {
 		error("Set Experimental Debug failed with status 0x%02x (%s)",
 						status, mgmt_errstr(status));
-	else
-		DBG("Experimental Debug successfully set");
+		return;
+	}
+
+	DBG("Experimental Debug successfully set");
+
+	if (action)
+		queue_push_tail(adapter->exps, (void *)debug_uuid);
 }
 
 static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
@@ -9434,8 +9488,11 @@ static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
 	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
 
 	/* If already set don't attempt to set it again */
-	if (action == (flags & BIT(0)))
+	if (action == (flags & BIT(0))) {
+		if (action)
+			queue_push_tail(adapter->exps, (void *)debug_uuid);
 		return;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(cp.uuid, debug_uuid, 16);
@@ -9452,25 +9509,33 @@ static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
 static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
 							uint32_t flags)
 {
-	adapter->le_simult_roles_supported = flags & 0x01;
+	if (flags & 0x01)
+		queue_push_tail(adapter->exps,
+				(void *)le_simult_central_peripheral_uuid);
 }
 
 static void quality_report_func(struct btd_adapter *adapter, uint32_t flags)
 {
-	adapter->quality_report_supported = le32_to_cpu(flags) & 0x01;
-
-	btd_info(adapter->dev_id, "quality_report_supported %d",
-			adapter->quality_report_supported);
+	if (flags & 0x01)
+		queue_push_tail(adapter->exps, (void *)quality_report_uuid);
 }
 
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
-	if (status != 0)
+	struct btd_adapter *adapter = user_data;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+
+	if (status != 0) {
 		error("Set RPA Resolution failed with status 0x%02x (%s)",
 						status, mgmt_errstr(status));
-	else
-		DBG("RPA Resolution successfully set");
+		return;
+	}
+
+	DBG("RPA Resolution successfully set");
+
+	if (action)
+		queue_push_tail(adapter->exps, (void *)rpa_resolution_uuid);
 }
 
 static void rpa_resolution_func(struct btd_adapter *adapter, uint32_t flags)
@@ -9479,8 +9544,12 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint32_t flags)
 	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
 
 	/* If already set don't attempt to set it again */
-	if (action == (flags & BIT(0)))
+	if (action == (flags & BIT(0))) {
+		if (action)
+			queue_push_tail(adapter->exps,
+						(void *)rpa_resolution_uuid);
 		return;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(cp.uuid, rpa_resolution_uuid, 16);
-- 
2.31.1

