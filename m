Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/5] monitor: Add basic decoding for Mesh Data
Date: Fri, 21 Jul 2017 13:59:19 +0300
Message-Id: <20170721105919.7777-5-luiz.dentz@gmail.com>
In-Reply-To: <20170721105919.7777-1-luiz.dentz@gmail.com>
References: <20170721105919.7777-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds basic decoding for Mesh Data packets such as:

> HCI Event: LE Meta Event (0x3e) plen 43
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 29:3C:CE:85:C7:3D (Non-Resolvable)
        Data length: 31
        Mesh Data: 37cb3a2bdfca0783b10833cfbdc9e691b0d58b2dada00269181477c901
          IV: 1
          NID: 0x1b
        RSSI: -28 dBm (0xe4)
---
 monitor/packet.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d016400..387be1d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3672,6 +3672,18 @@ static void print_mesh_prov(const uint8_t *data, uint8_t len)
 	}
 }
 
+static void print_mesh_data(const uint8_t *data, uint8_t len)
+{
+	print_hex_field("Mesh Data", data, len);
+
+	if (len < 1)
+		return;
+
+	print_field("  IV: %u", data[0] & 0x01);
+	print_field("  NID: 0x%2.2x", data[0] & 0xfe);
+	packet_hexdump(data + 1, len - 1);
+}
+
 static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 {
 	uint16_t len = 0;
@@ -3897,7 +3909,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			break;
 
 		case BT_EIR_MESH_DATA:
-			print_hex_field("Mesh Data", data, data_len);
+			print_mesh_data(data, data_len);
 			break;
 
 		case BT_EIR_MESH_PROV:
-- 
2.9.4

