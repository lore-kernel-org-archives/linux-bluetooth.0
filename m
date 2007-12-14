Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47613E47.10305@access-company.com>
References: <47613E47.10305@access-company.com>
Content-Type: multipart/mixed; boundary="=-A40lbpMaLhPgPmsF4AK0"
Date: Fri, 14 Dec 2007 05:40:33 +0530
Message-Id: <1197591033.28907.18.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] HFP - Audio Gateway Features
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


--=-A40lbpMaLhPgPmsF4AK0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello, 

Sending a patch for the following : 

1. Added AG's Feature definitions + BRSF response. 

2. Modified headset_send() for variable args. 


Let me know if anything needs to be fixed. 



-Alok Barsode.


--=-A40lbpMaLhPgPmsF4AK0
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff --git a/audio/headset.c b/audio/headset.c
index e7425d5..ee9a57f 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -31,6 +31,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <signal.h>
 #include <string.h>
 #include <getopt.h>
@@ -64,6 +65,17 @@
 #define HEADSET_GAIN_SPEAKER 'S'
 #define HEADSET_GAIN_MICROPHONE 'M'
 
+#define AG_FEATURE_THREE_WAY_CALLING             0x0001
+#define AG_FEATURE_EC_ANDOR_NR                   0x0002
+#define AG_FEATURE_VOICE_RECOGNITION             0x0004
+#define AG_FEATURE_INBAND_RINGTONE               0x0008
+#define AG_FEATURE_ATTACH_NUMBER_TO_VOICETAG     0x0010
+#define AG_FEATURE_REJECT_A_CALL                 0x0020
+#define AG_FEATURE_ENHANCES_CALL_STATUS          0x0040
+#define AG_FEATURE_ENHANCES_CALL_CONTROL         0x0080
+/*Audio Gateway features.Default is In-band Ringtone*/
+static unsigned int ag_features = AG_FEATURE_INBAND_RINGTONE;
+
 static char *str_state[] = {
 	"HEADSET_STATE_DISCONNECTED",
 	"HEADSET_STATE_CONNECT_IN_PROGRESS",
@@ -120,21 +132,31 @@ struct event {
 static int rfcomm_connect(struct device *device, struct pending_connect *c);
 static int get_handles(struct device *device, struct pending_connect *c);
 
-static int headset_send(struct headset *hs, const char *str)
+static int headset_send(struct headset *hs, char *format, ...)
 {
+	char rsp[BUF_SIZE];
+	va_list ap;
 	GIOError err;
 	gsize total_written, written, count;
+	int er;
+
+	va_start(ap, hs);
+	er = vsnprintf(rsp, sizeof(rsp), format, ap);
+	va_end(ap);
+
+	if (er < 0)
+		return -EINVAL;
 
 	if (hs->state < HEADSET_STATE_CONNECTED || !hs->rfcomm) {
 		error("headset_send: the headset is not connected");
 		return -EIO;
 	}
 
-	count = strlen(str);
+	count = strlen(rsp);
 	written = total_written = 0;
 
 	while (total_written < count) {
-		err = g_io_channel_write(hs->rfcomm, str + total_written,
+		err = g_io_channel_write(hs->rfcomm, rsp + total_written,
 					count - total_written, &written);
 		if (err != G_IO_ERROR_NONE)
 			return -errno;
@@ -150,8 +172,7 @@ static int supported_features(struct device *device, const char *buf)
 	int err;
 
 	hs->hfp_features = strtoul(&buf[8], NULL, 10);
-
-	err = headset_send(hs, "\r\n+BRSF:0\r\n");
+	err = headset_send(hs, "\r\n+BRSF=%u\r\n", ag_features);
 	if (err < 0)
 		return err;
 
@@ -355,7 +376,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 	err = handle_event(device, &hs->buf[hs->data_start]);
 	if (err < 0)
 		error("Error handling command %s: %s (%d)", &hs->buf[hs->data_start],
-				strerror(-err), -err);
+		      strerror(-err), -err);
 
 	hs->data_start += cmd_len;
 	hs->data_length -= cmd_len;
@@ -1103,8 +1124,11 @@ error:
 static gboolean ring_timer_cb(gpointer data)
 {
 	struct device *device = data;
+	int err;
+
+	err = headset_send(device->headset, "\r\nRING\r\n");
 
-	if (headset_send(device->headset, "\r\nRING\r\n") != G_IO_ERROR_NONE)
+	if (err)
 		error("Sending RING failed");
 
 	return TRUE;
@@ -1116,6 +1140,7 @@ static DBusHandlerResult hs_ring(DBusConnection *conn, DBusMessage *msg,
 	struct device *device = data;
 	struct headset *hs = device->headset;
 	DBusMessage *reply = NULL;
+	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
 		return error_not_connected(conn, msg);
@@ -1129,7 +1154,8 @@ static DBusHandlerResult hs_ring(DBusConnection *conn, DBusMessage *msg,
 		goto done;
 	}
 
-	if (headset_send(device->headset, "\r\nRING\r\n") != G_IO_ERROR_NONE) {
+	err = headset_send(device->headset, "\r\nRING\r\n");
+	if (err) {
 		dbus_message_unref(reply);
 		return error_failed(conn, msg, "Failed");
 	}
@@ -1261,7 +1287,7 @@ static DBusHandlerResult hs_set_gain(DBusConnection *conn,
 	DBusMessage *reply;
 	DBusError derr;
 	dbus_uint16_t gain;
-	char str[13];
+	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
 		return error_not_connected(conn, msg);
@@ -1286,10 +1312,8 @@ static DBusHandlerResult hs_set_gain(DBusConnection *conn,
 
 	if (hs->state != HEADSET_STATE_PLAYING)
 		goto done;
-
-	snprintf(str, sizeof(str) - 1, "\r\n+VG%c=%u\r\n", type, gain);
-
-	if (headset_send(device->headset, str) != G_IO_ERROR_NONE) {
+	err = headset_send(device->headset, "\r\n+VG%c=%u\r\n", type, gain);
+	if (err) {
 		dbus_message_unref(reply);
 		return error_failed(conn, msg, "Unable to send to headset");
 	}
@@ -1584,7 +1608,6 @@ int headset_close_rfcomm(struct device *dev)
 void headset_set_state(struct device *dev, headset_state_t state)
 {
 	struct headset *hs = dev->headset;
-	char str[13];
 
 	if (hs->state == state)
 		return;
@@ -1629,17 +1652,11 @@ void headset_set_state(struct device *dev, headset_state_t state)
 						AUDIO_HEADSET_INTERFACE,
 						"Playing", DBUS_TYPE_INVALID);
 
-		if (hs->sp_gain >= 0) {
-			snprintf(str, sizeof(str) - 1, "\r\n+VGS=%u\r\n",
-				hs->sp_gain);
-			headset_send(hs, str);
-		}
+		if (hs->sp_gain >= 0)
+			headset_send(hs, "\r\n+VGS=%u\r\n", hs->sp_gain);
 
-		if (hs->mic_gain >= 0) {
-			snprintf(str, sizeof(str) - 1, "\r\n+VGM=%u\r\n",
-				hs->sp_gain);
-			headset_send(hs, str);
-		}
+		if (hs->mic_gain >= 0)
+			headset_send(hs, "\r\n+VGM=%u\r\n", hs->mic_gain);
 		break;
 	}
 

--=-A40lbpMaLhPgPmsF4AK0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-A40lbpMaLhPgPmsF4AK0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-A40lbpMaLhPgPmsF4AK0--
