Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] audio/avdtp: Fix session list handling
Date: Mon, 23 Feb 2015 15:41:20 +0200
Message-Id: <1424698880-14526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Until we move to queue we shall use server->sessions, this will be
changed in the following patches.
---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f3d4087..926f01c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2394,7 +2394,7 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
 
 	session->version = get_version(session);
 
-	sessions = g_slist_append(sessions, session);
+	server->sessions = g_slist_append(server->sessions, session);
 
 	if (!chan)
 		return session;
-- 
2.1.0

