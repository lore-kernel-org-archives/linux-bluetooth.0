Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 07/18] sap: Fix compilation errors due to unaligned memory access
Date: Tue, 4 Sep 2012 16:41:26 +0200
Message-ID: <1346769697-9930-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build errors on ARM.

  CC     profiles/sap/bluetoothd-server.o
profiles/sap/server.c: In function connect_req:
profiles/sap/server.c:317:8: error: cast increases required alignment
	of targettype [-Werror=cast-align]
profiles/sap/server.c: In function sap_connect_rsp:
profiles/sap/server.c:676:16: error: cast increases required alignment
	of target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [profiles/sap/bluetoothd-server.o] Error 1
make: *** [all] Error 2

---
 profiles/sap/server.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 3adbb1a..78a63bf 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -302,7 +302,7 @@ static void connect_req(struct sap_server *server,
 				struct sap_parameter *param)
 {
 	struct sap_connection *conn = server->conn;
-	uint16_t maxmsgsize, *val;
+	uint16_t maxmsgsize;
 
 	DBG("conn %p state %d", conn, conn->state);
 
@@ -314,8 +314,7 @@ static void connect_req(struct sap_server *server,
 
 	stop_guard_timer(server);
 
-	val = (uint16_t *) &param->val;
-	maxmsgsize = ntohs(*val);
+	maxmsgsize = bt_get_be16(&param->val);
 
 	DBG("Connect MaxMsgSize: 0x%04x", maxmsgsize);
 
@@ -638,7 +637,6 @@ int sap_connect_rsp(void *sap_device, uint8_t status)
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
 	size_t size = sizeof(struct sap_message);
-	uint16_t *maxmsgsize;
 
 	if (!conn)
 		return -EINVAL;
@@ -673,8 +671,7 @@ int sap_connect_rsp(void *sap_device, uint8_t status)
 		param = (struct sap_parameter *) &buf[size];
 		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
 		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
-		maxmsgsize = (uint16_t *) &param->val;
-		*maxmsgsize = htons(SAP_BUF_SIZE);
+		bt_put_be16(SAP_BUF_SIZE, &param->val);
 		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
 
 		/* fall */
-- 
1.7.9.5

