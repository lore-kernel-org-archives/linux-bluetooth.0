Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/11] adapter: Add btd_adapter_get_pairable function
Date: Mon, 17 Dec 2012 15:44:51 +0100
Message-ID: <1355755498-2700-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add btd_adapter_get_pairable and remove pairable argument from
btd_adapter_get_mode. Use btd_adapter_get_pairable to get pairable
state where needed.
---
 plugins/neard.c | 6 +-----
 src/adapter.c   | 9 +++++----
 src/adapter.h   | 5 +++--
 src/mgmt.c      | 6 ++++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index a8c12fd..e1f3583 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -593,17 +593,13 @@ static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
 
 static int check_adapter(struct btd_adapter *adapter)
 {
-	gboolean pairable;
-
 	if (!adapter)
 		return -ENOENT;
 
 	if (btd_adapter_check_oob_handler(adapter))
 		return -EINPROGRESS;
 
-	btd_adapter_get_mode(adapter, NULL, NULL, &pairable);
-
-	if (!pairable || !adapter_get_agent(adapter))
+	if (!btd_adapter_get_pairable(adapter) || !adapter_get_agent(adapter))
 		return -ENONET;
 
 	if (!btd_adapter_ssp_enabled(adapter))
diff --git a/src/adapter.c b/src/adapter.c
index e50e646..8f1c229 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1694,17 +1694,18 @@ static void load_connections(struct btd_adapter *adapter)
 }
 
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-						uint16_t *discoverable_timeout,
-						gboolean *pairable)
+						uint16_t *discoverable_timeout)
 {
 	if (mode)
 		*mode = adapter->mode;
 
 	if (discoverable_timeout)
 		*discoverable_timeout = adapter->discov_timeout;
+}
 
-	if (pairable)
-		*pairable = adapter->pairable;
+bool btd_adapter_get_pairable(struct btd_adapter *adapter)
+{
+	return adapter->pairable;
 }
 
 void btd_adapter_get_major_minor(struct btd_adapter *adapter, uint8_t *major,
diff --git a/src/adapter.h b/src/adapter.h
index 7c20e29..125657a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -81,8 +81,9 @@ void btd_adapter_start(struct btd_adapter *adapter);
 int btd_adapter_stop(struct btd_adapter *adapter);
 
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-						uint16_t *discoverable_timeout,
-						gboolean *pairable);
+						uint16_t *discoverable_timeout);
+
+bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 
 void btd_adapter_get_major_minor(struct btd_adapter *adapter, uint8_t *major,
 							uint8_t *minor);
diff --git a/src/mgmt.c b/src/mgmt.c
index cc54e8b..feca194 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -336,7 +336,7 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 
 	DBG("new settings %x", settings);
 
-	btd_adapter_get_mode(adapter, NULL, &discoverable_timeout, &pairable);
+	btd_adapter_get_mode(adapter, NULL, &discoverable_timeout);
 
 	index = adapter_get_dev_id(adapter);
 
@@ -346,6 +346,8 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 		adapter_mode_changed(adapter, mgmt_connectable(settings),
 						mgmt_discoverable(settings));
 
+	pairable = btd_adapter_get_pairable(adapter);
+
 	if (mgmt_pairable(settings) != pairable)
 		mgmt_set_pairable(index, pairable);
 
@@ -1213,7 +1215,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	btd_adapter_get_major_minor(adapter, &major, &minor);
 	mgmt_set_dev_class(index, major, minor);
 
-	btd_adapter_get_mode(adapter, &mode, NULL, NULL);
+	btd_adapter_get_mode(adapter, &mode, NULL);
 	if (mode == MODE_OFF && mgmt_powered(info->current_settings)) {
 		mgmt_set_powered(index, FALSE);
 		return;
-- 
1.8.0

