Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7371CBEB9
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365377; cv=none; b=e6HMiFGFM29+mRO6YTL6tmdNwNVsM1VufLsxQb/BjIZhX5EpA+Mj2prlbN0vycQe2UscKaMRJvQqi37Uhd5htX96gUDgJPDyh9YjWU2ZIQ/tC5GJFqEFHIbAPBV3b5q/jtZekNUI1Gjl5JFmj4IoGP66wasDaEvZR725d8gL/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365377; c=relaxed/simple;
	bh=gNdcHYqbavQDOkehAK1bD2l3fLBXfa7W62whKVBUR54=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k5qv2qIROBk2xLelLTcQF04T6PUdA1e39dJVuQ7KDoGOqwpsSYoBFudfLMZGhbkL57qZeFz5fXj+EJPFxEpDOdh93QVOp65J5c0DqFvlk7FhunDGNK1dI5YBQNVwhpBHRmXEFNZnNOHut3pEQlsdue9wSDfvHuBD7bhDTnwbeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f78hPHtV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f78hPHtV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776365374;
	bh=gNdcHYqbavQDOkehAK1bD2l3fLBXfa7W62whKVBUR54=;
	h=From:To:Subject:Date:From;
	b=f78hPHtVbucpij9IEqSVtkO853cCgMMs7uzAExbeUQkw16xVsqqc5KLn4EW7OWSoE
	 NZpR3DeRPbGZM+pIlOZedG3rIMq3xI8enNk6dwz1bS53Hk+7JIc6PIisJNVJ5ZKyct
	 E70dTVkUXUJlgN1swXJSDy8YqnzXvzN7P4V/FlESki+QNAFxS8UTk9eLdykiOq+yTY
	 P4bJTvtjIBglTmrPsGbU9614xytAZDBU4YIUdCE3Dd8j8gwzcGoIInwwVAMrQ39Sc3
	 UkgJAulXukM0HKQWq+68UDtt2dphYB5dq0xUCNy2r/9mJMag3tVPML0xRQpsaV9ZqG
	 yPzm+HSbGgglg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA1CE17E1276
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 20:49:33 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/btpclient: Add GATT discovery supports
Date: Thu, 16 Apr 2026 20:49:29 +0200
Message-ID: <20260416184929.145224-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This implements the following BTP GATT services commands which are used
by BTP BAP service:
- BTP_OP_GATT_DISC_PRIM_UUID
- BTP_OP_GATT_DISC_CHRC_UUID
- BTP_OP_GATT_DISC_ALL_DESC
---
 client/btpclient/gatt.c | 226 ++++++++++++++++++++++++++++++++++++++++
 src/shared/btp.h        |  62 +++++++++++
 2 files changed, 288 insertions(+)

diff --git a/client/btpclient/gatt.c b/client/btpclient/gatt.c
index 4a28a7b27..9d847141c 100644
--- a/client/btpclient/gatt.c
+++ b/client/btpclient/gatt.c
@@ -53,6 +53,9 @@ static void btp_gatt_read_commands(uint8_t index, const void *param,
 	}
 
 	commands |= (1 << BTP_OP_GATT_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_GATT_DISC_PRIM_UUID);
+	commands |= (1 << BTP_OP_GATT_DISC_CHRC_UUID);
+	commands |= (1 << BTP_OP_GATT_DISC_ALL_DESC);
 	commands |= (1 << BTP_OP_GATT_READ);
 	commands |= (1 << BTP_OP_GATT_READ_UUID);
 	commands |= (1 << BTP_OP_GATT_WRITE_WITHOUT_RSP);
@@ -78,6 +81,218 @@ static bool match_attribute_handle(const void *attr, const void *handle)
 	return attribute->handle == L_PTR_TO_UINT(handle);
 }
 
