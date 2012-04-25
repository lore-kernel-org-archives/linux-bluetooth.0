Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <vishal.agarwal@stericsson.com>
Subject: [PATCH] Bluetooth: eir_append_data should take care of padding
Date: Wed, 25 Apr 2012 13:21:51 +0530
Message-ID: <1335340311-25057-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EIR data received from controller might contain padding zeros.
In this case data should be appended in the starting of padding
instead of at the end of padding. Data added after the padding will
be discarded by user space.

Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 include/net/bluetooth/hci_core.h |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ef6e654..9e42e2b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -938,11 +938,24 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 				  u8 data_len)
 {
-	eir[eir_len++] = sizeof(type) + data_len;
-	eir[eir_len++] = type;
-	memcpy(&eir[eir_len], data, data_len);
-	eir_len += data_len;
+	u8 field_len;
+	size_t parsed = 0;
+
+	while (parsed < eir_len - 1) {
+		field_len = eir[0];
 
+		if (field_len == 0) {
+			eir[0] = sizeof(type) + data_len;
+			eir[1] = type;
+			memcpy(&eir[2], data, data_len);
+			/* data_len + 1 byte for size + 1 byte for type */
+			eir_len = parsed + data_len + 2;
+			break;
+		}
+
+		parsed += field_len + 1;
+		eir += field_len + 1;
+	}
 	return eir_len;
 }
 
-- 
1.7.0.4

