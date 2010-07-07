Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	rshaffer@codeaurora.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 1/3] Support for adding UUID128 to extended inquiry response
Date: Wed,  7 Jul 2010 15:08:36 -0700
Message-Id: <1278540518-18620-2-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-service.c |  108 ++++++++++++++++++++++++++++++++++++++++++++--------
 src/sdpd.h         |   12 ++++++
 2 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index cdbb4f4..1bb79a7 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2002-2003  Stephen Crane <steve.crane@rococosoft.com>
+ *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -49,6 +50,8 @@
 #include "manager.h"
 #include "adapter.h"
 
+#define SIZEOF_UUID128 16
+
 static sdp_record_t *server = NULL;
 
 static uint16_t did_vendor = 0x0000;
@@ -174,41 +177,102 @@ static void update_svclass_list(const bdaddr_t *src)
 
 }
 
+static void eir_generate_uuid128(sdp_list_t *list, uint8_t *ptr, uint16_t *eir_len)
+{
+	int i, k, index = 0;
+	uint16_t len = *eir_len;
+	uint8_t *uuid128;
+	gboolean truncated = FALSE;
+
+	/* Store UUID128 in place, skip 2 bytes to insert type and length later */
+	uuid128 = ptr + 2;
+
+	for (; list; list = list->next) {
+		sdp_record_t *rec = (sdp_record_t *) list->data;
+
+		if (rec->svclass.type != SDP_UUID128)
+			continue;
+
+		/* Stop if not enough space to put next UUID128 */
+		if ((len + 2 + SIZEOF_UUID128) > EIR_DATA_LENGTH) {
+			truncated = TRUE;
+			break;
+		}
+
+		/* Check for duplicates, EIR data is Little Endian */
+		for (i = 0; i < index; i++) {
+			for (k = 0; k < SIZEOF_UUID128; k++) {
+				if (uuid128[i*SIZEOF_UUID128 + k] !=
+					rec->svclass.value.uuid128.data[SIZEOF_UUID128 - k])
+					break;
+			}
+			if (k == SIZEOF_UUID128)
+				break;
+		}
+
+		if (i < index)
+			continue;
+
+		/* EIR data is Little Endian */
+		for (k = 0; k < SIZEOF_UUID128; k++)
+			uuid128[index*SIZEOF_UUID128 + k] =
+				rec->svclass.value.uuid128.data[SIZEOF_UUID128 - 1 - k];
+
+		len += SIZEOF_UUID128;
+		index++;
+	}
+
+	if (index > 0 || truncated) {
+		/* EIR Data length */
+		ptr[0] = (index * SIZEOF_UUID128) + 1;
+		/* EIR Data type */
+		ptr[1] = (truncated) ? EIR_UUID128_SOME : EIR_UUID128_ALL;
+		len += 2;
+		*eir_len = len;
+	}
+}
+
 void create_ext_inquiry_response(const char *name,
 					int8_t tx_power, sdp_list_t *services,
 					uint8_t *data)
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
@@ -217,10 +281,10 @@ void create_ext_inquiry_response(const char *name,
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
 
@@ -233,30 +297,42 @@ void create_ext_inquiry_response(const char *name,
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
+
+	/* Group all UUID128 types */
+	if (eir_len <= EIR_DATA_LENGTH - 2)
+		eir_generate_uuid128(services, ptr, &eir_len);
 }
 
 void register_public_browse_group(void)
diff --git a/src/sdpd.h b/src/sdpd.h
index e93b0b6..8fd8bbe 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -6,6 +6,7 @@
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2002-2003  Stephen Crane <steve.crane@rococosoft.com>
+ *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -34,6 +35,17 @@
 #define SDPDBG(fmt...)
 #endif
 
+#define EIR_DATA_LENGTH  240
+
+#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
+#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT              0x08  /* shortened local name */
+#define EIR_NAME_COMPLETE           0x09  /* complete local name */
+#define EIR_DEVICE_ID               0x10  /* device ID */
+#define EIR_TX_POWER                0x0A  /* Transmit power level */
+
 typedef struct request {
 	bdaddr_t device;
 	bdaddr_t bdaddr;
-- 
1.7.1

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
