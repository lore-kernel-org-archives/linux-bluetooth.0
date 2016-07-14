Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Fix using uuid128_to_str
Date: Thu, 14 Jul 2016 13:08:30 +0300
Message-Id: <1468490911-23032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function always return "Unknown" regardless of the input, instead
uuidstr_to_str shall be used for UUID 128 bit format since it can return
proper friendly names:

> ACL Data RX: Handle 3585 flags 0x02 dlen 26
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x0001-0x0015
        UUID: Eddystone Configuration Service (a3c87500-8ed3-4bdf-8a39-a01bebede295)
---
 monitor/l2cap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 93a1b20..59a3206 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1999,6 +1999,7 @@ static void print_hex_field(const char *label, const uint8_t *data,
 static void print_uuid(const char *label, const void *data, uint16_t size)
 {
 	const char *str;
+	char uuidstr[36];
 
 	switch (size) {
 	case 2:
@@ -2010,12 +2011,12 @@ static void print_uuid(const char *label, const void *data, uint16_t size)
 		print_field("%s: %s (0x%8.8x)", label, str, get_le32(data));
 		break;
 	case 16:
-		str = uuid128_to_str(data);
-		print_field("%s: %s (%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x)",
-				label, str,
+		sprintf(uuidstr, "%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
 				get_le32(data + 12), get_le16(data + 10),
 				get_le16(data + 8), get_le16(data + 6),
 				get_le32(data + 2), get_le16(data + 0));
+		str = uuidstr_to_str(uuidstr);
+		print_field("%s: %s (%s)", label, str, uuidstr);
 		break;
 	default:
 		packet_hexdump(data, size);
-- 
2.7.4

