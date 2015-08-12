Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] tools/rctest: Fix resource leaks
Date: Wed, 12 Aug 2015 18:07:08 +0300
Message-Id: <1439392033-11822-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/rctest.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index 9169e3c..6d84e07 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -102,7 +102,7 @@ static float tv2fl(struct timeval tv)
 static uint8_t get_channel(const char *svr, uint16_t uuid)
 {
 	sdp_session_t *sdp;
-	sdp_list_t *srch, *attrs, *rsp;
+	sdp_list_t *srch, *attrs, *rsp, *protos;
 	uuid_t svclass;
 	uint16_t attr;
 	bdaddr_t dst;
@@ -128,7 +128,6 @@ static uint8_t get_channel(const char *svr, uint16_t uuid)
 
 	for (; rsp; rsp = rsp->next) {
 		sdp_record_t *rec = (sdp_record_t *) rsp->data;
-		sdp_list_t *protos;
 
 		if (!sdp_get_access_protos(rec, &protos)) {
 			channel = sdp_get_proto_port(protos, RFCOMM_UUID);
@@ -137,7 +136,11 @@ static uint8_t get_channel(const char *svr, uint16_t uuid)
 		}
 	}
 
+	sdp_list_free(protos, NULL);
+
 done:
+	sdp_list_free(srch, NULL);
+	sdp_list_free(attrs, NULL);
 	sdp_close(sdp);
 
 	return channel;
@@ -593,6 +596,7 @@ static void send_mode(int sk)
 		syslog(LOG_INFO, "Close failed: %m");
 	else
 		syslog(LOG_INFO, "Done");
+	close(sk);
 }
 
 static void reconnect_mode(char *svr)
-- 
2.4.3

