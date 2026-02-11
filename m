Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683762F6192
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803254; cv=none; b=ZddbMd04vmgDOiIuxuv7gfjRpyqBb57QMfI9HTjhTfcrAT4GiNkBXNCitu7g9+6rVmRXQZ3LUIxrnUSfHIn+tL0BpZSalJOG39JjvuHFPOo+7oA2VoSi2cA/RsnjRBacV7532fEWMjxnxtCDODCYjoF3gxEybz2nv159U63O0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803254; c=relaxed/simple;
	bh=vN6Ldi968Ka0jA+5UKT1gJWmf7nDlcesQdxNmp7k+3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vieo/ZLR5ZZRyoM8dcaWnordzzBIV0u5K04INY4qpWYmUua4O5KlaMRDHfKkq97PLKgbgoN3PG/XIhBtgfeNMzJ2UXMJriw1XnJK3Qs7q3UwX00XFJq4XEXYMuMt6UpS4bl5K3w4lphZUawj3qm20/8Z5Kt8F2t00KMIx4AIAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ndw2IIqY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ndw2IIqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770803251;
	bh=vN6Ldi968Ka0jA+5UKT1gJWmf7nDlcesQdxNmp7k+3w=;
	h=From:To:Subject:Date:From;
	b=Ndw2IIqYcli6fg7fJ8b/2oIU98FuedTKKuBdZDK7PoyobGdDHeoaKpbe8D9c6nVir
	 lQja4QjfCU0ZInlYb8kn8lSf/yPy4kdi7rQrT0KOCiO+0S1asEvYz0iST3JkxSuXeC
	 3W6T0bgr7ZNSgiUZUprSzZ6IKM9Lwax+hod3Gcv7AL32nf/AKmur58+QPGGIK9/bDy
	 whxWthHsFxlv+qsqxauQ6MJmFGBq2sym/azqrNP7Pm7D1gcJAiGZvZEoZncLijaZ7Y
	 /+hDyNTQqVD9bTuDMq8eOPUj4TSQgxpVGid7OthpA0SrVr1Y+1vbi8ktJwk23g2Jbu
	 SDvkJCOE5LKOQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-3D27-f5d9-cb51-6B68.rev.sfr.net [IPv6:2a02:8428:af44:1001:3d27:f5d9:cb51:6b68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86C5D17E009B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 10:47:31 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] tools/btpclient: Add GATT support to get Device name
Date: Wed, 11 Feb 2026 10:47:26 +0100
Message-ID: <20260211094726.198317-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The device name is retrieved during GATT connection, so no need to
send a specific request, just need to send the name to PTS when the
property is updated.

This allows to pass GAP/IDLE/NAMP/BV-01-C.
---
v1 -> v2: Fix memory leak

 src/shared/btp.h  |  18 +++++++
 tools/btpclient.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/src/shared/btp.h b/src/shared/btp.h
index ad18cfb3a..cf921e64a 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -285,6 +285,24 @@ struct btp_gap_identity_resolved_ev {
 	bdaddr_t identity_address;
 } __packed;
 
+#define BTP_OP_GATT_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_GATT_READ_UUID			0x12
+struct btp_gatt_read_uuid_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid_len;
+	uint8_t uuid[];
+} __packed;
+
+struct btp_gatt_read_uuid_rp {
+	uint8_t status;
+	uint8_t count;
+	uint8_t data[];
+} __packed;
+
 struct btp;
 
 typedef void (*btp_destroy_func_t)(void *user_data);
diff --git a/tools/btpclient.c b/tools/btpclient.c
index b70e2b573..8466d0606 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -22,6 +22,7 @@
 #include <ell/ell.h>
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
 #include "src/shared/btp.h"
 
 #define AD_PATH "/org/bluez/advertising"
@@ -41,6 +42,7 @@
 #define AD_TYPE_MANUFACTURER_DATA		0xff
 
 static void register_gap_service(void);
+static void register_gatt_service(void);
 
 static struct l_dbus *dbus;
 
@@ -65,6 +67,9 @@ static char *socket_path;
 static struct btp *btp;
 
 static bool gap_service_registered;
+static bool gatt_service_registered;
+
+static bool gatt_uuid_name_in_progress;
 
 struct ad_data {
 	uint8_t data[25];
@@ -2769,6 +2774,72 @@ static void register_gap_service(void)
 					btp_gap_confirm_entry_rsp, NULL, NULL);
 }
 
+static void btp_gatt_read_commands(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	uint16_t commands = 0;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_GATT_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	commands |= (1 << BTP_OP_GATT_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_GATT_READ_UUID);
+
+	commands = L_CPU_TO_LE16(commands);
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
+			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+}
+
+static void btp_gatt_read_uuid(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gatt_read_uuid_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to read UUID */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b",
+					&prop) || !prop) {
+		goto failed;
+	}
+
+	if (cp->uuid_len == 2) {
+		uint16_t uuid = cp->uuid[0] | (cp->uuid[1] << 8);
+
+		/* Name UUID is automatically retrieved during connection */
+		if (uuid == GATT_CHARAC_DEVICE_NAME) {
+			gatt_uuid_name_in_progress = true;
+			return;
+		}
+	}
+
+	/* TODO: Process other UUIDs */
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
+static void register_gatt_service(void)
+{
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
+					btp_gatt_read_commands, NULL, NULL);
+
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_UUID,
+					btp_gatt_read_uuid, NULL, NULL);
+}
+
 static void btp_core_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -2833,6 +2904,16 @@ static void btp_core_register(uint8_t index, const void *param,
 
 		return;
 	case BTP_GATT_SERVICE:
+		if (gatt_service_registered)
+			goto failed;
+
+		register_gatt_service();
+		gatt_service_registered = true;
+
+		btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
+					BTP_INDEX_NON_CONTROLLER, 0, NULL);
+
+		return;
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
 	case BTP_CORE_SERVICE:
@@ -2871,6 +2952,12 @@ static void btp_core_unregister(uint8_t index, const void *param,
 		gap_service_registered = false;
 		break;
 	case BTP_GATT_SERVICE:
+		if (!gatt_service_registered)
+			goto failed;
+
+		btp_unregister_service(btp, BTP_GATT_SERVICE);
+		gatt_service_registered = false;
+		break;
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
 	case BTP_CORE_SERVICE:
@@ -3162,6 +3249,40 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 			 * type.
 			 */
 			btp_identity_resolved_ev(proxy);
+		} else if (!strcmp(name, "Name")) {
+			struct btp_device *device;
+			struct btp_adapter *adapter;
+			const char *pts_name;
+			uint8_t pts_name_len;
+			struct btp_gatt_read_uuid_rp *rp;
+
+			if (!gatt_uuid_name_in_progress)
+				return;
+
+			device = find_device_by_proxy(proxy);
+			adapter = find_adapter_by_device(device);
+
+			if (!l_dbus_message_get_arguments(msg, "s", &pts_name))
+				return;
+
+			pts_name_len = strlen(pts_name);
+			rp = malloc(sizeof(struct btp_gatt_read_uuid_rp) + 3 +
+								pts_name_len);
+
+			rp->status = 0;
+			rp->count = 1;
+			bt_put_le16(GATT_CHARAC_DEVICE_NAME, rp->data);
+			rp->data[2] = pts_name_len;
+			memcpy(rp->data+3, pts_name, pts_name_len);
+
+			btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_UUID,
+					adapter->index,
+					sizeof(struct btp_gatt_read_uuid_rp) +
+					3 + pts_name_len, rp);
+
+			gatt_uuid_name_in_progress = false;
+
+			free(rp);
 		}
 	}
 }
-- 
2.43.0

