Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 27 Mar 2007 17:42:24 +0100
References: <200703252035.05891.dgollub@suse.de>
In-Reply-To: <200703252035.05891.dgollub@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wlUCG17/3/Rt0fe"
Message-Id: <200703271842.24684.dgollub@suse.de>
Subject: Re: [Bluez-devel] Input service and multiple adapters
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

--Boundary-00=_wlUCG17/3/Rt0fe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

as discussed in #bluez we should store the address of the adapter.
I renamed GetAddress() to GetPeerAddress() and added a new function 
GetLocalAddress(). Simple patch attachted ... i hope everyone is happy with 
this one...

best regards,
Daniel




--Boundary-00=_wlUCG17/3/Rt0fe
Content-Type: text/x-diff; charset="iso-8859-1";
	name="bluez-utils-input_service-localaddress.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-input_service-localaddress.diff"

Index: input/device.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/device.c,v
retrieving revision 1.37
diff -u -p -r1.37 device.c
--- input/device.c	22 Mar 2007 14:53:22 -0000	1.37
+++ input/device.c	27 Mar 2007 16:40:09 -0000
@@ -889,7 +889,28 @@ static DBusHandlerResult device_is_conne
 	return send_message_and_unref(conn, reply);
 }
 
-static DBusHandlerResult device_get_address(DBusConnection *conn,
+static DBusHandlerResult device_get_local_address(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct device *idev = data;
+	DBusMessage *reply;
+	char addr[18];
+	const char *paddr = addr;
+
+	ba2str(&idev->src, addr);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_STRING, &paddr,
+			DBUS_TYPE_INVALID);
+
+	return send_message_and_unref(conn, reply);
+}
+
+static DBusHandlerResult device_get_peer_address(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct device *idev = data;
@@ -983,8 +1004,11 @@ static DBusHandlerResult device_message(
 	if (strcmp(member, "IsConnected") == 0)
 		return device_is_connected(conn, msg, data);
 
-	if (strcmp(member, "GetAddress") == 0)
-		return device_get_address(conn, msg, data);
+	if (strcmp(member, "GetLocalAddress") == 0)
+		return device_get_local_address(conn, msg, data);
+
+	if (strcmp(member, "GetPeerAddress") == 0)
+		return device_get_peer_address(conn, msg, data);
 
 	if (strcmp(member, "GetName") == 0)
 		return device_get_name(conn, msg, data);
Index: input/input-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/input/input-api.txt,v
retrieving revision 1.8
diff -u -p -r1.8 input-api.txt
--- input/input-api.txt	22 Mar 2007 14:55:35 -0000	1.8
+++ input/input-api.txt	27 Mar 2007 16:40:09 -0000
@@ -48,7 +48,13 @@ Service		org.bluez.input
 Interface	org.bluez.input.Device
 Object path	/org/bluez/input/{keyboard*|mouse*|...}
 
-Methods		string GetAddress()
+Methods		string GetLocalAddress()
+
+			Returns the adapter address.
+
+			Example: "00:11:22:33:44:55"
+
+		string GetPeerAddress()
 
 			Returns the device address.
 

--Boundary-00=_wlUCG17/3/Rt0fe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_wlUCG17/3/Rt0fe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_wlUCG17/3/Rt0fe--
