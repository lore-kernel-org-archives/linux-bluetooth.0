Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [RFC PATCH BlueZ 1/3] Add a btd_manager_get_default_adapter_str() call
Date: Mon, 19 Sep 2011 19:42:03 +0200
Message-Id: <1316454126-32614-2-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to get the default adapter address as a string,
this is going to be used by the external playstation-peripheral plugin.
---
 src/manager.h |    1 +
 src/manager.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/manager.h b/src/manager.h
index 4f92d2f..91d9894 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -36,6 +36,7 @@ const char *manager_get_base_path(void);
 struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
 struct btd_adapter *manager_find_adapter_by_id(int id);
 struct btd_adapter *manager_get_default_adapter(void);
+char *btd_manager_get_default_adapter_str(void);
 void manager_foreach_adapter(adapter_cb func, gpointer user_data);
 GSList *manager_get_adapters(void);
 struct btd_adapter *btd_manager_register_adapter(int id);
diff --git a/src/manager.c b/src/manager.c
index 464b0ca..8947f85 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -270,6 +270,22 @@ struct btd_adapter *manager_get_default_adapter(void)
 	return manager_find_adapter_by_id(default_adapter_id);
 }
 
+char *btd_manager_get_default_adapter_str(void)
+{
+	struct btd_adapter *adapter;
+	bdaddr_t adapter_bdaddr;
+	char *str = bt_malloc(18);
+
+	adapter = manager_get_default_adapter();
+	if (adapter == NULL) {
+		return NULL;
+	}
+
+	adapter_get_address(adapter, &adapter_bdaddr);
+	ba2str(&adapter_bdaddr, str);
+	return str;
+}
+
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
-- 
1.7.6.3

