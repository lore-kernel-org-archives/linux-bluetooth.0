Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 1/2] gobex: Remove reduntant NULL assignment
Date: Fri, 13 Jan 2012 15:25:52 +0530
Message-id: <1326448552-8297-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gobex/gobex.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0db4567..33b77fd 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -247,8 +247,6 @@ static gboolean req_timeout(gpointer user_data)
 
 	g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
 
-	obex->pending_req = NULL;
-
 	if (p->rsp_func)
 		p->rsp_func(obex, err, NULL, p->rsp_data);
 
-- 
1.7.1

