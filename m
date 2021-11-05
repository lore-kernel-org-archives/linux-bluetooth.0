Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F05C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7533561159
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhKEVPa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKEVPa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B7C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:12:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r28so9365938pga.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Pfv/cnvgiSwS5FWpcgo7yOZIZbZrRdEtNYrReT3xGBE=;
        b=U0VyrMsct2BAGkJrMN1AfXtLaqH1CSpbUiJAOwe29F8CLLNMrgjLeUn7qGXtAfXgt1
         zZVjnoYe5tjnQ/nFpbMJAct3J5FXe/w7VWidQriHwuhivLmtrHybfALRf+1ydL3JU+eE
         OTQQKLy4iJ8dtIshseuCBguYDRLV4FgbP/TyKjtRh/SDtDOQLriabNextpM1ty02t2LF
         WlZGGW77887rTBZoEx5UgcHLVwk2b+4xOqBufePuhyxuahKy2lkau29qt0335hDya5lz
         O4lTniqbLcD8rtV0jNf2/1CboF+GXh4eN3rOHnM90lZNAfkvY4+H3VeCfzslaPzL7BZe
         CjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pfv/cnvgiSwS5FWpcgo7yOZIZbZrRdEtNYrReT3xGBE=;
        b=5w7AV+ky98rymQ81CqbtysbjdJD/eO2JtCu0b398kvTx2ISoEYqdey7TLht/YjRYtQ
         xnCy8ISjBSZVLxT8IkYTLTnFXFOUI8dksWzWVtUlbvoXM85K2Pby4CkHzS+ng7U92+7E
         wer6gXU/RN5WaHZ603wsCkIX7O58lwikUGFLPERtj3AYc/Cv5HNhaQjHDlSPQMpmZcd3
         ni5NNqDjh6Pkuu5dPTj1f5UFBV1U7q82le3cZC1SWX+oHkZznnA3LFrJz5E0UgaJTs+U
         nr2UJq0edSUyw4caOxNeFKGZOTEjcmvG0eJjnerCly2gJRaGghfcymGu8ukW/8yzuCcV
         YcJg==
X-Gm-Message-State: AOAM531HKXvBHmuc62h6ucWQsnydUcoIKWFpyDVe9Nm29WVQ1rjc6TXf
        giBW95t2U9hKlZI0hTov6i7bVIL/bbA=
X-Google-Smtp-Source: ABdhPJzElY3ga9UtBmQNpcRBeQWZvqNq+GuCDV24Vh+X/glvTjsyldahKmNJAinamd1UrU0OtksibQ==
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id j25-20020aa78019000000b0044dd7616f79mr62713052pfi.3.1636146769414;
        Fri, 05 Nov 2021 14:12:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id om8sm2250553pjb.12.2021.11.05.14.12.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:12:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] adapter: Set Device Privacy Mode
Date:   Fri,  5 Nov 2021 14:12:43 -0700
Message-Id: <20211105211245.424024-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting Device Privacy flag when enabled in
main.conf via Privacy = device,limited-device.
---
 lib/mgmt.h    |  3 +-
 src/adapter.c | 76 +++++++++++++++++++++++----------------------------
 src/adapter.h |  9 ++++--
 src/device.c  | 58 +++++++++++++++++++++++++++++----------
 src/device.h  |  1 -
 5 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0d1678f01..400167e9b 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -665,7 +665,8 @@ struct mgmt_rp_get_device_flags {
 	uint32_t current_flags;
 } __packed;
 
-#define DEVICE_FLAG_REMOTE_WAKEUP	(1 << 0)
+#define DEVICE_FLAG_REMOTE_WAKEUP	BIT(0)
+#define DEVICE_FLAG_DEVICE_PRIVACY	BIT(1)
 
 #define MGMT_OP_SET_DEVICE_FLAGS	0x0050
 #define MGMT_SET_DEVICE_FLAGS_SIZE	11
diff --git a/src/adapter.c b/src/adapter.c
index 508917e58..309956bbb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5308,6 +5308,23 @@ void adapter_accept_list_remove(struct btd_adapter *adapter,
 				remove_accept_list_complete, adapter, NULL);
 }
 
+static void set_device_privacy_complete(uint8_t status, uint16_t length,
+					 const void *param, void *user_data)
+{
+	const struct mgmt_rp_set_device_flags *rp = param;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Set device flags return status: %s",
+					mgmt_errstr(status));
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small Set Device Flags complete event: %d", length);
+		return;
+	}
+}
+
 static void add_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -5342,6 +5359,18 @@ static void add_device_complete(uint8_t status, uint16_t length,
 	}
 
 	DBG("%s (%u) added to kernel connect list", addr, rp->addr.type);
+
+	if (btd_opts.device_privacy) {
+		uint32_t flags = btd_device_get_current_flags(dev);
+
+		/* Set Device Privacy Mode has not set the flag yet. */
+		if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
+			adapter_set_device_flags(adapter, dev, flags |
+						DEVICE_FLAG_DEVICE_PRIVACY,
+						set_device_privacy_complete,
+						NULL);
+		}
+	}
 }
 
 void adapter_auto_connect_add(struct btd_adapter *adapter,
@@ -5383,42 +5412,9 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 	adapter->connect_list = g_slist_append(adapter->connect_list, device);
 }
 
