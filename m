Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25482C324D
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227006; cv=none; b=PnlaCZ/9h1r2e7rUl/9/EdGyPlE4JGG7612dhv2JyGinjytQJ1UyXc86U3TwVJIl/8d0HUeXmNT9bPELbrU5pvNPze2ez6Ra9jNKUoALwJJjVBMhWxSyz9yINSh95J2z6p9I/MB7pMWGUtXropvc7r8oBQFaEnDMXXkanN+S74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227006; c=relaxed/simple;
	bh=NWaVvS2OX6xibivz2qCHU7i7WQigWfUFNgXswvzUoTM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+6FkGKFMaMDqB3rfMXXCQ6yDVcWjolxLpOFJ0Pw0zS2iYcgQ7NQHTadbRVW/w00Jsfy2liEQW9Vxgd20ysFU93TSjAD86CBYbngkK3gshvcWKtdLD1Sb6I53iNQsJUOlcSIEWEHY2uw4ybc3jfUiX/sFft5+fPFZQOIdXwARvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h3m6LT7R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h3m6LT7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1775226997;
	bh=NWaVvS2OX6xibivz2qCHU7i7WQigWfUFNgXswvzUoTM=;
	h=From:To:Subject:Date:From;
	b=h3m6LT7RiBXl6jN21KTbeKj8iWY4cIJgmcamXynbbsKO9etbaPDE3ZJ1V/YicWNxq
	 6cfrmW1wErO4taaZkqP1d04tmqRGuu8uUMz4dYz3a5lZIbfbt1ufc2tEFHBQo99fE6
	 fas0jr3zJX4ZSHYrzSVJTcxh7GnP4C3qfc/W++PKuqZoKB2GLTbB0gYx+mKG0Uwfzt
	 PqM5vu7/fv5E76uwFYM5DrK1kbfyy+wuP5EvHF91sJWScM2MwMpBUPsZbPHOiWPZrh
	 ottIiVsWnT0SLBUx6mjD8Dtbo/yJMAOTYtAeZ2+kGeWtu/9xOAvyQXMFzIinreHn+a
	 6cXyPmaUImaWA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-FD67-957d-4069-F097.rev.sfr.net [IPv6:2a02:8428:af44:1001:fd67:957d:4069:f097])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FBC317E8925
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 16:36:37 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/btpclient: Add GATT read and write value supports
Date: Fri,  3 Apr 2026 16:36:31 +0200
Message-ID: <20260403143631.545312-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This stores the characteristics proxy and handle so we can call
org.bluez.GattCharacteristic1 ReadValue and WriteValue methods with
the "handle provided by PTS - 1".

This will allow to pass BAP/CL/CGGIT/CHA/BV-02-C and
BAP/UCL/CGGIT/CHA/BV-03-C.
---
 client/btpclient/gatt.c | 285 ++++++++++++++++++++++++++++++++++++++++
 src/shared/btp.h        |  35 +++++
 2 files changed, 320 insertions(+)

diff --git a/client/btpclient/gatt.c b/client/btpclient/gatt.c
index c6bb254b4..4a28a7b27 100644
--- a/client/btpclient/gatt.c
+++ b/client/btpclient/gatt.c
@@ -53,7 +53,10 @@ static void btp_gatt_read_commands(uint8_t index, const void *param,
 	}
 
 	commands |= (1 << BTP_OP_GATT_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_GATT_READ);
 	commands |= (1 << BTP_OP_GATT_READ_UUID);
+	commands |= (1 << BTP_OP_GATT_WRITE_WITHOUT_RSP);
+	commands |= (1 << BTP_OP_GATT_WRITE);
 
 	commands = L_CPU_TO_LE16(commands);
 
@@ -68,6 +71,13 @@ static bool match_attribute_uuid(const void *attr, const void *uuid)
 	return !bt_uuid_cmp(&attribute->uuid, uuid);
 }
 
+static bool match_attribute_handle(const void *attr, const void *handle)
+{
+	const struct gatt_attribute *attribute = attr;
+
+	return attribute->handle == L_PTR_TO_UINT(handle);
+}
+
 static void gatt_read_setup(struct l_dbus_message *message,
 							void *user_data)
 {
@@ -82,6 +92,93 @@ static void gatt_read_setup(struct l_dbus_message *message,
 	l_dbus_message_builder_destroy(builder);
 }
 
+static void gatt_read_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_adapter *adapter = user_data;
+	struct btp_gatt_read_rp *rp;
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
+		btp_send_error(btp, BTP_GATT_SERVICE, adapter->index,
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
+	rp = malloc(sizeof(struct btp_gatt_read_rp) + n);
+	rp->response = 0;
+	rp->len = n;
+	memcpy(rp->data, data, n);
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ, adapter->index,
+				sizeof(struct btp_gatt_read_rp) + n, rp);
+
+	free(rp);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, adapter->index, BTP_ERROR_FAIL);
+}
+
+static void btp_gatt_read(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_read_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	struct gatt_attribute *characteristic;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to read Handle */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b",
+					&prop) || !prop) {
+		goto failed;
+	}
+
+	device = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+	if (!device)
+		goto failed;
+
+	characteristic = l_queue_find(device->characteristics,
+					match_attribute_handle,
+					L_UINT_TO_PTR(cp->handle - 1));
+	if (!characteristic)
+		goto failed;
+
+	l_dbus_proxy_method_call(characteristic->proxy, "ReadValue",
+					gatt_read_setup, gatt_read_reply,
+					adapter, NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
 static void gatt_read_uuid_reply(struct l_dbus_proxy *proxy,
 						struct l_dbus_message *result,
 						void *user_data)
@@ -187,6 +284,185 @@ failed:
 	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
 }
 
