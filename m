Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/2] Add function to get default adapter ID
Date: Thu,  9 Jun 2011 14:53:08 +0100
Message-Id: <1307627589-25786-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Combined with manager_find_adapter_by_id(), it is now possible
to get the btd_adapter struct for the default adapter:
manager_find_adapter_by_id (manager_get_default_adapter_id ());
---
 src/manager.c |    8 ++++++++
 src/manager.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index e805e0c..9d0de25 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		btd_start_exit_timer();
 }
 
+int manager_get_default_adapter_id(void)
+{
+	return default_adapter_id;
+}
+
 void manager_cleanup(DBusConnection *conn, const char *path)
 {
 	g_slist_foreach(adapters, (GFunc) manager_remove_adapter, NULL);
@@ -331,6 +336,9 @@ struct btd_adapter *manager_find_adapter_by_id(int id)
 {
 	GSList *match;
 
+	if (id < 0)
+		return NULL;
+
 	match = g_slist_find_custom(adapters, GINT_TO_POINTER(id),
 							adapter_id_cmp);
 	if (!match)
diff --git a/src/manager.h b/src/manager.h
index 05c38b3..52bf36b 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -41,3 +41,4 @@ struct btd_adapter *btd_manager_register_adapter(int id);
 int btd_manager_unregister_adapter(int id);
 void manager_add_adapter(const char *path);
 void btd_manager_set_did(uint16_t vendor, uint16_t product, uint16_t version);
+int manager_get_default_adapter_id(void);
-- 
1.7.5.1

