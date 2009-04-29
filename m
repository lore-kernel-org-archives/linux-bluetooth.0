Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Moving adapter_ops registration to adapter.c.
Date: Wed, 29 Apr 2009 21:10:01 +0530
Message-Id: <1241019601-7757-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c |   35 +++++++++++++++++++++++++++++++++++
 src/adapter.h |   10 ++++++++++
 src/main.c    |    2 +-
 src/manager.c |   35 -----------------------------------
 src/manager.h |    8 --------
 5 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index afa1d4d..1ebd508 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -74,6 +74,8 @@
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
 
+const struct btd_adapter_ops *adapter_ops = NULL;
+
 struct session_req {
 	struct btd_adapter	*adapter;
 	DBusConnection		*conn;		/* Connection reference */
@@ -3085,3 +3087,36 @@ gboolean adapter_powering_down(struct btd_adapter *adapter)
 {
 	return adapter->off_requested;
 }
+
+int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops)
+{
+	/* Already registered */
+	if (adapter_ops)
+		return -EALREADY;
+
+	if (btd_adapter_ops->setup == NULL)
+		return -EINVAL;
+
+	adapter_ops = btd_adapter_ops;
+
+	return 0;
+}
+
+void btd_adapter_cleanup_ops()
+{
+	adapter_ops->cleanup();
+}
+
+void adapter_ops_setup()
+{
+	int err;
+
+	if (!adapter_ops) {
+		error("Unable to initialize adapter operations");
+		return;
+	}
+
+	err = adapter_ops->setup();
+	if (err < 0)
+		error("btd_register_adapter_ops failed:%s (%d)", strerror(-err), -err);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 8111d6f..3452519 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -147,3 +147,13 @@ const char *btd_adapter_any_request_path(void);
 void btd_adapter_any_release_path(void);
 gboolean adapter_is_pairable(struct btd_adapter *adapter);
 gboolean adapter_powering_down(struct btd_adapter *adapter);
+
+
+struct btd_adapter_ops {
+	int (*setup) (void);
+	void (*cleanup) (void);
+};
+
+int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
+void btd_adapter_cleanup_ops();
+void adapter_ops_setup();
diff --git a/src/main.c b/src/main.c
index 603695b..a940cb7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -411,7 +411,7 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	manager_init_adapters();
+	adapter_ops_setup();
 
 	starting = FALSE;
 
diff --git a/src/manager.c b/src/manager.c
index a4b0c58..0cf0d59 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -55,8 +55,6 @@ static DBusConnection *connection = NULL;
 static int default_adapter_id = -1;
 static GSList *adapters = NULL;
 
-const struct btd_adapter_ops *adapter_ops = NULL;
-
 const char *manager_get_base_path(void)
 {
 	return base_path;
@@ -520,36 +518,3 @@ void manager_set_default_adapter(int id)
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 }
-
-int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops)
-{
-	/* Already registered */
-	if (adapter_ops)
-		return -EALREADY;
-
-	if (btd_adapter_ops->setup == NULL)
-		return -EINVAL;
-
-	adapter_ops = btd_adapter_ops;
-
-	return 0;
-}
-
-void btd_adapter_cleanup_ops()
-{
-	adapter_ops->cleanup();
-}
-
-void manager_init_adapters()
-{
-	int err;
-
-	if (!adapter_ops) {
-		info("No adapter_ops registered.");
-		return;
-	}
-
-	err = adapter_ops->setup();
-	if (err < 0)
-		error("btd_register_adapter_ops failed:%s (%d)", strerror(-err), -err);
-}
diff --git a/src/manager.h b/src/manager.h
index b9ccf44..670f0c2 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -43,12 +43,4 @@ void manager_set_default_adapter(int id);
 int manager_update_adapter(uint16_t id, uint8_t svc, gboolean starting);
 int manager_startup_complete(void);
 int manager_get_adapter_class(uint16_t dev_id, uint8_t *cls);
-void manager_init_adapters();
 
-struct btd_adapter_ops {
-	int (*setup) (void);
-	void (*cleanup) (void);
-};
-
-int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
-void btd_adapter_cleanup_ops();
-- 
1.5.6.3

