Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/5] monitor: Add AD/EIR types for mesh
Date: Fri, 21 Jul 2017 13:59:15 +0300
Message-Id: <20170721105919.7777-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print out mesh type and payload:

> HCI Event: LE Meta Event (0x3e) plen 33
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 29:D0:F2:61:17:B0 (Non-Resolvable)
        Data length: 21
        Mesh Data: 59a7ddee2e1f580463521b98c40c2a3b5086c6
        RSSI: -72 dBm (0xb8)
---
 monitor/packet.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index a3d188a..cc24165 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3259,6 +3259,9 @@ static void print_fec(uint8_t fec)
 #define BT_EIR_TRANSPORT_DISCOVERY	0x26
 #define BT_EIR_LE_SUPPORTED_FEATURES	0x27
 #define BT_EIR_CHANNEL_MAP_UPDATE_IND	0x28
+#define BT_EIR_MESH_DATA		0x29
+#define BT_EIR_MESH_PROV		0x2a
+#define BT_EIR_MESH_BEACON		0x2b
 #define BT_EIR_3D_INFO_DATA		0x3d
 #define BT_EIR_MANUFACTURER_DATA	0xff
 
@@ -3720,6 +3723,18 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_field("  Path Loss Threshold: %d", data[1]);
 			break;
 
+		case BT_EIR_MESH_DATA:
+			print_hex_field("Mesh Data", data, data_len);
+			break;
+
+		case BT_EIR_MESH_PROV:
+			print_hex_field("Mesh Provisioning", data, data_len);
+			break;
+
+		case BT_EIR_MESH_BEACON:
+			print_hex_field("Mesh Beacon", data, data_len);
+			break;
+
 		case BT_EIR_MANUFACTURER_DATA:
 			if (data_len < 2)
 				break;
-- 
2.9.4

