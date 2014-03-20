Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 11/62] Replace bt_get_le16() by get_le16()
Date: Thu, 20 Mar 2014 11:42:36 -0300
Message-Id: <1395326607-27068-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/l2cap.c      | 68 ++++++++++++++++++++++++++--------------------------
 monitor/packet.c     | 38 ++++++++++++++---------------
 src/eir.c            |  6 ++---
 tools/btmgmt.c       | 22 ++++++++---------
 tools/hciconfig.c    |  3 ++-
 tools/l2test.c       |  2 +-
 tools/parser/hci.c   |  3 ++-
 tools/parser/l2cap.c | 21 ++++++++--------
 8 files changed, 83 insertions(+), 80 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 58c8c5c..362a0b3 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -457,11 +457,11 @@ static void print_config_options(const struct l2cap_frame *frame,
 		switch (type) {
 		case 0x01:
 			print_field("  MTU: %d",
-					bt_get_le16(data + consumed + 2));
+					get_le16(data + consumed + 2));
 			break;
 		case 0x02:
 			print_field("  Flush timeout: %d",
-					bt_get_le16(data + consumed + 2));
+					get_le16(data + consumed + 2));
 			break;
 		case 0x03:
 			switch (data[consumed + 3]) {
@@ -521,11 +521,11 @@ static void print_config_options(const struct l2cap_frame *frame,
 			print_field("  TX window size: %d", data[consumed + 3]);
 			print_field("  Max transmit: %d", data[consumed + 4]);
 			print_field("  Retransmission timeout: %d",
-					bt_get_le16(data + consumed + 5));
+					get_le16(data + consumed + 5));
 			print_field("  Monitor timeout: %d",
-					bt_get_le16(data + consumed + 7));
+					get_le16(data + consumed + 7));
 			print_field("  Maximum PDU size: %d",
-					bt_get_le16(data + consumed + 9));
+					get_le16(data + consumed + 9));
 			break;
 		case 0x05:
 			switch (data[consumed + 2]) {
@@ -562,7 +562,7 @@ static void print_config_options(const struct l2cap_frame *frame,
 			print_field("  Service type: %s (0x%2.2x)",
 						str, data[consumed + 3]);
 			print_field("  Maximum SDU size: 0x%4.4x",
-					bt_get_le16(data + consumed + 4));
+					get_le16(data + consumed + 4));
 			print_field("  SDU inter-arrival time: 0x%8.8x",
 					bt_get_le32(data + consumed + 6));
 			print_field("  Access latency: 0x%8.8x",
@@ -572,7 +572,7 @@ static void print_config_options(const struct l2cap_frame *frame,
 			break;
 		case 0x07:
 			print_field("  Max window size: %d",
-					bt_get_le16(data + consumed + 2));
+					get_le16(data + consumed + 2));
 			break;
 		default:
 			packet_hexdump(data + consumed + 2, len);
@@ -794,7 +794,7 @@ static void sig_cmd_reject(const struct l2cap_frame *frame)
 			packet_hexdump(data, size);
 			break;
 		}
-		print_field("MTU: %d", bt_get_le16(data));
+		print_field("MTU: %d", get_le16(data));
 		break;
 	case 0x0002:
 		if (size != 4) {
@@ -802,8 +802,8 @@ static void sig_cmd_reject(const struct l2cap_frame *frame)
 			packet_hexdump(data, size);
 			break;
 		}
-		dcid = bt_get_le16(data);
-		scid = bt_get_le16(data + 2);
+		dcid = get_le16(data);
+		scid = get_le16(data + 2);
 		print_cid("Destination", cpu_to_le16(dcid));
 		print_cid("Source", cpu_to_le16(scid));
 		break;
@@ -916,7 +916,7 @@ static void sig_info_rsp(const struct l2cap_frame *frame)
 			packet_hexdump(data, size);
 			break;
 		}
-		print_field("MTU: %d", bt_get_le16(data));
+		print_field("MTU: %d", get_le16(data));
 		break;
 	case 0x0002:
 		if (size != 4) {
@@ -1604,8 +1604,8 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 		return;
 	}
 
-	control = bt_get_le16(data);
-	fcs = bt_get_le16(data + size - 2);
+	control = get_le16(data);
+	fcs = get_le16(data + size - 2);
 
 	print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
 				" %d dlen %d control 0x%4.4x fcs 0x%4.4x",
