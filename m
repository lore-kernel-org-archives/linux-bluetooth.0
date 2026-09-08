Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE75803BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887202; cv=none; b=Zn4bn1An+o8lbwy0n0XRV8SmC3mQLDXAUxZtjQcFNKFVzuali3HJS3//6IsfsBW0v1358ObLviDEm6t4S7BtxdB1MLK1yeAcv94LDfpYBW5Yt5786D8SwyIVRcW9vC21ftU37CCTb9flanPjiAtsgZcHNmTh2wLUIXUMoGlQ824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887202; c=relaxed/simple;
	bh=a7TujOR1jLjcxkaMfcm0JNuUyVhMSFEaD2RkumBwl/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyAplqlGthtgtYh4wvbAVyYk0e0ulzNHbtKPfTrOBR7/adB+ShY3jH+uQkxXFIxpw1iFIXlQ+0Rw8L7dc0dSgZ+0IK3TvbiIi6NkKmPVwe6vjMDreLiJqjn6GfN/ETEfB50ToV4jH4zLdjdmA01otX56fnuptaSvcsGBBIbJs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mp7BXOO6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mp7BXOO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788887199;
	bh=a7TujOR1jLjcxkaMfcm0JNuUyVhMSFEaD2RkumBwl/4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mp7BXOO68C1f8upvwhUnX68JV+1WWHz6DKIo93uy37yeD4zA9hdwUgE+sBraixDZR
	 MVotHVqnxoun0DNK+8dGKhQK1rAZmr2tf9l0cuqqN1DSZ4EncL08dd7ORIkNxldT9j
	 LaZsNAMxSu0nq5eHzG/gObSy72yvWl+fEH1UCLwcHyZRWvsz1yNhOfZRFP2f6e2Lu6
	 rdTZOmnNe7Rta7BKyULCv/IIW8XMNaM+OkCHOCkSF8g2upD8iq3vtVly8HP40tXtlO
	 Oq5tat1+Mz/P3jga98179rXlhseOgwlXpK+bIa9i0SMPHAus7PL3X1t4MCdGhVRUVj
	 4rmIh3Frytyrw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 16D2617E0D02
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 19:06:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/8] client/btpclient: Add BTP_EV_BAP_ASE_FOUND support
Date: Tue,  8 Sep 2026 19:06:26 +0200
Message-ID: <20260908170633.510244-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908170633.510244-1-frederic.danis@collabora.com>
References: <20260908170633.510244-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is used at least for BAP/UCL/SCC/BV-004-C and BAP/UCL/SCC/BV-019-C
tests.
---
 client/btpclient/bap.c       | 109 +++++++++++++++++++++++++++++++++++
 client/btpclient/bap.h       |   2 +
 client/btpclient/btpclient.c |   6 ++
 client/btpclient/btpclient.h |   8 +++
 src/shared/btp.h             |  11 ++++
 5 files changed, 136 insertions(+)

diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index 0302fc1c0..cdbae4ac2 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -96,6 +96,115 @@ failed:
 	btp_send_error(btp, BTP_BAP_SERVICE, index, status);
 }
 
