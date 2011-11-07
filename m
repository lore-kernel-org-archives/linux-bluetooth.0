Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <henrik.possung@stericsson.com>, <ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/4] SAP: Fix for connect response
Date: Mon, 7 Nov 2011 15:56:55 +0100
Message-ID: <1320677816-32260-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Max Message size shall be added to connect
response when ConnectionStatus is
SAP_STATUS_OK_ONGOING_CALL.
Let's always attach maxmsgsize to the connect 
response if it is provided by the backend.

Change-Id: I6c2b387f5f8e636620ed1f7e11ee2e7bbfe20a1d
---
 sap/server.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 8bd8fe1..06a4361 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -630,8 +630,7 @@ int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
 	size += PARAMETER_SIZE(SAP_PARAM_ID_CONN_STATUS_LEN);
 
 	/* Add MaxMsgSize */
-	if (maxmsgsize && (status == SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED ||
-				status == SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL)) {
+	if (maxmsgsize) {
 		uint16_t *len;
 
 		msg->nparam++;
-- 
on behalf of ST-Ericsson

