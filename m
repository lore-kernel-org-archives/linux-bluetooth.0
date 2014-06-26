Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] android/health: Add handling MDL connection request
Date: Thu, 26 Jun 2014 15:04:18 +0300
Message-Id: <1403784265-1455-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index de67475..dd2e5af 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1101,7 +1101,38 @@ static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 static void mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
-	DBG("Not Implemeneted");
+	GError *gerr = NULL;
+
+	DBG("Data channel request: mdepid %u mdlid %u", mdepid, mdlid);
+
+	/* TODO: find / create device */
+
+	if (mdepid == HDP_MDEP_ECHO) {
+		switch (*conf) {
+		case HDP_NO_PREFERENCE_DC:
+			*conf = HDP_RELIABLE_DC;
+		case HDP_RELIABLE_DC:
+			break;
+		case HDP_STREAMING_DC:
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
 }
 
 static void mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
-- 
1.8.3.2