+static void bap_charac_read_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	struct l_dbus_message_builder *builder;
+
+	builder = l_dbus_message_builder_new(message);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_ase *ase = user_data;
+	struct btp_device *device = ase->device;
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct btp_bap_ase_found_ev *rp;
+	struct l_dbus_message_iter iter;
+	uint8_t *data;
+	uint32_t n;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to read value (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_BAP_SERVICE, adapter->index,
+							BTP_ERROR_FAIL);
+		return;
+	}
+
+	if (!l_dbus_message_get_arguments(result, "ay", &iter))
+		goto failed;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &data, &n)) {
+		l_debug("Cannot read value");
+		goto failed;
+	}
+
+	ase->ase_id = data[0];
+
+	rp = l_new(struct btp_bap_ase_found_ev, 1);
+	rp->address_type = device->address_type;
+	rp->address = device->address;
+	rp->dir = ase->dir;
+	rp->ase_id = data[0];
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_EV_BAP_ASE_FOUND, adapter->index,
+				sizeof(struct btp_bap_ase_found_ev), rp);
+
+	free(rp);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_BAP_SERVICE, adapter->index, BTP_ERROR_FAIL);
+}
+
+void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
+{
+	struct btp_device *device = user_data;
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		char *str, str_uuid[MAX_LEN_UUID_STR];
+		bt_uuid_t uuid;
+		struct btp_ase *ase;
+
+		if (!l_dbus_proxy_get_property(proxy, "UUID", "s", &str))
+			return;
+
+		bt_uuid16_create(&uuid, ASE_SINK_UUID);
+		bt_uuid_to_string(&uuid, str_uuid, MAX_LEN_UUID_STR);
+		if (!bt_uuid_strcmp(str, str_uuid)) {
+			ase = l_new(struct btp_ase, 1);
+			ase->device = device;
+			ase->dir = BTP_BAP_DIR_SINK;
+			ase->uuid = uuid;
+			l_queue_push_tail(device->ases, ase);
+
+			l_dbus_proxy_method_call(proxy, "ReadValue",
+						bap_charac_read_setup,
+						bap_read_ase_reply,
+						ase, NULL);
+		}
+
+		bt_uuid16_create(&uuid, ASE_SOURCE_UUID);
+		bt_uuid_to_string(&uuid, str_uuid, MAX_LEN_UUID_STR);
+		if (!bt_uuid_strcmp(str, str_uuid)) {
+			ase = l_new(struct btp_ase, 1);
+			ase->device = device;
+			ase->dir = BTP_BAP_DIR_SOURCE;
+			ase->uuid = uuid;
+			l_queue_push_tail(device->ases, ase);
+
+			l_dbus_proxy_method_call(proxy, "ReadValue",
+						bap_charac_read_setup,
+						bap_read_ase_reply,
+						ase, NULL);
+		}
+	}
+}
+
 bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
 					struct l_dbus_client *client)
 {
diff --git a/client/btpclient/bap.h b/client/btpclient/bap.h
index 2b7a218b5..7fea19f8b 100644
--- a/client/btpclient/bap.h
+++ b/client/btpclient/bap.h
@@ -11,3 +11,5 @@ bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
 					struct l_dbus_client *client);
 void bap_unregister_service(struct btp *btp);
 bool bap_is_service_registered(void);
+
+void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data);
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index 0d124bc7a..c0aa13287 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -25,6 +25,7 @@
 #include "bluetooth/uuid.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
+#include "bap.h"
 #include "core.h"
 #include "gap.h"
 #include "gatt.h"
@@ -347,6 +348,7 @@ static void signal_handler(uint32_t signo, void *user_data)
 
 static void btp_device_free(struct btp_device *device)
 {
+	l_queue_destroy(device->ases, l_free);
 	l_queue_destroy(device->services, l_free);
 	l_queue_destroy(device->characteristics, l_free);
 	l_queue_destroy(device->descriptors, l_free);
@@ -444,6 +446,7 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 		device->services = l_queue_new();
 		device->characteristics = l_queue_new();
 		device->descriptors = l_queue_new();
+		device->ases = l_queue_new();
 
 		l_queue_push_tail(adapter->devices, device);
 
@@ -545,6 +548,9 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 		}
 
 		l_queue_push_tail(device->characteristics, attribute);
+
+		if (bap_is_service_registered())
+			bap_proxy_added(proxy, device);
 	}
 
 	if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index 8a5ea2172..74ca7278c 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -26,6 +26,14 @@ struct btp_device {
 	struct l_queue *services;
 	struct l_queue *characteristics;
 	struct l_queue *descriptors;
+	struct l_queue *ases;
+};
+
+struct btp_ase {
+	struct btp_device *device;
+	bt_uuid_t uuid;
+	uint8_t dir;
+	uint8_t ase_id;
 };
 
 struct btp_agent {
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 5590bb51f..9757301f2 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -425,6 +425,9 @@ struct btp_gatt_write_rp {
 	uint8_t att_response;
 } __packed;
 
+#define BTP_BAP_DIR_SINK			0x01
+#define BTP_BAP_DIR_SOURCE			0x02
+
 #define BTP_OP_BAP_READ_SUPPORTED_COMMANDS	0x01
 
 #define BTP_OP_BAP_DISCOVER			0x02
@@ -440,6 +443,14 @@ struct btp_bap_discovery_completed_ev {
 	uint8_t status;
 } __packed;
 
+#define BTP_EV_BAP_ASE_FOUND			0x82
+struct btp_bap_ase_found_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t dir;
+	uint8_t ase_id;
+} __packed;
+
 struct btp;
 
 typedef void (*btp_destroy_func_t)(void *user_data);
-- 
2.43.0

