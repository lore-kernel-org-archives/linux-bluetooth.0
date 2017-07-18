Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] monitor: Add basic decoding for Mesh Data
Date: Tue, 18 Jul 2017 19:46:26 +0300
Message-Id: <20170718164627.20114-6-luiz.dentz@gmail.com>
In-Reply-To: <20170718164627.20114-1-luiz.dentz@gmail.com>
References: <20170718164627.20114-1-luiz.dentz@gmail.com>
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
 monitor/packet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 9655dca..678d7a7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3647,6 +3647,15 @@ static void print_mesh_prov(const uint8_t *data, uint8_t len)
 	}
 }
 
+static void print_mesh_data(const uint8_t *data, uint8_t len)
+{
+	if (len < 1)
+		return;
+
+	print_field("  IV: %u", data[0] & 0x01);
+	print_field("  NID: 0x%2.2x", data[0] & 0xfe);
+}
+
 static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 {
 	uint16_t len = 0;
@@ -3873,6 +3882,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 
 		case BT_EIR_MESH_DATA:
 			print_hex_field("Mesh Data", data, data_len);
+			print_mesh_data(data, data_len);
 			break;
 
 		case BT_EIR_MESH_PROV:
-- 
2.9.4

