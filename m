Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080227134910.GA26414@localhost>
References: <1204114452.25999.8.camel@greatbear>
	<20080227134910.GA26414@localhost>
Content-Type: multipart/mixed; boundary="=-9SJ6GRb76bsUaW8cN+Wq"
Date: Wed, 27 Feb 2008 20:35:26 +0530
Message-Id: <1204124727.25999.21.camel@greatbear>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [HFP][Patch] Plugin.
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


--=-9SJ6GRb76bsUaW8cN+Wq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Marcel, 

Attaching the updated Plugin patch.
Let me know what you think.

-Alok.


--=-9SJ6GRb76bsUaW8cN+Wq
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: acinclude.m4
===================================================================
RCS file: /cvsroot/bluez/utils/acinclude.m4,v
retrieving revision 1.127
diff -u -5 -p -r1.127 acinclude.m4
--- acinclude.m4	22 Feb 2008 08:22:07 -0000	1.127
+++ acinclude.m4	27 Feb 2008 14:59:57 -0000
@@ -60,14 +60,17 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 	else
 		storagedir="${localstatedir}/lib/bluetooth"
 	fi
 
 	servicedir="${libdir}/bluetooth"
+	
+	plugindir="${libdir}/bluetooth"
 
 	AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}", [Directory for the configuration files])
 	AC_DEFINE_UNQUOTED(STORAGEDIR, "${storagedir}", [Directory for the storage files])
 	AC_DEFINE_UNQUOTED(SERVICEDIR, "${servicedir}", [Directory for the service programs])
+	AC_DEFINE_UNQUOTED(PLUGINDIR, "${plugindir}", [Directory for the telephony plugins])
 ])
 
 AC_DEFUN([AC_PATH_BLUEZ], [
 	PKG_CHECK_MODULES(BLUEZ, bluez, dummy=yes, AC_MSG_ERROR(Bluetooth library is required))
 	AC_SUBST(BLUEZ_CFLAGS)
@@ -184,10 +187,11 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	alsa_enable=${alsa_found}
 	obex_enable=${openobex_found}
 	glib_enable=no
 	gstreamer_enable=${gstreamer_found}
 	audio_enable=yes
+	plugin_enable=no
 	input_enable=yes
 	serial_enable=yes
 	network_enable=yes
 	sync_enable=no
 	echo_enable=no
@@ -278,10 +282,14 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 
 	AC_ARG_ENABLE(audio, AC_HELP_STRING([--enable-audio], [enable audio service]), [
 		audio_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(plugin, AC_HELP_STRING([--enable-hfp-plugin], [enable telephony plugins]), [
+		plugin_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(input, AC_HELP_STRING([--enable-input], [enable input service]), [
 		input_enable=${enableval}
 	])
 
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--enable-serial], [enable serial service]), [
@@ -317,11 +325,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	])
 
 	AC_ARG_ENABLE(dund, AC_HELP_STRING([--enable-dund], [install DUN daemon]), [
 		dund_enable=${enableval}
 	])
-
 	
 	AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-test], [install test programs]), [
 		test_enable=${enableval}
 	])
 
@@ -413,10 +420,11 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes")
 	AM_CONDITIONAL(ALSA, test "${alsa_enable}" = "yes" && test "${alsa_found}" = "yes")
 	AM_CONDITIONAL(OBEX, test "${obex_enable}" = "yes" && test "${openobex_found}" = "yes")
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test "${gstreamer_found}" = "yes")
 	AM_CONDITIONAL(AUDIOSERVICE, test "${audio_enable}" = "yes")
+	AM_CONDITIONAL(PLUGIN, test "${plugin_enable}" = "yes")
 	AM_CONDITIONAL(INPUTSERVICE, test "${input_enable}" = "yes")
 	AM_CONDITIONAL(SERIALSERVICE, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKSERVICE, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SYNCSERVICE, test "${sync_enable}" = "yes" && test "${opensync_found}" = "yes")
 	AM_CONDITIONAL(ECHOSERVICE, test "${echo_enable}" = "yes")
Index: audio/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/audio/Makefile.am,v
retrieving revision 1.46
diff -u -5 -p -r1.46 Makefile.am
--- audio/Makefile.am	23 Jan 2008 15:18:15 -0000	1.46
+++ audio/Makefile.am	27 Feb 2008 14:59:57 -0000
@@ -14,11 +14,22 @@ bluetoothd_service_audio_SOURCES = main.
 	manager.h manager.c headset.h headset.c ipc.h ipc.c unix.h unix.c \
 	device.h device.c gateway.h gateway.c \
 	sink.c sink.h avdtp.c avdtp.h a2dp.c a2dp.h control.c control.h
 
 bluetoothd_service_audio_LDADD = $(top_builddir)/common/libhelper.a \
-				@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
+				@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@ @GMODULE_LIBS@
+
+if PLUGIN
+plugindir = $(libdir)/bluetooth
+
+plugin_LTLIBRARIES = hfp_plugin_test.la
+
+hfp_plugin_test_la_SOURCES = hfp_plugin_test.c hfp_plugin.h
+hfp_plugin_test_la_LDFLAGS = -module
+hfp_plugin_test_la_LIBADD = @GLIB_LIBS@
+hfp_plugin_test_la_CFLAGS = @GLIB_CFLAGS@
+endif
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
 
 alsa_LTLIBRARIES = libasound_module_pcm_bluetooth.la libasound_module_ctl_bluetooth.la
