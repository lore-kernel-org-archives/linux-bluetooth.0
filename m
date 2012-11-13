Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] network: Fix dead assignment in connect_cb
Date: Tue, 13 Nov 2012 13:52:40 +0100
Message-ID: <1352811160-12722-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
References: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Value stored to err_msg is never read in case err was not NULL.
Simply remove err_msg and pass strerror() directly where it is used.

---
 profiles/network/connection.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index abcbee8..1a1fb4d 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -371,19 +371,16 @@ static int bnep_connect(struct network_conn *nc)
 static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct network_conn *nc = data;
-	const char *err_msg;
 	int perr;
 
 	if (err) {
 		error("%s", err->message);
-		err_msg = err->message;
 		goto failed;
 	}
 
 	perr = bnep_connect(nc);
 	if (perr < 0) {
-		err_msg = strerror(-perr);
-		error("bnep connect(): %s (%d)", err_msg, -perr);
+		error("bnep connect(): %s (%d)", strerror(-perr), -perr);
 		goto failed;
 	}
 
-- 
1.7.9.5

