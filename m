Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sdp: Check correct number of bytes received in recv
Date: Tue, 17 Sep 2013 17:40:20 +0300
Message-Id: <1379428820-6952-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of checking for error check that correct number of bytes received.
---
 src/sdpd-server.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 181d248..7b1351f 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -177,7 +177,7 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
 		return TRUE;
 
 	len = recv(sk, buf, size, 0);
-	if (len <= 0) {
+	if (len != size) {
 		sdp_svcdb_collect_all(sk);
 		free(buf);
 		return FALSE;
-- 
1.7.10.4

