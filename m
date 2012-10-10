Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 08/10] adapter: Read mode in storage at init
Date: Wed, 10 Oct 2012 18:23:29 +0200
Message-Id: <1349886211-18920-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   61 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 40df4a1..85c5da9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -118,6 +118,8 @@ struct service_auth {
 struct btd_adapter_config {
 	char *name;
 	uint8_t class[3];
+	uint8_t mode;
+	uint8_t on_mode;
 };
 
 struct btd_adapter {
@@ -210,7 +212,7 @@ static const char *mode2str(uint8_t mode)
 	}
 }
 
-static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
+static uint8_t get_mode(const char *mode)
 {
 	if (strcasecmp("off", mode) == 0)
 		return MODE_OFF;
@@ -218,15 +220,7 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
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
 
@@ -331,6 +325,10 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		return err;
 
 done:
+	adapter->config.mode = new_mode;
+	if (new_mode != MODE_OFF)
+		adapter->config.on_mode = new_mode;
+
 	modestr = mode2str(new_mode);
 	write_device_mode(&adapter->bdaddr, modestr);
 
@@ -390,7 +388,7 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 	int err;
 
 	if (powered) {
-		mode = get_mode(&adapter->bdaddr, "on");
+		mode = adapter->config.on_mode;
 		return set_discoverable(adapter, mode == MODE_DISCOVERABLE,
 									id);
 	}
@@ -1403,7 +1401,7 @@ static DBusMessage *request_session(DBusConnection *conn,
 	if (!adapter->mode_sessions)
 		adapter->global_mode = adapter->mode;
 
-	new_mode = get_mode(&adapter->bdaddr, "on");
+	new_mode = adapter->config.on_mode;
 
 	req = find_session(adapter->mode_sessions, sender);
 	if (req) {
@@ -2312,21 +2310,15 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
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
+	if (mode)
+		*mode = adapter->config.mode;
 
 	if (on_mode)
-		*on_mode = get_mode(&adapter->bdaddr, "on");
+		*on_mode = adapter->config.on_mode;
 
 	if (discoverable_timeout)
 		*discoverable_timeout = adapter->discov_timeout;
@@ -2490,6 +2482,10 @@ static void set_mode_complete(struct btd_adapter *adapter)
 	const char *modestr;
 	int err;
 
+	adapter->config.mode = adapter->mode;
+	if (adapter->mode != MODE_OFF)
+		adapter->config.on_mode = adapter->mode;
+
 	modestr = mode2str(adapter->mode);
 	write_device_mode(&adapter->bdaddr, modestr);
 
@@ -2664,6 +2660,7 @@ static void load_config(struct btd_adapter *adapter)
 {
 	char name[MAX_NAME_LENGTH + 1];
 	char address[18];
+	char mode[14];
 	int timeout;
 
 	ba2str(&adapter->bdaddr, address);
@@ -2695,6 +2692,20 @@ static void load_config(struct btd_adapter *adapter)
 		adapter->discov_timeout = main_opts.discovto;
 	else
 		adapter->discov_timeout = timeout;
+
+	/* Get mode */
+	if (main_opts.remember_powered == FALSE)
+		adapter->config.mode = main_opts.mode;
+	else if (read_device_mode(address, mode, sizeof(mode)) == 0)
+		adapter->config.mode = get_mode(mode);
+	else
+		adapter->config.mode = main_opts.mode;
+
+	/* Get on mode */
+	if (read_on_mode(address, mode, sizeof(mode)) == 0)
+		adapter->config.on_mode = get_mode(mode);
+	else
+		adapter->config.on_mode = MODE_CONNECTABLE;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
@@ -3601,17 +3612,13 @@ gboolean adapter_powering_down(struct btd_adapter *adapter)
 
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
+	if (adapter->config.mode == MODE_OFF)
 		return 0;
 
 	return mgmt_set_powered(adapter->dev_id, TRUE);
-- 
1.7.9.5

