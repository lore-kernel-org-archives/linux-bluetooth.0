Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B89C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3835620BED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qh9Xe9qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGFUZg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgGFUZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D97C061794
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:25:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so1612036pld.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SKTS/P3VVnxtXiKmmcc9yL2vznCzJDGVC6hgr5NWd8=;
        b=Qh9Xe9qSMSTqvB68j2i5QzuSgSb0C1QiQw3xUSEQJLK/0Js84pY95EBAEuvAruEcK9
         IIl6mtvQlPxqpyhkfWrnIpYq3cVA6hSDTD+0RfEVRL5nmBOe6fQZiLRNWuLXOtV3BpiW
         EhKy+nHYn76BC4b+lO/N5PTqDw0ljCRj6Ra5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SKTS/P3VVnxtXiKmmcc9yL2vznCzJDGVC6hgr5NWd8=;
        b=ccQFwn/Mm02kzztjsPym27Dpya7r95cKuv/9DFzA5562pM1favTs3BOj0tpiwdFaJn
         Hjjh5yWNctF0zl+YWcl2t0mUJvKqnYBWxQrRnaaN7639t6OmgpRTPptVqSsFE0G0oJt8
         AWiE42Gx3UuRITfGG6Wf4Qaq55hbJa7Zq7kegHnVs1LqnlPv2u7LNK3/rv8XL05gU9VW
         XcYbrSSBWnfNtf82gJFOSnBKqMQUkA2cbNHOHv78nJTWdUEWWpJta7f/cKRo2i6pcPlA
         we0pyxOjOf4e/0nwAxf0ItotqoypNdwT8AY24Uy58VHKU8NIxa/llu6gFShnbhATfQJp
         pB6g==
X-Gm-Message-State: AOAM533H6JBG2hqs/p8pB2qXlrdrCZeK0/am8Uyliyknv0rN1Kv/cgwF
        0KQ6TogCFwoNhObkxovFzhIGaQ==
X-Google-Smtp-Source: ABdhPJwf35MTPoQgz5QG1C8aP5J+BSvlAouurmNUsmq/Vt8qmhzp422dmgquBd+8im+0XFJhhc716g==
X-Received: by 2002:a17:902:d392:: with SMTP id e18mr30091623pld.139.1594067133799;
        Mon, 06 Jul 2020 13:25:33 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id n25sm3320226pff.51.2020.07.06.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:25:33 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 3/6] device: Support marking a device with wake allowed
Date:   Mon,  6 Jul 2020 13:25:15 -0700
Message-Id: <20200706132503.BlueZ.v7.3.I1b0ff04f458fdaec2a193d27c2b94ce8f2cc4138@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706202518.1153647-1-abhishekpandit@chromium.org>
References: <20200706202518.1153647-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a device is allowed to wake the host system from suspend, it should
be marked as wake allowed. We add support for a new property that is
sent to the kernel via set device flags mgmt op. We also add the dbus
endpoint to allow the wake allowed setting to be controlled.

In order for wake allowed to be set, the profile must also support wake.
This setting isn't exposed to the user but must be set by profiles that
intend to support wake from suspend.

If a device is connecting for the first time, it will be marked
WakeAllowed if the profile supports it. On subsequent reloads of bluez,
the stored setting "WakeAllowed" will be used to override any other
setting.

---

Changes in v7:
* Fix more build issues reported by bluez.test.bot

Changes in v6:
* Save pending property id and emit success only after set flags returns
* Ignore multiple calls to set_wake_allowed to the same value
* Emit property error busy if same value is already sent to mgmt
* Fix up build issues reported by bluez.test.bot

Changes in v5:
* Refactor to use set_wake_flags and respond to device flags changed
* Add wake_override so we can keep track of user/profile configuration
  vs what is currently active

Changes in v4:
* Renamed wake_capable to wake_allowed
* Removed set_wake_capable mgmt op and updated add_device to accept
  flags to set whether a device is wakeable
* Refactored adapter_whitelist_add and adapter_auto_connect_add to call
  adapter_add_device

Changes in v3:
* Added profile_wake_support and made wake_capable dependent on it

