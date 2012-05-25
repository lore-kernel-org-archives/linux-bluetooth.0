Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/10] sap-dummy: Small refactor to sap_connect_req
Date: Fri, 25 May 2012 16:20:56 +0200
Message-ID: <1337955662-19016-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes function easier to read and more similar to rest of code.
---
 sap/sap-dummy.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 9a21779..238c5f3 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -60,26 +60,32 @@ void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
 		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED,
 								maxmsgsize);
 		return;
-	} else if (max_msg_size_supported > maxmsgsize) {
+	}
+
+	if (max_msg_size_supported > maxmsgsize) {
 		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL,
 						max_msg_size_supported);
 		return;
-	} else if (max_msg_size_supported < maxmsgsize) {
+	}
+
+	if (max_msg_size_supported < maxmsgsize) {
 		sap_connect_rsp(sap_device,
 				SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
 				max_msg_size_supported);
 		return;
-	} else if (ongoing_call_status) {
+	}
+
+	if (ongoing_call_status) {
 		sap_connect_rsp(sap_device, SAP_STATUS_OK_ONGOING_CALL,
 						max_msg_size_supported);
 		return;
-	} else {
-		sim_card_conn_status = SIM_CONNECTED;
-		sap_data = sap_device;
-
-		sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
-		sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
 	}
+
+	sim_card_conn_status = SIM_CONNECTED;
+	sap_data = sap_device;
+
+	sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
+	sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
 }
 
 void sap_disconnect_req(void *sap_device, uint8_t linkloss)
-- 
on behalf of ST-Ericsson

