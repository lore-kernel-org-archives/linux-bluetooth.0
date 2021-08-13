Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3826CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D5610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbhHMMXF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbhHMMXF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9AC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b4-20020a252e440000b0290593da85d104so9056655ybn.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pi+ZSjtNMZx2ERhij8HxpqYVAfENVOs+spuBD3BOrEc=;
        b=aoLozi/qX+lESDWLuudcqZc3VDOBIlc9FvF98TbhBqeWeghYG56dwrw6Pm3dSEMgkK
         ZhqRgBSYB+uUf8wJXK8ece69vahEJlBP1V/ipO/L5ZY5VsqUCtPi7POP/Tw4394sIlSY
         8az0QKJzDEKLoRi/Gh9KLwDqx2SGfej+mxiIMtr1GOWbh2thgYcy0Lgah33Vp1eM8wdS
         EgcT0Qsskx7SHwpPAha2BApMRruqq4Gn+g+Kcy8+unj0NxmWnY9iH/TTXFLBIB/GZw5q
         19pMlas9Fg34aUqqbFnV6lUmAjwk8OavYLW1XgXKbmSnSm7Egvn0sNwUK7xoVzJCAxNR
         9R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pi+ZSjtNMZx2ERhij8HxpqYVAfENVOs+spuBD3BOrEc=;
        b=TRpv6mSxruhOQqQ+XVmq4sjkDNMaERHn6M4uyzZN54hrp5IosGrRe8Uu4OUcG+FFRU
         uTwpGUtwtWqrnIE5zU+DUGycGfquS3Z5fGQ20i0WxGKXrXSq505DsIe0HQd9kH6VmBfH
         aqMM7/Zu/THDx/G4M28xKP5JFVjZ16+xmeXey80IBbekQt4tw6h2AXXb/ujNXanKte7i
         SPxlbawOxQkFXjvFF8g6wTzZycBYS1L+bKeCgRZqNS/diuqCFA1wBc4gvtxDI53GYe8E
         i6xg1IqrlS0A41amlnbtTGbU0DvJ7UpPlMkyncvAEECqI0CVVhNYRlP4+fMI48Y3Cdmr
         Dx7g==
X-Gm-Message-State: AOAM530LQZWkxOOQ/7awDYshQ6KTMMwFHl0ZtIYAfaZgXbL0JVW6nMcO
        L7xeFvxN8xi9kiBqNDno7VjvneReySR+kVb+7nnKeGVtpi+MrUNaNHyU+6uS6/TWL/xzFX7lYT2
        kZaYaE0WHMH8gHcND6HP8E3mQpj99XJsAqbqOKYYspXOSoP5eOzeLEBI93wXYKzAxuDRMKXPljY
        nU
X-Google-Smtp-Source: ABdhPJz03WBay7uQ4VyAoUSmkwN3mfDfwBnGRB9Om2CQUV2m3B9wijvp85jl5vnc1LmRzuKRFkGULDBCaPII
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:7497:: with SMTP id
 p145mr2670018ybc.338.1628857358037; Fri, 13 Aug 2021 05:22:38 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:35 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.50.I390a2e541f55decd24fbf5c87e2b6c92522518a0@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 50/62] adapter: Inclusive language for central and peripheral
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
Also use "primary" to refer the global mgmt struct.
---

 src/adapter.c | 93 ++++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a71ebd15c3..60712f01a0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -112,7 +112,7 @@ static bool powering_down = false;
 
 static GSList *adapters = NULL;
 
-static struct mgmt *mgmt_master = NULL;
+static struct mgmt *mgmt_primary = NULL;
 
 static uint8_t mgmt_version = 0;
 static uint8_t mgmt_revision = 0;
@@ -134,7 +134,7 @@ struct smp_ltk_info {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 	uint8_t authenticated;
-	bool master;
+	bool central;
 	uint8_t enc_size;
 	uint16_t ediv;
 	uint64_t rand;
@@ -3595,7 +3595,7 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 {
 	struct smp_ltk_info *ltk = NULL;
 	GError *gerr = NULL;
-	bool master;
+	bool central;
 	char *key;
 	char *rand = NULL;
 
@@ -3609,8 +3609,8 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 
 	ltk = g_new0(struct smp_ltk_info, 1);
 
-	/* Default to assuming a master key */
-	ltk->master = true;
+	/* Default to assuming a central key */
+	ltk->central = true;
 
 	str2ba(peer, &ltk->bdaddr);
 	ltk->bdaddr_type = peer_type;
@@ -3651,11 +3651,11 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
 									NULL);
 	ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
 
-	master = g_key_file_get_boolean(key_file, group, "Master", &gerr);
+	central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
 	if (gerr)
 		g_error_free(gerr);
 	else
-		ltk->master = master;
+		ltk->central = central;
 
 	ltk->is_blocked = is_blocked_key(HCI_BLOCKED_KEY_TYPE_LTK,
 								ltk->val);
@@ -3675,7 +3675,7 @@ static struct smp_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 	return get_ltk(key_file, peer, bdaddr_type, "LongTermKey");
 }
 
