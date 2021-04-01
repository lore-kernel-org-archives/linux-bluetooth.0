Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A4C4363E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D245C6112D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhDAK2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhDAK1w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA9BC0617A9
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x22so5296593ybi.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mBZDJ27quEoeuB7sdi/xI42HBNcqavoUI6lrFoCV90Q=;
        b=Xvok7x2NhSSQTfsM2UnSi/UjtUYW/0ij5xxEr4DFJBFuEcb6UU07K8dJaR36XMKq0O
         rBPirhib3kN9mhFlHTHF9lf7ydK+8fHXRNZO4ko5EjLfatSZwrqIkwRHKE3AV+84GdmJ
         M2W6rQ1GJwyIscic8J+K7EUgUEax+ORCIAD+hgzxsFv1FTx0wAce3K5RHl47P+UMQ0Oe
         O5dojP8GnvAJAPKyCLjeWWTSN98AbggaUuVNzupKTQJ/HthCNAq8KiaH+txYdt1ARBwo
         QiwyzYpgrj7j+Mq747QXG7t1XkNB1WL/kIMkwLDQRtfG7rfJTdVmj23/yUMEqyEoNPqB
         Lmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mBZDJ27quEoeuB7sdi/xI42HBNcqavoUI6lrFoCV90Q=;
        b=IQ/Zm7JWyYBL+bdHCdC3PbN7jIo01D5bgK3reXtqH2F+AIdz+Ji2rAjSe0I21XBfFW
         6uvOtdNlmkIdyvfQnoJXViXGeo28haKFS3Ytv4jzISYm9wHefHrZ4jGsl+LrvWOqkeFz
         hlScfDZmImXaFFH9KFe0TaxzoF10FfZrD2wZfk+NiMtOE8ycWsNZ95+FPfIgDKcFEKjh
         50mVEpj5Hf0Ams7BUyEO73SQ+jPiZYK1jsoqxh5xMHC8oZ5S5nyKECgsYO561vVBkTor
         3VMSNDdNmv/C6ZT605k1nF8db9ElK7VtpxRo9ePx5t923ZvV84WfbjypDI6ia1g2wWWR
         GFrg==
X-Gm-Message-State: AOAM533YW0NnmqA1W/GjbtuDNjsXyiy+h/DtLdxn4W3Tx3Wy0HLB/z88
        HaUD90xxuBQtTp25RGvIYBUZxBHaYjSRXb34s50Toonn45spFqtYHwW2zdKzq03aeAcxaYNM2Mn
        c3WFWfA5G+uoqEMWEfTA9z4vHf95TopEUi4vOfk/PoK1i5BfcdD1cwVe0ZGVUGEthb0mNNi88M0
        puAYBGmMTqbY4=
X-Google-Smtp-Source: ABdhPJxfROASGnlhutlwbs4+mjPH8PscHzx6A2UE4skzvq3vbLBsC4FKkvDH6hFfG6QHA+51p+tc/FC7glw4o4S7+g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a5b:448:: with SMTP id
 s8mr10084433ybp.363.1617272739152; Thu, 01 Apr 2021 03:25:39 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:45 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.6.I85fe2263b7747372e2c01bd8dc73271dd24ad6cf@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 6/8] core: add properties IsBlockedByPolicy and ServiceAllowList
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds IsBlockedByPolicy to indicate if the remote device is
currently blocked by policy.

ServiceAllowlist is also introduced to indicate the current service
allowlist.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/admin_policy.c | 57 +++++++++++++++++++++++++++++++++++++++++++---
 src/device.c       | 32 ++++++++++++++++++++++++--
 src/device.h       |  1 +
 3 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/src/admin_policy.c b/src/admin_policy.c
index eeae2722cc0a..6498dcf05319 100644
--- a/src/admin_policy.c
+++ b/src/admin_policy.c
@@ -118,8 +118,13 @@ void btd_admin_policy_allowlist_set(struct btd_admin_policy *admin_policy,
 	 */
 	btd_profile_policy_update(admin_policy->adapter);
 
-	/* Update auto-connect status to all devices */
+	/* Update auto-connect and IsBlockedByPolicy status to all devices */
 	btd_adapter_refresh_is_blocked_by_policy(admin_policy->adapter);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					adapter_get_path(admin_policy->adapter),
+					ADMIN_POLICY_INTERFACE,
+					"ServiceAllowList");
 }
 
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
@@ -201,6 +206,51 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 	return admin_policy;
 }
 