Changes in v2:
* Added dbus api "WakeCapable" to set value
* Update device_set_wake_capable to be called by
  adapter_set_wake_capable_complete so we can emit property changed

 lib/mgmt.h    |   2 +
 src/adapter.c |  93 ++++++++++++++++++++++
 src/adapter.h |   3 +-
 src/device.c  | 210 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  10 +++
 5 files changed, 317 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 525c4dd62..a800bcab4 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -665,6 +665,8 @@ struct mgmt_rp_get_device_flags {
 	uint32_t current_flags;
 } __packed;
 
+#define DEVICE_FLAG_REMOTE_WAKEUP	(1 << 0)
+
 #define MGMT_OP_SET_DEVICE_FLAGS	0x0050
 #define MGMT_SET_DEVICE_FLAGS_SIZE	11
 struct mgmt_cp_set_device_flags {
diff --git a/src/adapter.c b/src/adapter.c
index 9ce351893..bccdbe8bf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5102,6 +5102,94 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 	adapter->connect_list = g_slist_append(adapter->connect_list, device);
 }
 
+static void set_device_wakeable_complete(uint8_t status, uint16_t length,
+					 const void *param, void *user_data)
+{
+	const struct mgmt_rp_set_device_flags *rp = param;
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *dev;
+	char addr[18];
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id, "Set device flags return status: %s",
+			  mgmt_errstr(status));
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter->dev_id,
+			  "Too small Set Device Flags complete event: %d",
+			  length);
+		return;
+	}
+
+	ba2str(&rp->addr.bdaddr, addr);
+
+	dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr, rp->addr.type);
+	if (!dev) {
+		btd_error(adapter->dev_id,
+			  "Set Device Flags complete for unknown device %s",
+			  addr);
+		return;
+	}
+
+	device_set_wake_allowed_complete(dev);
+}
+
+void adapter_set_device_wakeable(struct btd_adapter *adapter,
+				 struct btd_device *device, bool wakeable)
+{
+	struct mgmt_cp_set_device_flags cp;
+	const bdaddr_t *bdaddr;
+	uint8_t bdaddr_type;
+
+	if (!kernel_conn_control)
+		return;
+
+	bdaddr = device_get_address(device);
+	bdaddr_type = btd_device_get_bdaddr_type(device);
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, bdaddr);
+	cp.addr.type = bdaddr_type;
+	cp.current_flags = btd_device_get_current_flags(device);
+	if (wakeable)
+		cp.current_flags |= DEVICE_FLAG_REMOTE_WAKEUP;
+	else
+		cp.current_flags &= ~DEVICE_FLAG_REMOTE_WAKEUP;
+
+	mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_FLAGS, adapter->dev_id,
+		  sizeof(cp), &cp, set_device_wakeable_complete, adapter, NULL);
+}
+
+static void device_flags_changed_callback(uint16_t index, uint16_t length,
+					  const void *param, void *user_data)
+{
+	const struct mgmt_ev_device_flags_changed *ev = param;
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *dev;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id,
+			  "Too small Device Flags Changed event: %d",
+			  length);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	dev = btd_adapter_find_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	if (!dev) {
+		btd_error(adapter->dev_id,
+			"Device Flags Changed for unknown device %s", addr);
+		return;
+	}
+
+	btd_device_flags_changed(dev, ev->supported_flags, ev->current_flags);
+}
+
+
 static void remove_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8544,6 +8632,11 @@ static int adapter_register(struct btd_adapter *adapter)
 							adapter, NULL);
 
 load:
+	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_FLAGS_CHANGED,
+						adapter->dev_id,
+						device_flags_changed_callback,
+						adapter, NULL);
+
 	load_config(adapter);
 	fix_storage(adapter);
 	load_drivers(adapter);
diff --git a/src/adapter.h b/src/adapter.h
index d0a5253bd..f8ac20261 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -213,6 +213,8 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
 					struct btd_device *device);
 void adapter_connect_list_remove(struct btd_adapter *adapter,
 						struct btd_device *device);
+void adapter_set_device_wakeable(struct btd_adapter *adapter,
+				 struct btd_device *dev, bool wakeable);
 void adapter_auto_connect_add(struct btd_adapter *adapter,
 					struct btd_device *device);
 void adapter_auto_connect_remove(struct btd_adapter *adapter,
@@ -231,4 +233,3 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void *data);
 
 bool btd_le_connect_before_pairing(void);
-
diff --git a/src/device.c b/src/device.c
index 7b0eb256e..0deee2707 100644
--- a/src/device.c
+++ b/src/device.c
@@ -177,6 +177,12 @@ struct csrk_info {
 	uint32_t counter;
 };
 