+struct gatt_write_req {
+	struct btp_adapter *adapter;
+	const struct btp_gatt_write_cp *cp;
+	const char *type;
+};
+
+static void gatt_write_setup(struct l_dbus_message *message,
+							void *user_data)
+{
+	struct gatt_write_req *req = user_data;
+	struct l_dbus_message_builder *builder;
+	uint16_t i;
+
+	builder = l_dbus_message_builder_new(message);
+	l_dbus_message_builder_enter_array(builder, "y");
+	for (i = 0; i < req->cp->len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y',
+						&(req->cp->data[i]));
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	if (req->type) {
+		l_dbus_message_builder_append_basic(builder, 's', "type");
+		l_dbus_message_builder_enter_variant(builder, "s");
+		l_dbus_message_builder_append_basic(builder, 's', req->type);
+		l_dbus_message_builder_leave_variant(builder);
+	}
+	l_dbus_message_builder_leave_dict(builder);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+}
+
+static void gatt_write_without_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct gatt_write_req *req = user_data;
+	struct btp_adapter *adapter = req->adapter;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to write value (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GATT_SERVICE, adapter->index,
+							BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_WRITE_WITHOUT_RSP,
+				adapter->index, 0, NULL);
+}
+
+static void btp_gatt_write_without_rsp(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_write_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	struct gatt_attribute *characteristic;
+	struct gatt_write_req *req;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to write to Handle */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b",
+					&prop) || !prop) {
+		goto failed;
+	}
+
+	device = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+	if (!device)
+		goto failed;
+
+	characteristic = l_queue_find(device->characteristics,
+					match_attribute_handle,
+					L_UINT_TO_PTR(cp->handle - 1));
+	if (!characteristic)
+		goto failed;
+
+	req = l_new(struct gatt_write_req, 1);
+	req->adapter = adapter;
+	req->cp = cp;
+	req->type = "command";
+
+	l_dbus_proxy_method_call(characteristic->proxy, "WriteValue",
+					gatt_write_setup,
+					gatt_write_without_reply,
+					req, NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
+static void gatt_write_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct gatt_write_req *req = user_data;
+	struct btp_adapter *adapter = req->adapter;
+	struct btp_gatt_write_rp *rp;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to write value (%s), %s", name, desc);
+
+		btp_send_error(btp, BTP_GATT_SERVICE, adapter->index,
+							BTP_ERROR_FAIL);
+		return;
+	}
+
+	rp = l_new(struct btp_gatt_write_rp, 1);
+	rp->att_response = 0;
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_WRITE, adapter->index,
+				sizeof(struct btp_gatt_write_rp), rp);
+
+	free(rp);
+}
+
+static void btp_gatt_write(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_write_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	struct gatt_attribute *characteristic;
+	struct gatt_write_req *req;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Adapter needs to be powered to be able to write to Handle */
+	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b",
+					&prop) || !prop) {
+		goto failed;
+	}
+
+	device = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+	if (!device)
+		goto failed;
+
+	characteristic = l_queue_find(device->characteristics,
+					match_attribute_handle,
+					L_UINT_TO_PTR(cp->handle - 1));
+	if (!characteristic)
+		goto failed;
+
+	req = l_new(struct gatt_write_req, 1);
+	req->adapter = adapter;
+	req->cp = cp;
+
+	l_dbus_proxy_method_call(characteristic->proxy, "WriteValue",
+					gatt_write_setup, gatt_write_reply,
+					req, NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
 bool gatt_register_service(struct btp *btp_, struct l_dbus *dbus_,
 					struct l_dbus_client *client)
 {
@@ -195,9 +471,18 @@ bool gatt_register_service(struct btp *btp_, struct l_dbus *dbus_,
 	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
 					btp_gatt_read_commands, NULL, NULL);
 
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ,
+					btp_gatt_read, NULL, NULL);
+
 	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_UUID,
 					btp_gatt_read_uuid, NULL, NULL);
 
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_WRITE_WITHOUT_RSP,
+					btp_gatt_write_without_rsp, NULL, NULL);
+
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_WRITE,
+					btp_gatt_write, NULL, NULL);
+
 	gatt_service_registered = true;
 
 	return true;
diff --git a/src/shared/btp.h b/src/shared/btp.h
index bdb5ad33e..8b5078f82 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -293,6 +293,19 @@ struct btp_gatt_char_value {
 
 #define BTP_OP_GATT_READ_SUPPORTED_COMMANDS	0x01
 
+#define BTP_OP_GATT_READ			0x11
+struct btp_gatt_read_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t handle;
+} __packed;
+
+struct btp_gatt_read_rp {
+	uint8_t response;
+	uint16_t len;
+	uint8_t data[];
+} __packed;
+
 #define BTP_OP_GATT_READ_UUID			0x12
 struct btp_gatt_read_uuid_cp {
 	uint8_t address_type;
@@ -309,6 +322,28 @@ struct btp_gatt_read_uuid_rp {
 	struct btp_gatt_char_value values[];
 } __packed;
 
+#define BTP_OP_GATT_WRITE_WITHOUT_RSP		0x15
+struct btp_gatt_write_without_rsp_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t handle;
+	uint16_t len;
+	uint8_t data[];
+} __packed;
+
+#define BTP_OP_GATT_WRITE			0x17
+struct btp_gatt_write_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t handle;
+	uint16_t len;
+	uint8_t data[];
+} __packed;
+
+struct btp_gatt_write_rp {
+	uint8_t att_response;
+} __packed;
+
 struct btp;
 
 typedef void (*btp_destroy_func_t)(void *user_data);
-- 
2.43.0

