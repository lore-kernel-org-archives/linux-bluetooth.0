Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 8/9] adapter: Remove not used btd_adapter_switch_{online,offline} functions
Date: Tue, 9 Oct 2012 14:12:01 +0200
Message-ID: <1349784722-14578-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Were used only in Maemo plugin which is now removed.

---
 src/adapter.c |   43 -------------------------------------------
 src/adapter.h |    2 --
 2 files changed, 45 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f3e381b..e6cb3e9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3582,49 +3582,6 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 	return mgmt_set_powered(adapter->dev_id, TRUE);
 }
 
-static gboolean switch_off_timeout(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	mgmt_set_powered(adapter->dev_id, FALSE);
-	adapter->off_timer = 0;
-
-	return FALSE;
-}
-
-int btd_adapter_switch_online(struct btd_adapter *adapter)
-{
-	if (adapter->up)
-		return -EALREADY;
-
-	if (adapter->off_timer)
-		off_timer_remove(adapter);
-
-	return mgmt_set_powered(adapter->dev_id, TRUE);
-}
-
-int btd_adapter_switch_offline(struct btd_adapter *adapter)
-{
-	if (!adapter->up)
-		return -EALREADY;
-
-	if (adapter->off_timer)
-		return 0;
-
-	adapter->global_mode = MODE_OFF;
-
-	if (adapter->connections == NULL)
-		return mgmt_set_powered(adapter->dev_id, FALSE);
-
-	g_slist_foreach(adapter->connections,
-				(GFunc) device_request_disconnect, NULL);
-
-	adapter->off_timer = g_timeout_add_seconds(OFF_TIMER,
-						switch_off_timeout, adapter);
-
-	return 0;
-}
-
 static gboolean disable_auto(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
diff --git a/src/adapter.h b/src/adapter.h
index 9fd034d..cef59d2 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -178,8 +178,6 @@ void btd_adapter_any_release_path(void);
 gboolean adapter_powering_down(struct btd_adapter *adapter);
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
-int btd_adapter_switch_online(struct btd_adapter *adapter);
-int btd_adapter_switch_offline(struct btd_adapter *adapter);
 void btd_adapter_enable_auto_connect(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
-- 
1.7.9.5

