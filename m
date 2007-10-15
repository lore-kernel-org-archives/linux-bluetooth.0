Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <471331EC.8050204@free.fr>
Date: Mon, 15 Oct 2007 11:25:00 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <4712383C.9030200@free.fr>
	<2d5a2c100710141848s5cc34c5bn71c077673114e924@mail.gmail.com>
In-Reply-To: <2d5a2c100710141848s5cc34c5bn71c077673114e924@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------090706050206090404050300"
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] [PATCH] Small headset.c fixes
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
--------------090706050206090404050300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luiz,
> Thought we should not emit Stopped signal please maintain the code
> for sco cleanup (close_sco), sco connection may fail or disconnected
> before we got a chance to change the state to playing.

This was bogus indeed, thanks for spotting that ;-)

> 
> Besides that it seems good to me.
> 

Here comes ans updated version of the patch. I moved close_sco to be 
executed at anytime, it doesn't hurt as close_sco does already check to
see if the the sco channel is already opened.

Cheers,

Fabien

--------------090706050206090404050300
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
 
@@ -1544,6 +1548,7 @@
 	case HEADSET_STATE_CONNECT_IN_PROGRESS:
 		break;
 	case HEADSET_STATE_CONNECTED:
+		close_sco(dev);
 		if (hs->state < state) {
 			g_io_add_watch(hs->rfcomm,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
@@ -1553,8 +1558,7 @@
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_INVALID);
-		} else {
-			close_sco(dev);
+		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			dbus_connection_emit_signal(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Stopped",

--------------090706050206090404050300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------090706050206090404050300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090706050206090404050300--