@@ -52,13 +63,12 @@ libgstbluetooth_la_LDFLAGS = -module -av
 libgstbluetooth_la_LIBADD = @SBC_LIBS@ @GSTREAMER_LIBS@ -lgstaudio-0.10 -lgstrtp-0.10
 libgstbluetooth_la_CFLAGS = @GSTREAMER_CFLAGS@ @SBC_CFLAGS@
 endif
 endif
 
-AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ @GMODULE_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
 EXTRA_DIST = audio.service audio.conf audio-api.txt test-audio asound.conf
 
 MAINTAINERCLEANFILES = Makefile.in
-
Index: audio/audio.conf
===================================================================
RCS file: /cvsroot/bluez/utils/audio/audio.conf,v
retrieving revision 1.5
diff -u -5 -p -r1.5 audio.conf
--- audio/audio.conf	23 Jan 2008 13:27:30 -0000	1.5
+++ audio/audio.conf	27 Feb 2008 14:59:57 -0000
@@ -30,9 +30,14 @@ VoiceTags=false
 RejectingCalls=false
 EnhancedCallStatus=false
 EnhancedCallControl=false
 ExtendedErrorResultCodes=false
 
+#HFP telephony plugin options
+Plugin=test
+#Values can be test, openmoko or telepathy based on 
+#the telephony system. 
+
 # Just an example of potential config options for the other interfaces
 #[A2DP]
 #SBCSources=1
 #MPEG12Sources=0
Index: audio/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.c,v
retrieving revision 1.90
diff -u -5 -p -r1.90 manager.c
--- audio/manager.c	19 Feb 2008 08:20:22 -0000	1.90
+++ audio/manager.c	27 Feb 2008 14:59:58 -0000
@@ -35,10 +35,12 @@
 #include <sys/stat.h>
 #include <dirent.h>
 #include <ctype.h>
 #include <signal.h>
 
+#include <gmodule.h>
+
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/rfcomm.h>
 #include <bluetooth/sdp.h>
@@ -105,10 +107,12 @@ static uint32_t hs_record_id = 0;
 static uint32_t hf_record_id = 0;
 
 static GIOChannel *hs_server = NULL;
 static GIOChannel *hf_server = NULL;
 
+static GModule *hfp_plugin = NULL;
+
 static struct enabled_interfaces enabled = {
 	.headset	= TRUE,
 	.gateway	= FALSE,
 	.sink		= TRUE,
 	.source		= FALSE,
@@ -1534,10 +1538,44 @@ static GIOChannel *server_socket(uint8_t
 	}
 
 	return io;
 }
 
+int load_hfp_plugin(GKeyFile *config)
+{
+	gchar *str = NULL;
+	GError *err = NULL;
+	char filename[PATH_MAX];
+
+	/*There is no audio.conf*/
+	/*Fall back to defaults*/
+	if (config == NULL)
+		return 0;
+
+	str = g_key_file_get_string(config, "Headset", "Plugin", &err);
+
+	if (err) {
+		debug("audio.conf: %s", err->message);
+		g_error_free(err);
+		err = NULL;
+		return -1;
+	}
+
+	snprintf(filename, sizeof(filename) - 1, "%s/hfp_plugin_%s.so", PLUGINDIR, str);
+	g_free(str);
+
+	debug("Plugin is %s", filename);
+	hfp_plugin = g_module_open(filename, G_MODULE_BIND_LAZY);
+
+	if (!hfp_plugin) {
+		debug("Error loading HFP plugin:%s", g_module_error ());
+		return -1;
+	}
+
+	return 0;
+}
+
 static int headset_server_init(DBusConnection *conn, GKeyFile *config)
 {
 	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
 	sdp_buf_t buf;
 	gboolean no_hfp = FALSE;
@@ -1582,15 +1620,22 @@ static int headset_server_init(DBusConne
 		return 0;
 
 	chan = DEFAULT_HF_AG_CHANNEL;
 
 	hf_server = server_socket(&chan);
+
 	if (!hf_server)
 		return -1;
 
+	if (load_hfp_plugin(config) < 0)
+		return -1;
+
 	features = headset_config_init(config);
 
+	if (features < 0)
+		return -1;
+
 	if (hfp_ag_record(&buf, chan, features) < 0) {
 		error("Unable to allocate new service record");
 		return -1;
 	}
 
@@ -1721,10 +1766,15 @@ failed:
 
 void audio_exit(void)
 {
 	server_exit();
 
+	if (hfp_plugin) {
+		if (!g_module_close(hfp_plugin))
+			debug("Error Unloading plugin:%s", g_module_error ());
+	}
+
 	dbus_connection_destroy_object_path(connection, AUDIO_MANAGER_PATH);
 
 	dbus_connection_unref(connection);
 
 	connection = NULL;

--=-9SJ6GRb76bsUaW8cN+Wq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-9SJ6GRb76bsUaW8cN+Wq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-9SJ6GRb76bsUaW8cN+Wq--
