Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDF9C33C9B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 01:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF31A2073D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 01:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mr+xThdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgAGBaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:30:22 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38802 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgAGBaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 20:30:22 -0500
Received: by mail-ua1-f67.google.com with SMTP id c7so14915415uaf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 17:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMOyKHZrZly9vb+D7IErIVhSdXWXyenvU9Z0hzUB26c=;
        b=Mr+xThduYO0KMRBHgbjQ8+Wfi9SUS/3aQbAh6jB92wc2fDeuLrkWjd5hFcYiWOoRDO
         eMXnOrlzK4UY+t8anHVT8o9D+JI3ijIa+w50watiW/+0t9jDOq65V3lxSi3pGjq+Uwe6
         5s7D/5gWo0eJpFgEOrPuDLFf8VUjYR3RT4Pac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMOyKHZrZly9vb+D7IErIVhSdXWXyenvU9Z0hzUB26c=;
        b=FNuAKN+lLZmD3/L/RsG/LdRAvrVUs8HxRkDsOqq8vh/S7K+UFcdTWDgbtxail8sMM+
         be+SzCNndNob5tKfZsto7kvY9Vl3/4No3ClYgZp76Y/B8HC4IkmW52bKvYqYAWbk1EkN
         XD4ujS4hD51hEYCMViiMOHl5Hth9SnvROVdWFZ8tlw8BSNI8ML6DO+c18q2XaLQ8qeD+
         rX5yF3E2braC87ywe36mHMGwn2D98ABy3A8T0e9xdDaKC1f8Zw0NliZePBoTlCgscppB
         Pt2GWusARO33HzQcoeQJ1LcDWBTxIksUr9bO6E4Ft8q32IfgDcKuIr3ANqjM+LQR62TW
         G0rg==
X-Gm-Message-State: APjAAAVugob84+LgqKPS6VT2/0h14JXZIYpsU8f4BnN96SeUt57k0ClE
        vuiuEzeRNICPKgwBdF+ANBw+ugsCiR0=
X-Google-Smtp-Source: APXvYqwsHOr5q4JQmTKZ9JmeSQLZUIoalJqciEq+6yr9hZL+RvDgsDo/lmWj7F7y/eAPtHGG0B19ug==
X-Received: by 2002:ab0:770b:: with SMTP id z11mr62457549uaq.127.1578360620470;
        Mon, 06 Jan 2020 17:30:20 -0800 (PST)
Received: from alain.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id y7sm18784079vkd.38.2020.01.06.17.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:30:19 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, Alain Michaud <alainm@chromium.org>
Subject: [PATCH v5 3/3] Loading keys that should be blocked by the kernel.
Date:   Tue,  7 Jan 2020 01:28:22 +0000
Message-Id: <20200107012820.158721-3-alainm@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107012820.158721-1-alainm@chromium.org>
References: <20200107012820.158721-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change accomplishes 2 things:
 1. Drop device security data from previously paired devices
 using blocked keys.
 2. Send the list of known bad keys that should be blocked to the kernel
 if supported.

In particular keys from the Google Titan Security key are being
blocked.

For additional background information, please see
https://security.googleblog.com/2019/05/titan-keys-update.html
---

 src/adapter.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cef25616f..9c41ebe86 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -99,10 +99,27 @@
 #define DISTANCE_VAL_INVALID	0x7FFF
 #define PATHLOSS_MAX		137
 
