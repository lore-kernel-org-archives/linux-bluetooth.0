Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/11] adapter: Remove not used parameter from btd_adapter_get_mode
Date: Mon, 17 Dec 2012 15:44:52 +0100
Message-ID: <1355755498-2700-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

discoverable_timeout is not used outside of adapter code.
---
 src/adapter.c | 6 +-----
 src/adapter.h | 3 +--
 src/mgmt.c    | 6 ++----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8f1c229..915d897 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1693,14 +1693,10 @@ static void load_connections(struct btd_adapter *adapter)
 	g_slist_free_full(conns, g_free);
 }
 
-void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-						uint16_t *discoverable_timeout)
+void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode)
 {
 	if (mode)
 		*mode = adapter->mode;
-
-	if (discoverable_timeout)
-		*discoverable_timeout = adapter->discov_timeout;
 }
 
 bool btd_adapter_get_pairable(struct btd_adapter *adapter)
diff --git a/src/adapter.h b/src/adapter.h
index 125657a..44ba56a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -80,8 +80,7 @@ void btd_adapter_start(struct btd_adapter *adapter);
 
 int btd_adapter_stop(struct btd_adapter *adapter);
 
-void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-						uint16_t *discoverable_timeout);
+void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode);
 
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 
diff --git a/src/mgmt.c b/src/mgmt.c
index feca194..3c7e014 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -332,12 +332,10 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 {
 	struct controller_info *info;
 	gboolean pairable;
-	uint16_t index, discoverable_timeout;
+	uint16_t index;
 
 	DBG("new settings %x", settings);
 
-	btd_adapter_get_mode(adapter, NULL, &discoverable_timeout);
-
 	index = adapter_get_dev_id(adapter);
 
 	info = &controllers[index];
@@ -1215,7 +1213,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	btd_adapter_get_major_minor(adapter, &major, &minor);
 	mgmt_set_dev_class(index, major, minor);
 
-	btd_adapter_get_mode(adapter, &mode, NULL);
+	btd_adapter_get_mode(adapter, &mode);
 	if (mode == MODE_OFF && mgmt_powered(info->current_settings)) {
 		mgmt_set_powered(index, FALSE);
 		return;
-- 
1.8.0