-static struct smp_ltk_info *get_slave_ltk_info(GKeyFile *key_file,
+static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
 							const char *peer,
 							uint8_t bdaddr_type)
 {
@@ -3685,7 +3685,7 @@ static struct smp_ltk_info *get_slave_ltk_info(GKeyFile *key_file,
 
 	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
 	if (ltk)
-		ltk->master = false;
+		ltk->central = false;
 
 	return ltk;
 }
@@ -4028,7 +4028,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		key->rand = cpu_to_le64(info->rand);
 		key->ediv = cpu_to_le16(info->ediv);
 		key->type = info->authenticated;
-		key->central = info->master;
+		key->central = info->central;
 		key->enc_size = info->enc_size;
 	}
 
@@ -4487,7 +4487,7 @@ static void load_devices(struct btd_adapter *adapter)
 		GKeyFile *key_file;
 		struct link_key_info *key_info;
 		struct smp_ltk_info *ltk_info;
-		struct smp_ltk_info *slave_ltk_info;
+		struct smp_ltk_info *peripheral_ltk_info;
 		GSList *list;
 		struct irk_info *irk_info;
 		struct conn_param *param;
@@ -4512,16 +4512,16 @@ static void load_devices(struct btd_adapter *adapter)
 
 		ltk_info = get_ltk_info(key_file, entry->d_name, bdaddr_type);
 
