Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200801151220.58275.denis.kenzior@trolltech.com>
References: <200801151220.58275.denis.kenzior@trolltech.com>
Content-Type: multipart/mixed; boundary="=-QshRBMu19ne0PCQq5nEr"
Date: Wed, 16 Jan 2008 02:04:41 +0530
Message-Id: <1200429281.23989.58.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [HFP][PATCH] HFP options in audio.conf
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-QshRBMu19ne0PCQq5nEr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric, 

Attaching a patch for HFP AG feature options in audio.conf and the other
changes we discussed on #bluez yesterday. 

Let me know if something needs to be changed. 


-Alok.


--=-QshRBMu19ne0PCQq5nEr
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/audio.conf
===================================================================
RCS file: /cvsroot/bluez/utils/audio/audio.conf,v
retrieving revision 1.3
diff -u -5 -p -r1.3 audio.conf
--- audio/audio.conf	28 Aug 2007 11:49:37 -0000	1.3
+++ audio/audio.conf	15 Jan 2008 20:22:38 -0000
@@ -18,8 +18,20 @@
 
 # Set to true to only support HSP
 # Defaults to false
 DisableHFP=true
 
+# HFP Gateway features 
+# Defaults to false 
+3WayCalling=false
+EchoCancelNoiseCancel=false
+VoiceRecognition=false
+InBandRingtone=false
+VoiceTags=false
+RejectingCalls=false
+EnhancedCallStatus=false
+EnhancedCallControl=false
+ExtendedErrorResultCodes=false
+
 # Just an example of potential config options for the other interfaces
 #[A2DP]
 #SourceCount=2
Index: audio/manager.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.h,v
retrieving revision 1.31
diff -u -5 -p -r1.31 manager.h
--- audio/manager.h	8 Jan 2008 08:58:14 -0000	1.31
+++ audio/manager.h	15 Jan 2008 20:22:38 -0000
@@ -24,10 +24,12 @@
 
 #define MAX_PATH_LENGTH 64 /* D-Bus path */
 #define AUDIO_MANAGER_PATH "/org/bluez/audio"
 #define AUDIO_MANAGER_INTERFACE "org.bluez.audio.Manager"
 
+#define configfile CONFIGDIR"/audio.conf"
+
 struct enabled_interfaces {
 	gboolean headset;
 	gboolean gateway;
 	gboolean sink;
 	gboolean source;
@@ -35,13 +37,11 @@ struct enabled_interfaces {
 	gboolean target;
 };
 
 typedef void (*create_dev_cb_t) (struct device *dev, void *user_data);
 
-int audio_init(DBusConnection *conn, struct enabled_interfaces *enabled,
-		gboolean no_hfp, gboolean sco_hci, int source_count);
-
+int audio_init(DBusConnection *conn, GKeyFile *config);
 void audio_exit(void);
 
 uint32_t add_service_record(DBusConnection *conn, sdp_buf_t *buf);
 int remove_service_record(DBusConnection *conn, uint32_t rec_id);
 gboolean server_is_enabled(uint16_t svc);
Index: audio/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.c,v
retrieving revision 1.85
diff -u -5 -p -r1.85 manager.c
--- audio/manager.c	8 Jan 2008 08:58:14 -0000	1.85
+++ audio/manager.c	15 Jan 2008 20:22:39 -0000
@@ -105,11 +105,18 @@ static uint32_t hs_record_id = 0;
 static uint32_t hf_record_id = 0;
 
 static GIOChannel *hs_server = NULL;
 static GIOChannel *hf_server = NULL;
 
-static const struct enabled_interfaces *enabled;
+static struct enabled_interfaces enabled = {
+	.headset	= TRUE,
+	.gateway	= FALSE,
+	.sink		= TRUE,
+	.source		= FALSE,
+	.control	= TRUE,
+	.target		= FALSE,
+};
 
 static void get_next_record(struct audio_sdp_data *data);
 static DBusHandlerResult get_handles(const char *uuid,
 					struct audio_sdp_data *data);
 
@@ -223,14 +230,14 @@ gboolean server_is_enabled(uint16_t svc)
 		break;
 	case HANDSFREE_SVCLASS_ID:
 		ret = (hf_server != NULL);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
-		return enabled->sink;
+		return enabled.sink;
 	case AV_REMOTE_TARGET_SVCLASS_ID:
 	case AV_REMOTE_SVCLASS_ID:
-		return enabled->control;
+		return enabled.control;
 	default:
 		ret = FALSE;
 		break;
 	}
 
