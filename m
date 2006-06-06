Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4485929B.8010602@palmsource.com>
Date: Tue, 06 Jun 2006 16:35:07 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------080103080900000001040602"
Subject: [Bluez-devel] [PATCH] DBus GetRemoteName problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080103080900000001040602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

When I use GetRemoteName of dbus-test program I receive a 
DiscoveryCompleted signal after the RemoteNameUpdated (or 
RemoteNameFailed) signal.
You can find attached a patch to fix this.

Hope this helps.

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


--------------080103080900000001040602
Content-Type: text/plain;
 name="fix_dbus_get_remote_name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_dbus_get_remote_name.patch"

--- dbus-adapter.c.orig	2006-06-06 11:35:32.000000000 +0200
+++ dbus-adapter.c	2006-06-06 14:51:57.000000000 +0200
@@ -1255,8 +1255,7 @@
 	 * Otherwise, send the HCI cmd to get the remote name
 	 */
 	if (dbus_data->discover_state == STATE_IDLE) {
-		if (!disc_device_req_name(dbus_data))
-			dbus_data->discover_state = STATE_RESOLVING_NAMES;
+		disc_device_req_name(dbus_data);
 	}
 
 	return error_request_deferred(conn, msg);

--------------080103080900000001040602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080103080900000001040602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080103080900000001040602--
