Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/4] android/avrcp: Fix PDU length calculation
Date: Tue,  4 Mar 2014 21:43:23 +0100
Message-Id: <1393965804-13866-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393965804-13866-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index a763b88..e428486 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -167,25 +167,28 @@ static void handle_get_player_values_text(const void *buf, uint16_t len)
 			HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT, HAL_STATUS_FAILED);
 }
 
-static void write_element_text(uint8_t id, uint8_t text_len, uint8_t *text,
-						uint8_t *pdu, size_t *len)
+static size_t write_element_text(uint8_t id, uint8_t text_len, uint8_t *text,
+						uint8_t *pdu)
 {
 	uint16_t charset = 106;
+	size_t len = 0;
 
 	bt_put_be32(id, pdu);
 	pdu += 4;
-	*len += 4;
+	len += 4;
 
 	bt_put_be16(charset, pdu);
 	pdu += 2;
-	*len += 2;
+	len += 2;
 
 	bt_put_be16(text_len, pdu);
 	pdu += 2;
-	*len += 2;
+	len += 2;
 
 	memcpy(pdu, text, text_len);
-	*len += text_len;
+	len += text_len;
+
+	return len;
 }
 
 static void write_element_attrs(uint8_t *ptr, uint8_t number, uint8_t *pdu,
@@ -199,11 +202,13 @@ static void write_element_attrs(uint8_t *ptr, uint8_t number, uint8_t *pdu,
 
 	for (i = 0; i < number; i++) {
 		struct hal_avrcp_player_setting_text *text = (void *) ptr;
+		size_t ret;
 
-		write_element_text(text->id, text->len, text->text, pdu, len);
+		ret = write_element_text(text->id, text->len, text->text, pdu);
 
 		ptr += sizeof(*text) + text->len;
-		pdu += *len;
+		pdu += ret;
+		*len += ret;
 	}
 }
 
-- 
1.9.0

