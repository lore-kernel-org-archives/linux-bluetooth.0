Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9D5908CB
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887209; cv=none; b=ENPTNaAvMrpeqPo6Cp71dFVhOFWQWQrhOa2Ggnus/3GwfqliKFMd9akRG3FWNanM40zHYP1uPwyuh3yJf8voj8JxEVlTpQCbTB2V+ot6ds6psZyUHfCAQzdnIsGCMQbnfSEEGrFwz+8mMzc/uc2RLWI7r3HV9Z1A/xTh+/4kzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887209; c=relaxed/simple;
	bh=Ub+Inlr0kkFNBR2ptQb0UReVJyJgHcmu/IQUl5Q+VQI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBQf20Rmf0vTu1YeltCBCXjFJ9NAfKs9e6XzMxjpK/QOrK1Ssn67jG4k0992GhmBH8lGiZ+IPbNT5QxJoreBviSp3wSpj1wmKY6sXJGihV/cgNTFjg2PMGZpXD6Ew4LhCcAudwyxD9wth9M+5Ofn5Mmqv8n4yRE9J23VRiQ2cmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jl8CHV8p; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jl8CHV8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788887200;
	bh=Ub+Inlr0kkFNBR2ptQb0UReVJyJgHcmu/IQUl5Q+VQI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jl8CHV8pP2gKUe52Xxf46f3eLncMCw1ato3EQ1PxG/CN51jkRieenAqojHgjj0/4t
	 Lr6e5pzlxU44WfAvyByeUfRbqWwifIz1qc00uKlqQIxsNrsramlj6lxw7ND7FjGKJV
	 qiM1yF9fznc/VxiMVEZstKtqrdm/SXPLlEqUzyVAYPYxWiOg53HG2Ed01uAEN12M3a
	 DjpeDFgyUdvI8i/fDAEwwvHy4fIYGmdec48vp4Loon3CJ3xj+60cdwQP6aJU3aYjDW
	 mibKavUwn7njVXlUDUKyHkblHw6S2P68ImVuLnPuBAt4C0uF6DN5wD5V3F2nTbJYic
	 SQqwv5ubjqGPw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 50B3617E0FAA
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 19:06:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] client/btpclient: Add ASCS support for BAP/UCL/STR/* tests
Date: Tue,  8 Sep 2026 19:06:31 +0200
Message-ID: <20260908170633.510244-7-frederic.danis@collabora.com>
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

---
v1->v2: Fix stream connection when transport interface is created after
        auto-pts requests enabling ASE

 client/btpclient/ascs.c      | 706 ++++++++++++++++++++++++++++++++---
 client/btpclient/ascs.h      |   3 +
 client/btpclient/bap.c       |  97 ++++-
 client/btpclient/btpclient.c |  35 ++
 client/btpclient/btpclient.h |  13 +
 client/btpclient/vendor.c    |   1 +
 src/shared/btp.h             |  68 ++++
 7 files changed, 869 insertions(+), 54 deletions(-)

diff --git a/client/btpclient/ascs.c b/client/btpclient/ascs.c
index 063fc8306..85f6f171a 100644
--- a/client/btpclient/ascs.c
+++ b/client/btpclient/ascs.c
@@ -131,6 +131,11 @@ static void btp_ascs_read_commands(uint8_t index, const void *param,
 	const uint8_t supported_commands[] = {
 		BTP_OP_ASCS_READ_SUPPORTED_COMMANDS,
 		BTP_OP_ASCS_CONFIGURE_CODEC,
+		BTP_OP_ASCS_CONFIGURE_QOS,
+		BTP_OP_ASCS_ENABLE,
+		BTP_OP_ASCS_RECEIVER_START_READY,
+		BTP_OP_ASCS_ADD_ASE_TO_CIS,
+		BTP_OP_ASCS_PRECONFIGURE_QOS,
 	};
 	uint8_t *commands = NULL;
 	size_t commands_len = 0;
@@ -362,6 +367,394 @@ failed:
 	btp_send_error(btp, BTP_ASCS_SERVICE, index, status);
 }
 
+static bool match_ase(const void *entry, const void *data)
+{
+	const struct btp_ase *ase = entry;
+	uint8_t id = L_PTR_TO_UINT(data);
+
+	return ase->ase_id == id;
+}
+
+struct configure_qos_complete_data {
+	struct btp_adapter *adapter;
+	const struct btp_ascs_configure_qos_cp *cp;
+};
+
+static void configure_qos_complete_cb(void *data, void *user_data)
+{
+	struct btp_ase *ase = data;
+	struct configure_qos_complete_data *param = user_data;
+	const struct btp_ascs_configure_qos_cp *cp = param->cp;
+	struct btp_ascs_operation_completed_ev ev;
+
+	if ((cp->ase_id && cp->ase_id != ase->ase_id) ||
+					(cp->cig_id != ase->cig_id))
+		return;
+
+	memcpy(&ev.address, &cp->address, sizeof(ev.address));
+	ev.address_type = cp->address_type;
+	ev.ase_id = ase->ase_id;
+	ev.opcode = BTP_OP_ASCS_CONFIGURE_QOS;
+	ev.status = 0;
+	ev.flags = 0;
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_EV_ASCS_OPERATION_COMPLETED,
+			param->adapter->index, sizeof(ev), &ev);
+
+	send_state_changed(param->adapter->index,  &cp->address,
+					cp->address_type, ase->ase_id,
+					BT_BAP_STREAM_STATE_QOS);
+}
+
+static void btp_ascs_configure_qos(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *dev;
+	const struct btp_ascs_configure_qos_cp *cp = param;
+	struct configure_qos_complete_data data;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	dev = find_device_by_address(adapter, &cp->address, cp->address_type);
+	if (!dev)
+		goto failed;
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_CONFIGURE_QOS, index, 0,
+									NULL);
+
+	/* Send BTP_EV_ASCS_OPERATION_COMPLETED for each of the ASEs */
+	data.adapter = adapter;
+	data.cp = cp;
+	l_queue_foreach(dev->ases, configure_qos_complete_cb, &data);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_ASCS_SERVICE, index, status);
+}
+
+static bool read_cb(struct l_io *io, void *user_data)
+{
+	struct btp_ase *ase = user_data;
+	struct btp_device *device = ase->device;
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct btp_bap_stream_received_ev *ev;
+	ssize_t bytes_read;
+
+	ev = l_malloc(sizeof(struct btp_bap_stream_received_ev) + ase->rx_mtu);
+	memcpy(&ev->address, &device->address, sizeof(ev->address));
+	ev->address_type = device->address_type;
+	ev->ase_id = ase->ase_id;
+
+	bytes_read = read(l_io_get_fd(io), ev->data, ase->rx_mtu);
+	if (bytes_read < 0) {
+		l_info("Invalid read length: %ld", bytes_read);
+		l_free(ev);
+		return false;
+	}
+	ev->data_len = bytes_read;
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_EV_BAP_STREAM_RECEIVED,
+				adapter->index, sizeof(*ev) + bytes_read, ev);
+
+	l_free(ev);
+
+	return false;
+}
+
+static bool match_ase_path(const void *entry, const void *data)
+{
+	const struct btp_ase *ase = entry;
+	const char *path = data;
+	const char *ase_path = l_dbus_proxy_get_path(ase->transport_proxy);
+
+	if (!path || !ase_path)
+		return false;
+
+	return !strcmp(path, ase_path);
+}
+
+static void ase_change_state(struct btp_ase *ase,
+					enum ase_transport_state state)
+{
+	struct btp_device *device = ase->device;
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct l_dbus_message_iter iter;
+	const char *path;
+
+	ase->transport_state = state;
+	if (state == ASE_TRANSPORT_ACQUIRED)
+		send_state_changed(adapter->index, &device->address,
+						device->address_type,
+						ase->ase_id,
+						BT_BAP_STREAM_STATE_ENABLING);
+
+	if (adapter->desync)
+		return;
+
+	/* Update linked endpoints */
+	if (!l_dbus_proxy_get_property(ase->transport_proxy, "Links", "ao",
+						&iter))
+		return;
+
+	while (l_dbus_message_iter_next_entry(&iter, &path)) {
+		struct btp_ase *l;
+
+		l = l_queue_find(device->ases, match_ase_path, path);
+		if (!l)
+			continue;
+
+		l->transport_state = state;
+		if (state != ASE_TRANSPORT_ACQUIRED)
+			continue;
+
+		send_state_changed(adapter->index, &l->device->address,
+						l->device->address_type,
+						l->ase_id,
+						BT_BAP_STREAM_STATE_ENABLING);
+	}
+}
+
+static void ascs_acquire_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_ase *ase = user_data;
+	struct btp_device *device = ase->device;
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	uint8_t status = BTP_ERROR_FAIL;
+	int sk;
+	uint16_t rx, tx;
+	struct l_dbus_message_iter iter;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to acquire endpoint (%s), %s", name, desc);
+
+		goto failed;
+	}
+
+	if (!l_dbus_message_get_arguments(result, "hqq", &sk, &rx, &tx))
+		goto failed;
+
+	ase_change_state(ase, ASE_TRANSPORT_ACQUIRED);
+	ase->rx_mtu = rx;
+	ase->tx_mtu = tx;
+	ase->io = l_io_new(sk);
+	if (!ase->io) {
+		close(sk);
+		goto failed;
+	}
+
+	if (ase->dir == BTP_BAP_DIR_SOURCE)
+		l_io_set_read_handler(ase->io, read_cb, ase, NULL);
+
+	/* Update linked endpoints */
+	if (l_dbus_proxy_get_property(ase->transport_proxy, "Links", "ao",
+						&iter)) {
+		const char *path;
+
+		while (l_dbus_message_iter_next_entry(&iter, &path)) {
+			struct btp_ase *l;
+
+			l = l_queue_find(device->ases, match_ase_path, path);
+			if (l) {
+				l->rx_mtu = rx;
+				l->tx_mtu = tx;
+				if (l->dir == BTP_BAP_DIR_SOURCE)
+					l_io_set_read_handler(ase->io,
+							read_cb, l, NULL);
+				break;
+			}
+		}
+	}
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_ASCS_SERVICE, adapter->index, status);
+}
+
+static void btp_ascs_enable(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_ascs_enable_cp *cp = param;
+	struct btp_ascs_operation_completed_ev ev;
+	struct btp_device *dev;
+	struct btp_ase *ase;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_ENABLE, index, 0, NULL);
+
+	memcpy(&ev.address, &cp->address, sizeof(ev.address));
+	ev.address_type = cp->address_type;
+	ev.ase_id = cp->ase_id;
+	ev.opcode = BTP_OP_ASCS_ENABLE;
+	ev.status = 0;
+	ev.flags = 0;
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_EV_ASCS_OPERATION_COMPLETED,
+			adapter->index, sizeof(ev), &ev);
+
+	dev = find_device_by_address(adapter, &cp->address, cp->address_type);
+	if (!dev)
+		goto failed;
+
+	ase = l_queue_find(dev->ases, match_ase, L_UINT_TO_PTR(cp->ase_id));
+	if (!ase)
+		goto failed;
+
+	/* In desync mode, Acquire the transport straight away and defer
+	 * sending the ENABLING state notification until Acquire completes;
+	 * otherwise notify ENABLING immediately.
+	 */
+	if (adapter->desync) {
+		ase_change_state(ase, ASE_TRANSPORT_ACQUIRING);
+
+		if (!ase->transport_proxy)
+			return;
+
+		l_dbus_proxy_method_call(ase->transport_proxy, "Acquire",
+					NULL, ascs_acquire_reply, ase, NULL);
+	} else if (ase->transport_proxy) {
+		send_state_changed(adapter->index, &cp->address,
+						cp->address_type,
+						ase->ase_id,
+						BT_BAP_STREAM_STATE_ENABLING);
+	}
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_ASCS_SERVICE, index, status);
+}
+
+static void btp_ascs_receiver_start_ready(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_ascs_enable_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	/* Outside desync mode, Acquire the transport on Receiver Start
+	 * Ready; in desync mode it was already Acquired when Enable was
+	 * received.
+	 */
+	if (!adapter->desync) {
+		struct btp_device *dev;
+		struct btp_ase *ase;
+
+		dev = find_device_by_address(adapter, &cp->address,
+							cp->address_type);
+		if (!dev)
+			goto failed;
+
+		ase = l_queue_find(dev->ases, match_ase,
+						L_UINT_TO_PTR(cp->ase_id));
+		if (!ase)
+			goto failed;
+
+		if (ase->transport_proxy)
+			l_dbus_proxy_method_call(ase->transport_proxy,
+							"Acquire", NULL,
+							ascs_acquire_reply,
+							ase, NULL);
+
+		ase_change_state(ase, ASE_TRANSPORT_ACQUIRING);
+	}
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_RECEIVER_START_READY,
+							index, 0, NULL);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_ASCS_SERVICE, index, status);
+}
+
+static void btp_ascs_add_ase_to_cis(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	struct btp_device *dev;
+	const struct btp_ascs_add_ase_to_cis_cp *cp = param;
+	struct btp_ase *ase;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	dev = find_device_by_address(adapter, &cp->address, cp->address_type);
+	if (!dev)
+		goto failed;
+
+	ase = l_queue_find(dev->ases, match_ase, L_UINT_TO_PTR(cp->ase_id));
+	if (!ase)
+		goto failed;
+
+	if (ase->cig_id != cp->cig_id || ase->cis_id != cp->cis_id) {
+		l_error("Invalid CIG/CIS ID, expecting %u/%u, got %u/%u",
+						ase->cig_id, ase->cis_id,
+						cp->cig_id, cp->cis_id);
+		goto failed;
+	}
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_ADD_ASE_TO_CIS, index, 0,
+									NULL);
+
+	if (ase->transport_proxy) {
+		struct btp_ascs_cis_connected_ev ev;
+
+		memcpy(&ev.address, &dev->address, sizeof(ev.address));
+		ev.address_type = dev->address_type;
+		ev.ase_id = ase->ase_id;
+		ev.cis_id = ase->cis_id;
+
+		btp_send(btp, BTP_ASCS_SERVICE, BTP_EV_ASCS_CIS_CONNECTED,
+				adapter->index, sizeof(ev), &ev);
+	}
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_ASCS_SERVICE, index, status);
+}
+
+static void btp_ascs_preconfigure_qos(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+
+	if (!adapter) {
+		btp_send_error(btp, BTP_ASCS_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	btp_send(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_PRECONFIGURE_QOS, index, 0,
+									NULL);
+}
+
 bool ascs_setup(struct btp_adapter *adapter)
 {
 	bt_uuid_t uuid;
@@ -626,6 +1019,28 @@ static struct l_dbus_message *get_properties_reply(
 	l_dbus_message_builder_enter_variant(builder, "a{sv}");
 	l_dbus_message_builder_enter_array(builder, "{sv}");
 
+	if (ase->cig_id != BT_ISO_QOS_CIG_UNSET) {
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+						"CIG");
+		l_dbus_message_builder_enter_variant(builder, "y");
+		l_dbus_message_builder_append_basic(builder, 'y',
+						&ase->cig_id);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+	if (ase->cis_id != BT_ISO_QOS_CIS_UNSET) {
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+						"CIS");
+		l_dbus_message_builder_enter_variant(builder, "y");
+		l_dbus_message_builder_append_basic(builder, 'y',
+						&ase->cis_id);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
 	l_dbus_message_builder_enter_dict(builder, "sv");
 	l_dbus_message_builder_append_basic(builder, 's',
 					"PresentationDelay");
@@ -815,79 +1230,250 @@ static struct l_dbus_message *find_pending_msg(struct l_queue *l,
 	return NULL;
 }
 
-void ascs_property_changed(struct l_dbus_proxy *proxy, const char *name,
-				struct l_dbus_message *msg, void *user_data)
+static void set_desync_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *result, void *user_data)
 {
-	const char *interface = l_dbus_proxy_get_interface(proxy);
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
 
-	if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
-		char *uuid, *str;
-		struct btp_device *device;
-		struct btp_adapter *adapter;
-		struct btp_ase *ase;
-		struct l_dbus_message_iter iter;
-		uint8_t *data;
-		uint32_t n;
-		const struct l_queue_entry *entry;
-		struct l_dbus_message *reply;
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to desync Links (%s), %s", name, desc);
+		return;
+	}
+}
 
-		if (strcmp(name, "Value"))
-			return;
+void ascs_ase_replied(struct btp_adapter *adapter, struct btp_ase *ase)
+{
+	struct l_dbus_message *msg, *reply;
 
-		if (!l_dbus_proxy_get_property(proxy, "UUID", "s", &uuid))
-			return;
+	msg = find_pending_msg(pending_select_properties, ase);
+	if (msg) {
+		l_queue_remove(pending_select_properties, msg);
+		reply = get_properties_reply(msg, adapter, ase);
+		l_dbus_send(dbus, reply);
 
-		if (!l_dbus_proxy_get_property(proxy, "Service", "o", &str))
-			return;
+		l_dbus_message_unref(msg);
+	}
+}
 
-		device = find_device_by_service_path(str);
-		if (!device)
-			return;
+static bool transport_get_cig_cis(struct l_dbus_proxy *proxy, uint8_t *cig,
+								uint8_t *cis)
+{
+	struct l_dbus_message_iter iter, var;
+	const char *key;
 
-		adapter = find_adapter_by_device(device);
-		if (!adapter)
-			return;
+	*cig = BT_ISO_QOS_CIG_UNSET;
+	*cis = BT_ISO_QOS_CIS_UNSET;
 
-		ase = find_ase_by_uuid(device, uuid);
-		if (!ase)
-			return;
+	if (!l_dbus_proxy_get_property(proxy, "QoS", "a{sv}", &iter))
+		return false;
 
-		if (!l_dbus_message_get_arguments(msg, "ay", &iter))
-			return;
+	while (l_dbus_message_iter_next_entry(&iter, &key, &var)) {
+		if (!strcmp(key, "CIG")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", cig))
+				return false;
+		}
 
-		if (!l_dbus_message_iter_get_fixed_array(&iter, &data, &n)) {
-			l_debug("Cannot read value");
-			return;
+		if (!strcmp(key, "CIS")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", cis))
+				return false;
 		}
+	}
+
+	return true;
+}
 
-		ase->ase_id = data[0];
+void ascs_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
+{
+	char *str, *state;
+	struct btp_device *device = user_data;
+	struct btp_adapter *adapter;
+	uint8_t dir;
+	uint8_t cig = BT_ISO_QOS_CIG_UNSET, cis = BT_ISO_QOS_CIS_UNSET;
+	struct btp_ase *ase;
+
+	adapter = find_adapter_by_device(device);
+	if (!adapter)
+		return;
 
-		for (entry = l_queue_get_entries(device->endpoints); entry;
-							entry = entry->next) {
-			struct l_dbus_proxy *p = entry->data;
-			const char *str, *pac_uuid;
+	if (!l_dbus_proxy_get_property(proxy, "UUID", "s", &str))
+		return;
 
-			if (!l_dbus_proxy_get_property(p, "UUID", "s", &str))
-				continue;
+	if (!l_dbus_proxy_get_property(proxy, "State", "s", &state))
+		return;
+
+	if (!bt_uuid_strcmp(str, PAC_SINK_UUID))
+		dir = BTP_BAP_DIR_SOURCE;
+	else
+		dir = BTP_BAP_DIR_SINK;
 
-			if (bt_uuid16_cmp(&ase->uuid, ASE_SINK_UUID))
-				pac_uuid = PAC_SINK_UUID;
+	if (!transport_get_cig_cis(proxy, &cig, &cis))
+		return;
+
+	ase = find_ase(device, cig, cis, dir);
+	if (!ase)
+		return;
+
+	ase->transport_proxy = proxy;
+
+	/* In desync mode, the CIS_CONNECTED event is sent later, once the
+	 * "Desynchronized" property has been set (see set_desync_reply());
+	 * otherwise send it now.
+	 */
+	if (!adapter->desync) {
+		struct btp_ascs_cis_connected_ev ev;
+
+		memcpy(&ev.address, &device->address, sizeof(ev.address));
+		ev.address_type = device->address_type;
+		ev.ase_id = ase->ase_id;
+		ev.cis_id = ase->cis_id;
+
+		btp_send(btp, BTP_ASCS_SERVICE, BTP_EV_ASCS_CIS_CONNECTED,
+				adapter->index, sizeof(ev), &ev);
+
+		send_state_changed(adapter->index, &device->address,
+					device->address_type,
+					ase->ase_id,
+					BT_BAP_STREAM_STATE_ENABLING);
+
+		if (ase->transport_state == ASE_TRANSPORT_ACQUIRING &&
+				!strcmp(state, "idle")) {
+			l_dbus_proxy_method_call(proxy, "Acquire",
+						NULL,
+						ascs_acquire_reply,
+						ase, NULL);
+		}
+	}
+}
+
+void ascs_property_changed(struct l_dbus_proxy *proxy, const char *name,
+				struct l_dbus_message *msg, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.MediaTransport1")) {
+		if (!strcmp(name, "State")) {
+			const char *state, *path, *uuid;
+			struct btp_device *dev;
+			struct btp_adapter *adapter;
+			uint8_t dir, cig, cis;
+			struct btp_ase *ase;
+			uint8_t ase_state;
+
+			if (!l_dbus_message_get_arguments(msg, "s", &state))
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "Device", "o",
+								&path))
+				return;
+
+			dev = find_device_by_path(path);
+			if (!dev)
+				return;
+
+			adapter = find_adapter_by_device(dev);
+			if (!adapter)
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "UUID", "s",
+								&uuid))
+				return;
+
+			if (!bt_uuid_strcmp(uuid, PAC_SINK_UUID))
+				dir = BTP_BAP_DIR_SOURCE;
 			else
-				pac_uuid = PAC_SOURCE_UUID;
+				dir = BTP_BAP_DIR_SINK;
 
-			if (!strcmp(str, pac_uuid)) {
-				ase->ep_proxy = p;
-				break;
+			if (!transport_get_cig_cis(proxy, &cig, &cis))
+				return;
+
+			ase = find_ase(dev, cig, cis, dir);
+			if (!ase)
+				return;
+
+			if (!strcmp(state, "active"))
+				ase_state = BT_BAP_STREAM_STATE_STREAMING;
+			else {
+				if (ase->io) {
+					l_io_destroy(ase->io);
+					ase->io = NULL;
+				}
+
+				ase_state = BT_BAP_STREAM_STATE_IDLE;
 			}
+
+			send_state_changed(adapter->index,  &dev->address,
+							dev->address_type,
+							ase->ase_id,
+							ase_state);
 		}
 
-		msg = find_pending_msg(pending_select_properties, ase);
-		if (msg) {
-			l_queue_remove(pending_select_properties, msg);
-			reply = get_properties_reply(msg, adapter, ase);
-			l_dbus_send(dbus, reply);
+		if (!strcmp(name, "Desynchronized")) {
+			struct btp_device *dev;
+			struct btp_adapter *adapter;
+			const bool desynchronized;
+			const char *path, *uuid;
+			uint8_t dir, cig, cis;
+			struct btp_ase *ase;
+			struct btp_ascs_cis_connected_ev ev;
+
+			if (!l_dbus_message_get_arguments(msg, "b",
+							&desynchronized))
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "Device", "o",
+								&path))
+				return;
+
+			dev = find_device_by_path(path);
+			if (!dev)
+				return;
+
+			adapter = find_adapter_by_device(dev);
+			if (!adapter || !adapter->desync)
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "UUID", "s",
+								&uuid))
+				return;
+
+			if (!bt_uuid_strcmp(uuid, PAC_SINK_UUID))
+				dir = BTP_BAP_DIR_SOURCE;
+			else
+				dir = BTP_BAP_DIR_SINK;
+
+			if (!transport_get_cig_cis(proxy, &cig, &cis))
+				return;
+
+			ase = find_ase(dev, cig, cis, dir);
+			if (!ase)
+				return;
+
+			if (!desynchronized) {
+				l_dbus_proxy_set_property(proxy,
+							set_desync_reply,
+							ase, NULL,
+							"Desynchronized", "b",
+							true);
+				return;
+			}
 
