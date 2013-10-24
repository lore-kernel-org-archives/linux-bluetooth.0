Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 5/5] android: Use adapter index in mgmt functions
Date: Thu, 24 Oct 2013 11:54:24 +0200
Message-ID: <1382608464-10389-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
References: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Instead of hardcoding index 0 use real index of adapter. This fix
using invalid index if adapter ID happens to be different than 0.

This should not happen on Android but is possible while testing on
Linux PC.
---
 android/adapter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 84b3d93..8917b8e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -170,14 +170,16 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 
 static void register_mgmt_handlers(void)
 {
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, 0,
+	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
 					new_settings_callback, NULL, NULL);
 
 	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
-			0, mgmt_dev_class_changed_event, NULL, NULL);
+				adapter->index, mgmt_dev_class_changed_event,
+				NULL, NULL);
 
 	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
-			0, mgmt_local_name_changed_event, NULL, NULL);
+				adapter->index, mgmt_local_name_changed_event,
+				NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
@@ -216,7 +218,7 @@ static void load_link_keys(GSList *keys)
 	cp->debug_keys = 0;
 	cp->key_count = htobs(key_len);
 
-	mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, 0, len,
+	mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, adapter->index, len,
 				cp, load_link_keys_complete, NULL, NULL);
 
 	g_free(cp);
-- 
1.8.4

