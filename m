Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix unloading of adapter drivers
Date: Thu, 10 Mar 2011 13:10:09 +0100
Message-ID: <1299759009-17407-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call driver remove callback only if corresponding probe succeed.
---
 src/adapter.c |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b119fd1..c72017b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -144,6 +144,8 @@ struct btd_adapter {
 	GSList *powered_callbacks;
 
 	gboolean name_stored;
+
+	GSList *loaded_drivers;
 };
 
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
@@ -2246,23 +2248,26 @@ static void probe_driver(struct btd_adapter *adapter, gpointer user_data)
 	if (!adapter->up)
 		return;
 
+	if (driver->probe == NULL)
+		return;
+
 	err = driver->probe(adapter);
-	if (err < 0)
+
+	if (err < 0) {
 		error("%s: %s (%d)", driver->name, strerror(-err), -err);
+		return;
+	}
+
+	adapter->loaded_drivers = g_slist_prepend(adapter->loaded_drivers,
+									driver);
 }
 
 static void load_drivers(struct btd_adapter *adapter)
 {
 	GSList *l;
 
-	for (l = adapter_drivers; l; l = l->next) {
-		struct btd_adapter_driver *driver = l->data;
-
-		if (driver->probe == NULL)
-			continue;
-
-		probe_driver(adapter, driver);
-	}
+	for (l = adapter_drivers; l; l = l->next)
+		probe_driver(adapter, l->data);
 }
 
 static void load_connections(struct btd_adapter *adapter)
@@ -2477,16 +2482,20 @@ static void reply_pending_requests(struct btd_adapter *adapter)
 	}
 }
 
-static void unload_drivers(struct btd_adapter *adapter)
+
+static void remove_driver(gpointer data, gpointer user_data)
 {
-	GSList *l;
+	struct btd_adapter_driver *driver = data;
+	struct btd_adapter *adapter = user_data;
 
-	for (l = adapter_drivers; l; l = l->next) {
-		struct btd_adapter_driver *driver = l->data;
+	if (driver->remove)
+		driver->remove(adapter);
+}
 
-		if (driver->remove)
-			driver->remove(adapter);
-	}
+static void unload_drivers(struct btd_adapter *adapter)
+{
+	g_slist_foreach(adapter->loaded_drivers, remove_driver, adapter);
+	g_slist_free(adapter->loaded_drivers);
 }
 
 static void set_mode_complete(struct btd_adapter *adapter)
-- 
1.7.0.4
on behalf of ST-Ericsson