@@ -1067,15 +1074,15 @@ static void parse_stored_devices(char *k
 		return;
 
 	/* Change storage to source adapter */
 	bacpy(&device->store, src);
 
-	if (enabled->headset && strstr(value, "headset"))
+	if (enabled.headset && strstr(value, "headset"))
 		device->headset = headset_init(device, NULL, 0);
-	if (enabled->sink && strstr(value, "sink"))
+	if (enabled.sink && strstr(value, "sink"))
 		device->sink = sink_init(device);
-	if (enabled->control && strstr(value, "control"))
+	if (enabled.control && strstr(value, "control"))
 		device->control = control_init(device);
 	add_device(device, FALSE);
 }
 
 static void register_devices_stored(const char *adapter)
@@ -1527,16 +1534,18 @@ static GIOChannel *server_socket(uint8_t
 	}
 
 	return io;
 }
 
-static int headset_server_init(DBusConnection *conn, gboolean no_hfp)
+static int headset_server_init(DBusConnection *conn, GKeyFile *config)
 {
 	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
 	sdp_buf_t buf;
+	gboolean no_hfp = TRUE;
+	GError *err = NULL;
 
-	if (!(enabled->headset || enabled->gateway))
+	if (!(enabled.headset || enabled.gateway))
 		return 0;
 
 	hs_server = server_socket(&chan);
 	if (!hs_server)
 		return -1;
@@ -1555,10 +1564,19 @@ static int headset_server_init(DBusConne
 		return -1;
 	}
 
 	g_io_add_watch(hs_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 						(GIOFunc) ag_io_cb, NULL);
+	if (config) {
+		no_hfp = g_key_file_get_boolean(config, "Headset", "DisableHFP",
+				&err);
+		if (err) {
+			debug("%s: %s", configfile, err->message);
+			g_error_free(err);
+			err = NULL;
+		}
+	}
 
 	if (no_hfp)
 		return 0;
 
 	chan = DEFAULT_HF_AG_CHANNEL;
@@ -1608,42 +1626,97 @@ static void server_exit(void)
 		g_io_channel_unref(hf_server);
 		hf_server = NULL;
 	}
 }
 