+static void btp_gatt_discover_prim_uuid(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_disc_prim_uuid_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	bt_uuid_t uuid;
+	struct gatt_attribute *service;
+	uint16_t first_handle, end_handle;
+	uint rp_length;
+	struct btp_gatt_disc_prim_rp *rp;
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
+	if (cp->uuid_length == 2)
+		bt_uuid16_create(&uuid, bt_get_le16(cp->uuid));
+	else if (cp->uuid_length == 4)
+		bt_uuid32_create(&uuid, bt_get_le32(cp->uuid));
+	else if (cp->uuid_length == 16) {
+		uint128_t uint128;
+
+		btoh128((uint128_t *)cp->uuid, &uint128);
+		bt_uuid128_create(&uuid, uint128);
+	} else
+		goto failed;
+
+	service = l_queue_find(device->services, match_attribute_uuid, &uuid);
+	if (!service)
+		goto failed;
+
+	/* TODO: Find last handle */
+	first_handle = end_handle = service->handle;
+
+	rp_length = sizeof(struct btp_gatt_disc_prim_rp) +
+					sizeof(struct btp_gatt_service) +
+					bt_uuid_len(&service->uuid);
+	rp = malloc(rp_length);
+	rp->services_count = 1;
+	rp->services[0].start_handle = first_handle;
+	rp->services[0].end_handle = end_handle;
+	rp->services[0].uuid_length = bt_uuid_len(&service->uuid);
+	bt_uuid_to_le(&service->uuid, rp->services[0].uuid);
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_DISC_PRIM_UUID,
+					adapter->index, rp_length, rp);
+
+	free(rp);
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
+static void btp_gatt_discover_charac_uuid(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_disc_chrc_uuid_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	bt_uuid_t uuid;
+	struct gatt_attribute *charac;
+	uint rp_length;
+	struct btp_gatt_disc_chrc_rp *rp = NULL;
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
+	if (cp->uuid_length == 2)
+		bt_uuid16_create(&uuid, bt_get_le16(cp->uuid));
+	else if (cp->uuid_length == 4)
+		bt_uuid32_create(&uuid, bt_get_le32(cp->uuid));
+	else if (cp->uuid_length == 16) {
+		uint128_t uint128;
+
+		btoh128((uint128_t *)cp->uuid, &uint128);
+		bt_uuid128_create(&uuid, uint128);
+	} else
+		goto failed;
+
+	charac = l_queue_find(device->characteristics, match_attribute_uuid,
+									&uuid);
+	if (!charac)
+		goto failed;
+
+	rp_length = sizeof(struct btp_gatt_disc_chrc_rp) +
+				sizeof(struct btp_gatt_characteristic) +
+				bt_uuid_len(&charac->uuid);
+	rp = malloc(rp_length);
+	rp->characteristics_count = 1;
+
+	rp->characteristics[0].characteristic_handle = charac->handle;
+	rp->characteristics[0].value_handle = charac->handle + 1;
+	rp->characteristics[0].properties = 0;
+	rp->characteristics[0].uuid_length = bt_uuid_len(&charac->uuid);
+	bt_uuid_to_le(&charac->uuid, rp->characteristics[0].uuid);
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_DISC_CHRC_UUID,
+					adapter->index, rp_length, rp);
+
+	free(rp);
+	return;
+
+failed:
+	free(rp);
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
+static void btp_gatt_discover_all_desc(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *device;
+	const struct btp_gatt_disc_all_desc_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	bool prop;
+	const struct l_queue_entry *entry;
+	struct l_queue *list;
+	uint16_t count;
+	uint rp_length;
+	struct btp_gatt_disc_all_desc_rp *rp = NULL;
+	uint8_t *ptr;
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
+	list = l_queue_new();
+	count = 0;
+	rp_length = sizeof(struct btp_gatt_disc_all_desc_rp);
+	for (entry = l_queue_get_entries(device->descriptors); entry;
+							entry = entry->next) {
+		struct gatt_attribute *attribute = entry->data;
+
+		if (attribute->handle < cp->start_handle ||
+					attribute->handle > cp->end_handle)
+			continue;
+
+		l_queue_push_tail(list, attribute);
+		count++;
+		rp_length += sizeof(struct btp_gatt_descriptor) +
+						bt_uuid_len(&attribute->uuid);
+	}
+
+	rp = malloc(rp_length);
+	rp->descriptors_count = count;
+	ptr = (uint8_t *)rp->descriptors;
+	for (entry = l_queue_get_entries(list); entry; entry = entry->next) {
+		struct gatt_attribute *attribute = entry->data;
+		struct btp_gatt_descriptor *descriptor;
+
+		descriptor = (struct btp_gatt_descriptor *)ptr;
+		descriptor->descriptor_handle = attribute->handle;
+		descriptor->uuid_length = bt_uuid_len(&attribute->uuid);
+		bt_uuid_to_le(&attribute->uuid, descriptor->uuid);
+		ptr += sizeof(struct btp_gatt_descriptor) +
+						bt_uuid_len(&attribute->uuid);
+	}
+
+	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_DISC_ALL_DESC,
+					adapter->index, rp_length, rp);
+
+	free(rp);
+	return;
+
+failed:
+	free(rp);
+	btp_send_error(btp, BTP_GATT_SERVICE, index, status);
+}
+
 static void gatt_read_setup(struct l_dbus_message *message,
 							void *user_data)
 {
@@ -471,6 +686,17 @@ bool gatt_register_service(struct btp *btp_, struct l_dbus *dbus_,
 	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
 					btp_gatt_read_commands, NULL, NULL);
 
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_DISC_PRIM_UUID,
+					btp_gatt_discover_prim_uuid, NULL,
+					NULL);
+
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_DISC_CHRC_UUID,
+					btp_gatt_discover_charac_uuid, NULL,
+					NULL);
+
+	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_DISC_ALL_DESC,
+					btp_gatt_discover_all_desc, NULL, NULL);
+
 	btp_register(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ,
 					btp_gatt_read, NULL, NULL);
 
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 8b5078f82..72b61784e 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -285,6 +285,27 @@ struct btp_gap_identity_resolved_ev {
 	bdaddr_t identity_address;
 } __packed;
 
