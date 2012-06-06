Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/17] SAP: Use proper type instead of *void for  disconnect_ind param
Date: Wed, 6 Jun 2012 15:19:18 +0200
Message-ID: <1338988767-19467-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use struct sap_connection as parameter type for clarity.
---
 sap/server.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index c385baa..bc466d0 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -264,9 +264,8 @@ static int send_message(struct sap_connection *conn, void *buf, size_t size)
 	return written;
 }
 
-static int disconnect_ind(void *sap_device, uint8_t disc_type)
+static int disconnect_ind(struct sap_connection *conn, uint8_t disc_type)
 {
-	struct sap_connection *conn = sap_device;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
@@ -284,7 +283,7 @@ static int disconnect_ind(void *sap_device, uint8_t disc_type)
 	*param->val = disc_type;
 	size += PARAMETER_SIZE(SAP_PARAM_ID_DISCONNECT_IND_LEN);
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 static void connect_req(struct sap_connection *conn,
-- 
on behalf of ST-Ericsson

