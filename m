Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 08/16] adapter: Read mode in storage at init
Date: Wed, 24 Oct 2012 16:34:10 +0200
Message-Id: <1351089258-25179-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mgmt interface allows to change connectable and discoverable adapter
status even if the adapter is off. So both status are changed during
adapter init.
Remove on_mode from btd_adapter_get_mode(), as it is no more used.
Update src/mgmt.c and plugins/neard.c
---
 plugins/neard.c |    2 +-
 src/adapter.c   |   75 +++++++++++++++++++++++++++++--------------------------
 src/adapter.h   |    1 -
 src/mgmt.c      |   17 +++----------
 src/mgmt.h      |    1 +
 5 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 2da5024..8018977 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -376,7 +376,7 @@ static int check_adapter(struct btd_adapter *adapter)
 	if (btd_adapter_check_oob_handler(adapter))
 		return -EINPROGRESS;
 
-	btd_adapter_get_mode(adapter, NULL, NULL, NULL, &pairable);
+	btd_adapter_get_mode(adapter, NULL, NULL, &pairable);
 
 	if (!pairable || !adapter_get_agent(adapter))
 		return -ENOENT;
diff --git a/src/adapter.c b/src/adapter.c
index a91e9bb..a2a5da9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -156,6 +156,7 @@ struct btd_adapter {
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
 
+	gboolean discoverable;		/* discoverable state */
 	gboolean pairable;		/* pairable state */
 	gboolean initialized;
 
@@ -196,7 +197,7 @@ static const char *mode2str(uint8_t mode)
 	}
 }
 
-static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
+static uint8_t get_mode(const char *mode)
 {
 	if (strcasecmp("off", mode) == 0)
 		return MODE_OFF;
@@ -204,15 +205,7 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
 		return MODE_CONNECTABLE;
 	else if (strcasecmp("discoverable", mode) == 0)
 		return MODE_DISCOVERABLE;
-	else if (strcasecmp("on", mode) == 0) {
-		char onmode[14], srcaddr[18];
-
-		ba2str(bdaddr, srcaddr);
-		if (read_on_mode(srcaddr, onmode, sizeof(onmode)) < 0)
-			return MODE_CONNECTABLE;
-
-		return get_mode(bdaddr, onmode);
-	} else
+	else
 		return MODE_UNKNOWN;
 }
 
@@ -373,11 +366,8 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 	uint8_t mode;
 	int err;
 
-	if (powered) {
-		mode = get_mode(&adapter->bdaddr, "on");
-		return set_discoverable(adapter, mode == MODE_DISCOVERABLE,
-									id);
-	}
+	if (powered)
+		return set_discoverable(adapter, adapter->discoverable, id);
 
 	mode = MODE_OFF;
 
@@ -1406,7 +1396,10 @@ static DBusMessage *request_session(DBusConnection *conn,
 	if (!adapter->mode_sessions)
 		adapter->global_mode = adapter->mode;
 
-	new_mode = get_mode(&adapter->bdaddr, "on");
+	if (adapter->discoverable)
+		new_mode = MODE_DISCOVERABLE;
+	else
+		new_mode = MODE_CONNECTABLE;
 
 	req = find_session(adapter->mode_sessions, sender);
 	if (req) {
@@ -2120,25 +2113,15 @@ static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
 }
 
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-						uint8_t *on_mode,
 						uint16_t *discoverable_timeout,
 						gboolean *pairable)
 {
-	char str[14], address[18];
+	char address[18];
 
 	ba2str(&adapter->bdaddr, address);
 
-	if (mode) {
-		if (main_opts.remember_powered == FALSE)
-			*mode = main_opts.mode;
-		else if (read_device_mode(address, str, sizeof(str)) == 0)
-			*mode = get_mode(&adapter->bdaddr, str);
-		else
-			*mode = main_opts.mode;
-	}
-
-	if (on_mode)
-		*on_mode = get_mode(&adapter->bdaddr, "on");
+	if (mode)
+		*mode = adapter->mode;
 
 	if (discoverable_timeout)
 		*discoverable_timeout = adapter->discov_timeout;
@@ -2224,10 +2207,13 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->up = TRUE;
 	adapter->off_timer = 0;
 
-	if (adapter->scan_mode & SCAN_INQUIRY)
+	if (adapter->scan_mode & SCAN_INQUIRY) {
 		adapter->mode = MODE_DISCOVERABLE;
-	else
+		adapter->discoverable = TRUE;
+	} else {
 		adapter->mode = MODE_CONNECTABLE;
+		adapter->discoverable = FALSE;
+	}
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 						ADAPTER_INTERFACE, "Powered");
@@ -2469,6 +2455,7 @@ static void load_config(struct btd_adapter *adapter)
 {
 	char name[MAX_NAME_LENGTH + 1];
 	char address[18];
+	char mode[14];
 	int timeout;
 
 	ba2str(&adapter->bdaddr, address);
@@ -2497,6 +2484,24 @@ static void load_config(struct btd_adapter *adapter)
 		adapter->discov_timeout = main_opts.discovto;
 	else
 		adapter->discov_timeout = timeout;
+
+	/* Get mode */
+	if (main_opts.remember_powered == FALSE)
+		adapter->mode = main_opts.mode;
+	else if (read_device_mode(address, mode, sizeof(mode)) == 0)
+		adapter->mode = get_mode(mode);
+	else
+		adapter->mode = main_opts.mode;
+
+	/* Get on mode */
+	if (read_on_mode(address, mode, sizeof(mode)) == 0)
+		adapter->discoverable = (strcasecmp("discoverable", mode) == 0);
+	else
+		adapter->discoverable = (adapter->mode == MODE_DISCOVERABLE);
+
+	mgmt_set_connectable(adapter->dev_id, TRUE);
+	mgmt_set_discoverable(adapter->dev_id, adapter->discoverable,
+				adapter->discov_timeout);
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
@@ -2877,9 +2882,11 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 		break;
 	case SCAN_PAGE:
 		adapter->mode = MODE_CONNECTABLE;
+		adapter->discoverable = FALSE;
 		break;
 	case (SCAN_PAGE | SCAN_INQUIRY):
 		adapter->mode = MODE_DISCOVERABLE;
+		adapter->discoverable = TRUE;
 		break;
 	default:
 		/* ignore, reserved */
@@ -3182,17 +3189,13 @@ gboolean adapter_powering_down(struct btd_adapter *adapter)
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
-	char mode[14], address[18];
-
 	if (!main_opts.remember_powered)
 		return -EINVAL;
 
 	if (adapter->up)
 		return 0;
 
-	ba2str(&adapter->bdaddr, address);
-	if (read_device_mode(address, mode, sizeof(mode)) == 0 &&
-						g_str_equal(mode, "off"))
+	if (adapter->mode == MODE_OFF)
 		return 0;
 
 	return mgmt_set_powered(adapter->dev_id, TRUE);
diff --git a/src/adapter.h b/src/adapter.h
index be69781..54f9ea7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -81,7 +81,6 @@ void btd_adapter_start(struct btd_adapter *adapter);
 int btd_adapter_stop(struct btd_adapter *adapter);
 
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
-						uint8_t *on_mode,
 						uint16_t *discoverable_timeout,
 						gboolean *pairable);
 
