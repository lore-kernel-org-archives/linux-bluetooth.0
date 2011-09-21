Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix freeing watches list in maemo6 telephony
Date: Wed, 21 Sep 2011 15:49:52 +0300
Message-Id: <1316609392-28914-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes regression introduced in 83064481481d23523e5cdd04.
List watches has to be freed instead of list pending.
---
 audio/telephony-maemo6.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index a5845c4..42d693a 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -2017,7 +2017,7 @@ void telephony_exit(void)
 	g_slist_free_full(pending, pending_req_finalize);
 	pending = NULL;
 
-	g_slist_free_full(pending, remove_watch);
+	g_slist_free_full(watches, remove_watch);
 	watches = NULL;
 
 	dbus_connection_unref(connection);
-- 
1.7.4.1