@@ -1622,7 +1622,7 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 
 	opcode = *((const uint8_t *) (data + 2));
 	ident = *((const uint8_t *) (data + 3));
-	len = bt_get_le16(data + 4);
+	len = get_le16(data + 4);
 
 	if (len != size - 8) {
 		print_text(COLOR_ERROR, "invalid manager packet size");
@@ -1697,8 +1697,8 @@ static void print_uuid(const char *label, const void *data, uint16_t size)
 
 	switch (size) {
 	case 2:
-		str = uuid16_to_str(bt_get_le16(data));
-		print_field("%s: %s (0x%4.4x)", label, str, bt_get_le16(data));
+		str = uuid16_to_str(get_le16(data));
+		print_field("%s: %s (0x%4.4x)", label, str, get_le16(data));
 		break;
 	case 4:
 		str = uuid32_to_str(bt_get_le32(data));
@@ -1708,9 +1708,9 @@ static void print_uuid(const char *label, const void *data, uint16_t size)
 		str = uuid128_to_str(data);
 		print_field("%s: %s (%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x)",
 				label, str,
-				bt_get_le32(data + 12), bt_get_le16(data + 10),
-				bt_get_le16(data + 8), bt_get_le16(data + 6),
-				bt_get_le32(data + 2), bt_get_le16(data + 0));
+				bt_get_le32(data + 12), get_le16(data + 10),
+				get_le16(data + 8), get_le16(data + 6),
+				bt_get_le32(data + 2), get_le16(data + 0));
 		break;
 	default:
 		packet_hexdump(data, size);
@@ -1721,7 +1721,7 @@ static void print_uuid(const char *label, const void *data, uint16_t size)
 static void print_handle_range(const char *label, const void *data)
 {
 	print_field("%s: 0x%4.4x-0x%4.4x", label,
-				bt_get_le16(data), bt_get_le16(data + 2));
+				get_le16(data), get_le16(data + 2));
 }
 
 static void print_data_list(const char *label, uint8_t length,
@@ -1737,7 +1737,7 @@ static void print_data_list(const char *label, uint8_t length,
 	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
 
 	while (size >= length) {
-		print_field("Handle: 0x%4.4x", bt_get_le16(data));
+		print_field("Handle: 0x%4.4x", get_le16(data));
 		print_hex_field("Value", data + 2, length - 2);
 
 		data += length;
@@ -1772,7 +1772,7 @@ static void print_attribute_info(uint16_t type, const void *data, uint16_t len)
 			break;
 		}
 		print_field("  Properties: 0x%2.2x", *((uint8_t *) data));
-		print_field("  Handle: 0x%2.2x", bt_get_le16(data + 1));
+		print_field("  Handle: 0x%2.2x", get_le16(data + 1));
 		print_uuid("  UUID", data + 3, len - 3);
 		break;
 	default:
@@ -1885,7 +1885,7 @@ static const char *att_format_str(uint8_t format)
 static uint16_t print_info_data_16(const uint16_t *data, uint16_t len)
 {
 	while (len >= 4) {
-		print_field("Handle: 0x%4.4x", bt_get_le16(data));
+		print_field("Handle: 0x%4.4x", get_le16(data));
 		print_uuid("UUID", data + 2, 2);
 		data += 4;
 		len -= 4;
@@ -1897,7 +1897,7 @@ static uint16_t print_info_data_16(const uint16_t *data, uint16_t len)
 static uint16_t print_info_data_128(const uint16_t *data, uint16_t len)
 {
 	while (len >= 18) {
-		print_field("Handle: 0x%4.4x", bt_get_le16(data));
+		print_field("Handle: 0x%4.4x", get_le16(data));
 		print_uuid("UUID", data + 2, 16);
 		data += 18;
 		len -= 18;
@@ -1929,7 +1929,7 @@ static void att_find_by_type_val_req(const struct l2cap_frame *frame)
 
 	print_handle_range("Handle range", frame->data);
 
-	type = bt_get_le16(frame->data + 4);
+	type = get_le16(frame->data + 4);
 	print_attribute_info(type, frame->data + 6, frame->size - 6);
 }
 
@@ -1976,8 +1976,8 @@ static void att_read_rsp(const struct l2cap_frame *frame)
 
 static void att_read_blob_req(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", bt_get_le16(frame->data));
-	print_field("Offset: 0x%4.4x", bt_get_le16(frame->data + 2));
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
 }
 
 static void att_read_blob_rsp(const struct l2cap_frame *frame)
@@ -1993,7 +1993,7 @@ static void att_read_multiple_req(const struct l2cap_frame *frame)
 
 	for (i = 0; i < count; i++)
 		print_field("Handle: 0x%4.4x",
-					bt_get_le16(frame->data + (i * 2)));
+					get_le16(frame->data + (i * 2)));
 }
 
 static void att_read_group_type_req(const struct l2cap_frame *frame)
@@ -2013,7 +2013,7 @@ static void att_read_group_type_rsp(const struct l2cap_frame *frame)
 
 static void att_write_req(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", bt_get_le16(frame->data));
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
@@ -2023,15 +2023,15 @@ static void att_write_rsp(const struct l2cap_frame *frame)
 
 static void att_prepare_write_req(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", bt_get_le16(frame->data));
-	print_field("Offset: 0x%4.4x", bt_get_le16(frame->data + 2));
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
 	print_hex_field("  Data", frame->data + 4, frame->size - 4);
 }
 
 static void att_prepare_write_rsp(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", bt_get_le16(frame->data));
-	print_field("Offset: 0x%4.4x", bt_get_le16(frame->data + 2));
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
 	print_hex_field("  Data", frame->data + 4, frame->size - 4);
 }
 
@@ -2077,7 +2077,7 @@ static void att_handle_value_conf(const struct l2cap_frame *frame)
 
 static void att_write_command(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", bt_get_le16(frame->data));
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 83dafe2..73c804a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1916,7 +1916,7 @@ static void print_flow_spec(const char *label, const uint8_t *data)
 
 	print_field("%s flow spec: 0x%2.2x", label, data[0]);
 	print_field("  Service type: %s (0x%2.2x)", str, data[1]);
-	print_field("  Maximum SDU size: 0x%4.4x", bt_get_le16(data + 2));
+	print_field("  Maximum SDU size: 0x%4.4x", get_le16(data + 2));
 	print_field("  SDU inter-arrival time: 0x%8.8x", bt_get_le32(data + 4));
 	print_field("  Access latency: 0x%8.8x", bt_get_le32(data + 8));
 	print_field("  Flush timeout: 0x%8.8x", bt_get_le32(data + 12));
@@ -2767,12 +2767,12 @@ static void print_manufacturer_apple(const void *data, uint8_t data_len)
 
 		uuid = data + 2;
 		print_field("  iBeacon: %8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				bt_get_le32(&uuid[12]), bt_get_le16(&uuid[10]),
-				bt_get_le16(&uuid[8]), bt_get_le16(&uuid[6]),
-				bt_get_le32(&uuid[2]), bt_get_le16(&uuid[0]));
+				bt_get_le32(&uuid[12]), get_le16(&uuid[10]),
+				get_le16(&uuid[8]), get_le16(&uuid[6]),
+				bt_get_le32(&uuid[2]), get_le16(&uuid[0]));
 
-		major = bt_get_le16(data + 18);
-		minor = bt_get_le16(data + 20);
+		major = get_le16(data + 18);
+		minor = get_le16(data + 20);
 		print_field("  Version: %u.%u", major, minor);
 
 		tx_power = *(int8_t *) (data + 22);
@@ -2786,7 +2786,7 @@ static void print_manufacturer_apple(const void *data, uint8_t data_len)
 
 static void print_manufacturer_data(const void *data, uint8_t data_len)
 {
-	uint16_t company = bt_get_le16(data);
+	uint16_t company = get_le16(data);
 
 	packet_print_company("Company", company);
 
@@ -2810,10 +2810,10 @@ static void print_device_id(const void *data, uint8_t data_len)
 	if (data_len < 8)
 		return;
 
-	source = bt_get_le16(data);
-	vendor = bt_get_le16(data + 2);
-	product = bt_get_le16(data + 4);
-	version = bt_get_le16(data + 6);
+	source = get_le16(data);
+	vendor = get_le16(data + 2);
+	product = get_le16(data + 4);
+	version = get_le16(data + 6);
 
 	switch (source) {
 	case 0x0001:
@@ -2871,7 +2871,7 @@ static void print_uuid16_list(const char *label, const void *data,
 	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
 
 	for (i = 0; i < count; i++) {
-		uint16_t uuid = bt_get_le16(data + (i * 2));
+		uint16_t uuid = get_le16(data + (i * 2));
 		print_field("  %s (0x%4.4x)", uuid16_to_str(uuid), uuid);
 	}
 }
@@ -2902,9 +2902,9 @@ static void print_uuid128_list(const char *label, const void *data,
 		const uint8_t *uuid = data + (i * 16);
 
 		print_field("  %8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				bt_get_le32(&uuid[12]), bt_get_le16(&uuid[10]),
-				bt_get_le16(&uuid[8]), bt_get_le16(&uuid[6]),
-				bt_get_le32(&uuid[2]), bt_get_le16(&uuid[0]));
+				bt_get_le32(&uuid[12]), get_le16(&uuid[10]),
+				get_le16(&uuid[8]), get_le16(&uuid[6]),
+				bt_get_le32(&uuid[2]), get_le16(&uuid[0]));
 	}
 }
 
@@ -3074,8 +3074,8 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			if (data_len < 4)
 				break;
 			print_field("Slave Conn. Interval: 0x%4.4x - 0x%4.4x",
-							bt_get_le16(&data[0]),
-							bt_get_le16(&data[2]));
+							get_le16(&data[0]),
+							get_le16(&data[2]));
 			break;
 
 		case BT_EIR_SERVICE_UUID16:
@@ -3096,7 +3096,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			if (data_len < 2)
 				break;
 			sprintf(label, "Service Data (UUID 0x%4.4x)",
-							bt_get_le16(&data[0]));
+							get_le16(&data[0]));
 			print_hex_field(label, &data[2], data_len - 2);
 			break;
 
@@ -3115,7 +3115,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 		case BT_EIR_GAP_APPEARANCE:
 			if (data_len < 2)
 				break;
-			print_appearance(bt_get_le16(data));
+			print_appearance(get_le16(data));
 			break;
 
 		case BT_EIR_SSP_HASH_P256:
diff --git a/src/eir.c b/src/eir.c
index be83718..62e91ac 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -65,7 +65,7 @@ static void eir_parse_uuid16(struct eir_data *eir, const void *data,
 
 	service.type = SDP_UUID16;
 	for (i = 0; i < len / 2; i++, uuid16++) {
-		service.value.uuid16 = bt_get_le16(uuid16);
+		service.value.uuid16 = get_le16(uuid16);
 
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
@@ -216,7 +216,7 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 		case EIR_GAP_APPEARANCE:
 			if (data_len < 2)
 				break;
-			eir->appearance = bt_get_le16(data);
+			eir->appearance = get_le16(data);
 			break;
 
 		case EIR_SSP_HASH:
@@ -252,7 +252,7 @@ int eir_parse_oob(struct eir_data *eir, uint8_t *eir_data, uint16_t eir_len)
 	if (eir_len < EIR_OOB_MIN)
 		return -1;
 
-	if (eir_len != bt_get_le16(eir_data))
+	if (eir_len != get_le16(eir_data))
 		return -1;
 
 	eir_data += sizeof(uint16_t);
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9a5e971..e8552e2 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -191,7 +191,7 @@ static void connected(uint16_t index, uint16_t len, const void *param,
 		return;
 	}
 
-	eir_len = bt_get_le16(&ev->eir_len);
+	eir_len = get_le16(&ev->eir_len);
 	if (len != sizeof(*ev) + eir_len) {
 		fprintf(stderr, "Invalid connected event length "
 			"(%u bytes, eir_len %u bytes)\n", len, eir_len);
@@ -358,7 +358,7 @@ static void device_found(uint16_t index, uint16_t len, const void *param,
 
 	flags = btohl(ev->flags);
 
-	eir_len = bt_get_le16(&ev->eir_len);
+	eir_len = get_le16(&ev->eir_len);
 	if (len != sizeof(*ev) + eir_len) {
 		fprintf(stderr, "dev_found: expected %zu bytes, got %u bytes\n",
 						sizeof(*ev) + eir_len, len);
@@ -615,7 +615,7 @@ static void version_rsp(uint8_t status, uint16_t len, const void *param,
 	}
 
 	printf("MGMT Version %u, revision %u\n", rp->version,
-						bt_get_le16(&rp->revision));
+						get_le16(&rp->revision));
 
 done:
 	mainloop_quit();
@@ -651,8 +651,8 @@ static void commands_rsp(uint8_t status, uint16_t len, const void *param,
 		goto done;
 	}
 
-	num_commands = bt_get_le16(&rp->num_commands);
-	num_events = bt_get_le16(&rp->num_events);
+	num_commands = get_le16(&rp->num_commands);
+	num_events = get_le16(&rp->num_events);
 
 	expected_len = sizeof(*rp) + num_commands * sizeof(uint16_t) +
 						num_events * sizeof(uint16_t);
@@ -667,13 +667,13 @@ static void commands_rsp(uint8_t status, uint16_t len, const void *param,
 
 	printf("%u commands:\n", num_commands);
 	for (i = 0; i < num_commands; i++) {
-		uint16_t op = bt_get_le16(opcode++);
+		uint16_t op = get_le16(opcode++);
 		printf("\t%s (0x%04x)\n", mgmt_opstr(op), op);
 	}
 
 	printf("%u events:\n", num_events);
 	for (i = 0; i < num_events; i++) {
-		uint16_t ev = bt_get_le16(opcode++);
+		uint16_t ev = get_le16(opcode++);
 		printf("\t%s (0x%04x)\n", mgmt_evstr(ev), ev);
 	}
 
@@ -715,7 +715,7 @@ static void info_rsp(uint8_t status, uint16_t len, const void *param,
 	ba2str(&rp->bdaddr, addr);
 	printf("hci%u:\taddr %s version %u manufacturer %u"
 			" class 0x%02x%02x%02x\n", index,
-			addr, rp->version, bt_get_le16(&rp->manufacturer),
+			addr, rp->version, get_le16(&rp->manufacturer),
 			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
 
 	printf("\tsupported settings: ");
@@ -755,7 +755,7 @@ static void index_rsp(uint8_t status, uint16_t len, const void *param,
 		goto done;
 	}
 
-	count = bt_get_le16(&rp->num_controllers);
+	count = get_le16(&rp->num_controllers);
 
 	if (len < sizeof(*rp) + count * sizeof(uint16_t)) {
 		fprintf(stderr,
@@ -778,7 +778,7 @@ static void index_rsp(uint8_t status, uint16_t len, const void *param,
 		uint16_t index;
 		void *data;
 
-		index = bt_get_le16(&rp->index[i]);
+		index = get_le16(&rp->index[i]);
 
 		if (monitor)
 			printf("hci%u ", index);
@@ -1188,7 +1188,7 @@ static void con_rsp(uint8_t status, uint16_t len, const void *param,
 		goto done;
 	}
 
-	count = bt_get_le16(&rp->conn_count);
+	count = get_le16(&rp->conn_count);
 	if (len != sizeof(*rp) + count * sizeof(struct mgmt_addr_info)) {
 		fprintf(stderr, "Invalid get_connections length "
 					" (count=%u, len=%u)\n", count, len);
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 548e572..765d980 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -44,6 +44,7 @@
 #include <bluetooth/hci_lib.h>
 
 #include "src/textfile.h"
+#include "src/shared/util.h"
 #include "tools/csr.h"
 
 static struct hci_dev_info di;
@@ -1316,7 +1317,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 				printf("\t%s service classes:",
 					type == 0x02 ? "Shortened" : "Complete");
 				for (i = 0; i < (len - 1) / 2; i++) {
-					uint16_t val = bt_get_le16((ptr + (i * 2)));
+					uint16_t val = get_le16((ptr + (i * 2)));
 					printf(" 0x%4.4x", val);
 				}
 				printf("\n");
diff --git a/tools/l2test.c b/tools/l2test.c
index a9fc642..5381a50 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -919,7 +919,7 @@ static void recv_mode(int sk)
 			seq++;
 
 			/* Check length */
-			l = bt_get_le16(buf + 4);
+			l = get_le16(buf + 4);
 			if (len != l) {
 				syslog(LOG_INFO, "size missmatch: %d -> %d", len, l);
 				continue;
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 17b776d..b018e93 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -37,6 +37,7 @@
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
 #include "lib/amp.h"
+#include "src/shared/util.h"
 
 static uint16_t manufacturer = DEFAULT_COMPID;
 
@@ -792,7 +793,7 @@ static inline void ext_inquiry_data_dump(int level, struct frame *frm,
 				type == 0x02 ? "Shortened" : "Complete");
 
 		for (i = 0; i < len / 2; i++)
-			printf(" 0x%4.4x", bt_get_le16(data + i * 2));
+			printf(" 0x%4.4x", get_le16(data + i * 2));
 
 		printf("\n");
 		break;
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index f0fb78b..b6bb8be 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -39,6 +39,7 @@
 #include "lib/hci.h"
 #include "lib/a2mp.h"
 #include "lib/amp.h"
+#include "src/shared/util.h"
 
 typedef struct {
 	uint16_t handle;
@@ -250,7 +251,7 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
 	case 1:
 		return *ptr;
 	case 2:
-		return bt_get_le16(ptr);
+		return get_le16(ptr);
 	case 4:
 		return bt_get_le32(ptr);
 	}
@@ -595,9 +596,9 @@ static void conf_rfc(void *ptr, int len, int in, uint16_t handle,
 		uint16_t rto, mto, mps;
 		txwin = *((uint8_t *) (ptr + 1));
 		maxtrans = *((uint8_t *) (ptr + 2));
-		rto = bt_get_le16(ptr + 3);
-		mto = bt_get_le16(ptr + 5);
-		mps = bt_get_le16(ptr + 7);
+		rto = get_le16(ptr + 3);
+		mto = get_le16(ptr + 5);
+		mps = get_le16(ptr + 7);
 		printf(", TxWin %d, MaxTx %d, RTo %d, MTo %d, MPS %d",
 					txwin, maxtrans, rto, mto, mps);
 	}
@@ -916,7 +917,7 @@ static void l2cap_ctrl_ext_parse(int level, struct frame *frm, uint32_t ctrl)
 		printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
 			uint16_t len;
-			len = bt_get_le16(frm->ptr);
+			len = get_le16(frm->ptr);
 			frm->ptr += L2CAP_SDULEN_SIZE;
 			frm->len -= L2CAP_SDULEN_SIZE;
 			printf(" (len %d)", len);
@@ -949,7 +950,7 @@ static void l2cap_ctrl_parse(int level, struct frame *frm, uint32_t ctrl)
 		printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
 			uint16_t len;
-			len = bt_get_le16(frm->ptr);
+			len = get_le16(frm->ptr);
 			frm->ptr += L2CAP_SDULEN_SIZE;
 			frm->len -= L2CAP_SDULEN_SIZE;
 			printf(" (len %d)", len);
@@ -1062,7 +1063,7 @@ static inline void a2mp_discover_req(int level, struct frame *frm, uint16_t len)
 
 	do {
 		len -= 2;
-		mask = bt_get_le16(octet);
+		mask = get_le16(octet);
 		printf(" 0x%4.4x", mask);
 
 		extension = octet[1] & 0x80;
@@ -1102,7 +1103,7 @@ static inline void a2mp_discover_rsp(int level, struct frame *frm, uint16_t len)
 
 	do {
 		len -= 2;
-		mask = bt_get_le16(octet);
+		mask = get_le16(octet);
 		printf(" 0x%4.4x", mask);
 
 		extension = octet[1] & 0x80;
@@ -1324,7 +1325,7 @@ static void l2cap_parse(int level, struct frame *frm)
 		if (p_filter(FILT_L2CAP))
 			return;
 
-		psm = bt_get_le16(frm->ptr);
+		psm = get_le16(frm->ptr);
 		frm->ptr += 2;
 		frm->len -= 2;
 
@@ -1433,7 +1434,7 @@ static void l2cap_parse(int level, struct frame *frm)
 				frm->ptr += 2;
 				frm->len -= 4;
 			}
-			fcs = bt_get_le16(frm->ptr + frm->len);
+			fcs = get_le16(frm->ptr + frm->len);
 		}
 
 		if (!p_filter(FILT_L2CAP)) {
-- 
1.8.3.1

