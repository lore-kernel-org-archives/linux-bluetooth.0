Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F16630.9000606@access-company.com>
Date: Fri, 09 Mar 2007 14:50:40 +0100
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------020800070500040703030207"
Subject: [Bluez-devel] RemoteNameRequested signal during discovery patch
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
--------------020800070500040703030207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I wrote a little patch to add a DBus signal when a remote name is asked 
by the service daemon during discovery, so discovery applications can 
display this information to user.

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------


--------------020800070500040703030207
Content-Type: text/plain;
 name="hcid_name_requested_signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid_name_requested_signal.patch"

? hcid/.deps
? hcid/.libs
? hcid/Makefile
? hcid/Makefile.in
? hcid/hcid
? hcid/lexer.c
? hcid/parser.c
? hcid/parser.h
Index: hcid/dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.108
diff -u -r1.108 dbus-api.txt
--- hcid/dbus-api.txt	6 Mar 2007 13:37:39 -0000	1.108
+++ hcid/dbus-api.txt	9 Mar 2007 11:14:46 -0000
@@ -1021,6 +1021,11 @@
 			This signal will be sent every time the service daemon
 			tries to resolve a remote and this fails.
 
+		void RemoteNameRequested(string address)
+
+			This signal will be sent every time the service daemon
+			tries to resolve a remote name during discovery.
+
 		void RemoteAliasChanged(string address, string alias)
 
 			After changing an alias with SetRemoteAlias this
Index: hcid/dbus-hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-hci.c,v
retrieving revision 1.16
diff -u -r1.16 dbus-hci.c
--- hcid/dbus-hci.c	26 Feb 2007 14:13:50 -0000	1.16
+++ hcid/dbus-hci.c	9 Mar 2007 11:14:47 -0000
@@ -1005,7 +1005,7 @@
 
 	/* send at least one request or return failed if the list is empty */
 	do {
-		DBusMessage *failed_signal = NULL;
+		DBusMessage *signal = NULL;
 		struct remote_dev_info *dev = l->data;
 		char *peer_addr;
 		bdaddr_t tmp;
@@ -1023,7 +1023,7 @@
 		if (hci_send_req(dd, &rq, 500) < 0) {
 			error("Unable to send the HCI remote name request: %s (%d)",
 						strerror(errno), errno);
-			failed_signal = dev_signal_factory(adapter->dev_id,
+			signal = dev_signal_factory(adapter->dev_id,
 						"RemoteNameFailed",
 						DBUS_TYPE_STRING, &peer_addr,
 						DBUS_TYPE_INVALID);
@@ -1032,21 +1032,30 @@
 		if (rp.status) {
 			error("Remote name request failed with status 0x%02x",
 					rp.status);
-			failed_signal = dev_signal_factory(adapter->dev_id,
+			signal = dev_signal_factory(adapter->dev_id,
 						"RemoteNameFailed",
 						DBUS_TYPE_STRING, &peer_addr,
 						DBUS_TYPE_INVALID);
 		}
 
-		free(peer_addr);
-
-		if (!failed_signal) {
+		if (!signal) {
 			req_sent = 1;
-			break;
+			/* if we are in discovery, inform application of getting name */
+			if (adapter->discov_type & (STD_INQUIRY | PERIODIC_INQUIRY)) {
+				signal = dev_signal_factory(adapter->dev_id,
+							"RemoteNameRequested",
+							DBUS_TYPE_STRING, &peer_addr,
+							DBUS_TYPE_INVALID);
+			} else {
+				free(peer_addr);
+				break;
+			}
 		}
 
-		send_message_and_unref(connection, failed_signal);
-		failed_signal = NULL;
+		free(peer_addr);
+
+		send_message_and_unref(connection, signal);
+		signal = NULL;
 
 		/* if failed, request the next element */
 		/* remove the element from the list */

--------------020800070500040703030207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020800070500040703030207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020800070500040703030207--