+/*
+ * These are known security keys that have been compromised.
+ * If this grows or there are needs to be platform specific, it is
+ * conceivable that these could be read from a config file.
+ */
+static const struct mgmt_blocked_key_info blocked_keys[] = {
+	/* Google Titan Security Keys */
+	{ HCI_BLOCKED_KEY_TYPE_LTK,
+		{0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
+		 0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
+	{ HCI_BLOCKED_KEY_TYPE_IRK,
+		{0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
+		 0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
 
+static bool kernel_blocked_keys_supported = false;
+
 static GList *adapter_list = NULL;
 static unsigned int adapter_remaining = 0;
 static bool powering_down = false;
@@ -124,6 +141,7 @@ struct link_key_info {
 	unsigned char key[16];
 	uint8_t type;
 	uint8_t pin_len;
+	bool is_blocked;
 };
 
 struct smp_ltk_info {
@@ -135,12 +153,14 @@ struct smp_ltk_info {
 	uint16_t ediv;
 	uint64_t rand;
 	uint8_t val[16];
+	bool is_blocked;
 };
 
 struct irk_info {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 	uint8_t val[16];
+	bool is_blocked;
 };
 
 struct conn_param {
@@ -3439,6 +3459,20 @@ static int str2buf(const char *str, uint8_t *buf, size_t blen)
 	return 0;
 }
 
+static bool is_blocked_key(uint8_t key_type, uint8_t *key_value)
+{
+	uint32_t i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(blocked_keys); ++i) {
+		if (key_type == blocked_keys[i].type &&
+				!memcmp(blocked_keys[i].val, key_value,
+						sizeof(blocked_keys[i].val)))
+			return true;
+	}
+
+	return false;
+}
+
 static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
 {
 	struct link_key_info *info = NULL;
@@ -3461,6 +3495,9 @@ static struct link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
 	info->pin_len = g_key_file_get_integer(key_file, "LinkKey", "PINLength",
 						NULL);
 
+	info->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LINKKEY,
+								info->key);
+
 failed:
 	g_free(str);
 
@@ -3534,6 +3571,9 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 	else
 		ltk->master = master;
 
+	ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
+								ltk->val);
+
 failed:
 	g_free(key);
 	g_free(rand);
@@ -3584,6 +3624,9 @@ static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
 	else
 		str2buf(&str[0], irk->val, sizeof(irk->val));
 
+	irk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LINKKEY,
+								irk->val);
+
 failed:
 	g_free(str);
 
@@ -4142,21 +4185,55 @@ static void load_devices(struct btd_adapter *adapter)
 		g_key_file_load_from_file(key_file, filename, 0, NULL);
 
 		key_info = get_key_info(key_file, entry->d_name);
-		if (key_info)
-			keys = g_slist_append(keys, key_info);
 
 		bdaddr_type = get_le_addr_type(key_file);
 
 		ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
-		if (ltk_info)
-			ltks = g_slist_append(ltks, ltk_info);
 
 		slave_ltk_info = get_slave_ltk_info(key_file, entry->d_name,
 								bdaddr_type);
+
+		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
+
+		// If any key for the device is blocked, we discard all.
+		if ((key_info && key_info->is_blocked) ||
+				(ltk_info && ltk_info->is_blocked) ||
+				(slave_ltk_info &&
+					slave_ltk_info->is_blocked) ||
+				(irk_info && irk_info->is_blocked)) {
+
+			if (key_info) {
+				g_free(key_info);
+				key_info = NULL;
+			}
+
+			if (ltk_info) {
+				g_free(ltk_info);
+				ltk_info = NULL;
+			}
+
+			if (slave_ltk_info) {
+				g_free(slave_ltk_info);
+				slave_ltk_info = NULL;
+			}
+
+			if (irk_info) {
+				g_free(irk_info);
+				irk_info = NULL;
+			}
+
+			goto free;
+		}
+
+		if (key_info)
+			keys = g_slist_append(keys, key_info);
+
+		if (ltk_info)
+			ltks = g_slist_append(ltks, ltk_info);
+
 		if (slave_ltk_info)
 			ltks = g_slist_append(ltks, slave_ltk_info);
 
-		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
 		if (irk_info)
 			irks = g_slist_append(irks, irk_info);
 
@@ -8568,6 +8645,42 @@ static bool set_static_addr(struct btd_adapter *adapter)
 	return false;
 }
 
+static void set_blocked_keys_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+				"Failed to set blocked keys: %s (0x%02x)",
+				mgmt_errstr(status), status);
+		return;
+	}
+
+	DBG("Successfully set blocked keys for index %u", adapter->dev_id);
+}
+
+static bool set_blocked_keys(struct btd_adapter *adapter)
+{
+	uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
+					sizeof(blocked_keys)] = { 0 };
+	struct mgmt_cp_set_blocked_keys *cp =
+				(struct mgmt_cp_set_blocked_keys *)buffer;
+	int i;
+
+	cp->key_count = ARRAY_SIZE(blocked_keys);
+	for (i = 0; i < cp->key_count; ++i) {
+		cp->keys[i].type = blocked_keys[i].type;
+		memcpy(cp->keys[i].val, blocked_keys[i].val,
+						sizeof(cp->keys[i].val));
+	}
+
+	return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, adapter->dev_id,
+						sizeof(buffer),	buffer,
+						set_blocked_keys_complete,
+						adapter, NULL);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8795,6 +8908,13 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_name(adapter, btd_adapter_get_name(adapter));
 
+	if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
+		btd_error(adapter->dev_id,
+				"Failed to set blocked keys for index %u",
+				adapter->dev_id);
+		goto failed;
+	}
+
 	if (main_opts.pairable &&
 			!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
@@ -8972,9 +9092,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 	for (i = 0; i < num_commands; i++) {
 		uint16_t op = get_le16(rp->opcodes + i);
 
-		if (op == MGMT_OP_ADD_DEVICE) {
+		switch (op) {
+		case MGMT_OP_ADD_DEVICE:
 			DBG("enabling kernel-side connection control");
 			kernel_conn_control = true;
+			break;
+		case MGMT_OP_SET_BLOCKED_KEYS:
+			DBG("kernel supports the set_blocked_keys op");
+			kernel_blocked_keys_supported = true;
+			break;
+		default:
+			break;
 		}
 	}
 }
-- 
2.24.1.735.g03f4e72817-goog

