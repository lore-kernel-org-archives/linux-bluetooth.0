Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFAC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59F52075D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/KC/3P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGMUPF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMUPF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 16:15:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E23C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 13:15:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so5996026plm.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrBgPrgTeBiJc90yEeremeQlH6Tb4/9Y0eWkSBJnlyc=;
        b=W/KC/3P+fyNwficSIm+l9Hmg8NVivaEb7530aUaJRrF8v0fvEMPNKHiWbAGoa6KHMv
         Yy3VZbnx0qMhKRaco32m/D78T2/lNs9fqEeLqHa87JFIJqRHP/pRIr2Hvsx6bAcykWYN
         3w7pCjEJSCvkV2P1vU3UiyX5MGKC+dfNFQVvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrBgPrgTeBiJc90yEeremeQlH6Tb4/9Y0eWkSBJnlyc=;
        b=PGyMOYsHPphvPIvXC21Ca6MKpXUqDcvghSyzy9QxHml0+TTBjItxPd90ajRG1HMnJl
         +/UlodLvArM//zOsJWe1+efUdsIjfNOt5jbFzMmxtS2HmAGCIlnnanF0NIGhVq6mhmHI
         Iyi+A+15R5aNVVPV2z0vMSRg4RSZq1WoN4ozdUDlR+pS+NIDrnm6LS/a3OUWlWPrsRmB
         FYBrun9D8OTFK7JlKMSTVZ1yesYqas8ImnaiB2x1FDWzFMFj2PoRoRRkdrCsGSyi7XYU
         No0f9JTinEsVArtyPmnNoJwNY6lyanlEDFnYvlBV6g++CAQRwYrhY2rPMqWuJTNNJUYb
         AU/Q==
X-Gm-Message-State: AOAM5317Rw0MVodZsax2ERkUs+F/s9iw1cx06QU7vQcKFYcXOqoGxQcB
        pgoJHeRHLsxZSXMXDZcL0XlRjiAJfEI=
X-Google-Smtp-Source: ABdhPJyqtBpD62gnyd+/pHFGD0fZhhtKH2c4YaEVXRMjvzu5/fjGcdn+So9cmZgkufLOC/cFBnF4Iw==
X-Received: by 2002:a17:90a:bc98:: with SMTP id x24mr966653pjr.63.1594671304665;
        Mon, 13 Jul 2020 13:15:04 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id h18sm7866135pfr.186.2020.07.13.13.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 13:15:04 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth-@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ 2/3] device: Add "AllowInternalProfiles" property to org.bluez.Device1
Date:   Mon, 13 Jul 2020 13:14:40 -0700
Message-Id: <20200713201441.235959-3-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713201441.235959-1-sonnysasaka@chromium.org>
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some clients want to have full control over all profiles for specific
peer devices, for example to handle the GATT Battery profile. This patch
adds an option via a property in org.bluez.Device1 interface. Setting to
true will let BlueZ take control over internal profiles (such as A2DP,
HOG, Battery), and setting to false will prevent BlueZ from handling all
internal profiles, allowing the client to handle them.

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 src/device.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcid.h    |  2 ++
 src/main.c    | 10 ++++++
 src/main.conf |  4 +++
 4 files changed, 112 insertions(+)