-int audio_init(DBusConnection *conn, struct enabled_interfaces *enable,
-		gboolean no_hfp, gboolean sco_hci, int source_count)
+int audio_init(DBusConnection *conn, GKeyFile *config)
 {
-	int sinks, sources;
-
+	static int sinks, sources;
+	char *str;
+	GError *err = NULL;
 	connection = dbus_connection_ref(conn);
+	debug("config is %x",config);
+	if (config) {
+		str = g_key_file_get_string(config, "General", "Enable", &err);
+
+		if (err) {
+			debug("%s: %s", configfile, err->message);
+			g_error_free(err);
+			err = NULL;
+		} else {
+			if (strstr(str, "Headset"))
+				enabled.headset = TRUE;
+			if (strstr(str, "Gateway"))
+				enabled.gateway = TRUE;
+			if (strstr(str, "Sink"))
+				enabled.sink = TRUE;
+			if (strstr(str, "Source"))
+				enabled.source = TRUE;
+			if (strstr(str, "Control"))
+				enabled.control = TRUE;
+			if (strstr(str, "Target"))
+				enabled.target = TRUE;
+			g_free(str);
+		}
 
-	enabled = enable;
+		str = g_key_file_get_string(config, "General", "Disable", &err);
+
+		if (err) {
+			debug("%s: %s", configfile, err->message);
+			g_error_free(err);
+			err = NULL;
+		} else {
+			if (strstr(str, "Headset"))
+				enabled.headset = FALSE;
+			if (strstr(str, "Gateway"))
+				enabled.gateway = FALSE;
+			if (strstr(str, "Sink"))
+				enabled.sink = FALSE;
+			if (strstr(str, "Source"))
+				enabled.source = FALSE;
+			if (strstr(str, "Control"))
+				enabled.control = FALSE;
+			if (strstr(str, "Target"))
+				enabled.target = FALSE;
+			g_free(str);
+		}
+	}
 
 	if (!dbus_connection_create_object_path(conn, AUDIO_MANAGER_PATH,
 						NULL, manager_unregister)) {
 		error("D-Bus failed to register %s path", AUDIO_MANAGER_PATH);
 		goto failed;
 	}
 
-	if (headset_server_init(conn, no_hfp) < 0)
+	if (enabled.headset && headset_config_init(config) &&
+		headset_server_init(conn, config) < 0)
 		goto failed;
 
-	if (enable->sink)
-		sources = source_count;
-	else
+	if (enabled.sink) {
+		if (config) {
+			str = g_key_file_get_string(config, "A2DP", "SourceCount", &err);
+			if (err) {
+				debug("%s: %s", configfile, err->message);
+				g_error_free(err);
+				err = NULL;
+			} else {
+				sources = atoi(str);
+				g_free(str);
+			}
+		}
+	} else
 		sources = 0;
 
-	if (enable->source)
+	if (enabled.source)
 		sinks = 1;
 	else
 		sinks = 0;
 
 	if (a2dp_init(conn, sources, sinks) < 0)
 		goto failed;
 
-	if (enable->control && avrcp_init(conn) < 0)
+	if (enabled.control && avrcp_init(conn) < 0)
 		goto failed;
 
 	if (!dbus_connection_register_interface(conn, AUDIO_MANAGER_PATH,
 						AUDIO_MANAGER_INTERFACE,
 						manager_methods,
Index: audio/headset.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.h,v
retrieving revision 1.34
diff -u -5 -p -r1.34 headset.h
--- audio/headset.h	8 Jan 2008 08:58:14 -0000	1.34
+++ audio/headset.h	15 Jan 2008 20:22:40 -0000
@@ -45,10 +45,12 @@ typedef void (*headset_stream_cb_t) (str
 struct headset *headset_init(struct device *dev, sdp_record_t *record,
 				uint16_t svc);
 
 void headset_free(struct device *dev);
 
+int headset_config_init(GKeyFile *config);
+
 void headset_update(struct device *dev, sdp_record_t *record, uint16_t svc);
 
 unsigned int headset_request_stream(struct device *dev, headset_stream_cb_t cb,
 					void *user_data);
 gboolean headset_cancel_stream(struct device *dev, unsigned int id);
Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.157
diff -u -5 -p -r1.157 headset.c
--- audio/headset.c	11 Jan 2008 11:19:00 -0000	1.157
+++ audio/headset.c	15 Jan 2008 20:22:40 -0000
@@ -71,12 +71,14 @@
 #define AG_FEATURE_INBAND_RINGTONE               0x0008
 #define AG_FEATURE_ATTACH_NUMBER_TO_VOICETAG     0x0010
 #define AG_FEATURE_REJECT_A_CALL                 0x0020
 #define AG_FEATURE_ENHANCES_CALL_STATUS          0x0040
 #define AG_FEATURE_ENHANCES_CALL_CONTROL         0x0080
+#define AG_FEATURE_EXTENDED_ERROR_RESULT_CODES   0x0100
 /*Audio Gateway features.Default is In-band Ringtone*/
-static unsigned int ag_features = AG_FEATURE_INBAND_RINGTONE;
+static unsigned int ag_features;
+static gboolean sco_hci = TRUE;
 
 static char *str_state[] = {
 	"HEADSET_STATE_DISCONNECTED",
 	"HEADSET_STATE_CONNECT_IN_PROGRESS",
 	"HEADSET_STATE_CONNECTED",
@@ -1584,10 +1586,138 @@ register_iface:
 	}
 
 	return hs;
 }
 
+int headset_config_init(GKeyFile *config)
+{
+	GError *err = NULL;
+	gboolean value;
+	char *str;
+
+	/*Use the default values if there is no config file*/
+	if (config == NULL)
+		return 1;
+
+	str = g_key_file_get_string(config, "General", "SCORouting",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (strcmp(str, "PCM") == 0)
+			sco_hci = FALSE;
+		else if (strcmp(str, "HCI") == 0)
+			sco_hci = TRUE;
+		else
+			error("Invalid Headset Routing value: %s", str);
+		g_free(str);
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "3WayCalling",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_THREE_WAY_CALLING;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "EchoCancelNoiseCancel",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_EC_ANDOR_NR;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "VoiceRecognition",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_VOICE_RECOGNITION;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "InBandRingtone",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_INBAND_RINGTONE;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "VoiceTags",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_ATTACH_NUMBER_TO_VOICETAG;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "RejectingCalls",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_REJECT_A_CALL;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "EnhancedCallStatus",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_ENHANCES_CALL_STATUS;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "EnhancedCallControl",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_ENHANCES_CALL_CONTROL;
+	}
+
+	value = g_key_file_get_boolean(config, "Headset", "ExtendedErrorResultCodes",
+				&err);
+	if (err) {
+		debug("%s: %s", configfile, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		if (value)
+			ag_features |= AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
+	}
+
+	return 1;
+}
+
 void headset_free(struct device *dev)
 {
 	struct headset *hs = dev->headset;
 
 	if (hs->sco) {
Index: audio/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/main.c,v
retrieving revision 1.29
diff -u -5 -p -r1.29 main.c
--- audio/main.c	27 Nov 2007 09:15:54 -0000	1.29
+++ audio/main.c	15 Jan 2008 20:22:40 -0000
@@ -40,133 +40,38 @@
 #include "logging.h"
 #include "unix.h"
 #include "device.h"
 #include "manager.h"
 
-static gboolean disable_hfp = TRUE;
-static gboolean sco_hci = TRUE;
-static int source_count = 1;
-
 static GMainLoop *main_loop = NULL;
 
-static struct enabled_interfaces enabled = {
-	.headset	= TRUE,
-	.gateway	= FALSE,
-	.sink		= TRUE,
-	.source		= FALSE,
-	.control	= TRUE,
-	.target		= FALSE,
-};
-
 static void sig_term(int sig)
 {
 	g_main_loop_quit(main_loop);
 }
 
-static void read_config(const char *file)
+static GKeyFile *load_config_file(const char *file)
 {
-	GKeyFile *keyfile;
 	GError *err = NULL;
-	gboolean no_hfp;
-	char *str;
+	GKeyFile *keyfile;
 
 	keyfile = g_key_file_new();
 
 	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
 		error("Parsing %s failed: %s", file, err->message);
 		g_error_free(err);
 		g_key_file_free(keyfile);
-		return;
-	}
-
-	str = g_key_file_get_string(keyfile, "General", "SCORouting", &err);
-	if (err) {
-		debug("%s: %s", file, err->message);
-		g_error_free(err);
-		err = NULL;
-	} else {
-		if (strcmp(str, "PCM") == 0)
-			sco_hci = FALSE;
-		else if (strcmp(str, "HCI") == 0)
-			sco_hci = TRUE;
-		else
-			error("Invalid Headset Routing value: %s", str);
-		g_free(str);
-	}
-
-	str = g_key_file_get_string(keyfile, "General", "Enable", &err);
-	if (err) {
-		debug("%s: %s", file, err->message);
-		g_error_free(err);
-		err = NULL;
-	} else {
-		if (strstr(str, "Headset"))
-			enabled.headset = TRUE;
-		if (strstr(str, "Gateway"))
-			enabled.gateway = TRUE;
-		if (strstr(str, "Sink"))
-			enabled.sink = TRUE;
-		if (strstr(str, "Source"))
-			enabled.source = TRUE;
-		if (strstr(str, "Control"))
-			enabled.control = TRUE;
-		if (strstr(str, "Target"))
-			enabled.target = TRUE;
-		g_free(str);
+		return NULL;
 	}
-
-	str = g_key_file_get_string(keyfile, "General", "Disable", &err);
-	if (err) {
-		debug("%s: %s", file, err->message);
-		g_error_free(err);
-		err = NULL;
-	} else {
-		if (strstr(str, "Headset"))
-			enabled.headset = FALSE;
-		if (strstr(str, "Gateway"))
-			enabled.gateway = FALSE;
-		if (strstr(str, "Sink"))
-			enabled.sink = FALSE;
-		if (strstr(str, "Source"))
-			enabled.source = FALSE;
-		if (strstr(str, "Control"))
-			enabled.control = FALSE;
-		if (strstr(str, "Target"))
-			enabled.target = FALSE;
-		g_free(str);
-	}
-
-	no_hfp = g_key_file_get_boolean(keyfile, "Headset", "DisableHFP",
-					&err);
-	if (err) {
-		debug("%s: %s", file, err->message);
-		g_error_free(err);
-		err = NULL;
-	} else
-		disable_hfp = no_hfp;
-
-	str = g_key_file_get_string(keyfile, "A2DP", "SourceCount", &err);
-	if (err) {
-		debug("%s: %s", file, err->message);
-		g_error_free(err);
-		err = NULL;
-	} else {
-		source_count = atoi(str);
-		g_free(str);
-	}
-
-	debug("Config options: DisableHFP=%s, SCORouting=%s, SourceCount=%d",
-			disable_hfp ? "true" : "false",
-			sco_hci ? "HCI" : "PCM", source_count);
-
-	g_key_file_free(keyfile);
+	return keyfile;
 }
 
 int main(int argc, char *argv[])
 {
 	DBusConnection *conn;
 	struct sigaction sa;
+	GKeyFile *config;
 
 	start_logging("audio", "Bluetooth Audio daemon");
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags = SA_NOCLDSTOP;
@@ -178,11 +83,11 @@ int main(int argc, char *argv[])
 	sigaction(SIGCHLD, &sa, NULL);
 	sigaction(SIGPIPE, &sa, NULL);
 
 	enable_debug();
 
-	read_config(CONFIGDIR "/audio.conf");
+	config = load_config_file(CONFIGDIR "/audio.conf");
 
 	main_loop = g_main_loop_new(NULL, FALSE);
 
 	conn = dbus_bus_system_setup_with_main_loop(NULL, NULL, NULL);
 	if (!conn) {
@@ -193,18 +98,19 @@ int main(int argc, char *argv[])
 	if (unix_init() < 0) {
 		error("Unable to setup unix socket");
 		exit(1);
 	}
 
-	if (audio_init(conn, &enabled, disable_hfp, sco_hci,
-				source_count) < 0) {
+	if (audio_init(conn, config) < 0) {
 		error("Audio init failed!");
 		exit(1);
 	}
 
 	if (argc > 1 && !strcmp(argv[1], "-s"))
 		register_external_service(conn, "audio", "Audio service", "");
+	if (config)
+		g_key_file_free(config);
 
 	g_main_loop_run(main_loop);
 
 	audio_exit();
 

--=-QshRBMu19ne0PCQq5nEr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-QshRBMu19ne0PCQq5nEr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-QshRBMu19ne0PCQq5nEr--
