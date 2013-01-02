Return-Path: <cyrus@holtmann.org>
From: Giovanni Gherdovich <g.gherdovich@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Giovanni Gherdovich <g.gherdovich@gmail.com>
Subject: [PATCH 1/2] core: Replace calls to g_queue_free_full function
Date: Wed,  2 Jan 2013 22:31:27 +0100
Message-Id: <1357162287-14216-1-git-send-email-g.gherdovich@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function g_queue_free_full is available only from GLib 2.32.
If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
this patch replaces the calls to g_queue_free_full in the "core" BlueZ module
with its body, taken from the sources of GLib 2.32.
---
 src/adapter.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e71cea8..f7fc00e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1688,6 +1688,15 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	return 0;
 }
 
+static void g_free_wrapper(gpointer mem, gpointer dummy)
+{
+	/* 
+	 * Wrapper around GLib's g_free to match the signature
+	 * required for the second argument of g_queue_foreach.
+	 */
+	g_free(mem);
+}
+
 static void adapter_free(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -1697,7 +1706,8 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
-	g_queue_free_full(adapter->auths, g_free);
+	g_queue_foreach(adapter->auths, g_free_wrapper, NULL);
+	g_queue_free(adapter->auths);
 
 	sdp_list_free(adapter->services, NULL);
 
-- 
1.7.4.1