diff --git a/src/device.c b/src/device.c
index 0deee2707..bd8c80032 100644
--- a/src/device.c
+++ b/src/device.c
@@ -275,6 +275,7 @@ struct btd_device {
 	gboolean	auto_connect;
 	gboolean	disable_auto_connect;
 	gboolean	general_connect;
+	gboolean	allow_internal_profiles;
 
 	bool		legacy;
 	int8_t		rssi;
@@ -294,6 +295,10 @@ static const uint16_t uuid_list[] = {
 static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
 
+static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data);
+static void gatt_service_removed(struct gatt_db_attribute *attr,
+					void *user_data);
+
 static struct bearer_state *get_state(struct btd_device *dev,
 							uint8_t bdaddr_type)
 {
@@ -436,6 +441,9 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	g_key_file_set_boolean(key_file, "General", "AllowInternalProfiles",
+				device->allow_internal_profiles);
+
 	if (device->wake_override != WAKE_FLAG_DEFAULT) {
 		g_key_file_set_boolean(key_file, "General", "WakeAllowed",
 				       device->wake_override ==
@@ -1468,6 +1476,71 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
+static gboolean
+dev_property_get_allow_internal_profiles(const GDBusPropertyTable *property,
+						DBusMessageIter *iter,
+						void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t allow_internal_profiles = device->allow_internal_profiles;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+					&allow_internal_profiles);
+
+	return TRUE;
+}
+
+static void
+dev_property_set_allow_internal_profiles(const GDBusPropertyTable *property,
+						DBusMessageIter *value,
+						GDBusPendingPropertySet id,
+						void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t b;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(
+			id, ERROR_INTERFACE ".InvalidArguments",
+			"Invalid arguments in method call");
+		return;
+	}
+
+	if (device->le_state.connected || device->bredr_state.connected) {
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+					"Device is connected");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &b);
+
+	device->allow_internal_profiles = b;
+
+	/* Remove GATT client cache */
+	gatt_db_unregister(device->db, device->db_id);
+	btd_gatt_client_destroy(device->client_dbus);
+	gatt_db_unref(device->db);
+
+	device->db = gatt_db_new();
+	device->client_dbus = btd_gatt_client_new(device);
+	device->db_id = gatt_db_register(device->db, gatt_service_added,
+			gatt_service_removed, device, NULL);
+
+	/* Re-probe all profiles */
+	while (device->services != NULL) {
+		struct btd_service *service = device->services->data;
+
+		device->services = g_slist_remove(device->services, service);
+		service_remove(service);
+	}
+
+	device_probe_profiles(device, device->uuids);
+
+	/* Update D-Bus property and reply client */
+	g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
+						"AllowInternalProfiles");
+	g_dbus_pending_property_success(id);
+}
 
 static gboolean disconnect_all(gpointer user_data)
 {
@@ -2944,6 +3017,9 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
 				dev_property_set_wake_allowed,
 				dev_property_wake_allowed_exist },
+	{ "AllowInternalProfiles", "b",
+				dev_property_get_allow_internal_profiles,
+				dev_property_set_allow_internal_profiles },
 	{ }
 };
 
@@ -3196,6 +3272,7 @@ static void load_info(struct btd_device *device, const char *local,
 	char *str;
 	gboolean store_needed = FALSE;
 	gboolean blocked;
+	gboolean allow_internal_profiles;
 	gboolean wake_allowed;
 	char **uuids;
 	int source, vendor, product, version;
@@ -3283,6 +3360,20 @@ next:
 	if (blocked)
 		device_block(device, FALSE);
 
+	/* Load allow internal profiles */
+	allow_internal_profiles = g_key_file_get_boolean(
+		key_file, "General", "AllowInternalProfiles", &gerr);
+	if (!gerr) {
+		device->allow_internal_profiles = allow_internal_profiles;
+	} else {
+		/* Old config doesn't contain this item, so set it to true to
+		 * match the previous default behavior.
+		 */
+		device->allow_internal_profiles = true;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
+
 	/* Load device profile list */
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
 						NULL, NULL);
@@ -3782,6 +3873,9 @@ static bool device_match_profile(struct btd_device *device,
 							bt_uuid_strcmp) == NULL)
 		return false;
 
+	if (!device->allow_internal_profiles && !profile->external)
+		return false;
+
 	return true;
 }
 
@@ -4055,6 +4149,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
 	device->adapter = adapter;
 	device->temporary = true;
+	device->allow_internal_profiles =
+		main_opts.default_allow_internal_profiles;
 
 	device->db_id = gatt_db_register(device->db, gatt_service_added,
 					gatt_service_removed, device, NULL);
diff --git a/src/hcid.h b/src/hcid.h
index c21ac9980..82ea0cb14 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -114,6 +114,8 @@ struct main_opts {
 	uint8_t		key_size;
 
 	enum jw_repairing_t jw_repairing;
+
+	gboolean	default_allow_internal_profiles;
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index bacb44197..30218f8d0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -89,6 +89,7 @@ static const char *supported_options[] = {
 	"FastConnectable",
 	"Privacy",
 	"JustWorksRepairing",
+	"DefaultAllowInternalProfiles",
 	NULL
 };
 
@@ -615,6 +616,13 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.fast_conn = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+					"DefaultAllowInternalProfiles", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		main_opts.default_allow_internal_profiles = boolean;
+
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -691,6 +699,8 @@ static void init_defaults(void)
 	main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	main_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
 	main_opts.gatt_channels = 3;
+
+	main_opts.default_allow_internal_profiles = true;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 6a6f7d4b4..497394395 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -77,6 +77,10 @@
 # Defaults to "never"
 #JustWorksRepairing = never
 
+# The default value of "AllowInternalProfiles" property in org.bluez.Device1
+# interface. Defaults to 'true'.
+#DefaultAllowInternalProfiles = true
+
 [Controller]
 # The following values are used to load default adapter parameters.  BlueZ loads
 # the values into the kernel before the adapter is powered if the kernel
-- 
2.26.2

