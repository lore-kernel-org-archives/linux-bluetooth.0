Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/7] monitor: Add support for Transport Discovery AD
Date: Wed, 18 Apr 2018 14:05:01 +0300
Message-Id: <20180418110502.13099-6-luiz.dentz@gmail.com>
In-Reply-To: <20180418110502.13099-1-luiz.dentz@gmail.com>
References: <20180418110502.13099-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding Transport Discovery Data:

@ MGMT Command: Add Advertising (0x003e) plen 16
        Instance: 1
        Flags: 0x00000001
          Switch into Connectable mode
        Duration: 0
        Timeout: 0
        Advertising data length: 5
        Transport Discovery Data
          Organization: Bluetooth SIG (0x01)
          Flags: 0x01
            Role: 0x01
              Seeker Only
            Transport Data Incomplete: False (0x00)
            Transport State: 0x00
              Off
          Length: 0
          Data:
        Scan response length: 0
---
 monitor/packet.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b800a2d75..c00e9efa4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3545,6 +3545,57 @@ static void print_mesh_data(const uint8_t *data, uint8_t len)
 	packet_hexdump(data + 1, len - 1);
 }
 
+static void print_transport_data(const uint8_t *data, uint8_t len)
+{
+	print_field("Transport Discovery Data");
+
+	if (len < 3)
+		return;
+
+	print_field("  Organization: %s (0x%02x)",
+			data[0] == 0x01 ? "Bluetooth SIG" : "RFU", data[0]);
+	print_field("  Flags: 0x%2.2x", data[1]);
+	print_field("    Role: 0x%2.2x", data[1] & 0x03);
+
+	switch (data[1] & 0x03) {
+	case 0x00:
+		print_field("      Not Specified");
+		break;
+	case 0x01:
+		print_field("      Seeker Only");
+		break;
+	case 0x02:
+		print_field("      Provider Only");
+		break;
+	case 0x03:
+		print_field("      Both Seeker an Provider");
+		break;
+	}
+
+	print_field("    Transport Data Incomplete: %s (0x%2.2x)",
+			data[1] & 0x04 ? "True" : "False", data[1] & 0x04);
+
+	print_field("    Transport State: 0x%2.2x", data[1] & 0x18);
+
+	switch (data[1] & 0x18) {
+	case 0x00:
+		print_field("      Off");
+		break;
+	case 0x08:
+		print_field("      On");
+		break;
+	case 0x10:
+		print_field("      Temporary Unavailable");
+		break;
+	case 0x18:
+		print_field("      RFU");
+		break;
+	}
+
+	print_field("  Length: %u", data[2]);
+	print_hex_field("  Data", data + 3, len - 3);
+}
+
 static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 {
 	uint16_t len = 0;
@@ -3744,6 +3795,10 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_randomizer_p256(data);
 			break;
 
+		case BT_EIR_TRANSPORT_DISCOVERY:
+			print_transport_data(data, data_len);
+			break;
+
 		case BT_EIR_3D_INFO_DATA:
 			print_hex_field("3D Information Data", data, data_len);
 			if (data_len < 2)
-- 
2.14.3

