Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84C4189D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223165; cv=none; b=aAP3WM7qIvj5b5bUwLXNynDrssbbKiIJVNmdDKyIS3+pbo54Or7LDGKI7ICtd5JRu0UwxGEp8gQ6CB2WTV/jqGwDQXBEb1G52KseljNZUG+jXeu1Dcgf5vqD5aFirVL0Tbw0KgErPic8AnmZItNUZgg7YMbw78i25+STb5BPkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223165; c=relaxed/simple;
	bh=7jQHoixS2PxgKNA6FmPGB84xD9e+vMwJh03YMqYav10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxNnKHiM9TUEnObvb+M2zCWl3aucCSfvHHz78EisSfu1tffG+AETEwfFa9hXRrMoFeFeR+hG1rcIj9a15CIpWST/vW7LgKEHRm+ogdtFA/Q6QfPLyYXpjRsM99GJ1usBw6vPpugb1i2qWji0AIv+gpnSNbHB0emZ6wJlwHO5d4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NcMTMZWO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NcMTMZWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787223162;
	bh=7jQHoixS2PxgKNA6FmPGB84xD9e+vMwJh03YMqYav10=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NcMTMZWORgjtX3PnftdxHR/VZqtSnQhydoTtYxPQBXJBavb9lPeyXKXxDdanNj8Kv
	 vbdR9Gn2KuWz6hqGsKqD1nE2GC7ZSVcXyfv5HBh9k0Vs312q+XPAuf42CJujfuBu4e
	 QBoxBcMcz5VzT0pqOcl9tkIjOHL/cIrD7EtppmeOw9gZ7ptuEAAqSHXV9EDobQJHWh
	 fbFdvZjhA30raot7rOjvYt27evR/R8AJuVw31+/+/6HYQa/O/H2LrHRgCh9fJCdFsr
	 6BF6SB9r09FAgxICnJVA0Rw/lktU6WiVTznQhhHevPryjOLv6OARcrKzdgks6dKilX
	 dNxoGpwJgzNQQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DFB4A17E0FE2
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:52:41 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] device: Add SecurityLevel properties to org.bluez.Device1
Date: Thu, 20 Aug 2026 12:52:32 +0200
Message-ID: <20260820105235.1190318-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820105235.1190318-1-frederic.danis@collabora.com>
References: <20260820105235.1190318-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This uses the new MGMT_EV_SECURITY_LEVEL_CHANGED event.

It will be used by btpclient to reduce test time.
---
 src/adapter.c | 33 ++++++++++++++++++++
 src/device.c  | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |  3 ++
 3 files changed, 120 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c21b3e7fb..2fd5e005e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10036,6 +10036,34 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 	device_set_unpaired(device, ev->addr.type);
 }
 
+static void device_sec_level_callback(uint16_t index, uint16_t length,
+					  const void *param, void *user_data)
+{
+	const struct mgmt_ev_security_level_changed *ev = param;
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *dev;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id,
+			  "Too small Device Security Level Changed event: %d",
+			  length);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	dev = btd_adapter_find_device(adapter, &ev->addr.bdaddr, ev->addr.type);
+	if (!dev) {
+		btd_error(adapter->dev_id,
+			"Device Security Level Changed for unknown device %s",
+			addr);
+		return;
+	}
+
+	btd_device_sec_level_changed(dev, ev->tlv_data, length - 8);
+}
+
 static void clear_devices_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -10754,6 +10782,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						controller_resume_callback,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_SECURITY_LEVEL_CHANGED,
+						adapter->dev_id,
+						device_sec_level_callback,
+						adapter, NULL);
+
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
diff --git a/src/device.c b/src/device.c
index 65d84be56..c6cb0aecf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -306,6 +306,9 @@ struct btd_device {
 
 	uint32_t	auth_failures;
 	guint		auth_retry_id;
+
+	uint8_t		sec_level;
+	uint8_t		enc_type;
 };
 
 static const uint16_t uuid_list[] = {
@@ -3689,6 +3692,26 @@ dev_property_prefer_bearer_exists(const GDBusPropertyTable *property,
 	return device_prefer_bearer_str(device) != NULL;
 }
 
+static gboolean dev_get_security_level(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &dev->sec_level);
+
+	return TRUE;
+}
+
+static gboolean dev_get_encryption_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &dev->enc_type);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "AddressType", "s", property_get_address_type },
@@ -3732,6 +3755,10 @@ static const GDBusPropertyTable device_properties[] = {
 				dev_property_set_prefer_bearer,
 				dev_property_prefer_bearer_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SecurityLevel", "y", dev_get_security_level, NULL, NULL,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "EncryptionType", "y", dev_get_encryption_type, NULL, NULL,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -8341,3 +8368,60 @@ next:
 		l = next;
 	}
 }
+
+static void parse_sec_level_tlv(void *data, void *user_data)
+{
+	struct btd_device *dev = user_data;
+	const struct mgmt_tlv *entry = data;
+	uint16_t type = get_le16(&entry->type);
+	uint32_t value;
+
+	if (entry->length != 1 && entry->length != 2 && entry->length != 4) {
+		warn("Invalid length %u for security level TLV type %u",
+							entry->length, type);
+		return;
+	}
+
+	if (entry->length == 1)
+		value = get_u8(entry->value);
+	else if (entry->length == 2)
+		value = get_le16(entry->value);
+	else
+		value = get_le32(entry->value);
+
+	switch (type) {
+	case MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL:
+		if (dev->sec_level != value) {
+			dev->sec_level = value;
+			g_dbus_emit_property_changed(dbus_conn, dev->path,
+							DEVICE_INTERFACE,
+							"SecurityLevel");
+		}
+		break;
+	case MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE:
+		if (dev->enc_type != value) {
+			dev->enc_type = value;
+			g_dbus_emit_property_changed(dbus_conn, dev->path,
+							DEVICE_INTERFACE,
+							"EncryptionType");
+		}
+		break;
+	default:
+		DBG("Unknown security level TLV type %u", type);
+		break;
+	}
+}
+
+void btd_device_sec_level_changed(struct btd_device *dev, const uint8_t *data,
+					uint16_t size)
+{
+	struct mgmt_tlv_list *tlv_list;
+
+	tlv_list = mgmt_tlv_list_load_from_buf(data, size);
+	if (!tlv_list) {
+		error("Failed to parse security level TLV list");
+		return;
+	}
+	mgmt_tlv_list_foreach(tlv_list, parse_sec_level_tlv, dev);
+	mgmt_tlv_list_free(tlv_list);
+}
diff --git a/src/device.h b/src/device.h
index b890f23d4..3dff67eb0 100644
--- a/src/device.h
+++ b/src/device.h
@@ -245,3 +245,6 @@ void btd_device_foreach_service(struct btd_device *dev,
 				void *user_data);
 void device_remove_pending_services(struct btd_device *dev,
 					uint8_t bdaddr_type);
+
+void btd_device_sec_level_changed(struct btd_device *dev, const uint8_t *data,
+					uint16_t size);
-- 
2.43.0

