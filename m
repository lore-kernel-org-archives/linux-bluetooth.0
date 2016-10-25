Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH v2] profiles/network: Check for any server when accepting connections
Date: Tue, 25 Oct 2016 16:25:14 +0200
Message-Id: <1477405514-2284-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When asking confirmation to accept an incoming connection,
we now only check for any network_server to be registered to
the adapter.

This fixes GN Master role, that wouldn't accept any connection
before.
---
 profiles/network/server.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 1bff9f8..aa7f773 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -454,8 +454,7 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	ns = find_server(na->servers, BNEP_SVC_NAP);
-	if (!ns || !ns->record_id || !ns->bridge)
+	if (!na->servers)
 		goto drop;
 
 	na->setup = g_new0(struct network_session, 1);
-- 
2.1.4

