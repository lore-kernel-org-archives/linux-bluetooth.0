Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 1/2] Fix empty parameter list in function declaration
Date: Wed, 09 Nov 2011 11:29:39 +0530
Message-id: <1320818380-17217-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |    2 +-
 src/log.c                  |    2 +-
 src/manager.c              |    2 +-
 src/transport.c            |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 218a016..8f9b30a 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -120,7 +120,7 @@ static void destroy_folder_tree(void *root)
 	g_free(folder);
 }
 
-static void create_folder_tree()
+static void create_folder_tree(void)
 {
 	struct message_folder *parent, *child;
 
diff --git a/src/log.c b/src/log.c
index baa57c5..db7b5f3 100644
--- a/src/log.c
+++ b/src/log.c
@@ -92,7 +92,7 @@ static gboolean is_enabled(struct obex_debug_desc *desc)
 	return 0;
 }
 
-void __obex_log_enable_debug()
+void __obex_log_enable_debug(void)
 {
 	struct obex_debug_desc *desc;
 
diff --git a/src/manager.c b/src/manager.c
index db5d67d..3953e9d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -450,7 +450,7 @@ void manager_unregister_transfer(struct obex_session *os)
 	g_free(path);
 }
 
-static void agent_cancel()
+static void agent_cancel(void)
 {
 	DBusMessage *msg;
 
diff --git a/src/transport.c b/src/transport.c
index 6d51f53..f178e44 100644
--- a/src/transport.c
+++ b/src/transport.c
@@ -53,7 +53,7 @@ static struct obex_transport_driver *obex_transport_driver_find(
 	return NULL;
 }
 
-GSList *obex_transport_driver_list()
+GSList *obex_transport_driver_list(void)
 {
 	return drivers;
 }
-- 
1.7.4.1