+static void append_uuid_set(gpointer key, gpointer value, gpointer user_data)
+{
+	const bt_uuid_t *uuid = key;
+	DBusMessageIter *entry = user_data;
+	char uuid_str[MAX_LEN_UUID_STR];
+	const char *uuid_str_ptr = uuid_str;
+
+	bt_uuid_to_string(uuid, uuid_str, MAX_LEN_UUID_STR);
+	dbus_message_iter_append_basic(entry, DBUS_TYPE_STRING, &uuid_str_ptr);
+}
+
+static gboolean
+property_get_service_allowlist(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	g_hash_table_foreach(admin_policy->allowed_uuid_set, append_uuid_set,
+									&entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static gboolean
+property_exists_service_allowlist(const GDBusPropertyTable *property,
+							void *user_data)
+{
+	struct btd_admin_policy *admin_policy = user_data;
+
+	return admin_policy->allowed_uuid_set != NULL ? TRUE : FALSE;
+}
+
+static const GDBusPropertyTable admin_policy_properties[] = {
+	{"ServiceAllowList", "as", property_get_service_allowlist, NULL,
+					property_exists_service_allowlist,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
+	{ }
+};
+
 struct btd_admin_policy *btd_admin_policy_create(struct btd_adapter *adapter)
 {
 	struct btd_admin_policy *admin_policy;
@@ -212,8 +262,9 @@ struct btd_admin_policy *btd_admin_policy_create(struct btd_adapter *adapter)
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(admin_policy->adapter),
 					ADMIN_POLICY_INTERFACE,
-					admin_policy_methods, NULL, NULL,
-					admin_policy, NULL)) {
+					admin_policy_methods, NULL,
+					admin_policy_properties, admin_policy,
+					NULL)) {
 		btd_error(admin_policy->adapter_id,
 				"Failed to register "
 				ADMIN_POLICY_INTERFACE);
diff --git a/src/device.c b/src/device.c
index 2192346d5f8d..aa54f00441c1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -265,6 +265,7 @@ struct btd_device {
 	gboolean	auto_connect;
 	gboolean	disable_auto_connect;
 	gboolean	general_connect;
+	gboolean	is_blocked_by_policy;
 
 	bool		legacy;
 	int8_t		rssi;
@@ -1470,6 +1471,18 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
+static gboolean
+dev_property_get_is_blocked_by_policy(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t is_blocked = device->is_blocked_by_policy;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &is_blocked);
+
+	return TRUE;
+}
+
 static bool disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1929,6 +1942,16 @@ static int service_prio_cmp(gconstpointer a, gconstpointer b)
 	return p2->priority - p1->priority;
 }
 
+static void refresh_is_blocked_by_policy(struct btd_device *dev, bool value)
+{
+	if (value == dev->is_blocked_by_policy)
+		return;
+
+	dev->is_blocked_by_policy = value;
+	g_dbus_emit_property_changed(dbus_conn, dev->path,
+					DEVICE_INTERFACE, "IsBlockedByPolicy");
+}
+
 void btd_device_update_is_blocked_by_policy(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
@@ -1936,6 +1959,7 @@ void btd_device_update_is_blocked_by_policy(struct btd_device *dev)
 	struct btd_profile *profile;
 	GSList *l;
 	bool auto_connect = false;
+	bool is_blocked = false;
 
 	/* If service discover is ongoing, let the service discover complete
 	 * callback call this function.
@@ -1950,13 +1974,16 @@ void btd_device_update_is_blocked_by_policy(struct btd_device *dev)
 		if (!profile->auto_connect)
 			continue;
 
-		if (profile->accept &&
-			!btd_service_is_blocked_by_policy(service))
+		if (btd_service_is_blocked_by_policy(service))
+			is_blocked = true;
+		else if (profile->accept)
 			auto_connect = true;
 	}
 
 	if (!dev->disable_auto_connect)
 		device_set_auto_connect(dev, auto_connect);
+
+	refresh_is_blocked_by_policy(dev, is_blocked);
 }
 
 static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
@@ -2994,6 +3021,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
 				dev_property_set_wake_allowed,
 				dev_property_wake_allowed_exist },
+	{ "IsBlockedByPolicy", "b", dev_property_get_is_blocked_by_policy},
 	{ }
 };
 
diff --git a/src/device.h b/src/device.h
index 3ca4f2c56566..a24ae088b68e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -74,6 +74,7 @@ void device_set_service_data(struct btd_device *dev, GSList *list,
 							bool duplicate);
 void device_set_data(struct btd_device *dev, GSList *list,
 							bool duplicate);
+void btd_device_update_is_blocked_by_policy(struct btd_device *dev);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-- 
2.31.0.291.g576ba9dcdaf-goog