+enum {
+	WAKE_FLAG_DEFAULT = 0,
+	WAKE_FLAG_ENABLED,
+	WAKE_FLAG_DISABLED,
+};
+
 struct btd_device {
 	int ref_count;
 
@@ -189,6 +195,21 @@ struct btd_device {
 	bool		le;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
+
+	/* Manage whether this device can wake the system from suspend.
+	 * - wake_support: Requires a profile that supports wake (i.e. HID)
+	 * - wake_allowed: Is wake currently allowed?
+	 * - pending_wake_allowed - Wake flag sent via set_device_flags
+	 * - wake_override - User configured wake setting
+	 */
+	bool		wake_support;
+	bool		wake_allowed;
+	bool		pending_wake_allowed;
+	uint8_t		wake_override;
+	GDBusPendingPropertySet wake_id;
+
+	uint32_t	supported_flags;
+	uint32_t	current_flags;
 	GSList		*svc_callbacks;
 	GSList		*eir_uuids;
 	struct bt_ad	*ad;
@@ -415,6 +436,12 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	if (device->wake_override != WAKE_FLAG_DEFAULT) {
+		g_key_file_set_boolean(key_file, "General", "WakeAllowed",
+				       device->wake_override ==
+					       WAKE_FLAG_ENABLED);
+	}
+
 	if (device->uuids) {
 		GSList *l;
 		int i;
@@ -1318,6 +1345,130 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
 	return bt_ad_has_data(device->ad, NULL);
 }
 
+static bool device_get_wake_support(struct btd_device *device)
+{
+	return device->wake_support;
+}
+
+void device_set_wake_support(struct btd_device *device, bool wake_support)
+{
+	device->wake_support = wake_support;
+
+	/* If wake configuration has not been made yet, set the initial
+	 * configuration.
+	 */
+	if (device->wake_override == WAKE_FLAG_DEFAULT) {
+		device_set_wake_override(device, wake_support);
+		device_set_wake_allowed(device, wake_support, -1U);
+	}
+}
+
+static bool device_get_wake_allowed(struct btd_device *device)
+{
+	return device->wake_allowed;
+}
+
+void device_set_wake_override(struct btd_device *device, bool wake_override)
+{
+	if (wake_override) {
+		device->wake_override = WAKE_FLAG_ENABLED;
+		device->current_flags |= DEVICE_FLAG_REMOTE_WAKEUP;
+	} else {
+		device->wake_override = WAKE_FLAG_DISABLED;
+		device->current_flags &= ~DEVICE_FLAG_REMOTE_WAKEUP;
+	}
+}
+
+void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
+			     GDBusPendingPropertySet id)
+{
+	/* Pending and current value are the same unless there is a change in
+	 * progress. Only update wake allowed if pending value doesn't match the
+	 * new value.
+	 */
+	if (wake_allowed == device->pending_wake_allowed)
+		return;
+
+	device->wake_id = id;
+	device->pending_wake_allowed = wake_allowed;
+	adapter_set_device_wakeable(device_get_adapter(device), device,
+				    wake_allowed);
+}
+
+void device_set_wake_allowed_complete(struct btd_device *device)
+{
+	if (device->wake_id != -1U) {
+		g_dbus_pending_property_success(device->wake_id);
+		device->wake_id = -1U;
+	}
+
+	device->wake_allowed = device->pending_wake_allowed;
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "WakeAllowed");
+
+	store_device_info(device);
+}
+
+
+static gboolean
+dev_property_get_wake_allowed(const GDBusPropertyTable *property,
+			     DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t wake_allowed = device_get_wake_allowed(device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &wake_allowed);
+
+	return TRUE;
+}
+
+static void dev_property_set_wake_allowed(const GDBusPropertyTable *property,
+					 DBusMessageIter *value,
+					 GDBusPendingPropertySet id, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t b;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	if (device->temporary) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".Unsupported",
+					"Cannot set property while temporary");
+		return;
+	}
+
+	/* Emit busy or success depending on current value. */
+	if (b == device->pending_wake_allowed) {
+		if (device->wake_allowed == device->pending_wake_allowed)
+			g_dbus_pending_property_success(id);
+		else
+			g_dbus_pending_property_error(
+				id, ERROR_INTERFACE ".Busy",
+				"Property change in progress");
+
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &b);
+	device_set_wake_override(device, b);
+	device_set_wake_allowed(device, b, id);
+}
+
+static gboolean dev_property_wake_allowed_exist(
+		const GDBusPropertyTable *property, void *data)
+{
+	struct btd_device *device = data;
+
+	return device_get_wake_support(device);
+}
+
+
 static gboolean disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -2790,6 +2941,9 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
 				NULL, dev_property_advertising_data_exist,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
