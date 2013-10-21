Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix not forwarding errors caused by SDP search properly
Date: Mon, 21 Oct 2013 16:04:08 +0300
Message-Id: <1382360648-5167-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case bt_search_service fails while processing (e.g. connection is
dropped) the error forward is a positive value leading
btd_service_connecting_complete to not change any state at all.

Futhermore the error from sdp_process was completely ignored which may
cause problems as well.
---
 src/sdp-client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index 2789db6..1221f5e 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -196,14 +196,15 @@ static gboolean search_process_cb(GIOChannel *chan, GIOCondition cond,
 							gpointer user_data)
 {
 	struct search_context *ctxt = user_data;
-	int err = 0;
+	int err;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
-		err = EIO;
+		err = -EIO;
 		goto failed;
 	}
 
-	if (sdp_process(ctxt->session) < 0)
+	err = sdp_process(ctxt->session);
+	if (err < 0)
 		goto failed;
 
 	return TRUE;
-- 
1.8.3.1

