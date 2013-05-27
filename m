Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 4/4] opp: Register Session interface for OPP transfers
Date: Mon, 27 May 2013 20:07:04 -0300
Message-Id: <1369696024-27434-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1369696024-27434-1-git-send-email-gustavo@padovan.org>
References: <1369696024-27434-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The Session interface wasn't registered when a new transfer arrives.
---
 obexd/plugins/opp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 97bf943..ee0204c 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -46,6 +46,8 @@
 
 static void *opp_connect(struct obex_session *os, int *err)
 {
+	manager_register_session(os);
+
 	if (err)
 		*err = 0;
 
@@ -154,6 +156,7 @@ static int opp_get(struct obex_session *os, void *user_data)
 static void opp_disconnect(struct obex_session *os, void *user_data)
 {
 	manager_unregister_transfer(user_data);
+	manager_unregister_session(os);
 }
 
 static void opp_reset(struct obex_session *os, void *user_data)
-- 
1.8.1.4

