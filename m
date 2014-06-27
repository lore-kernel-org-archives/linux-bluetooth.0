Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 03/10] android/health: Add handling MDL connection request
Date: Fri, 27 Jun 2014 18:16:04 +0300
Message-Id: <1403882171-16308-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handles MDL connection request for ECHO service
---
 android/health.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 9857240..fd79ce7 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1110,7 +1110,38 @@ static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
-	DBG("Not Implemeneted");
+	GError *gerr = NULL;
+
+	DBG("Data channel request: mdepid %u mdlid %u", mdepid, mdlid);
+
+	/* TODO: find / create device */
+
+	if (mdepid == MDEP_ECHO) {
+		switch (*conf) {
+		case CHANNEL_TYPE_ANY:
+			*conf = CHANNEL_TYPE_RELIABLE;
+		case CHANNEL_TYPE_RELIABLE:
+			break;
+		case CHANNEL_TYPE_STREAM:
+			return MCAP_CONFIGURATION_REJECTED;
+		default:
+			/* Special case defined in HDP spec 3.4. When an invalid
+			* configuration is received we shall close the MCL when
+			* we are still processing the callback. */
+			/* TODO close device */
+			return MCAP_CONFIGURATION_REJECTED; /* not processed */
+		}
+
+		if (!mcap_set_data_chan_mode(mcap, L2CAP_MODE_ERTM, &gerr)) {
+			error("Error: %s", gerr->message);
+			g_error_free(gerr);
+			return MCAP_MDL_BUSY;
+		}
+
+		/* TODO: Create channel */
+
+		return MCAP_SUCCESS;
+	}
 
 	return MCAP_SUCCESS;
 }
-- 
1.8.3.2

