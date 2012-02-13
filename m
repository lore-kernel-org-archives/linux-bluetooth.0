Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ 1/3] manager: add a btd_manager_get_default_adapter_str() call
Date: Mon, 13 Feb 2012 15:42:46 +0100
Message-Id: <1329144168-19263-2-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
References: <1329144168-19263-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to get the default adapter address as a string,
meant to be used by _external_ plugins.
---
 src/manager.c |   21 +++++++++++++++++++++
 src/manager.h |    1 +
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 1d44c66..64f7f2c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -270,6 +270,27 @@ struct btd_adapter *manager_get_default_adapter(void)
 	return manager_find_adapter_by_id(default_adapter_id);
 }
 
+char *btd_manager_get_default_adapter_str(void)
+{
+	struct btd_adapter *adapter;
+	bdaddr_t adapter_bdaddr;
+	char *str;
+
+	adapter = manager_get_default_adapter();
+	if (adapter == NULL) {
+		return NULL;
+	}
+
+	adapter_get_address(adapter, &adapter_bdaddr);
+
+	str = bt_malloc(18);
+	if (str == NULL)
+		return NULL;
+
+	ba2str(&adapter_bdaddr, str);
+	return str;
+}
+
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
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
-- 
1.7.9

