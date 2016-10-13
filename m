Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 1/1] profiles/network: look for GN servers to accept incoming connections
Date: Thu, 13 Oct 2016 15:24:39 +0200
Message-Id: <1476365079-3469-2-git-send-email-maxime.chevallier@smile.fr>
In-Reply-To: <1476365079-3469-1-git-send-email-maxime.chevallier@smile.fr>
References: <1476365079-3469-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When asking confirmation to accept an incoming connection, we must
try to get both NAP and GN servers from the adapter.

This fixes the PAN GN Master role, allowing devices to connect to it.
---
 profiles/network/server.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 1bff9f8..843472f 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -455,8 +455,13 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 	}
 
 	ns = find_server(na->servers, BNEP_SVC_NAP);
-	if (!ns || !ns->record_id || !ns->bridge)
-		goto drop;
+	if (!ns || !ns->record_id || !ns->bridge) {
+
+		ns = find_server(na->servers, BNEP_SVC_GN);
+		if (!ns || !ns->record_id || !ns->bridge)
+			goto drop;
+
+	}
 
 	na->setup = g_new0(struct network_session, 1);
 	bacpy(&na->setup->dst, &dst);
-- 
2.1.4

