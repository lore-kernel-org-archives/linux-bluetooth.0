Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH v2 1/5] adapter: Add is_default field to struct btd_adapter
Date: Wed,  6 Feb 2013 22:40:34 +0100
Message-Id: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of global default_adapter_id variable use is_default field
to indicate if adapter is default one.
---
 src/adapter.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9ddd2fc..3774c77 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -96,7 +96,6 @@ static unsigned int adapter_remaining = 0;
 static bool powering_down = false;
 
 static GSList *adapters = NULL;
-static int default_adapter_id = -1;
 
 static struct mgmt *mgmt_master = NULL;
 
@@ -184,6 +183,8 @@ struct btd_adapter {
 
 	unsigned int pair_device_id;
 	guint pair_device_timeout;
+
+	bool is_default;		/* true if adapter is default one */
 };
 
 static struct btd_adapter *btd_adapter_lookup(uint16_t index)
@@ -205,14 +206,11 @@ struct btd_adapter *btd_adapter_get_default(void)
 {
 	GList *list;
 
-	if (default_adapter_id < 0)
-		return NULL;
-
 	for (list = g_list_first(adapter_list); list;
 						list = g_list_next(list)) {
 		struct btd_adapter *adapter = list->data;
 
-		if (adapter->dev_id == default_adapter_id)
+		if (adapter->is_default)
 			return adapter;
 	}
 
@@ -224,10 +222,7 @@ bool btd_adapter_is_default(struct btd_adapter *adapter)
 	if (!adapter)
 		return false;
 
-	if (adapter->dev_id == default_adapter_id)
-		return true;
-
-	return false;
+	return adapter->is_default;
 }
 
 uint16_t btd_adapter_get_index(struct btd_adapter *adapter)
@@ -5506,8 +5501,8 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->initialized = TRUE;
 
-	if (default_adapter_id < 0)
-		default_adapter_id = adapter->dev_id;
+	if (g_slist_length(adapters) == 1)
+		adapter->is_default = true;
 
 	if (main_opts.did_source)
 		set_did(adapter, main_opts.did_vendor, main_opts.did_product,
@@ -5524,8 +5519,13 @@ static int adapter_unregister(struct btd_adapter *adapter)
 
 	adapters = g_slist_remove(adapters, adapter);
 
-	if (default_adapter_id == adapter->dev_id || default_adapter_id < 0)
-		default_adapter_id = hci_get_route(NULL);
+	if (adapter->is_default && adapters != NULL) {
+		struct btd_adapter *new_default;
+
+		new_default = adapter_find_by_id(hci_get_route(NULL));
+		if (new_default)
+			new_default->is_default = true;
+	}
 
 	adapter_list = g_list_remove(adapter_list, adapter);
 
-- 
1.8.1.2