diff --git a/src/mgmt.c b/src/mgmt.c
index f179dfa..8fe5100 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -207,7 +207,7 @@ static int mgmt_set_mode(int index, uint16_t opcode, uint8_t val)
 	return 0;
 }
 
-static int mgmt_set_connectable(int index, gboolean connectable)
+int mgmt_set_connectable(int index, gboolean connectable)
 {
 	DBG("index %d connectable %d", index, connectable);
 	return mgmt_set_mode(index, MGMT_OP_SET_CONNECTABLE, connectable);
@@ -315,27 +315,18 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 {
 	struct controller_info *info;
 	gboolean pairable;
-	uint8_t on_mode;
 	uint16_t index, discoverable_timeout;
 
 	DBG("new settings %x", settings);
 
-	btd_adapter_get_mode(adapter, NULL, &on_mode, &discoverable_timeout,
-								&pairable);
+	btd_adapter_get_mode(adapter, NULL, &discoverable_timeout, &pairable);
 
 	index = adapter_get_dev_id(adapter);
 
 	info = &controllers[index];
 
-	if (on_mode == MODE_DISCOVERABLE && !mgmt_discoverable(settings)) {
-		if(!mgmt_connectable(settings))
-			mgmt_set_connectable(index, TRUE);
-		mgmt_set_discoverable(index, TRUE, discoverable_timeout);
-	} else if (on_mode == MODE_CONNECTABLE && !mgmt_connectable(settings)) {
-		mgmt_set_connectable(index, TRUE);
-	} else if (mgmt_powered(settings)) {
+	if (mgmt_powered(settings))
 		adapter_mode_changed(adapter, create_mode(settings));
-	}
 
 	if (mgmt_pairable(settings) != pairable)
 		mgmt_set_pairable(index, pairable);
@@ -1108,7 +1099,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	btd_adapter_get_major_minor(adapter, &major, &minor);
 	mgmt_set_dev_class(index, major, minor);
 
-	btd_adapter_get_mode(adapter, &mode, NULL, NULL, NULL);
+	btd_adapter_get_mode(adapter, &mode, NULL, NULL);
 	if (mode == MODE_OFF && mgmt_powered(info->current_settings)) {
 		mgmt_set_powered(index, FALSE);
 		return;
diff --git a/src/mgmt.h b/src/mgmt.h
index a2c0497..daa168a 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -26,6 +26,7 @@ int mgmt_setup(void);
 void mgmt_cleanup(void);
 
 int mgmt_set_powered(int index, gboolean powered);
+int mgmt_set_connectable(int index, gboolean connectable);
 int mgmt_set_discoverable(int index, gboolean discoverable, uint16_t timeout);
 int mgmt_set_pairable(int index, gboolean pairable);
 int mgmt_set_name(int index, const char *name);
-- 
1.7.9.5

