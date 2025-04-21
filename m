Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC429D0E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234023; cv=none; b=LpW1ZJc6Y7DrcVVDueS4x1Xaqwfb9Xeaeu7QjTmBlbAP1alM4NZ3NDTZya28dLxmHHbDgRsaKrqrt7awiMIgeqZ3ABcTmPcNS/LBpeGNtsnyQaDeLAEzV+V0GTz1fzfraw9yK+4rG64w4q/KnUSUj3ZKSHwu/HfYGnWDvuQGGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234023; c=relaxed/simple;
	bh=Fi0MPczyk21pAUbypOskIDPslLKmxMIDpsqDKorEJpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYp9TWseek/T/UyU16kazOCBTN5aQmE7v5cxhNAuyfei6CM8nY6M4R46eexMz0OJwIzhsAHNu7wqm/w+jMpPcI+/A43a6noFC92XY9fTUPHEUUHl8CGN4J2R45gx4Wt42xFI5ZmORj5ZDhilteh8FVJ3vgdmR/FxXPN9Y48ax+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qW+tNbUl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qW+tNbUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745234019;
	bh=Fi0MPczyk21pAUbypOskIDPslLKmxMIDpsqDKorEJpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qW+tNbUlmqGExULSxcZt9YcBzIigsKzkKIQN1g5MSdd0qzxDbX8V/wXSE40iggCBS
	 usxz7cXu19SwrF8gadow+VU09mcKJPQioL7Spaqi2XzLOodqVOXV0Qt1QzGR1BzXxN
	 K7E79X8PFQ2Nfqwbyu76sLBJYSli/sCe4YINU4jAPxOHG2txHrY2GmHKgZuxrgyPLS
	 QERaTYqy67lS6VuDwPOd53QBgAw0dyANhTr3EiVtrIqYq94CIsiHMxv0V8jrsoa2An
	 rFvmQT28WueZIP2Gqlna+hetMTH/OSihM/Ij4hi0iYtOZjBOZ9MquVN38cmAbE4DtG
	 VcpN7/Zmc4tlQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 54EE417E00FC;
	Mon, 21 Apr 2025 13:13:39 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 1/5] src: Add new SixaxisCablePairing property
Date: Mon, 21 Apr 2025 13:12:47 +0200
Message-ID: <20250421111251.108943-2-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421111251.108943-1-ludovico.denittis@collabora.com>
References: <20250421111251.108943-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds initial support for a new SixaxisCablePairing property.
The property can be used to set a device as being a "real" Sixaxis
gamepad and then handle it differently when needed.
---
 doc/org.bluez.Device.rst |  6 ++++++
 src/device.c             | 44 ++++++++++++++++++++++++++++++++++++++++
 src/device.h             |  3 +++
 3 files changed, 53 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 13328249b..2d85d0dc2 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -279,6 +279,12 @@ boolean LegacyPairing [readonly]
 	Bluetooth 2.1 (or newer) devices that have disabled Extended Inquiry
 	Response support.
 
+boolean SixaxisCablePairing [readonly]
+``````````````````````````````````````
+
+	Set to true if the device was paired using the Sixaxis USB custom protocol.
+	If true, the device connection will happen without enforcing encryption.
+
 string Modalias [readonly, optional]
 ````````````````````````````````````
 
diff --git a/src/device.c b/src/device.c
index b82a905f9..b11b5c8e4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -239,6 +239,7 @@ struct btd_device {
 	GSList		*watches;		/* List of disconnect_data */
 	bool		temporary;
 	bool		connectable;
+	bool		sixaxis_cable_pairing;
 	unsigned int	disconn_timer;
 	unsigned int	discov_timer;
 	unsigned int	temporary_timer;	/* Temporary/disappear timer */
@@ -507,6 +508,9 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Blocked",
 							device->blocked);
 
+	g_key_file_set_boolean(key_file, "General", "SixaxisCablePairing",
+							device->sixaxis_cable_pairing);
+
 	if (device->wake_override != WAKE_FLAG_DEFAULT) {
 		g_key_file_set_boolean(key_file, "General", "WakeAllowed",
 				       device->wake_override ==
@@ -908,6 +912,11 @@ bool btd_device_is_trusted(struct btd_device *device)
 	return device->trusted;
 }
 
+bool device_is_sixaxis_cable_pairing(struct btd_device *device)
+{
+	return device->sixaxis_cable_pairing;
+}
+
 static gboolean dev_property_get_address(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1153,6 +1162,17 @@ static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_sixaxis_cable_pairing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	dbus_bool_t val = device->sixaxis_cable_pairing;
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
+	{ "SixaxisCablePairing", "b", dev_property_get_sixaxis_cable_pairing },
 	{ "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_rssi },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
@@ -4062,6 +4083,9 @@ next:
 	if (blocked)
 		device_block(device, FALSE);
 
+	device->sixaxis_cable_pairing = g_key_file_get_boolean(key_file, "General",
+							"SixaxisCablePairing", NULL);
+
 	/* Load device profile list */
 	uuids = g_key_file_get_string_list(key_file, "General", "Services",
 						NULL, NULL);
@@ -4857,6 +4881,9 @@ void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)
 	dev->trusted = dup->trusted;
 	dev->blocked = dup->blocked;
 
+	/* Skip sixaxis_cable_pairing property because it doesn't support LE, so we
+	 * never expect to have a duplicate device in that case */
+
 	for (l = dup->uuids; l; l = g_slist_next(l))
 		dev->uuids = g_slist_append(dev->uuids, g_strdup(l->data));
 
@@ -6416,6 +6443,23 @@ void device_set_legacy(struct btd_device *device, bool legacy)
 					DEVICE_INTERFACE, "LegacyPairing");
 }
 
+void device_set_sixaxis_cable_pairing(struct btd_device *device,
+							gboolean sixaxis_cable_pairing)
+{
+	if (!device)
+		return;
+
+	if (device->sixaxis_cable_pairing == sixaxis_cable_pairing)
+		return;
+
+	DBG("setting sixaxis cable pairing %d", sixaxis_cable_pairing);
+
+	device->sixaxis_cable_pairing = sixaxis_cable_pairing;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "SixaxisCablePairing");
+}
+
 void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 								uint16_t value)
 {
diff --git a/src/device.h b/src/device.h
index 2e4a9771d..c0fa6ec3a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -94,6 +94,7 @@ bool device_is_connectable(struct btd_device *device);
 bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 bool btd_device_is_trusted(struct btd_device *device);
+bool device_is_sixaxis_cable_pairing(struct btd_device *device);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
 void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
 void btd_device_set_temporary(struct btd_device *device, bool temporary);
@@ -101,6 +102,8 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted);
 void btd_device_set_connectable(struct btd_device *device, bool connectable);
 void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
 void device_set_legacy(struct btd_device *device, bool legacy);
+void device_set_sixaxis_cable_pairing(struct btd_device *device,
+							gboolean sixaxis_cable_pairing);
 void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
 							int8_t delta_threshold);
 void device_set_rssi(struct btd_device *device, int8_t rssi);
-- 
2.49.0

