Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@gmail.com>
Subject: [PATCH 7/8] Adding btd_register_adapter_ops framework
Date: Mon, 27 Apr 2009 19:45:44 +0530
Message-Id: <1240841745-11006-7-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   16 +++++++++++++++-
 src/adapter.c    |   29 +++++++++++++++++++++++++++++
 src/adapter.h    |    8 ++++++++
 3 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 25f5171..5845443 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -355,7 +355,7 @@ static gboolean io_stack_event(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
-static int hciops_init(void)
+static int hciops_setup(void)
 {
 	struct sockaddr_hci addr;
 	struct hci_filter flt;
@@ -413,8 +413,22 @@ static int hciops_init(void)
 	return init_all_devices(sock);
 }
 
+static void hciops_cleanup(void)
+{
+}
+
+static struct btd_adapter_ops hci_ops = {
+	.setup	 = hciops_setup,
+	.cleanup = hciops_cleanup,
+};
+
+static int hciops_init(void)
+{
+	return btd_register_adapter_ops(&hci_ops);
+}
 static void hciops_exit(void)
 {
+	btd_adapter_cleanup_ops(&hci_ops);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(hciops, VERSION,
diff --git a/src/adapter.c b/src/adapter.c
index 40c5ab0..db86228 100644
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
@@ -2905,6 +2907,33 @@ void btd_unregister_adapter_driver(struct btd_adapter_driver *driver)
 	adapter_drivers = g_slist_remove(adapter_drivers, driver);
 }
 
+int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops)
+{
+	int err;
+
+	/* Already registered */
+	if (adapter_ops)
+		return 1;
+
+	if (btd_adapter_ops->setup == NULL)
+		return -1;
+
+	err = btd_adapter_ops->setup();
+	if (err < 0) {
+		error("btd_register_adapter_ops failed:%s (%d)", strerror(-err), -err);
+		return -1;
+	}
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
 static void agent_auth_cb(struct agent *agent, DBusError *derr,
 							void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 8111d6f..b195c3c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -147,3 +147,11 @@ const char *btd_adapter_any_request_path(void);
 void btd_adapter_any_release_path(void);
 gboolean adapter_is_pairable(struct btd_adapter *adapter);
 gboolean adapter_powering_down(struct btd_adapter *adapter);
+
+struct btd_adapter_ops {
+	int (*setup) ();
+	void (*cleanup) ();
+};
+
+int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
+void btd_adapter_cleanup_ops();
-- 
1.5.6.3
