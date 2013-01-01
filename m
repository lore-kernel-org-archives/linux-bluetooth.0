Return-Path: <cyrus@holtmann.org>
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>
Subject: [PATCH 1/2] core: Replace calls to g_queue_free_full function
Date: Tue,  1 Jan 2013 12:21:34 +0100
Message-Id: <1357039294-8878-1-git-send-email-g.gherdovich@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function g_queue_free_full is available only from GLib 2.32.
If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
this patch replaces the calls to g_queue_free_full in the "core" BlueZ module
with its body, taken from the sources of GLib 2.32.
---
 src/adapter.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e71cea8..73c9e58 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1697,7 +1697,8 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
-	g_queue_free_full(adapter->auths, g_free);
+	g_queue_foreach(adapter->auths, (GFunc)g_free, NULL);
+	g_queue_free(adapter->auths);
 
 	sdp_list_free(adapter->services, NULL);
 
-- 
1.7.4.1

