Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 04/16] input: Bypass manager for profile server
Date: Tue, 25 Jun 2013 18:24:37 +0200
Message-Id: <1372177489-6858-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially adopt the btd_profile signature in server.h in order to avoid
boilerplate code in manager.c.
---
 profiles/input/manager.c | 14 --------------
 profiles/input/server.c  |  9 +++++++--
 profiles/input/server.h  |  4 ++--
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 4c32919..7c627aa 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -45,20 +45,6 @@
 #include "device.h"
 #include "server.h"
 
-static int hid_server_probe(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-
-	return server_start(adapter_get_address(adapter));
-}
-
-static void hid_server_remove(struct btd_server *server)
-{
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-
-	server_stop(adapter_get_address(adapter));
-}
-
 static struct btd_profile input_profile = {
 	.name		= "input-hid",
 	.local_uuid	= HID_UUID,
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 5c98573..077429c 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -43,6 +43,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/server.h"
 
 #include "device.h"
 #include "server.h"
@@ -193,8 +194,10 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-int server_start(const bdaddr_t *src)
+int hid_server_probe(struct btd_server *btd_server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(btd_server);
+	const bdaddr_t *src = adapter_get_address(adapter);
 	struct input_server *server;
 	GError *err = NULL;
 
@@ -233,8 +236,10 @@ int server_start(const bdaddr_t *src)
 	return 0;
 }
 
-void server_stop(const bdaddr_t *src)
+void hid_server_remove(struct btd_server *btd_server)
 {
+	struct btd_adapter *adapter = btd_server_get_adapter(btd_server);
+	const bdaddr_t *src = adapter_get_address(adapter);
 	struct input_server *server;
 	GSList *l;
 
diff --git a/profiles/input/server.h b/profiles/input/server.h
index 74159bb..8eefc5f 100644
--- a/profiles/input/server.h
+++ b/profiles/input/server.h
@@ -21,5 +21,5 @@
  *
  */
 
-int server_start(const bdaddr_t *src);
-void server_stop(const bdaddr_t *src);
+int hid_server_probe(struct btd_server *btd_server);
+void hid_server_remove(struct btd_server *btd_server);
-- 
1.8.1.4

