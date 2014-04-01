Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] tools/btmgmt: Print AD flags for LE devices
Date: Tue,  1 Apr 2014 15:29:45 +0200
Message-Id: <1396358985-16211-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is usefull for GAP qualification tests.
---
 tools/btmgmt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index adb5747..50c00b5 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -342,6 +342,34 @@ static char *eir_get_name(const uint8_t *eir, uint16_t eir_len)
 	return NULL;
 }
 
+static unsigned int eir_get_flags(const uint8_t *eir, uint16_t eir_len)
+{
+	uint8_t parsed = 0;
+
+	if (eir_len < 2)
+		return 0;
+
+	while (parsed < eir_len - 1) {
+		uint8_t field_len = eir[0];
+
+		if (field_len == 0)
+			break;
+
+		parsed += field_len + 1;
+
+		if (parsed > eir_len)
+			break;
+
+		/* Check for short of complete name */
+		if (eir[1] == 0x01)
+			return eir[2];
+
+		eir += field_len + 1;
+	}
+
+	return 0;
+}
+
 static void device_found(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -373,6 +401,10 @@ static void device_found(uint16_t index, uint16_t len, const void *param,
 			"flags 0x%04x ", index, addr,
 			typestr(ev->addr.type), ev->rssi, flags);
 
+		if (ev->addr.type != BDADDR_BREDR)
+			printf("AD flags 0x%02x ",
+					eir_get_flags(ev->eir, eir_len));
+
 		name = eir_get_name(ev->eir, eir_len);
 		if (name)
 			printf("name %s\n", name);
-- 
1.9.1

