Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4796A192.8000308@aircable.net>
References: <4796A192.8000308@aircable.net>
Content-Type: multipart/mixed; boundary="=-fTjwfHYc1qGBIPCU+OBU"
Date: Wed, 23 Jan 2008 18:32:54 +0530
Message-Id: <1201093374.23161.19.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [HFP][PATCH] fixes CancelCall
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


--=-fTjwfHYc1qGBIPCU+OBU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric, 

This patch fixes CancelCall .

Let me know if anything needs to be changed.  

-Alok.

--=-fTjwfHYc1qGBIPCU+OBU
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.163
diff -u -5 -p -r1.163 headset.c
--- audio/headset.c	23 Jan 2008 12:13:30 -0000	1.163
+++ audio/headset.c	23 Jan 2008 12:33:59 -0000
@@ -1270,10 +1270,11 @@ static DBusHandlerResult hs_cancel_ringi
 						void *data)
 {
 	struct device *device = data;
 	struct headset *hs = device->headset;
 	DBusMessage *reply = NULL;
+	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
 		return error_not_connected(conn, msg);
 
 	reply = dbus_message_new_method_return(msg);
@@ -1287,10 +1288,19 @@ static DBusHandlerResult hs_cancel_ringi
 
 	g_source_remove(hs->ring_timer);
 	hs->ring_timer = 0;
 
 done:
+	if (hs->hfp_active) {
+		/*+CIEV: (callsetup = 0)*/
+		err = headset_send(hs, "\r\n+CIEV:3, 0\r\n");
+		if (err < 0) {
+			dbus_message_unref(reply);
+			return error_failed_errno(conn, msg, -err);
+		}
+	}
+
 	send_message_and_unref(conn, reply);
 
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 

--=-fTjwfHYc1qGBIPCU+OBU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-fTjwfHYc1qGBIPCU+OBU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-fTjwfHYc1qGBIPCU+OBU--
