Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/3] Add ability to block name changes
Date: Wed, 22 Jun 2011 12:29:57 +0100
Message-Id: <1308742198-6024-2-git-send-email-hadess@hadess.net>
In-Reply-To: <1308742198-6024-1-git-send-email-hadess@hadess.net>
References: <1308742198-6024-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   12 ++++++++++++
 src/adapter.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f8c0370..5420acd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -111,6 +111,7 @@ struct btd_adapter {
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
 	char name[MAX_NAME_LENGTH + 1]; /* adapter name */
+	gboolean allow_name_changes;	/* whether the adapter name can be changed */
 	guint discov_timeout_id;	/* discoverable timeout id */
 	guint stop_discov_id;		/* stop inquiry/scanning id */
 	uint32_t discov_timeout;	/* discoverable time(sec) */
@@ -916,6 +917,9 @@ int adapter_update_local_name(struct btd_adapter *adapter, const char *name)
 {
 	char *name_ptr;
 
+	if (adapter->allow_name_changes == FALSE)
+		return -EPERM;
+
 	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
 		return 0;
 
@@ -2563,6 +2567,8 @@ gboolean adapter_init(struct btd_adapter *adapter)
 	 * start off as powered */
 	adapter->up = TRUE;
 
+	adapter->allow_name_changes = TRUE;
+
 	adapter_ops->read_bdaddr(adapter->dev_id, &adapter->bdaddr);
 
 	if (bacmp(&adapter->bdaddr, BDADDR_ANY) == 0) {
@@ -2663,6 +2669,12 @@ void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 	bacpy(bdaddr, &adapter->bdaddr);
 }
 
+void adapter_set_allow_name_changes(struct btd_adapter *adapter,
+						gboolean allow_name_changes)
+{
+	adapter->allow_name_changes = allow_name_changes;
+}
+
 static inline void suspend_discovery(struct btd_adapter *adapter)
 {
 	if (adapter->state != STATE_SUSPENDED)
diff --git a/src/adapter.h b/src/adapter.h
index 9516a99..38ea3ca 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -100,6 +100,8 @@ int adapter_resolve_names(struct btd_adapter *adapter);
 struct btd_adapter *adapter_create(DBusConnection *conn, int id);
 gboolean adapter_init(struct btd_adapter *adapter);
 void adapter_remove(struct btd_adapter *adapter);
+void adapter_set_allow_name_changes(struct btd_adapter *adapter,
+						gboolean allow_name_changes);
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
 void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
-- 
1.7.5.4

