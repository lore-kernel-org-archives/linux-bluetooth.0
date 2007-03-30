Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <460D363F.9010709@access-company.com>
Date: Fri, 30 Mar 2007 18:09:35 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45F16630.9000606@access-company.com>
In-Reply-To: <45F16630.9000606@access-company.com>
Content-Type: multipart/mixed; boundary="------------060708060509000001040808"
Subject: Re: [Bluez-devel] RemoteNameRequested signal during discovery patch
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
--------------060708060509000001040808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

A new version of the patch.
Are you okay with it ?

Thanks

Fred

Frederic Danis a écrit :
> Hello,
> 
> I wrote a little patch to add a DBus signal when a remote name is asked 
> by the service daemon during discovery, so discovery applications can 
> display this information to user.
> 
> Regards
> 
> Fred

--------------060708060509000001040808
Content-Type: text/plain;
 name="hcid_name_requested_signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid_name_requested_signal.patch"

? .deps
? .libs
? Makefile
? Makefile.in
? hcid
? lexer.c
? parser.c
? parser.h
Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.110
diff -a -u -r1.110 dbus-api.txt
--- dbus-api.txt	22 Mar 2007 01:56:44 -0000	1.110
+++ dbus-api.txt	30 Mar 2007 16:02:35 -0000
@@ -1030,6 +1030,11 @@
 			This signal will be sent every time the service daemon
 			tries to resolve a remote and this fails.
 
+		void RemoteNameRequested(string address)
+
+			This signal will be sent every time the service daemon
+			tries to resolve a remote name during discovery.
+
 		void RemoteAliasChanged(string address, string alias)
 
 			After changing an alias with SetRemoteAlias this
Index: dbus-hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-hci.c,v
retrieving revision 1.16
diff -a -u -r1.16 dbus-hci.c
--- dbus-hci.c	26 Feb 2007 14:13:50 -0000	1.16
+++ dbus-hci.c	30 Mar 2007 16:02:36 -0000
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
@@ -1032,21 +1032,32 @@
 		if (rp.status) {
 			error("Remote name request failed with status 0x%02x",
 					rp.status);
-			failed_signal = dev_signal_factory(adapter->dev_id,
+			signal = dev_signal_factory(adapter->dev_id,
 						"RemoteNameFailed",
 						DBUS_TYPE_STRING, &peer_addr,
 						DBUS_TYPE_INVALID);
 		}
 
+		if (!signal) {
+			req_sent = 1;
+			/* if we are in discovery, inform application of getting name */
+			if (adapter->discov_type & (STD_INQUIRY | PERIODIC_INQUIRY)) {
+				signal = dev_signal_factory(adapter->dev_id,
+							"RemoteNameRequested",
+							DBUS_TYPE_STRING, &peer_addr,
+							DBUS_TYPE_INVALID);
+			}
+		}
+
 		free(peer_addr);
 
-		if (!failed_signal) {
-			req_sent = 1;
-			break;
+		if (signal) {
+			send_message_and_unref(connection, signal);
+			signal = NULL;
 		}
 
-		send_message_and_unref(connection, failed_signal);
-		failed_signal = NULL;
+		if (req_sent)
+			break;
 
 		/* if failed, request the next element */
 		/* remove the element from the list */

--------------060708060509000001040808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------060708060509000001040808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060708060509000001040808--
