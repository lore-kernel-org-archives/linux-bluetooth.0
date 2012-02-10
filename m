Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 15/22] sap: Fix compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:40:00 -0300
Message-Id: <1328910007-25604-16-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/server.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index b8aa8a5..5497045 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -310,7 +310,7 @@ static int disconnect_ind(void *sap_device, uint8_t disc_type)
 static void connect_req(struct sap_connection *conn,
 				struct sap_parameter *param)
 {
-	uint16_t maxmsgsize, *val;
+	uint16_t maxmsgsize;
 
 	DBG("conn %p state %d", conn, conn->state);
 
@@ -322,8 +322,7 @@ static void connect_req(struct sap_connection *conn,
 
 	stop_guard_timer(conn);
 
-	val = (uint16_t *) &param->val;
-	maxmsgsize = ntohs(*val);
+	maxmsgsize = bt_get_be16(&param->val);
 
 	DBG("Connect MaxMsgSize: 0x%04x", maxmsgsize);
 
@@ -645,14 +644,11 @@ int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
 
 	/* Add MaxMsgSize */
 	if (maxmsgsize) {
-		uint16_t *len;
-
 		msg->nparam++;
 		param = (struct sap_parameter *) &buf[size];
 		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
 		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
-		len = (uint16_t *) &param->val;
-		*len = htons(maxmsgsize);
+		bt_put_be16(maxmsgsize, &param->val);
 		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
 	}
 
-- 
1.7.8.1

