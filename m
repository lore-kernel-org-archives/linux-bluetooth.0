Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] monitor: Add basic decoding for Mesh Provisioning
Date: Tue, 18 Jul 2017 19:46:25 +0300
Message-Id: <20170718164627.20114-5-luiz.dentz@gmail.com>
In-Reply-To: <20170718164627.20114-1-luiz.dentz@gmail.com>
References: <20170718164627.20114-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds basic decoding for Mesh Provisioning packets such as:

< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
        Length: 24
        Mesh Provision: 024874cb0003dddd0000000000000000000000000000
          Link ID: 0x024874cb
          Transaction Number: 0
          Provisioning Bearer Control (0x03)
          Link Open (0x00)
          Device UUID: 03dddd00000000000000000000000000

> HCI Event: LE Meta Event (0x3e) plen 20
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 34:11:85:DC:41:39 (Non-Resolvable)
        Data length: 8
        Mesh Provision: 024874cb0007
          Link ID: 0x024874cb
          Transaction Number: 0
          Provisioning Bearer Control (0x03)
          Link Ack (0x01)
        RSSI: -28 dBm (0xe4)
---
 monitor/packet.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 3e6382e..9655dca 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3581,6 +3581,72 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
 	}
 }
 
+static void print_mesh_prov(const uint8_t *data, uint8_t len)
+{
+	if (len < 6)
+		return;
+
+	print_field("  Link ID: 0x%08x", get_be32(&data[0]));
+	print_field("  Transaction Number: %u", data[4]);
+
+	data += 5;
+	len -= 5;
+
+	switch (data[0] & 0x03) {
+	case 0x00:
+		print_field("  Transaction Start (0x00)");
+		if (len < 5)
+			return;
+		print_field("  SeqN: %u", data[0] & 0xfc >> 2);
+		print_field("  TotalLength: %u", get_be16(&data[1]));
+		print_field("  FCS: 0x%2.2x", data[3]);
+		print_hex_field("  Data", data, len - 4);
+		break;
+	case 0x01:
+		print_field("  Transaction Acknowledgment (0x01)");
+		break;
+	case 0x02:
+		print_field("  Transaction Continuation (0x02)");
+		print_field("  SegmentIndex: %u", data[0] >> 2);
+		print_hex_field("  Data", &data[1], len - 1);
+		break;
+	case 0x03:
+		print_field("  Provisioning Bearer Control (0x03)");
+		switch (data[0] >> 2) {
+		case 0x00:
+			print_field("  Link Open (0x00)");
+			if (len < 17)
+				break;
+			print_hex_field("  Device UUID", data, 16);
+			break;
+		case 0x01:
+			print_field("  Link Ack (0x01)");
+			break;
+		case 0x02:
+			print_field("  Link Close (0x02)");
+			if (len < 2)
+				break;
+
+			switch (data[1]) {
+			case 0x00:
+				print_field("  Reason: Success (0x00)");
+				break;
+			case 0x01:
+				print_field("  Reason: Timeout (0x01)");
+				break;
+			case 0x02:
+				print_field("  Reason: Fail (0x02)");
+				break;
+			default:
+				print_field("  Reason: Unrecognized (0x%2.2x)",
+								data[1]);
+			}
+			break;
+		}
+		break;
+	}
+}
+
 static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 {
 	uint16_t len = 0;
@@ -3811,6 +3877,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 
 		case BT_EIR_MESH_PROV:
 			print_hex_field("Mesh Provisioning", data, data_len);
+			print_mesh_prov(data, data_len);
 			break;
 
 		case BT_EIR_MESH_BEACON:
-- 
2.9.4

