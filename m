Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/11] manager: Rename btd_manager_register_adapter up parameter to powered
Date: Mon, 17 Dec 2012 15:44:49 +0100
Message-ID: <1355755498-2700-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Match parameter name to adapter_init parameter name.
---
 src/manager.c | 4 ++--
 src/manager.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 1f4b831..22e593d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -156,7 +156,7 @@ GSList *manager_get_adapters(void)
 	return adapters;
 }
 
-struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
+struct btd_adapter *btd_manager_register_adapter(int id, gboolean powered)
 {
 	struct btd_adapter *adapter;
 	const char *path;
@@ -173,7 +173,7 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 
 	adapters = g_slist_append(adapters, adapter);
 
-	if (!adapter_init(adapter, up)) {
+	if (!adapter_init(adapter, powered)) {
 		adapters = g_slist_remove(adapters, adapter);
 		btd_adapter_unref(adapter);
 		return NULL;
diff --git a/src/manager.h b/src/manager.h
index fdaabfd..a2b8c31 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -35,5 +35,5 @@ struct btd_adapter *manager_find_adapter_by_id(int id);
 struct btd_adapter *manager_get_default_adapter(void);
 void manager_foreach_adapter(adapter_cb func, gpointer user_data);
 GSList *manager_get_adapters(void);
-struct btd_adapter *btd_manager_register_adapter(int id, gboolean up);
+struct btd_adapter *btd_manager_register_adapter(int id, gboolean powered);
 int btd_manager_unregister_adapter(int id);
-- 
1.8.0

