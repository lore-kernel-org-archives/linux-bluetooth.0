Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Fix unloading of adapter drivers
Date: Thu, 10 Mar 2011 16:10:34 +0100
Message-ID: <1299769834-11133-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <201103101516.30070.szymon.janc@tieto.com>
References: <201103101516.30070.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Call driver remove callback only if corresponding probe succeed.
---
 src/adapter.c |   47 +++++++++++++++++++++++++++++++----------------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b119fd1..e8abf42 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -144,6 +144,8 @@ struct btd_adapter {
 	GSList *powered_callbacks;
 
 	gboolean name_stored;
+
+	GSList *loaded_drivers;
 };
 
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
@@ -2246,23 +2248,25 @@ static void probe_driver(struct btd_adapter *adapter, gpointer user_data)
 	if (!adapter->up)
 		return;
 
+	if (driver->probe == NULL)
+		return;
+
 	err = driver->probe(adapter);
-	if (err < 0)
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
@@ -2477,16 +2481,20 @@ static void reply_pending_requests(struct btd_adapter *adapter)
 	}
 }
 
-static void unload_drivers(struct btd_adapter *adapter)
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
+	adapter->loaded_drivers = NULL;
 }
 
 static void set_mode_complete(struct btd_adapter *adapter)
@@ -3326,9 +3334,16 @@ int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 	return 0;
 }
 
+static void unload_driver(struct btd_adapter *adapter, gpointer data)
+{
+	adapter->loaded_drivers = g_slist_remove(adapter->loaded_drivers, data);
+}
+
 void btd_unregister_adapter_driver(struct btd_adapter_driver *driver)
 {
 	adapter_drivers = g_slist_remove(adapter_drivers, driver);
+
+	manager_foreach_adapter(unload_driver, driver);
 }
 
 static void agent_auth_cb(struct agent *agent, DBusError *derr,
-- 
1.7.0.4
on behalf of ST-Ericsson
