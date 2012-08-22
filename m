Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] network: Fix bnep setup failure handle bug
Date: Wed, 22 Aug 2012 18:20:38 +0900
Message-id: <1345627238-19290-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1345627238-19290-1-git-send-email-chanyeol.park@samsung.com>
References: <1345627238-19290-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch initializes rsp varailbe again for the remain setup failure
procedure.
---
 profiles/network/server.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 9bf2a02..77a8844 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -340,7 +340,7 @@ static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
 		return BNEP_CONN_INVALID_SVC;
 	}
 
-	return 0;
+	return BNEP_SUCCESS;
 }
 
 static void session_free(void *data)
@@ -422,6 +422,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 	if (rsp)
 		goto reply;
 
+	rsp = BNEP_CONN_NOT_ALLOWED;
+
 	ns = find_server(na->servers, dst_role);
 	if (!ns) {
 		error("Server unavailable: (0x%x)", dst_role);
-- 
1.7.9.5

