Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 02/12] android/health: Fix wrong callback return type
Date: Fri, 27 Jun 2014 14:24:53 +0300
Message-Id: <1403868303-8129-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index de67475..140afee 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1098,15 +1098,19 @@ static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
 	DBG("Not Implemeneted");
 }
 
-static void mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
+static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
 	DBG("Not Implemeneted");
+
+	return MCAP_SUCCESS;
 }
 
-static void mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
+static uint8_t mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 {
 	DBG("Not Implemeneted");
+
+	return MCAP_SUCCESS;
 }
 
 static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
-- 
1.8.3.2

