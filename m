Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCD1DB356
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758391; cv=none; b=SC1CAYE7bbB+pnNMMEUwVpOMr/QA6SAnvembry8FaNNAyPr2aCNJdAcKFsumaugdMYMbnVIvV0TgH9+p3eddzP7RB0Oyaq9squky18Li8ti8ClqDmzC1UaoDR4XFsI2BD2whhYFTgf6vf+BhKtrZJTzp6W0Ap9f8lK7GxH7bBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758391; c=relaxed/simple;
	bh=DTBBCWAIL5nrygf2sG7O64MQReW0fwWS3TA63hAnHos=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEdfVJ/F3RPNXFSb0xA9Rk4uHt6X+kat/hCEEyQnDI61UfiTzjpoPc9uvC6OQaxbZWB+eMPf3Q9HN4VIwrMBn2kNoBS0seIBqAIZtsy0hniQtnNKkWDGruWbg1UgtIhtvCS5aao8eOepBwnlzBhxFSZD8WEd8HR6QNpBJ6+CmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z7jKLyoD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z7jKLyoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747758387;
	bh=DTBBCWAIL5nrygf2sG7O64MQReW0fwWS3TA63hAnHos=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z7jKLyoDz5P3aAGRea4EvxwLSxvqvkIgMvbcet2EOKbzW209w++yVanLLQkSaDHMd
	 1UDF+r4gadSgKu+JaozgTVA9LK7U8SiOk67gpHYkQPe+G4y89eDVri0qwuB19Zdvln
	 5BVkubwaFuwFuf+WrMO+puTEBOxM++hVzERhQOEWQILMxxvTJTStG/I31BaL7QEBBk
	 562pRWJtavhwakDaIIxyCnER10WbzGBxcjKcVaeBLzD8NdSsBwmjw+z+B9Z9RB99J+
	 ANI7V+BFlk1+jBSWmXnaD/hUbjksaFKAbHoM3OotkbmSZhAKUHjEo7E4ozzxD+lEU+
	 97KXnxpoEOByg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-66a1-C560-f4d8-070F.rev.sfr.net [IPv6:2a02:8428:af44:1001:66a1:c560:f4d8:70f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A4DA17E1047
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 18:26:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] src/device: Add Disconnected signal to propagate disconnection reason
Date: Tue, 20 May 2025 18:26:19 +0200
Message-ID: <20250520162621.190769-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520162621.190769-1-frederic.danis@collabora.com>
References: <20250520162621.190769-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This helps client application to know the reason for the disconnection
and to take appropriate action.
---
v1->v2: Propagate numerical reason instead of text one

 src/adapter.c | 13 ++++++++-----
 src/device.c  | 16 ++++++++++++++--
 src/device.h  |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fd425e6d2..a10721489 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7549,7 +7549,8 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter)
 
 static void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
-						uint8_t bdaddr_type)
+						uint8_t bdaddr_type,
+						uint8_t reason)
 {
 	bool remove_device = false;
 
@@ -7560,7 +7561,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_remove_connection(device, bdaddr_type, &remove_device);
+	device_remove_connection(device, bdaddr_type, &remove_device, reason);
 
 	device_cancel_authentication(device, TRUE);
 
@@ -7601,9 +7602,11 @@ static void adapter_stop(struct btd_adapter *adapter)
 		struct btd_device *device = adapter->connections->data;
 		uint8_t addr_type = btd_device_get_bdaddr_type(device);
 
-		adapter_remove_connection(adapter, device, BDADDR_BREDR);
+		adapter_remove_connection(adapter, device, BDADDR_BREDR,
+						MGMT_DEV_DISCONN_UNKNOWN);
 		if (addr_type != BDADDR_BREDR)
-			adapter_remove_connection(adapter, device, addr_type);
+			adapter_remove_connection(adapter, device, addr_type,
+						MGMT_DEV_DISCONN_UNKNOWN);
 	}
 
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
@@ -8551,7 +8554,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 
 	device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
 	if (device) {
-		adapter_remove_connection(adapter, device, addr->type);
+		adapter_remove_connection(adapter, device, addr->type, reason);
 		disconnect_notify(device, reason);
 	}
 
diff --git a/src/device.c b/src/device.c
index d230af0a8..00a0fbfc7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3417,6 +3417,12 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
+static const GDBusSignalTable device_signals[] = {
+	{ GDBUS_SIGNAL("Disconnected",
+			GDBUS_ARGS({ "reason", "y" })) },
+	{ }
+};
+
 static gboolean
 dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *data)
@@ -3638,7 +3644,8 @@ static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 }
 
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
-								bool *remove)
+								bool *remove,
+								uint8_t reason)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
@@ -3708,6 +3715,11 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	g_slist_free_full(device->eir_uuids, g_free);
 	device->eir_uuids = NULL;
 
+	g_dbus_emit_signal(dbus_conn, device->path, DEVICE_INTERFACE,
+						"Disconnected",
+						DBUS_TYPE_BYTE, &reason,
+						DBUS_TYPE_INVALID);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
@@ -4611,7 +4623,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
 	if (g_dbus_register_interface(dbus_conn,
 					device->path, DEVICE_INTERFACE,
-					device_methods, NULL,
+					device_methods, device_signals,
 					device_properties, device,
 					device_free) == FALSE) {
 		error("Unable to register device interface for %s", address);
diff --git a/src/device.h b/src/device.h
index a35bb1386..4eebcebe9 100644
--- a/src/device.h
+++ b/src/device.h
@@ -134,7 +134,8 @@ gboolean device_is_authenticating(struct btd_device *device);
 void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 							uint32_t flags);
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
-								bool *remove);
+							bool *remove,
+							uint8_t reason);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
 void device_set_ltk(struct btd_device *device, const uint8_t val[16],
-- 
2.43.0

