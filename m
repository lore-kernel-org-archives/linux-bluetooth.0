Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sdp: Check for correct pkt size received instead of error
Date: Tue,  1 Oct 2013 14:57:34 +0300
Message-Id: <1380628654-6663-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check that the full header is received in recv().
---
 src/sdpd-server.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 7b1351f..10e46a1 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -166,7 +166,7 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
 	}
 
 	len = recv(sk, &hdr, sizeof(sdp_pdu_hdr_t), MSG_PEEK);
-	if (len <= 0) {
+	if (len != sizeof(sdp_pdu_hdr_t)) {
 		sdp_svcdb_collect_all(sk);
 		return FALSE;
 	}
-- 
1.7.10.4

