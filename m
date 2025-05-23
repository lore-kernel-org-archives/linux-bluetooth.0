Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB5220F4A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985220; cv=none; b=USPeeZaqFXDT3B7lCBr5bbSb+cJ3btkX4yuTz1Oo1uZ18AsgrePpw6VkOZS0g6rEDA8WlVSO6fB8IUX5nrOjvbjKsuLuKzrQnnpNCDypvZZqAnxhKj/xNkomhwvOqdWsgGdI8QEiai8kOBuYQI5aOKmGnxpM4ufG1uB3jIbUHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985220; c=relaxed/simple;
	bh=DwBpVz1Gh7yJEmEgzlZ6pZXz0T6sQCf5o3lc8veosNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh0hmtJI54bD1JV9q2YVBjyOi37ODHJnnvrhGxspj0AhdjZopVwot9uW0G5qMkGsMrieyapj1N2IfKc3MLjM1DXwKNZhQTchrVe0VXQJz9MJyLyb2dVzJDRi6uhQq02F6KtVynyWwZi606Bxe0n94FcCIFK5ZvFb9VRrTanTeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mWTzvyzg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mWTzvyzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747985216;
	bh=DwBpVz1Gh7yJEmEgzlZ6pZXz0T6sQCf5o3lc8veosNk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mWTzvyzgRAJyecHAS8BE7vL7Xw/YQWzhcGy/oy0ryt0wQoExpdlmIpFwyNd7C/VD/
	 MFs10RSQMR69/sNPgq2hwOu2+pkPA4etSqATV2RURGA0hY+3ACLCylu6VvBp4SB8g7
	 1cQLl/CE5z/5DIfhFvXk0JSnMYuMMIgzPduzVywb0XaPpLxncudhYLFbB10uc9G9Qb
	 fRWuWVjK+K5c9kAS6KIOvs47lsPkJ06ZtnT7GDDIXmMIc+oEaQgqNjnzp+lxSG2wW9
	 TIEy93TsqawGrNBM1ZMeshJCr4IXradOKhpj9C37BVZsGMDATNpn/gzzZo0wFuzdkB
	 BVWhzYJfy29ug==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-83a4-18CE-8675-8031.rev.sfr.net [IPv6:2a02:8428:af44:1001:83a4:18ce:8675:8031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 10D3F17E15A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 09:26:56 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/4] src/device: Add Disconnected signal to propagate disconnection reason
Date: Fri, 23 May 2025 09:26:45 +0200
Message-ID: <20250523072647.689324-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523072647.689324-1-frederic.danis@collabora.com>
References: <20250523072647.689324-1-frederic.danis@collabora.com>
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
v2->v3: Replace numerical value by name and message to be more consistent
        with Device.Connect error reply.

 src/adapter.c | 13 +++++++-----
 src/device.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/device.h  |  3 ++-
 3 files changed, 65 insertions(+), 8 deletions(-)

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
index 56583f71a..9591fe0a7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3481,6 +3481,12 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
+static const GDBusSignalTable device_signals[] = {
+	{ GDBUS_SIGNAL("Disconnected",
+			GDBUS_ARGS({ "name", "s" }, { "message", "s" })) },
+	{ }
+};
+
 static gboolean
 dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *data)
@@ -3732,8 +3738,53 @@ static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 								dev, NULL);
 }
 
+static void emit_disconnect_reason(struct btd_device *device,
+							uint8_t reason)
+{
+	const char *name;
+	const char *message;
+
+	switch (reason) {
+	case MGMT_DEV_DISCONN_UNKNOWN:
+		name = "org.bluez.Reason.Unknown";
+		message = "disconnection-unknown";
+		break;
+	case MGMT_DEV_DISCONN_TIMEOUT:
+		name = "org.bluez.Reason.Timeout";
+		message = "disconnection-timeout";
+		break;
+	case MGMT_DEV_DISCONN_LOCAL_HOST:
+		name = "org.bluez.Reason.Local";
+		message = "disconnection-localhost";
+		break;
+	case MGMT_DEV_DISCONN_REMOTE:
+		name = "org.bluez.Reason.Remote";
+		message = "disconnection-remote";
+		break;
+	case MGMT_DEV_DISCONN_AUTH_FAILURE:
+		name = "org.bluez.Reason.Authentication";
+		message = "disconnection-authentication-failure";
+		break;
+	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
+		name = "org.bluez.Reason.LocalSuspend";
+		message = "disconnection-local-suspend";
+		break;
+	default:
+		warn("Unknown disconnection value: %u", reason);
+		name = "org.bluez.Reason.Unknown";
+		message = "disconnection-undefined";
+	}
+
+	g_dbus_emit_signal(dbus_conn, device->path, DEVICE_INTERFACE,
+						"Disconnected",
+						DBUS_TYPE_STRING, &name,
+						DBUS_TYPE_STRING, &message,
+						DBUS_TYPE_INVALID);
+}
+
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
-								bool *remove)
+								bool *remove,
+								uint8_t reason)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
@@ -3803,6 +3854,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	g_slist_free_full(device->eir_uuids, g_free);
 	device->eir_uuids = NULL;
 
+	emit_disconnect_reason(device, reason);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
@@ -4704,7 +4757,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
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

