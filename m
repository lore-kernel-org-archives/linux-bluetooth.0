Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 2/6] Clean up code that generates extended inquiry response.
Date: Sat, 31 Jul 2010 04:45:08 -0700
Message-Id: <1280576713-1398-3-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Minor fix when skipping duplicate UUID16 from EIR.
---
 src/sdpd-service.c |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index cdbb4f4..c20df2e 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -180,35 +180,41 @@ void create_ext_inquiry_response(const char *name,
 {
 	sdp_list_t *list = services;
 	uint8_t *ptr = data;
-	uint16_t uuid[24];
+	uint16_t eir_len = 0;
+	uint16_t uuid16[EIR_DATA_LENGTH/2];
 	int i, index = 0;
+	gboolean truncated = FALSE;
 
 	if (name) {
 		int len = strlen(name);
 
+		/* EIR Data type */
 		if (len > 48) {
 			len = 48;
-			ptr[1] = 0x08;
+			ptr[1] = EIR_NAME_SHORT;
 		} else
-			ptr[1] = 0x09;
+			ptr[1] = EIR_NAME_COMPLETE;
 
+		/* EIR Data length */
 		ptr[0] = len + 1;
 
 		memcpy(ptr + 2, name, len);
 
-		ptr += len + 2;
+		eir_len += (len + 2);
+		ptr += (len + 2);
 	}
 
 	if (tx_power != 0) {
 		*ptr++ = 2;
-		*ptr++ = 0x0a;
+		*ptr++ = EIR_TX_POWER;
 		*ptr++ = (uint8_t) tx_power;
+		eir_len += 3;
 	}
 
 	if (did_vendor != 0x0000) {
 		uint16_t source = 0x0002;
 		*ptr++ = 9;
-		*ptr++ = 0x10;
+		*ptr++ = EIR_DEVICE_ID;
 		*ptr++ = (source & 0x00ff);
 		*ptr++ = (source & 0xff00) >> 8;
 		*ptr++ = (did_vendor & 0x00ff);
@@ -217,10 +223,10 @@ void create_ext_inquiry_response(const char *name,
 		*ptr++ = (did_product & 0xff00) >> 8;
 		*ptr++ = (did_version & 0x00ff);
 		*ptr++ = (did_version & 0xff00) >> 8;
+		eir_len += 10;
 	}
 
-	ptr[1] = 0x03;
-
+	/* Group all UUID16 types */
 	for (; list; list = list->next) {
 		sdp_record_t *rec = (sdp_record_t *) list->data;
 
@@ -233,28 +239,36 @@ void create_ext_inquiry_response(const char *name,
 		if (rec->svclass.value.uuid16 == PNP_INFO_SVCLASS_ID)
 			continue;
 
-		if (index > 23) {
-			ptr[1] = 0x02;
+		/* Stop if not enough space to put next UUID16 */
+		if ((eir_len + 2 + sizeof(uint16_t)) > EIR_DATA_LENGTH) {
+			truncated = TRUE;
 			break;
 		}
 
+		/* Check for duplicates */
 		for (i = 0; i < index; i++)
-			if (uuid[i] == rec->svclass.value.uuid16)
+			if (uuid16[i] == rec->svclass.value.uuid16)
 				break;
 
-		if (i == index - 1)
+		if (i < index)
 			continue;
 
-		uuid[index++] = rec->svclass.value.uuid16;
+		uuid16[index++] = rec->svclass.value.uuid16;
+		eir_len += sizeof(uint16_t);
 	}
 
 	if (index > 0) {
-		ptr[0] = (index * 2) + 1;
+		/* EIR Data length */
+		ptr[0] = (index * sizeof(uint16_t)) + 1;
+		/* EIR Data type */
+		ptr[1] = (truncated) ? EIR_UUID16_SOME : EIR_UUID16_ALL;
+
 		ptr += 2;
+		eir_len += 2;
 
 		for (i = 0; i < index; i++) {
-			*ptr++ = (uuid[i] & 0x00ff);
-			*ptr++ = (uuid[i] & 0xff00) >> 8;
+			*ptr++ = (uuid16[i] & 0x00ff);
+			*ptr++ = (uuid16[i] & 0xff00) >> 8;
 		}
 	}
 }
-- 
1.7.2
