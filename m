Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/10] SAP: Remove not needed src field from struct sap_server
Date: Fri, 25 May 2012 16:20:59 +0200
Message-ID: <1337955662-19016-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

src is only used in sap_server_register, no need to keep in memory for
SAP session duration.
---
 sap/server.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index aedbc60..98440e8 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -72,7 +72,6 @@ struct sap_connection {
 };
 
 struct sap_server {
-	bdaddr_t src;
 	char *path;
 	uint32_t record_id;
 	GIOChannel *listen_io;
@@ -1348,7 +1347,6 @@ int sap_server_register(const char *path, bdaddr_t *src)
 		return -ENOMEM;
 	}
 
-	bacpy(&server->src, src);
 	server->path = g_strdup(path);
 
 	record = create_sap_record(SAP_SERVER_CHANNEL);
@@ -1357,7 +1355,7 @@ int sap_server_register(const char *path, bdaddr_t *src)
 		goto sdp_err;
 	}
 
-	if (add_record_to_server(&server->src, record) < 0) {
+	if (add_record_to_server(src, record) < 0) {
 		error("Adding SAP SDP record to the SDP server failed.");
 		sdp_record_free(record);
 		goto sdp_err;
@@ -1367,7 +1365,7 @@ int sap_server_register(const char *path, bdaddr_t *src)
 
 	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server,
 			NULL, &gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &server->src,
+			BT_IO_OPT_SOURCE_BDADDR, src,
 			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
 			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
 			BT_IO_OPT_MASTER, TRUE,
-- 
on behalf of ST-Ericsson

