Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 09/21] manager: remove unused manager_add_adapter()
Date: Wed, 13 Jun 2012 17:43:31 -0300
Message-Id: <1339620223-6639-10-git-send-email-gustavo@padovan.org>
In-Reply-To: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 src/manager.c |   12 ------------
 src/manager.h |    1 -
 2 files changed, 13 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index d588995..4a39461 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -344,18 +344,6 @@ GSList *manager_get_adapters(void)
 	return adapters;
 }
 
-void manager_add_adapter(const char *path)
-{
-	g_dbus_emit_signal(connection, "/",
-				MANAGER_INTERFACE, "AdapterAdded",
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
-	manager_update_adapters();
-
-	btd_stop_exit_timer();
-}
-
 struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 {
 	struct btd_adapter *adapter;
diff --git a/src/manager.h b/src/manager.h
index 264cd25..f3c100e 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -40,4 +40,3 @@ void manager_foreach_adapter(adapter_cb func, gpointer user_data);
 GSList *manager_get_adapters(void);
 struct btd_adapter *btd_manager_register_adapter(int id, gboolean up);
 int btd_manager_unregister_adapter(int id);
-void manager_add_adapter(const char *path);
-- 
1.7.10.2