+				dev_property_set_wake_allowed,
+				dev_property_wake_allowed_exist },
 	{ }
 };
 
@@ -3038,9 +3192,11 @@ static void convert_info(struct btd_device *device, GKeyFile *key_file)
 static void load_info(struct btd_device *device, const char *local,
 			const char *peer, GKeyFile *key_file)
 {
+	GError *gerr = NULL;
 	char *str;
 	gboolean store_needed = FALSE;
 	gboolean blocked;
+	gboolean wake_allowed;
 	char **uuids;
 	int source, vendor, product, version;
 	char **techno, **t;
@@ -3152,6 +3308,18 @@ next:
 		btd_device_set_pnpid(device, source, vendor, product, version);
 	}
 
+	/* Wake allowed is only configured and stored if user changed it.
+	 * Otherwise, we enable if profile supports it.
+	 */
+	wake_allowed = g_key_file_get_boolean(key_file, "General",
+					      "WakeAllowed", &gerr);
+	if (!gerr) {
+		device_set_wake_override(device, wake_allowed);
+	} else {
+		g_error_free(gerr);
+		gerr = NULL;
+	}
+
 	if (store_needed)
 		store_device_info(device);
 }
@@ -6558,6 +6726,48 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 	store_device_info(device);
 }
 
+uint32_t btd_device_get_current_flags(struct btd_device *dev)
+{
+	return dev->current_flags;
+}
+
+/* This event is sent immediately after add device on all mgmt sockets.
+ * Afterwards, it is only sent to mgmt sockets other than the one which called
+ * set_device_flags.
+ */
+void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
+			      uint32_t current_flags)
+{
+	const uint32_t changed_flags = dev->current_flags ^ current_flags;
+	bool flag_value;
+
+	dev->supported_flags = supported_flags;
+	dev->current_flags = current_flags;
+
+	if (!changed_flags)
+		return;
+
+	if (changed_flags & DEVICE_FLAG_REMOTE_WAKEUP) {
+		flag_value = !!(current_flags & DEVICE_FLAG_REMOTE_WAKEUP);
+		dev->pending_wake_allowed = flag_value;
+
+		/* If an override exists and doesn't match the current state,
+		 * apply it. This logic will run after Add Device only and will
+		 * enable wake for previously paired devices.
+		 */
+		if (dev->wake_override != WAKE_FLAG_DEFAULT) {
+			bool wake_allowed =
+				dev->wake_override == WAKE_FLAG_ENABLED;
+			if (flag_value != wake_allowed)
+				device_set_wake_allowed(dev, wake_allowed, -1U);
+			else
+				device_set_wake_allowed_complete(dev);
+		} else {
+			device_set_wake_allowed_complete(dev);
+		}
+	}
+}
+
 static void service_state_changed(struct btd_service *service,
 						btd_service_state_t old_state,
 						btd_service_state_t new_state,
diff --git a/src/device.h b/src/device.h
index 06b100499..cb8d884e8 100644
--- a/src/device.h
+++ b/src/device.h
@@ -33,6 +33,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 char *btd_device_get_storage_path(struct btd_device *device,
 				const char *filename);
 
+
 void btd_device_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
@@ -139,6 +140,11 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 								uint16_t value);
 void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 							uint16_t *ccc_bredr);
+void device_set_wake_support(struct btd_device *device, bool wake_support);
+void device_set_wake_override(struct btd_device *device, bool wake_override);
+void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
+			     guint32 id);
+void device_set_wake_allowed_complete(struct btd_device *device);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
@@ -176,5 +182,9 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
 int device_discover_services(struct btd_device *device);
 int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
+uint32_t btd_device_get_current_flags(struct btd_device *dev);
+void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
+			      uint32_t current_flags);
+
 void btd_device_init(void);
 void btd_device_cleanup(void);
-- 
2.27.0.212.ge8ba1cc988-goog

