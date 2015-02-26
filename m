Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/12] profiles/network: Simplify id and bridge of server checking
Date: Thu, 26 Feb 2015 12:53:24 +0100
Message-Id: <1424951614-8527-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch simplifies checking of server record id and bridge, if those
exists.
---
 profiles/network/server.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index ebbe056..2b252d9 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -434,13 +434,7 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 	}
 
 	ns = find_server(na->servers, BNEP_SVC_NAP);
-	if (!ns)
-		goto drop;
-
-	if (!ns->record_id)
-		goto drop;
-
-	if (!ns->bridge)
+	if (!ns || !ns->record_id || !ns->bridge)
 		goto drop;
 
 	na->setup = g_new0(struct network_session, 1);
-- 
2.1.0