-			l_dbus_message_unref(msg);
+			memcpy(&ev.address, &ase->device->address,
+							sizeof(ev.address));
+			ev.address_type = ase->device->address_type;
+			ev.ase_id = ase->ase_id;
+			ev.cis_id = ase->cis_id;
+
+			btp_send(btp, BTP_ASCS_SERVICE,
+						BTP_EV_ASCS_CIS_CONNECTED,
+						adapter->index,
+						sizeof(ev), &ev);
+
+			if (ase->transport_state == ASE_TRANSPORT_ACQUIRING)
+				l_dbus_proxy_method_call(ase->transport_proxy,
+							"Acquire", NULL,
+							ascs_acquire_reply,
+							ase, NULL);
 		}
 	}
 }
@@ -905,6 +1491,22 @@ bool ascs_register_service(struct btp *btp_, struct l_dbus *dbus_,
 	btp_register(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_CONFIGURE_CODEC,
 					btp_ascs_configure_codec, NULL, NULL);
 
+	btp_register(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_CONFIGURE_QOS,
+					btp_ascs_configure_qos, NULL, NULL);
+
+	btp_register(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_ENABLE,
+					btp_ascs_enable, NULL, NULL);
+
+	btp_register(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_RECEIVER_START_READY,
+					btp_ascs_receiver_start_ready,
+					NULL, NULL);
+
+	btp_register(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_ADD_ASE_TO_CIS,
+					btp_ascs_add_ase_to_cis, NULL, NULL);
+
+	btp_register(btp, BTP_ASCS_SERVICE, BTP_OP_ASCS_PRECONFIGURE_QOS,
+					btp_ascs_preconfigure_qos, NULL, NULL);
+
 	if (!l_dbus_register_interface(dbus, ENDPOINT_IFACE,
 						setup_endpoint_interface,
 						NULL, false)) {
diff --git a/client/btpclient/ascs.h b/client/btpclient/ascs.h
index 46d38ae90..b3a2eb7e2 100644
--- a/client/btpclient/ascs.h
+++ b/client/btpclient/ascs.h
@@ -14,5 +14,8 @@ bool ascs_is_service_registered(void);
 
 bool ascs_setup(struct btp_adapter *adapter);
 
+void ascs_proxy_added(struct l_dbus_proxy *proxy, void *user_data);
 void ascs_property_changed(struct l_dbus_proxy *proxy, const char *name,
 				struct l_dbus_message *msg, void *user_data);
+
+void ascs_ase_replied(struct btp_adapter *adapter, struct btp_ase *ase);
diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index 548b5e8ed..b1d70a50d 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -20,6 +20,7 @@
 #include "src/shared/bap-defs.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
+#include "ascs.h"
 #include "bap.h"
 
 static struct btp *btp;
@@ -244,6 +245,8 @@ static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
 	uint32_t n;
 	bt_uuid_t uuid;
 	struct gatt_attribute *attribute;
+	const char *pac_uuid;
+	const struct l_queue_entry *entry;
 
 	if (l_dbus_message_is_error(result)) {
 		const char *name, *desc;
@@ -275,10 +278,30 @@ static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
 
 	free(rp);
 
-	if (bt_uuid16_cmp(&ase->uuid, ASE_SINK_UUID))
+	if (bt_uuid16_cmp(&ase->uuid, ASE_SINK_UUID)) {
 		bt_uuid16_create(&uuid, PAC_SINK_CHRC_UUID);
-	else
+		pac_uuid = PAC_SINK_UUID;
+	} else {
 		bt_uuid16_create(&uuid, PAC_SOURCE_CHRC_UUID);
+		pac_uuid = PAC_SOURCE_UUID;
+	}
+
+	for (entry = l_queue_get_entries(device->endpoints); entry;
+						entry = entry->next) {
+		struct l_dbus_proxy *p = entry->data;
+		const char *str;
+
+		if (!l_dbus_proxy_get_property(p, "UUID", "s", &str))
+			continue;
+
+		if (!strcmp(str, pac_uuid)) {
+			ase->ep_proxy = p;
+			break;
+		}
+	}
+
+	ascs_ase_replied(adapter, ase);
+
 	attribute = l_queue_find(device->characteristics,
 						match_attribute_uuid, &uuid);
 	if (!attribute)
@@ -294,6 +317,72 @@ failed:
 	btp_send_error(btp, BTP_BAP_SERVICE, adapter->index, BTP_ERROR_FAIL);
 }
 
+static uint8_t get_next_cis(struct btp_device *device, uint8_t dir)
+{
+	const struct l_queue_entry *adapter_entry;
+	const struct l_queue_entry *ase_entry;
+	uint8_t cis = 0;
+	bool found = false;
+
+	/* For the same device, reuse the opposite cis_id if there is no ASE
+	 * in the requested direction already using that same cis_id
+	 */
+	for (ase_entry = l_queue_get_entries(device->ases); ase_entry;
+					ase_entry = ase_entry->next) {
+		struct btp_ase *ase = ase_entry->data;
+		const struct l_queue_entry *entry;
+		bool has_same_dir = false;
+
+		if (ase->dir == dir)
+			continue;
+
+		for (entry = l_queue_get_entries(device->ases); entry;
+					entry = entry->next) {
+			struct btp_ase *peer = entry->data;
+
+			if (peer->dir == dir && peer->cis_id == ase->cis_id) {
+				has_same_dir = true;
+				break;
+			}
+		}
+
+		if (!has_same_dir)
+			return ase->cis_id;
+	}
+
+	/* Else returns the global highest cis_id + 1 across all ASEs of all
+	 * devices, or 0 if no ASE exists
+	 */
+	for (adapter_entry = l_queue_get_entries(get_adapters_list());
+					adapter_entry;
+					adapter_entry = adapter_entry->next) {
+		struct btp_adapter *adapter = adapter_entry->data;
+		const struct l_queue_entry *device_entry;
+
+		for (device_entry = l_queue_get_entries(adapter->devices);
+					device_entry;
+					device_entry = device_entry->next) {
+			struct btp_device *dev = device_entry->data;
+
+			for (ase_entry = l_queue_get_entries(dev->ases);
+						ase_entry;
+						ase_entry = ase_entry->next) {
+				struct btp_ase *ase = ase_entry->data;
+
+				if (!found || ase->cis_id > cis)
+					cis = ase->cis_id;
+
+				found = true;
+			}
+		}
+	}
+
+	if (!found)
+		return 0;
+
+	return cis + 1;
+}
+
 void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 {
 	struct btp_device *device = user_data;
@@ -314,6 +403,8 @@ void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 			ase->device = device;
 			ase->dir = BTP_BAP_DIR_SINK;
 			ase->uuid = uuid;
+			ase->cig_id = 0;
+			ase->cis_id = get_next_cis(device, ase->dir);
 			l_queue_push_tail(device->ases, ase);
 
 			l_dbus_proxy_method_call(proxy, "ReadValue",
@@ -329,6 +420,8 @@ void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 			ase->device = device;
 			ase->dir = BTP_BAP_DIR_SOURCE;
 			ase->uuid = uuid;
+			ase->cig_id = 0;
+			ase->cis_id = get_next_cis(device, ase->dir);
 			l_queue_push_tail(device->ases, ase);
 
 			l_dbus_proxy_method_call(proxy, "ReadValue",
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index eb4d348db..6e084e2c8 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -230,6 +230,26 @@ struct btp_device *find_device_by_proxy(struct l_dbus_proxy *proxy)
 	return NULL;
 }
 
+static bool match_cigcisdir(const void *entry, const void *data)
+{
+	const struct btp_ase *ase = entry;
+	uint32_t cigcisdir = L_PTR_TO_UINT(data);
+	uint8_t cig = cigcisdir & 0xFF;
+	uint8_t cis = (cigcisdir >> 8) & 0xFF;
+	uint8_t dir = (cigcisdir >> 16) & 0xFF;
+
+	return ase->cig_id == cig && ase->cis_id == cis && ase->dir == dir;
+}
+
+struct btp_ase *find_ase(struct btp_device *device, uint8_t cig, uint8_t cis,
+								uint8_t dir)
+{
+	uint32_t cigcisdir = cig + (cis << 8) + (dir << 16);
+
+	return l_queue_find(device->ases, match_cigcisdir,
+						L_UINT_TO_PTR(cigcisdir));
+}
+
 static bool match_uuid(const void *entry, const void *data)
 {
 	const struct btp_ase *ase = entry;
@@ -633,6 +653,21 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 		return;
 	}
+
+	if (!strcmp(interface, "org.bluez.MediaTransport1")) {
+		char *str;
+		struct btp_device *device;
+
+		if (!l_dbus_proxy_get_property(proxy, "Device", "o", &str))
+			return;
+
+		device = find_device_by_path(str);
+		if (!device)
+			return;
+
+		if (ascs_is_service_registered())
+			ascs_proxy_added(proxy, device);
+	}
 }
 
 static bool device_match_by_proxy(const void *a, const void *b)
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index 9996df506..6fab3d701 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -23,6 +23,7 @@ struct btp_adapter {
 	uint32_t source_locations;
 
 	uint8_t target_latency;
+	bool desync;
 };
 
 struct btp_device {
@@ -36,12 +37,22 @@ struct btp_device {
 	struct l_queue *endpoints;
 };
 
+enum ase_transport_state {
+	ASE_TRANSPORT_READY = 0,
+	ASE_TRANSPORT_ACQUIRING,
+	ASE_TRANSPORT_ACQUIRED,
+};
+
 struct btp_ase {
 	struct btp_device *device;
 	bt_uuid_t uuid;
 	uint8_t dir;
 	uint8_t ase_id;
+	uint8_t cig_id;
+	uint8_t cis_id;
 	struct l_dbus_proxy *ep_proxy;
+	struct l_dbus_proxy *transport_proxy;
+	enum ase_transport_state transport_state;
 	struct l_io *io;
 	uint16_t rx_mtu;
 	uint16_t tx_mtu;
@@ -70,6 +81,8 @@ struct btp_device *find_device_by_path(const char *path);
 struct btp_adapter *find_adapter_by_device(struct btp_device *device);
 struct btp_device *find_device_by_proxy(struct l_dbus_proxy *proxy);
 struct btp_device *find_device_by_service_path(const char *path);
+struct btp_ase *find_ase(struct btp_device *device, uint8_t cig, uint8_t cis,
+							uint8_t dir);
 struct btp_ase *find_ase_by_uuid(struct btp_device *device, char *uuid);
 
 struct btp_agent *get_agent(void);
diff --git a/client/btpclient/vendor.c b/client/btpclient/vendor.c
index 30ce5649c..f421035db 100644
--- a/client/btpclient/vendor.c
+++ b/client/btpclient/vendor.c
@@ -65,6 +65,7 @@ static void btp_vendor_ascs_setup(uint8_t index, const void *param,
 	const struct btp_vendor_ascs_setup_cp *cp = param;
 
 	adapter->target_latency = cp->target_latency;
+	adapter->desync = cp->desync;
 
 	ascs_setup(adapter);
 
diff --git a/src/shared/btp.h b/src/shared/btp.h
index fe93158aa..8cae0e765 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -450,6 +450,56 @@ struct btp_ascs_configure_codec_cp {
 	uint8_t cc_ltvs[];
 } __packed;
 
+#define BTP_OP_ASCS_CONFIGURE_QOS		0x03
+struct btp_ascs_configure_qos_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+	uint8_t cig_id;
+	uint8_t cis_id;
+	uint8_t sdu_interval[3];
+	uint8_t framing;
+	uint16_t max_sdu;
+	uint8_t retransmission_num;
+	uint16_t max_transport_latency;
+	uint8_t presentation_delay[3];
+} __packed;
+
+#define BTP_OP_ASCS_ENABLE			0x04
+struct btp_ascs_enable_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+} __packed;
+
+#define BTP_OP_ASCS_RECEIVER_START_READY	0x05
+struct btp_ascs_receiver_start_ready_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+} __packed;
+
+#define BTP_OP_ASCS_ADD_ASE_TO_CIS		0x0a
+struct btp_ascs_add_ase_to_cis_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+	uint8_t cig_id;
+	uint8_t cis_id;
+} __packed;
+
+#define BTP_OP_ASCS_PRECONFIGURE_QOS		0x0b
+struct btp_ascs_preconfigure_qos_cp {
+	uint8_t cig_id;
+	uint8_t cis_id;
+	uint8_t sdu_interval[3];
+	uint8_t framing;
+	uint16_t max_sdu;
+	uint8_t retransmission_num;
+	uint16_t max_transport_latency;
+	uint8_t presentation_delay[3];
+} __packed;
+
 #define BTP_EV_ASCS_OPERATION_COMPLETED		0x80
 struct btp_ascs_operation_completed_ev {
 	uint8_t address_type;
@@ -470,6 +520,14 @@ struct btp_ascs_ase_state_changed_ev {
 	uint8_t state;
 } __packed;
 
+#define BTP_EV_ASCS_CIS_CONNECTED		0x83
+struct btp_ascs_cis_connected_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+	uint8_t cis_id;
+} __packed;
+
 #define BTP_BAP_DIR_SINK			0x01
 #define BTP_BAP_DIR_SOURCE			0x02
 
@@ -521,11 +579,21 @@ struct btp_bap_ase_found_ev {
 	uint8_t ase_id;
 } __packed;
 
+#define BTP_EV_BAP_STREAM_RECEIVED		0x83
+struct btp_bap_stream_received_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+	uint8_t data_len;
+	uint8_t data[];
+} __packed;
+
 #define BTP_OP_VENDOR_READ_SUPPORTED_COMMANDS	0x01
 
 #define BTP_OP_VENDOR_ASCS_SETUP		0x02
 struct btp_vendor_ascs_setup_cp {
 	uint8_t target_latency;
+	uint8_t desync;
 } __packed;
 
 struct btp;
-- 
2.43.0