+struct btp_gatt_service {
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid_length;
+	uint8_t uuid[];
+} __packed;
+
+struct btp_gatt_characteristic {
+	uint16_t characteristic_handle;
+	uint16_t value_handle;
+	uint8_t properties;
+	uint8_t uuid_length;
+	uint8_t uuid[];
+} __packed;
+
+struct btp_gatt_descriptor {
+	uint16_t descriptor_handle;
+	uint8_t uuid_length;
+	uint8_t uuid[];
+} __packed;
+
 struct btp_gatt_char_value {
 	uint16_t handle;
 	uint8_t data_len;
@@ -293,6 +314,47 @@ struct btp_gatt_char_value {
 
 #define BTP_OP_GATT_READ_SUPPORTED_COMMANDS	0x01
 
+#define BTP_OP_GATT_DISC_PRIM_UUID		0x0c
+struct btp_gatt_disc_prim_uuid_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t uuid_length;
+	uint8_t uuid[];
+} __packed;
+
+struct btp_gatt_disc_prim_rp {
+	uint8_t services_count;
+	struct btp_gatt_service services[];
+} __packed;
+
+struct btp_gatt_disc_chrc_rp {
+	uint8_t characteristics_count;
+	struct btp_gatt_characteristic characteristics[];
+} __packed;
+
+#define BTP_OP_GATT_DISC_CHRC_UUID		0x0f
+struct btp_gatt_disc_chrc_uuid_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid_length;
+	uint8_t uuid[];
+} __packed;
+
+#define BTP_OP_GATT_DISC_ALL_DESC		0x10
+struct btp_gatt_disc_all_desc_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t start_handle;
+	uint16_t end_handle;
+} __packed;
+
+struct btp_gatt_disc_all_desc_rp {
+	uint8_t descriptors_count;
+	struct btp_gatt_descriptor descriptors[];
+} __packed;
+
 #define BTP_OP_GATT_READ			0x11
 struct btp_gatt_read_cp {
 	uint8_t address_type;
-- 
2.43.0

