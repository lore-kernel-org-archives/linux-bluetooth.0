Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Improbe decoding of ATT Read by Group Type Respose
Date: Sun, 24 May 2015 16:15:11 +0300
Message-Id: <1432473311-16657-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The group data is as follow:

Attribute Handle (2 octets) End Group Handle (2 octets) Attribute Value
(Length - 4) octets

But since only primary and secondary can be used in ATT Read by Group
Type Request the value is garanteed to be a UUID:

< ACL Data TX: Handle 3585 flags 0x00 dlen 24
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x000d
        UUID: Heart Rate (0x180d)
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
---
 monitor/l2cap.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 55efa54..409f5f4 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2217,12 +2217,35 @@ static void att_read_group_type_req(const struct l2cap_frame *frame)
 	print_uuid("Attribute group type", frame->data + 4, frame->size - 4);
 }
 
+static void print_group_list(const char *label, uint8_t length,
+					const void *data, uint16_t size)
+{
+	uint8_t count;
+
+	if (length == 0)
+		return;
+
+	count = size / length;
+
+	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
+
+	while (size >= length) {
+		print_handle_range("Handle range", data);
+		print_uuid("UUID", data + 4, length - 4);
+
+		data += length;
+		size -= length;
+	}
+
+	packet_hexdump(data, size);
+}
+
 static void att_read_group_type_rsp(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
 
 	print_field("Attribute data length: %d", pdu->length);
-	print_data_list("Attribute data list", pdu->length,
+	print_group_list("Attribute group list", pdu->length,
 					frame->data + 1, frame->size - 1);
 }
 
-- 
2.1.0

