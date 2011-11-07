Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <henrik.possung@stericsson.com>, <ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/4] SAP: Fix handling ongoing call in sap-dummy
Date: Mon, 7 Nov 2011 15:57:20 +0100
Message-ID: <1320677840-32375-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to send sap_connect_rsp when
"call" is ended. Status Indication is enough.

Also we should provide max supported msg size in 
the connect response having status: OK_ONGOING_CALL.
---
 sap/sap-dummy.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 37982be..acdec77 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -71,7 +71,7 @@ void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
 		return;
 	} else if (ongoing_call_status) {
 		sap_connect_rsp(sap_device, SAP_STATUS_OK_ONGOING_CALL,
-								maxmsgsize);
+						max_msg_size_supported);
 		return;
 	} else {
 		sim_card_conn_status = SIM_CONNECTED;
@@ -226,8 +226,6 @@ static DBusMessage *ongoing_call(DBusConnection *conn, DBusMessage *msg,
 
 	if (ongoing_call_status && !ongoing) {
 		/* An ongoing call has finished. Continue connection.*/
-		sap_connect_rsp(sap_data, SAP_STATUS_OK,
-						max_msg_size_supported);
 		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_RESET);
 		ongoing_call_status = ongoing;
 	} else if (!ongoing_call_status && ongoing) {
-- 
on behalf of ST-Ericsson

