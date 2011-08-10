Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd 3/3] Remove bogus extra semicolons
Date: Thu, 11 Aug 2011 00:13:28 +0530
Message-Id: <1313001808-29597-3-git-send-email-syamsidhardh@gmail.com>
In-Reply-To: <1313001808-29597-1-git-send-email-syamsidhardh@gmail.com>
References: <1313001808-29597-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/test-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/test-server.c b/tools/test-server.c
index 6096737..a25dfb9 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -260,7 +260,7 @@ static gboolean unix_accept(GIOChannel *chan, GIOCondition cond, gpointer data)
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, NULL);
 	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT, handle_connect,
 									NULL);
-	clients = g_slist_append(clients, obex);;
+	clients = g_slist_append(clients, obex);
 
 	return TRUE;
 }
-- 
1.7.4.1

