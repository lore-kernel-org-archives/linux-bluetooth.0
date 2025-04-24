Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F328BAA9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512210; cv=none; b=gE6qhhEvaHfCATGZC9ab0+etTuVFDPzWnmgXE1VA46ROX59p11SODCiyiaMK+vkiQY0XiLWkqwQFL4rjPH7xWJdZvtYv4cwR/r97eBvazPu/iz/bWclp4lymj0uTzWHCY1AplfVN1sPwILiSxL+1Z21xfSZUPY5EiNjFArmmaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512210; c=relaxed/simple;
	bh=VbhOsvfPzj15yFnYL9KtWMl5bGSXIe6QDJnauWIS+TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gavX84LFsRkSh+ebdDn6dklLxLuQIZxJpUgQvQEUaSAh1UR2PXltcpYuhmGqjw1/Jm8QzrCAnxAJnpHbibcLQNcX2NwmVKl/XW1whVZfV8GKeCjvTtgbSKuLGNfZfBuk5QgXdgzcurCLqm11shM07BnVoWIvH/TpMxpWgeEdJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FDZwhQz1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FDZwhQz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745512206;
	bh=VbhOsvfPzj15yFnYL9KtWMl5bGSXIe6QDJnauWIS+TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDZwhQz1GqpY6imr/PoPLgSjdsykB40nyKcJMk8n7JrIrXthEZFLyvq7pDRcUf1uy
	 aD/KeWW1H74oPtAog4u5M+RQaeFtW7e2JBlHs/7nrcg/ZM0qB5p+9bdzqscejuJywF
	 bjdxxyyY3xL+15NL+E9VWo4kUfHpG/APvKHAnHLE6c3YKbaRndbyHlzGxqCuWsqPJm
	 3L5KGxtGHU+dYzvdwVmEvdCk3gl5kw4yxxYh5Ob8sfRspxPD4UH0PGmFOppUv2Jv6s
	 VZrFZmkGJ4tE2FjxV/jmPbzoiTDp5kgd0sw8votIZTbrVhyMYdEwUWWf8n2nvsQBB1
	 BRrj8dvf3101Q==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3323017E3613;
	Thu, 24 Apr 2025 18:30:06 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v5 1/6] src: Add new CablePairing property
Date: Thu, 24 Apr 2025 18:29:28 +0200
Message-ID: <20250424162933.182103-2-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424162933.182103-1-ludovico.denittis@collabora.com>
References: <20250424162933.182103-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds initial support for a new CablePairing property.
The property can be used for devices that are paired using a cable and
don't support the expected bonding (with pairing/encryption), for
example like the Sixaxis gamepads.
---
 doc/org.bluez.Device.rst |  7 +++++++
 src/device.c             | 40 ++++++++++++++++++++++++++++++++++++++++
 src/device.h             |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 13328249b..80501eddd 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -279,6 +279,13 @@ boolean LegacyPairing [readonly]
 	Bluetooth 2.1 (or newer) devices that have disabled Extended Inquiry
 	Response support.
 
+boolean CablePairing [readonly]
+```````````````````````````````
+
+	Set to true if the device was cable paired and it doesn't support the
+	canonical bonding with encryption, e.g. the Sixaxis gamepad.
+	If true, BlueZ will establish a connection without enforcing encryption.
+
 string Modalias [readonly, optional]
 ````````````````````````````````````
 
diff --git a/src/device.c b/src/device.c
index b82a905f9..123d44c14 100644
--- a/src/device.c
+++ b/src/device.c
@@ -239,6 +239,7 @@ struct btd_device {
 	GSList		*watches;		/* List of disconnect_data */
 	bool		temporary;
 	bool		connectable;
+	bool		cable_pairing;
 	unsigned int	disconn_timer;
 	unsigned int	discov_timer;
 	unsigned int	temporary_timer;	/* Temporary/disappear timer */
@@ -507,6 +508,9 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	g_key_file_set_boolean(key_file, "General", "CablePairing",
+							device->cable_pairing);
+
 	if (device->wake_override != WAKE_FLAG_DEFAULT) {
 		g_key_file_set_boolean(key_file, "General", "WakeAllowed",
 				       device->wake_override ==
@@ -908,6 +912,11 @@ bool btd_device_is_trusted(struct btd_device *device)
 	return device->trusted;
 }
 
+bool device_is_cable_pairing(struct btd_device *device)
+{
+	return device->cable_pairing;
+}
+
 static gboolean dev_property_get_address(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1153,6 +1162,17 @@ static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_cable_pairing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t val = device->cable_pairing;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_rssi(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -3483,6 +3503,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
 	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "LegacyPairing", "b", dev_property_get_legacy },
+	{ "CablePairing", "b", dev_property_get_cable_pairing },
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
@@ -4062,6 +4083,9 @@ next:
 	if (blocked)
 		device_block(device, FALSE);
 
+	device->cable_pairing = g_key_file_get_boolean(key_file, "General",
+							"CablePairing", NULL);
+
 	/* Load device profile list */
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
 						NULL, NULL);
@@ -6416,6 +6440,22 @@ void device_set_legacy(struct btd_device *device, bool legacy)
 					DEVICE_INTERFACE, "LegacyPairing");
 }
 
+void device_set_cable_pairing(struct btd_device *device, bool cable_pairing)
+{
+	if (!device)
+		return;
+
+	if (device->cable_pairing == cable_pairing)
+		return;
+
+	DBG("setting cable pairing %d", cable_pairing);
+
+	device->cable_pairing = cable_pairing;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "CablePairing");
+}
+
 void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 								uint16_t value)
 {
diff --git a/src/device.h b/src/device.h
index 2e4a9771d..a35bb1386 100644
--- a/src/device.h
+++ b/src/device.h
@@ -94,6 +94,7 @@ bool device_is_connectable(struct btd_device *device);
 bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 bool btd_device_is_trusted(struct btd_device *device);
+bool device_is_cable_pairing(struct btd_device *device);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
 void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
 void btd_device_set_temporary(struct btd_device *device, bool temporary);
@@ -101,6 +102,7 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void btd_device_set_connectable(struct btd_device *device, bool connectable);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
+void device_set_cable_pairing(struct btd_device *device, bool cable_pairing);
 void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
 							int8_t delta_threshold);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
-- 
2.49.0