-static void set_device_wakeable_complete(uint8_t status, uint16_t length,
-					 const void *param, void *user_data)
-{
-	const struct mgmt_rp_set_device_flags *rp = param;
-	struct btd_adapter *adapter = user_data;
-	struct btd_device *dev;
-	char addr[18];
-
-	if (status != MGMT_STATUS_SUCCESS) {
-		btd_error(adapter->dev_id, "Set device flags return status: %s",
-			  mgmt_errstr(status));
-		return;
-	}
-
-	if (length < sizeof(*rp)) {
-		btd_error(adapter->dev_id,
-			  "Too small Set Device Flags complete event: %d",
-			  length);
-		return;
-	}
-
-	ba2str(&rp->addr.bdaddr, addr);
-
-	dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr, rp->addr.type);
-	if (!dev) {
-		btd_error(adapter->dev_id,
-			  "Set Device Flags complete for unknown device %s",
-			  addr);
-		return;
-	}
-
-	device_set_wake_allowed_complete(dev);
-}
-
-void adapter_set_device_wakeable(struct btd_adapter *adapter,
-				 struct btd_device *device, bool wakeable)
+void adapter_set_device_flags(struct btd_adapter *adapter,
+				struct btd_device *device, uint32_t flags,
+				mgmt_request_func_t func, void *user_data)
 {
 	struct mgmt_cp_set_device_flags cp;
 	const bdaddr_t *bdaddr;
@@ -5433,14 +5429,10 @@ void adapter_set_device_wakeable(struct btd_adapter *adapter,
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
 	cp.addr.type = bdaddr_type;
-	cp.current_flags = btd_device_get_current_flags(device);
-	if (wakeable)
-		cp.current_flags |= DEVICE_FLAG_REMOTE_WAKEUP;
-	else
-		cp.current_flags &= ~DEVICE_FLAG_REMOTE_WAKEUP;
+	cp.current_flags = cpu_to_le32(flags);
 
 	mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_FLAGS, adapter->dev_id,
-		  sizeof(cp), &cp, set_device_wakeable_complete, adapter, NULL);
+		  sizeof(cp), &cp, func, user_data, NULL);
 }
 
 static void device_flags_changed_callback(uint16_t index, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index db3c17f23..d191daf5d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -219,8 +219,13 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
 					struct btd_device *device);
 void adapter_connect_list_remove(struct btd_adapter *adapter,
 						struct btd_device *device);
-void adapter_set_device_wakeable(struct btd_adapter *adapter,
-				 struct btd_device *dev, bool wakeable);
+typedef void (*adapter_set_device_flags_func_t)(uint8_t status, uint16_t length,
+						const void *param,
+						void *user_data);
+void adapter_set_device_flags(struct btd_adapter *adapter,
+				struct btd_device *device, uint32_t flags,
+				adapter_set_device_flags_func_t func,
+				void *user_data);
 void adapter_auto_connect_add(struct btd_adapter *adapter,
 					struct btd_device *device);
 void adapter_auto_connect_remove(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 1b4dae685..6b398bd39 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1403,9 +1403,45 @@ void device_set_wake_override(struct btd_device *device, bool wake_override)
 	}
 }
 
+static void device_set_wake_allowed_complete(struct btd_device *device)
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
+static void set_wake_allowed_complete(uint8_t status, uint16_t length,
+					 const void *param, void *user_data)
+{
+	const struct mgmt_rp_set_device_flags *rp = param;
+	struct btd_device *dev = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Set device flags return status: %s",
+					mgmt_errstr(status));
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small Set Device Flags complete event: %d", length);
+		return;
+	}
+
+	device_set_wake_allowed_complete(dev);
+}
+
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 			     GDBusPendingPropertySet id)
 {
+	uint32_t flags;
+
 	/* Pending and current value are the same unless there is a change in
 	 * progress. Only update wake allowed if pending value doesn't match the
 	 * new value.
@@ -1415,25 +1451,17 @@ void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 
 	device->wake_id = id;
 	device->pending_wake_allowed = wake_allowed;
-	adapter_set_device_wakeable(device_get_adapter(device), device,
-				    wake_allowed);
-}
 
-void device_set_wake_allowed_complete(struct btd_device *device)
-{
-	if (device->wake_id != -1U) {
-		g_dbus_pending_property_success(device->wake_id);
-		device->wake_id = -1U;
-	}
-
-	device->wake_allowed = device->pending_wake_allowed;
-	g_dbus_emit_property_changed(dbus_conn, device->path,
-					DEVICE_INTERFACE, "WakeAllowed");
+	flags = device->current_flags;
+	if (wake_allowed)
+		flags |= DEVICE_FLAG_REMOTE_WAKEUP;
+	else
+		flags &= ~DEVICE_FLAG_REMOTE_WAKEUP;
 
-	store_device_info(device);
+	adapter_set_device_flags(device->adapter, device, flags,
+					set_wake_allowed_complete, device);
 }
 
-
 static gboolean
 dev_property_get_wake_allowed(const GDBusPropertyTable *property,
 			     DBusMessageIter *iter, void *data)
diff --git a/src/device.h b/src/device.h
index 5f615cb4b..b37a0a3d2 100644
--- a/src/device.h
+++ b/src/device.h
@@ -132,7 +132,6 @@ void device_set_wake_support(struct btd_device *device, bool wake_support);
 void device_set_wake_override(struct btd_device *device, bool wake_override);
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 			     guint32 id);
-void device_set_wake_allowed_complete(struct btd_device *device);
 void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
-- 
2.31.1

