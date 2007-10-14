Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4712383C.9030200@free.fr>
Date: Sun, 14 Oct 2007 17:39:40 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@xmission.com>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: multipart/mixed; boundary="------------020100060308090409030307"
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [PATCH] Small headset.c fixes
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

This is a multi-part message in MIME format.
--------------020100060308090409030307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Please find attached a rather small patch, that fixes some small issues 
i found while reading headset.c code:
  * make String representation of state consistent with the state name
  * send Stop() signal only if we transition from playing state, not 
playin_in_progress
  * remove unused io_id field.

Cheers,

Fabien


--------------020100060308090409030307
Content-Type: text/x-patch;
 name="headset.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="headset.patch"

Index: headset.c
===================================================================
--- headset.c	(révision 120)
+++ headset.c	(copie de travail)
@@ -63,14 +63,18 @@
 #define HEADSET_GAIN_SPEAKER 'S'
 #define HEADSET_GAIN_MICROPHONE 'M'
 
-static char *str_state[] = {"DISCONNECTED", "CONNECTING", "CONNECTED",
-				"STREAM_STARTING", "STREAMING"};
+static char *str_state[] = {
+	"HEADSET_STATE_DISCONNECTED", 
+	"HEADSET_STATE_CONNECT_IN_PROGRESS",
+	"HEADSET_STATE_CONNECTED",
+	"HEADSET_STATE_PLAY_IN_PROGRESS",
+	"HEADSET_STATE_PLAYING",
+	};
 
 struct pending_connect {
 	DBusMessage *msg;
 	DBusPendingCall *call;
 	GIOChannel *io;
-	guint io_id;
 	int sock;
 	int err;
 	unsigned int id;
@@ -489,9 +493,9 @@
 			return -err;
 		}
 
-		c->io_id = g_io_add_watch(c->io,
-					G_IO_OUT | G_IO_NVAL | G_IO_ERR | G_IO_HUP,
-					(GIOFunc) sco_connect_cb, device);
+		g_io_add_watch(c->io,
+				G_IO_OUT | G_IO_NVAL | G_IO_ERR | G_IO_HUP,
+				(GIOFunc) sco_connect_cb, device);
 	} else
 		do_callback = TRUE;
 
@@ -1553,7 +1557,7 @@
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_INVALID);
-		} else {
+		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			close_sco(dev);
 			dbus_connection_emit_signal(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,

--------------020100060308090409030307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------020100060308090409030307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020100060308090409030307--