-		slave_ltk_info = get_slave_ltk_info(key_file, entry->d_name,
-								bdaddr_type);
+		peripheral_ltk_info = get_peripheral_ltk_info(key_file,
+						entry->d_name, bdaddr_type);
 
 		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
 
 		// If any key for the device is blocked, we discard all.
 		if ((key_info && key_info->is_blocked) ||
 				(ltk_info && ltk_info->is_blocked) ||
-				(slave_ltk_info &&
-					slave_ltk_info->is_blocked) ||
+				(peripheral_ltk_info &&
+					peripheral_ltk_info->is_blocked) ||
 				(irk_info && irk_info->is_blocked)) {
 
 			if (key_info) {
@@ -4534,9 +4534,9 @@ static void load_devices(struct btd_adapter *adapter)
 				ltk_info = NULL;
 			}
 
-			if (slave_ltk_info) {
-				g_free(slave_ltk_info);
-				slave_ltk_info = NULL;
+			if (peripheral_ltk_info) {
+				g_free(peripheral_ltk_info);
+				peripheral_ltk_info = NULL;
 			}
 
 			if (irk_info) {
@@ -4553,8 +4553,8 @@ static void load_devices(struct btd_adapter *adapter)
 		if (ltk_info)
 			ltks = g_slist_append(ltks, ltk_info);
 
-		if (slave_ltk_info)
-			ltks = g_slist_append(ltks, slave_ltk_info);
+		if (peripheral_ltk_info)
+			ltks = g_slist_append(ltks, peripheral_ltk_info);
 
 		if (irk_info)
 			irks = g_slist_append(irks, irk_info);
@@ -4588,16 +4588,16 @@ device_exist:
 			device_set_bonded(device, BDADDR_BREDR);
 		}
 
-		if (ltk_info || slave_ltk_info) {
+		if (ltk_info || peripheral_ltk_info) {
 			device_set_paired(device, bdaddr_type);
 			device_set_bonded(device, bdaddr_type);
 
 			if (ltk_info)
 				device_set_ltk_enc_size(device,
 							ltk_info->enc_size);
-			else if (slave_ltk_info)
+			else if (peripheral_ltk_info)
 				device_set_ltk_enc_size(device,
-						slave_ltk_info->enc_size);
+						peripheral_ltk_info->enc_size);
 		}
 
 free:
@@ -5596,7 +5596,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 {
 	char *auth_str, *rand_str, *str;
 	int i, ret;
-	unsigned char auth, master, enc_size;
+	unsigned char auth, central, enc_size;
 	unsigned short ediv;
 
 	auth_str = strchr(value, ' ');
@@ -5613,7 +5613,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 		rand_str++;
 	}
 
-	ret = sscanf(auth_str, " %hhd %hhd %hhd %hd", &auth, &master,
+	ret = sscanf(auth_str, " %hhd %hhd %hhd %hd", &auth, &central,
 							&enc_size, &ediv);
 	if (ret < 4)
 		return;
@@ -5623,7 +5623,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 	g_free(str);
 
 	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
-	g_key_file_set_integer(key_file, "LongTermKey", "Master", master);
+	g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
 	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
 	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
 
@@ -6312,7 +6312,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 		return NULL;
 
 	adapter->dev_id = index;
-	adapter->mgmt = mgmt_ref(mgmt_master);
+	adapter->mgmt = mgmt_ref(mgmt_primary);
 	adapter->pincode_requested = false;
 
 	/*
@@ -8043,11 +8043,11 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 
 static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 				uint8_t bdaddr_type, const unsigned char *key,
-				uint8_t master, uint8_t authenticated,
+				uint8_t central, uint8_t authenticated,
 				uint8_t enc_size, uint16_t ediv,
 				uint64_t rand)
 {
-	const char *group = master ? "LongTermKey" : "SlaveLongTermKey";
+	const char *group = central ? "LongTermKey" : "SlaveLongTermKey";
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
@@ -8056,8 +8056,8 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char *str;
 	int i;
 
-	if (master != 0x00 && master != 0x01) {
-		error("Unsupported LTK type %u", master);
+	if (central != 0x00 && central != 0x01) {
+		error("Unsupported LTK type %u", central);
 		return;
 	}
 
@@ -9220,7 +9220,8 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 						sizeof(cp->keys[i].val));
 	}
 
-	return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, adapter->dev_id,
+	return mgmt_send(mgmt_primary, MGMT_OP_SET_BLOCKED_KEYS,
+						adapter->dev_id,
 						sizeof(buffer),	buffer,
 						set_blocked_keys_complete,
 						adapter, NULL);
@@ -9698,7 +9699,7 @@ static void reset_adv_monitors(uint16_t index)
 
 	/* Handle 0 indicates to remove all */
 	cp.monitor_handle = 0;
-	if (mgmt_send(mgmt_master, MGMT_OP_REMOVE_ADV_MONITOR, index,
+	if (mgmt_send(mgmt_primary, MGMT_OP_REMOVE_ADV_MONITOR, index,
 			sizeof(cp), &cp, reset_adv_monitors_complete, NULL,
 			NULL) > 0) {
 		return;
@@ -9748,7 +9749,7 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 
 	DBG("sending read info command for index %u", index);
 
-	if (mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
+	if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, index, 0, NULL,
 					read_info_complete, adapter, NULL) > 0)
 		return;
 
@@ -9932,18 +9933,18 @@ static void read_version_complete(uint8_t status, uint16_t length,
 	 * It is irrelevant if this command succeeds or fails. In case of
 	 * failure safe settings are assumed.
 	 */
-	mgmt_send(mgmt_master, MGMT_OP_READ_COMMANDS,
+	mgmt_send(mgmt_primary, MGMT_OP_READ_COMMANDS,
 				MGMT_INDEX_NONE, 0, NULL,
 				read_commands_complete, NULL, NULL);
 
-	mgmt_register(mgmt_master, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+	mgmt_register(mgmt_primary, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
 						index_added, NULL, NULL);
-	mgmt_register(mgmt_master, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+	mgmt_register(mgmt_primary, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
 						index_removed, NULL, NULL);
 
 	DBG("sending read index list command");
 
-	if (mgmt_send(mgmt_master, MGMT_OP_READ_INDEX_LIST,
+	if (mgmt_send(mgmt_primary, MGMT_OP_READ_INDEX_LIST,
 				MGMT_INDEX_NONE, 0, NULL,
 				read_index_list_complete, NULL, NULL) > 0)
 		return;
@@ -9962,18 +9963,18 @@ int adapter_init(void)
 {
 	dbus_conn = btd_get_dbus_connection();
 
-	mgmt_master = mgmt_new_default();
-	if (!mgmt_master) {
+	mgmt_primary = mgmt_new_default();
+	if (!mgmt_primary) {
 		error("Failed to access management interface");
 		return -EIO;
 	}
 
 	if (getenv("MGMT_DEBUG"))
-		mgmt_set_debug(mgmt_master, mgmt_debug, "mgmt: ", NULL);
+		mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
 
 	DBG("sending read version command");
 
-	if (mgmt_send(mgmt_master, MGMT_OP_READ_VERSION,
+	if (mgmt_send(mgmt_primary, MGMT_OP_READ_VERSION,
 				MGMT_INDEX_NONE, 0, NULL,
 				read_version_complete, NULL, NULL) > 0)
 		return 0;
@@ -10002,7 +10003,7 @@ void adapter_cleanup(void)
 	 * This is just an extra precaution to be safe, and in
 	 * reality should not make a difference.
 	 */
-	mgmt_unregister_index(mgmt_master, MGMT_INDEX_NONE);
+	mgmt_unregister_index(mgmt_primary, MGMT_INDEX_NONE);
 
 	/*
 	 * In case there is another reference active, cancel
@@ -10012,10 +10013,10 @@ void adapter_cleanup(void)
 	 * that potentially then could leak memory or access
 	 * an invalid structure.
 	 */
-	mgmt_cancel_index(mgmt_master, MGMT_INDEX_NONE);
+	mgmt_cancel_index(mgmt_primary, MGMT_INDEX_NONE);
 
-	mgmt_unref(mgmt_master);
-	mgmt_master = NULL;
+	mgmt_unref(mgmt_primary);
+	mgmt_primary = NULL;
 
 	dbus_conn = NULL;
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

