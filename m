Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] input: Control HID encryption from input.conf
Message-Id: <20140305221503.CBDCE100321@puck.mtv.corp.google.com>
Date: Wed,  5 Mar 2014 14:15:03 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for optional config item "Encryption=<true|false>" in input.conf.
Allows HID encryption to be disabled for keyboards and keyboard-like devices
that don't work properly with encryption due to firmware bugs.
---
 profiles/input/device.c  |  8 +++++++-
 profiles/input/device.h  |  1 +
 profiles/input/manager.c | 21 ++++++++++++++++-----
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d6e97c7..e2f97dc 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -85,12 +85,18 @@ struct input_device {
 };
 
 static int idle_timeout = 0;
+static gboolean encryption_enabled = TRUE;
 
 void input_set_idle_timeout(int timeout)
 {
 	idle_timeout = timeout;
 }
 
+void input_enable_encryption(gboolean state)
+{
+	encryption_enabled = state;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 
 static void input_device_free(struct input_device *idev)
@@ -424,7 +430,7 @@ static int hidp_add_connection(struct input_device *idev)
 		strncpy(req->name, idev->name, sizeof(req->name) - 1);
 
 	/* Encryption is mandatory for keyboards */
-	if (req->subclass & 0x40) {
+	if (encryption_enabled && (req->subclass & 0x40)) {
 		if (!bt_io_set(idev->intr_io, &gerr,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID)) {
diff --git a/profiles/input/device.h b/profiles/input/device.h
index da2149c..af9f5ea 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -28,6 +28,7 @@ struct input_device;
 struct input_conn;
 
 void input_set_idle_timeout(int timeout);
+void input_enable_encryption(gboolean state);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 6ef83f4..1a70391 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -97,15 +97,26 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
+		gboolean encryption;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
-						"IdleTimeout", &err);
-		if (err) {
-			DBG("input.conf: %s", err->message);
-			g_error_free(err);
+							"IdleTimeout", &err);
+		if (!err) {
+			DBG("input.conf: IdleTimeout=%d", idle_timeout);
+			input_set_idle_timeout(idle_timeout * 60);
+		} else {
+			g_clear_error(&err);
 		}
 
-		input_set_idle_timeout(idle_timeout * 60);
+		encryption = g_key_file_get_boolean(config, "General",
+							"Encryption", &err);
+		if (!err) {
+			DBG("input.conf: Encryption=%s", encryption ?
+							"true" : "false");
+			input_enable_encryption(encryption);
+		} else {
+			g_clear_error(&err);
+		}
 	}
 
 	btd_profile_register(&input_profile);
-- 
1.9.0.279.gdc9e3eb

