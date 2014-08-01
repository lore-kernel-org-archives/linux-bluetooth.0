Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/6] gobex: Fix use after free
Date: Fri,  1 Aug 2014 11:29:08 +0300
Message-Id: <1406881752-24897-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406881752-24897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
 <1406881752-24897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It is better not to dereference freed pointer
---
 gobex/gobex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 3848884..16a4aae 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -250,6 +250,7 @@ static gboolean req_timeout(gpointer user_data)
 
 	g_assert(p != NULL);
 
+	p->timeout_id = 0;
 	obex->pending_req = NULL;
 
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_TIMEOUT,
@@ -263,8 +264,6 @@ static gboolean req_timeout(gpointer user_data)
 	g_error_free(err);
 	pending_pkt_free(p);
 
-	p->timeout_id = 0;
-
 	return FALSE;
 }
 
-- 
1.9.1

