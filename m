Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH 4/5] network: Kill underlying session's connection before freeing it
Date: Tue, 21 Aug 2012 13:45:54 +0300
Message-Id: <1345545955-13144-5-git-send-email-tomasz.bursztyka@linux.intel.com>
In-Reply-To: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
References: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/server.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 5d64ee2..1b9989d 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -598,6 +598,8 @@ static void server_remove_sessions(struct network_server *ns)
 
 		bnep_del_from_bridge(session->dev, ns->bridge);
 		bnep_if_down(session->dev);
+
+		bnep_kill_connection(&session->dst);
 	}
 
 	g_slist_free_full(ns->sessions, session_free);
-- 
1.7.8.6

