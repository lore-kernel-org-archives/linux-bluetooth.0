Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 02/15] sap-u8500: Fix compile error due to unaligned memory access
Date: Fri, 31 Aug 2012 14:39:58 +0200
Message-ID: <1346416811-23484-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following compilation error on ARM.

  CC     profiles/sap/sap-u8500.o
profiles/sap/sap-u8500.c: In function recv_card_status:
profiles/sap/sap-u8500.c:323:16: error: cast increases required
	alignment of target type [-Werror=cast-align]
profiles/sap/sap-u8500.c: In function recv_response:
profiles/sap/sap-u8500.c:423:12: error: cast increases required
	alignment of target type [-Werror=cast-align]
cc1: all warnings being treated as errors

---
 profiles/sap/sap-u8500.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/profiles/sap/sap-u8500.c b/profiles/sap/sap-u8500.c
index f07209d..6e95d7a 100644
--- a/profiles/sap/sap-u8500.c
+++ b/profiles/sap/sap-u8500.c
@@ -32,6 +32,8 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
+#include <bluetooth/bluetooth.h>
+
 #include "log.h"
 #include "sap.h"
 
@@ -313,16 +315,16 @@ static void recv_status(uint32_t status)
 
 static void recv_card_status(uint32_t status, uint8_t *param)
 {
-	uint32_t *card_status;
+	uint32_t card_status;
 	uint8_t result;
 	uint8_t iccrs;
 
 	if (status != STE_STATUS_OK)
 		return;
 
-	card_status = (uint32_t *)param;
+	card_status = bt_get_32(param);
 
-	if (get_sap_reader_status(*card_status, &iccrs) < 0)
+	if (get_sap_reader_status(card_status, &iccrs) < 0)
 		result = SAP_RESULT_ERROR_NO_REASON;
 	else
 		result = get_sap_result(STE_GET_STATUS_MSG, status);
@@ -420,7 +422,7 @@ static void recv_response(struct ste_message *msg)
 	}
 
 	param = msg->payload;
-	status = *(uint32_t *)param;
+	status = bt_get_32(param);
 	param += sizeof(status);
 
 	SAP_VDBG("status 0x%x", status);
-- 
1.7.9.5

