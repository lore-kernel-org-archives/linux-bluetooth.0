Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v14 11/14] audio: Replace headset and gateway by telephony
Date: Fri, 20 Jul 2012 10:57:34 +0200
Message-Id: <1342774657-29392-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1342774657-29392-1-git-send-email-frederic.danis@linux.intel.com>
References: <1342774657-29392-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace Headset and Gateway configuration options by new
Telephony option.
Remove HFP option  in Headset section as it is no more
relevant.
---
 audio/audio.conf |    8 ++---
 audio/manager.c  |   90 ++++++++++++------------------------------------------
 audio/manager.h  |    4 +--
 3 files changed, 23 insertions(+), 79 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 9e9e664..2878030 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -8,8 +8,8 @@
 #Master=true
 
 # If we want to disable support for specific services
-# Defaults to supporting the services: HFP, Headset, Sink, Control and Media
-#Disable=Gateway,Source
+# Defaults to supporting the services: Telephony, Sink, Control and Media
+#Disable=Source
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
 # Defaults to HCI
@@ -25,9 +25,5 @@
 # service interacts with remote headset devices)
 [Headset]
 
-# Set to true to support HFP, false means only HSP is supported
-# Defaults to true
-HFP=true
-
 # Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
 MaxConnected=1
diff --git a/audio/manager.c b/audio/manager.c
index 5dcf52d..5a90398 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -100,9 +100,7 @@ static GSList *adapters = NULL;
 static GSList *devices = NULL;
 
 static struct enabled_interfaces enabled = {
-	.hfp		= TRUE,
-	.headset	= TRUE,
-	.gateway	= FALSE,
+	.telephony	= TRUE,
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
@@ -126,13 +124,13 @@ gboolean server_is_enabled(bdaddr_t *src, uint16_t svc)
 {
 	switch (svc) {
 	case HEADSET_SVCLASS_ID:
-		return enabled.headset;
+		return enabled.telephony;
 	case HEADSET_AGW_SVCLASS_ID:
 		return FALSE;
 	case HANDSFREE_SVCLASS_ID:
-		return enabled.headset && enabled.hfp;
+		return enabled.telephony;
 	case HANDSFREE_AGW_SVCLASS_ID:
-		return enabled.gateway;
+		return enabled.telephony;
 	case AUDIO_SINK_SVCLASS_ID:
 		return enabled.sink;
 	case AUDIO_SOURCE_SVCLASS_ID:
@@ -189,7 +187,7 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
 		DBG("Found Handsfree AG record");
-		if (enabled.gateway && (device->gateway == NULL))
+		if (enabled.telephony && (device->gateway == NULL))
 			device->gateway = gateway_init(device);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
@@ -350,7 +348,7 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 	telephony = FALSE;
 }
 
-static int headset_server_probe(struct btd_adapter *adapter)
+static int telephony_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
@@ -368,7 +366,7 @@ static int headset_server_probe(struct btd_adapter *adapter)
 	return 0;
 }
 
-static void headset_server_remove(struct btd_adapter *adapter)
+static void telephony_server_remove(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
 	const gchar *path = adapter_get_path(adapter);
@@ -384,31 +382,6 @@ static void headset_server_remove(struct btd_adapter *adapter)
 	audio_adapter_unref(adp);
 }
 
-static int gateway_server_probe(struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-
-	adp = audio_adapter_get(adapter);
-	if (!adp)
-		return -EINVAL;
-
-	return 0;
-}
-
-static void gateway_server_remove(struct btd_adapter *adapter)
-{
-	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	adp = find_adapter(adapters, adapter);
-	if (!adp)
-		return;
-
-	audio_adapter_unref(adp);
-}
-
 static int a2dp_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
@@ -533,16 +506,10 @@ static struct btd_device_driver audio_driver = {
 	.remove	= audio_remove,
 };
 
-static struct btd_adapter_driver headset_server_driver = {
-	.name	= "audio-headset",
-	.probe	= headset_server_probe,
-	.remove	= headset_server_remove,
-};
-
-static struct btd_adapter_driver gateway_server_driver = {
-	.name	= "audio-gateway",
-	.probe	= gateway_server_probe,
-	.remove	= gateway_server_remove,
+static struct btd_adapter_driver telephony_server_driver = {
+	.name	= "telephony",
+	.probe	= telephony_server_probe,
+	.remove	= telephony_server_remove,
 };
 
 static struct btd_adapter_driver a2dp_server_driver = {
@@ -581,10 +548,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 	list = g_key_file_get_string_list(config, "General", "Enable",
 						NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Headset"))
-			enabled.headset = TRUE;
-		else if (g_str_equal(list[i], "Gateway"))
-			enabled.gateway = TRUE;
+		if (g_str_equal(list[i], "Telephony"))
+			enabled.telephony = TRUE;
 		else if (g_str_equal(list[i], "Sink"))
 			enabled.sink = TRUE;
 		else if (g_str_equal(list[i], "Source"))
@@ -600,10 +565,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 	list = g_key_file_get_string_list(config, "General", "Disable",
 						NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Headset"))
-			enabled.headset = FALSE;
-		else if (g_str_equal(list[i], "Gateway"))
-			enabled.gateway = FALSE;
+		if (g_str_equal(list[i], "Telephony"))
+			enabled.telephony = FALSE;
 		else if (g_str_equal(list[i], "Sink"))
 			enabled.sink = FALSE;
 		else if (g_str_equal(list[i], "Source"))
@@ -622,13 +585,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 	} else
 		auto_connect = b;
 
-	b = g_key_file_get_boolean(config, "Headset", "HFP",
-					&err);
-	if (err)
-		g_clear_error(&err);
-	else
-		enabled.hfp = b;
-
 	err = NULL;
 	i = g_key_file_get_integer(config, "Headset", "MaxConnected",
 					&err);
@@ -645,18 +601,15 @@ proceed:
 	if (enabled.media)
 		btd_register_adapter_driver(&media_server_driver);
 
-	if (enabled.headset)
-		btd_register_adapter_driver(&headset_server_driver);
-
-	if (enabled.gateway)
-		btd_register_adapter_driver(&gateway_server_driver);
+	if (enabled.telephony)
+		btd_register_adapter_driver(&telephony_server_driver);
 
 	if (enabled.source || enabled.sink)
 		btd_register_adapter_driver(&a2dp_server_driver);
 
 	btd_register_device_driver(&audio_driver);
 
-	*enable_sco = (enabled.gateway || enabled.headset);
+	*enable_sco = (enabled.telephony);
 
 	return 0;
 }
@@ -678,11 +631,8 @@ void audio_manager_exit(void)
 	if (enabled.media)
 		btd_unregister_adapter_driver(&media_server_driver);
 
-	if (enabled.headset)
-		btd_unregister_adapter_driver(&headset_server_driver);
-
-	if (enabled.gateway)
-		btd_unregister_adapter_driver(&gateway_server_driver);
+	if (enabled.telephony)
+		btd_unregister_adapter_driver(&telephony_server_driver);
 
 	if (enabled.source || enabled.sink)
 		btd_unregister_adapter_driver(&a2dp_server_driver);
diff --git a/audio/manager.h b/audio/manager.h
index 85e5065..cd13a59 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -23,9 +23,7 @@
  */
 
 struct enabled_interfaces {
-	gboolean hfp;
-	gboolean headset;
-	gboolean gateway;
+	gboolean telephony;
 	gboolean sink;
 	gboolean source;
 	gboolean control;
-- 
1.7.9.5

