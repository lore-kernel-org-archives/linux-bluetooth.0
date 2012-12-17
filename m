Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/11] adapter: Make adapter_mode_changed accept mode as bool params
Date: Mon, 17 Dec 2012 15:44:50 +0100
Message-ID: <1355755498-2700-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass connectable and discoverable as bools.
---
 src/adapter.c | 19 ++++++++++++++++++-
 src/adapter.h |  3 ++-
 src/mgmt.c    | 19 ++++---------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f56b000..e50e646 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3151,9 +3151,26 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	}
 }
 
-void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
+static uint8_t create_mode(bool connectable, bool discoverable)
+{
+	uint8_t mode = 0;
+
+	if (connectable)
+		mode |= SCAN_PAGE;
+
+	if (discoverable)
+		mode |= SCAN_INQUIRY;
+
+	return mode;
+}
+
+void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
+							bool discoverable)
 {
 	bool emit_pairable = false;
+	uint8_t scan_mode;
+
+	scan_mode = create_mode(connectable, discoverable);
 
 	DBG("old 0x%02x new 0x%02x", adapter->scan_mode, scan_mode);
 
diff --git a/src/adapter.h b/src/adapter.h
index 3b2d14f..7c20e29 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -114,7 +114,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm_name, bool legacy,
 					uint8_t *data, uint8_t data_len);
-void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
+void adapter_mode_changed(struct btd_adapter *adapter, bool connectable,
+							bool discoverable);
 int adapter_set_name(struct btd_adapter *adapter, const char *name);
 void adapter_name_changed(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(struct btd_adapter *adapter, void *rec);
diff --git a/src/mgmt.c b/src/mgmt.c
index dfcf558..cc54e8b 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -328,19 +328,6 @@ static inline int mgmt_low_energy(uint32_t settings)
 	return (settings & MGMT_SETTING_LE) != 0;
 }
 
-static uint8_t create_mode(uint32_t settings)
-{
-	uint8_t mode = 0;
-
-	if (mgmt_connectable(settings))
-		mode |= SCAN_PAGE;
-
-	if (mgmt_discoverable(settings))
-		mode |= SCAN_INQUIRY;
-
-	return mode;
-}
-
 static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 {
 	struct controller_info *info;
@@ -356,7 +343,8 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 	info = &controllers[index];
 
 	if (mgmt_powered(settings))
-		adapter_mode_changed(adapter, create_mode(settings));
+		adapter_mode_changed(adapter, mgmt_connectable(settings),
+						mgmt_discoverable(settings));
 
 	if (mgmt_pairable(settings) != pairable)
 		mgmt_set_pairable(index, pairable);
@@ -434,7 +422,8 @@ static void mgmt_new_settings(int sk, uint16_t index, void *buf, size_t len)
 	if (new_power != old_power)
 		mgmt_update_powered(adapter, info, settings);
 	else if (new_power && mode_changed(settings, info->current_settings))
-		adapter_mode_changed(adapter, create_mode(settings));
+		adapter_mode_changed(adapter, mgmt_connectable(settings),
+						mgmt_discoverable(settings));
 
 	old_pairable = mgmt_pairable(info->current_settings);
 	new_pairable = mgmt_pairable(settings);
-- 
1.8.0

