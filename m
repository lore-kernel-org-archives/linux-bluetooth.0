Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 05/22] sap: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:39:50 -0300
Message-Id: <1328910007-25604-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/sap-u8500.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sap/sap-u8500.c b/sap/sap-u8500.c
index ef7d95c..9949504 100644
--- a/sap/sap-u8500.c
+++ b/sap/sap-u8500.c
@@ -32,6 +32,8 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
+#include <bluetooth/bluetooth.h>
+
 #include "log.h"
 #include "sap.h"
 
@@ -319,16 +321,16 @@ static void recv_status(uint32_t status)
 
 static void recv_card_status(uint32_t status, uint8_t *param)
 {
-	uint32_t *card_status;
+	uint32_t card_status;
 	uint8_t result;
 	uint8_t iccrs;
 
 	if (status != STE_STATUS_OK)
 		return;
 
-	card_status = (uint32_t *)param;
+	card_status = bt_get_h32(param);
 
-	if (get_sap_reader_status(*card_status, &iccrs) < 0)
+	if (get_sap_reader_status(card_status, &iccrs) < 0)
 		result = SAP_RESULT_ERROR_NO_REASON;
 	else
 		result = get_sap_result(STE_GET_STATUS_MSG, status);
@@ -430,7 +432,7 @@ static void recv_response(struct ste_message *msg)
 	}
 
 	param = msg->payload;
-	status = *(uint32_t *)param;
+	status = bt_get_h32(param);
 	param += sizeof(status);
 
 	DBG_VERBOSE("status 0x%x", status);
-- 
1.7.8.1

