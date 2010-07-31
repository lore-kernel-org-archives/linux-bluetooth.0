Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 3/6] Support for adding UUID128 to extended inquiry response
Date: Sat, 31 Jul 2010 04:45:09 -0700
Message-Id: <1280576713-1398-4-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-service.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index c20df2e..1314ada 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -49,6 +49,8 @@
 #include "manager.h"
 #include "adapter.h"
 
+#define SIZEOF_UUID128 16
+
 static sdp_record_t *server = NULL;
 
 static uint16_t did_vendor = 0x0000;
@@ -174,6 +176,62 @@ static void update_svclass_list(const bdaddr_t *src)
 
 }
 
+static void eir_generate_uuid128(sdp_list_t *list,
+					uint8_t *ptr, uint16_t *eir_len)
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
@@ -271,6 +329,10 @@ void create_ext_inquiry_response(const char *name,
 			*ptr++ = (uuid16[i] & 0xff00) >> 8;
 		}
 	}
+
+	/* Group all UUID128 types */
+	if (eir_len <= EIR_DATA_LENGTH - 2)
+		eir_generate_uuid128(services, ptr, &eir_len);
 }
 
 void register_public_browse_group(void)
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
