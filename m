Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/17] sap-dummy: Use switch insted of if-else where applicable
Date: Wed, 6 Jun 2012 15:19:11 +0200
Message-ID: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This improves readiblity of what actions are performed on each state.
---
 sap/sap-dummy.c |   80 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 7ea4e92..b840946 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -105,18 +105,24 @@ void sap_transfer_apdu_req(void *sap_device, struct sap_parameter *param)
 
 	DBG("status: %d", sim_card_conn_status);
 
-	if (sim_card_conn_status == SIM_MISSING)
+	switch (sim_card_conn_status) {
+	case SIM_MISSING:
 		sap_transfer_apdu_rsp(sap_device,
 				SAP_RESULT_ERROR_CARD_REMOVED, NULL, 0);
-	else if (sim_card_conn_status == SIM_POWERED_OFF)
+		break;
+	case SIM_POWERED_OFF:
 		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF,
 								NULL, 0);
-	else if (sim_card_conn_status != SIM_CONNECTED)
+		break;
+	case SIM_DISCONNECTED:
 		sap_transfer_apdu_rsp(sap_device,
-			SAP_RESULT_ERROR_NOT_ACCESSIBLE, NULL, 0);
-	else
+				SAP_RESULT_ERROR_NOT_ACCESSIBLE, NULL, 0);
+		break;
+	case SIM_CONNECTED:
 		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK,
-						(uint8_t *)&apdu, sizeof(apdu));
+						(uint8_t *)apdu, sizeof(apdu));
+		break;
+	}
 }
 
 void sap_transfer_atr_req(void *sap_device)
@@ -125,36 +131,46 @@ void sap_transfer_atr_req(void *sap_device)
 
 	DBG("status: %d", sim_card_conn_status);
 
-	if (sim_card_conn_status == SIM_MISSING)
+	switch (sim_card_conn_status) {
+	case SIM_MISSING:
 		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED,
 								NULL, 0);
-	else if (sim_card_conn_status == SIM_POWERED_OFF)
+		break;
+	case SIM_POWERED_OFF:
 		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF,
 								NULL, 0);
-	else if (sim_card_conn_status != SIM_CONNECTED)
+		break;
+	case SIM_DISCONNECTED:
 		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON,
 								NULL, 0);
-	else
+		break;
+	case SIM_CONNECTED:
 		sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK,
-						(uint8_t *)&atr, sizeof(atr));
+						(uint8_t *)atr, sizeof(atr));
+		break;
+	}
 }
 
 void sap_power_sim_off_req(void *sap_device)
 {
 	DBG("status: %d", sim_card_conn_status);
 
-	if (sim_card_conn_status == SIM_MISSING) {
+	switch (sim_card_conn_status) {
+	case SIM_MISSING:
 		sap_power_sim_off_rsp(sap_device,
 					SAP_RESULT_ERROR_CARD_REMOVED);
-	} else if (sim_card_conn_status == SIM_POWERED_OFF) {
+		break;
+	case SIM_POWERED_OFF:
 		sap_power_sim_off_rsp(sap_device,
 					SAP_RESULT_ERROR_POWERED_OFF);
-	} else if (sim_card_conn_status != SIM_CONNECTED) {
-		sap_power_sim_off_rsp(sap_device,
-					SAP_RESULT_ERROR_NO_REASON);
-	} else {
+		break;
+	case SIM_DISCONNECTED:
+		sap_power_sim_off_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
+		break;
+	case SIM_CONNECTED:
 		sap_power_sim_off_rsp(sap_device, SAP_RESULT_OK);
 		sim_card_conn_status = SIM_POWERED_OFF;
+		break;
 	}
 }
 
@@ -162,19 +178,22 @@ void sap_power_sim_on_req(void *sap_device)
 {
 	DBG("status: %d", sim_card_conn_status);
 
-	if (sim_card_conn_status == SIM_MISSING) {
+	switch (sim_card_conn_status) {
+	case SIM_MISSING:
 		sap_power_sim_on_rsp(sap_device,
 					SAP_RESULT_ERROR_CARD_REMOVED);
-	} else if (sim_card_conn_status == SIM_POWERED_OFF) {
+		break;
+	case SIM_POWERED_OFF:
 		sap_power_sim_on_rsp(sap_device, SAP_RESULT_OK);
 		sim_card_conn_status = SIM_CONNECTED;
-		return;
-	} else if (sim_card_conn_status != SIM_CONNECTED) {
+		break;
+	case SIM_DISCONNECTED:
 		sap_power_sim_on_rsp(sap_device,
 					SAP_RESULT_ERROR_NOT_ACCESSIBLE);
-	} else {
-		sap_power_sim_on_rsp(sap_device,
-					SAP_RESULT_ERROR_NO_REASON);
+		break;
+	case SIM_CONNECTED:
+		sap_power_sim_on_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
+		break;
 	}
 }
 
@@ -182,14 +201,19 @@ void sap_reset_sim_req(void *sap_device)
 {
 	DBG("status: %d", sim_card_conn_status);
 
-	if (sim_card_conn_status == SIM_MISSING) {
+	switch (sim_card_conn_status) {
+	case SIM_MISSING:
 		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED);
-	} else if (sim_card_conn_status == SIM_POWERED_OFF) {
+		break;
+	case SIM_POWERED_OFF:
 		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF);
-	} else if (sim_card_conn_status != SIM_CONNECTED) {
+		break;
+	case SIM_DISCONNECTED:
 		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
-	} else {
+		break;
+	case SIM_CONNECTED:
 		sap_reset_sim_rsp(sap_device, SAP_RESULT_OK);
+		break;
 	}
 }
 
-- 
on behalf of ST-Ericsson

