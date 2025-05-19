Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E592857FA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671263; cv=none; b=D6DPQgsOHNfu0ghqkC85uTG7D+fNdk4vOxYwabcRivzV8kxh4lOvY4XQgB/LQJlGkfZ+A01tRae1HEl71HEy3baL8o6NOijuOPo7NjaVmiBxOVX512Y3i3eABSUeODFUu38klLa+NjPI9MycoFO28XP8Vu4GDgwz7LQAxfehLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671263; c=relaxed/simple;
	bh=zCCoa+N68Fi6Oov1nd33xhmXBNm2OekkWpyDXY4GqXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+Alk24ISPOGKLOb2vLGKD8IDo3p/ybo/QoCFmL9WV7ow907Ut0ddqOSQlfSE7lLRqtbpDHvLJPE+cc/1IkCfNYLuxa96xjhtiZpANs6jlduGV5f57fyOmOfw0p2N6gT7lEzg7dCqaclekUbSuXZzgFY/27+zoZ0/n2CqIzpxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UL3p7aQm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UL3p7aQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747671259;
	bh=zCCoa+N68Fi6Oov1nd33xhmXBNm2OekkWpyDXY4GqXs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UL3p7aQmXLURPmHrbCasgDOZR3jeddm22BxjildtwP95Upt+9Y98zND4eSxnbU+UM
	 YNoEJpRWcoapFtSbPbBex6pK6+KOeyg/1IwIrOqO9hoceMkQ97dYu1+0w0DaZwK1u/
	 71cmCItqOCj3sbazVBrnnQOUQ7iB/dW6W5u7fsz0hQJlJR7I5YX9nZkBKK+dWTZ6uV
	 bj7AZzHWWNnXPtKB/V05RM5h5VbSW+hnm1CDdkOXTrwgytdpdw1kMaLHRMnSy/6Ny2
	 DZ8f/jz8hbCf5FM5zjiXF02hGOoL2WCXvk4dZ25beRc5VwKT2I6Th3ShGcwHFGRlPp
	 EnV5Yc/fvesEQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-131b-51fE-028d-5689.rev.sfr.net [IPv6:2a02:8428:af44:1001:131b:51fe:28d:5689])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E69A817E0EB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 18:14:18 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] src/device: Add Disconnected signal to propagate disconnection reason
Date: Mon, 19 May 2025 18:14:10 +0200
Message-ID: <20250519161412.107904-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519161412.107904-1-frederic.danis@collabora.com>
References: <20250519161412.107904-1-frederic.danis@collabora.com>
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
 src/adapter.c | 13 ++++++++-----
 src/device.c  | 37 +++++++++++++++++++++++++++++++++++--
 src/device.h  |  3 ++-
 3 files changed, 45 insertions(+), 8 deletions(-)

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
index d230af0a8..16e880f71 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3417,6 +3417,12 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
+static const GDBusSignalTable device_signals[] = {
+	{ GDBUS_SIGNAL("Disconnected",
+			GDBUS_ARGS({ "reason", "s" })) },
+	{ }
+};
+
 static gboolean
 dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *data)
@@ -3637,13 +3643,34 @@ static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 								dev, NULL);
 }
 
+static const char *disconnect_reason(uint8_t reason)
+{
+	switch (reason) {
+	case MGMT_DEV_DISCONN_UNKNOWN:
+		return "disconnection-unknown";
+	case MGMT_DEV_DISCONN_TIMEOUT:
+		return "disconnection-timeout";
+	case MGMT_DEV_DISCONN_LOCAL_HOST:
+		return "disconnection-local-host";
+	case MGMT_DEV_DISCONN_REMOTE:
+		return "disconnection-remote";
+	case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
+		return "disconnection-local-suspend";
+	default:
+		warn("Unknown disocnnection value: %u", reason);
+		return "disconnection-unknown";
+	}
+}
+
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
-								bool *remove)
+								bool *remove,
+								uint8_t reason)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
 	bool remove_device = false;
 	bool paired_status_updated = false;
+	const char *str_reason;
 
 	if (!state->connected)
 		return;
@@ -3708,6 +3735,12 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	g_slist_free_full(device->eir_uuids, g_free);
 	device->eir_uuids = NULL;
 
+	str_reason = disconnect_reason(reason);
+	g_dbus_emit_signal(dbus_conn, device->path, DEVICE_INTERFACE,
+						"Disconnected",
+						DBUS_TYPE_STRING, &str_reason,
+						DBUS_TYPE_INVALID);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
@@ -4611,7 +4644,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
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

