Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4593C480.5080806@nokia.com>
Date: Thu, 28 Dec 2006 15:20:00 +0200
From: Luciano Coelho <luciano.coelho@nokia.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------020806010206080402020006"
Subject: [Bluez-devel] [PATCH] New RemoteDeviceDisconnectionRequested signal
	implementation
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
--------------020806010206080402020006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel (and others),

As agreed last week, I've implemented a new D-Bus signal in hcid that 
allows upper-level applications to disconnect gracefuly before the ACL 
connection is terminated as a result of a call to RemoteDeviceDisconnect.

So, this is how it works: when the RemoteDeviceDisconnect is called, we 
send the new signal RemoteDeviceDisconnectionRequested(string bdaddr) 
and wait for 2 seconds before sending the disconnection command to the 
controller.  This enables the service implementations to disconnect in a 
nicer way, as specified in the profile specs (eg. in SIM Access Profile, 
a SIM_DISCONNECT_REQ can be sent by the client).

The change is not very big and should be backwards compatible, except 
for the fact that disconnections will take 2 seconds longer than before.

I also updated the documentation and the apitest script.

Please let me know what you think.

Cheers,
Luca.

--------------020806010206080402020006
Content-Type: text/x-patch;
 name="hcid_disconnect_signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid_disconnect_signal.patch"

Index: hcid/dbus-adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-adapter.c,v
retrieving revision 1.141
diff -u -r1.141 dbus-adapter.c
--- hcid/dbus-adapter.c	25 Dec 2006 15:06:01 -0000	1.141
+++ hcid/dbus-adapter.c	28 Dec 2006 13:06:01 -0000
@@ -1680,18 +1680,61 @@
 	return send_message_and_unref(conn, reply);
 }
 
-static DBusHandlerResult adapter_dc_remote_device(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+
+gboolean dc_pending_timeout_handler(void *data)
 {
+	int dd;
+	struct adapter *adapter = data;
+	struct pending_dc_info *pending_dc = adapter->pending_dc;
 	DBusMessage *reply;
 
+	dd = hci_open_dev(adapter->dev_id);
+
+	if (dd < 0) {
+ 		error_no_such_adapter(pending_dc->conn,
+				      pending_dc->msg);
+		dc_pending_timeout_cleanup(adapter);
+		return FALSE;
+	}
+
+	/* Send the HCI disconnect command */
+	if (hci_disconnect(dd, pending_dc->conn_handle,
+				HCI_OE_USER_ENDED_CONNECTION,
+			   	500) < 0) {
+		int err = errno;
+		error("Disconnect failed");
+		error_failed(pending_dc->conn, pending_dc->msg, err);
+	} else {
+		reply = dbus_message_new_method_return(pending_dc->msg);
+		if (!reply)
+			error("Failed to allocate disconnect reply");
+		else
+			send_message_and_unref(pending_dc->conn, reply);
+	}
+
+	hci_close_dev(dd);
+	dc_pending_timeout_cleanup(adapter);
+
+	return FALSE;
+}
+
+void dc_pending_timeout_cleanup(struct adapter *adapter)
+{
+	dbus_connection_unref(adapter->pending_dc->conn);
+	dbus_message_unref(adapter->pending_dc->msg);
+	free(adapter->pending_dc);
+	adapter->pending_dc = NULL;
+}
+
+static DBusHandlerResult adapter_dc_remote_device(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
 	struct adapter *adapter = data;
 	struct slist *l = adapter->active_conn;
 
 	const char *peer_addr;
 	bdaddr_t peer_bdaddr;
-	int dd;
-	struct active_conn_info *dev;
+	DBusMessage *signal;
 
 	if (!adapter->up)
 		return error_not_ready(conn, msg);
@@ -1710,29 +1753,38 @@
 	if (!l)
 		return error_not_connected(conn, msg);
 
-	dev = l->data;
+	if(adapter->pending_dc)
+		return error_disconnect_in_progress(conn, msg);
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return error_no_such_adapter(conn, msg);
+	adapter->pending_dc = malloc(sizeof(*adapter->pending_dc));
+	if(!adapter->pending_dc)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
-	/* Send the HCI disconnect command */
-	if (hci_disconnect(dd, dev->handle, HCI_OE_USER_ENDED_CONNECTION,
-				500) < 0) {
-		int err = errno;
-		error("Disconnect failed");
-		hci_close_dev(dd);
-		return error_failed(conn, msg, err);
+	/* Start waiting... */
+	adapter->pending_dc->timeout_id =
+		g_timeout_add(DC_PENDING_TIMEOUT,
+			      dc_pending_timeout_handler,
+			      adapter);
+
+	if(!adapter->pending_dc->timeout_id) {
+		free(adapter->pending_dc);
+		adapter->pending_dc = NULL;
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 	}
 
-	hci_close_dev(dd);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	adapter->pending_dc->conn = dbus_connection_ref(conn);
+	adapter->pending_dc->msg = dbus_message_ref(msg);
+	adapter->pending_dc->conn_handle =
+		((struct active_conn_info *) l->data)->handle;
+
+	/* ...and send a signal */
+	signal = dev_signal_factory(adapter->dev_id, "RemoteDeviceDisconnectionRequested",
+						DBUS_TYPE_STRING, &peer_addr,
+						DBUS_TYPE_INVALID);
+	send_message_and_unref(conn, signal);
 
-	return send_message_and_unref(conn, reply);
 
+	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
 static void reply_authentication_failure(struct bonding_request_info *bonding)
Index: hcid/dbus-adapter.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-adapter.h,v
retrieving revision 1.1
diff -u -r1.1 dbus-adapter.h
--- hcid/dbus-adapter.h	30 Oct 2006 18:39:38 -0000	1.1
+++ hcid/dbus-adapter.h	28 Dec 2006 13:06:01 -0000
@@ -34,6 +34,8 @@
 
 #define BONDING_TIMEOUT         45000 /* 45 sec */
 
+#define DC_PENDING_TIMEOUT      2000  /* 2 secs */
+
 /* Discover types */
 #define DISCOVER_TYPE_NONE	0x00
 #define STD_INQUIRY		0x01
@@ -77,6 +79,13 @@
 	uint16_t handle;
 };
 
+struct pending_dc_info {
+	DBusConnection *conn;
+	DBusMessage *msg;
+	uint16_t conn_handle;
+	guint timeout_id;
+};
+
 struct adapter {
 	uint16_t dev_id;
 	int up;
@@ -100,6 +109,7 @@
 	struct slist *active_conn;
 	struct bonding_request_info *bonding;
 	struct slist *pin_reqs;
+	struct pending_dc_info *pending_dc;
 };
 
 DBusHandlerResult handle_adapter_method(DBusConnection *conn, DBusMessage *msg, void *data);
@@ -112,4 +122,6 @@
 
 int pending_remote_name_cancel(struct adapter *adapter);
 
+void dc_pending_timeout_cleanup(struct adapter *adapter);
+
 #endif /* __ADAPTER_H */
Index: hcid/dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.91
diff -u -r1.91 dbus-api.txt
--- hcid/dbus-api.txt	25 Dec 2006 15:06:01 -0000	1.91
+++ hcid/dbus-api.txt	28 Dec 2006 13:06:01 -0000
@@ -679,15 +679,22 @@
 		void DisconnectRemoteDevice(string address)
 
 			This method disconnects a specific remote device by
-			terminating the low-level ACL connection. The use
-			of this method should be restricted to administrator
-			use only.
+			terminating the low-level ACL connection. The use of
+			this method should be restricted to administrator
+			use.
+
+			A RemoteDeviceDisconnectionRequested signal will be
+			sent and the actual disconnection will only happen 2
+			seconds later.  This enables upper-level applications
+			to terminate their connections gracefully before the
+			ACL connection is terminated.
 
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 					 org.bluez.Error.NoSuchAdapter
 					 org.bluez.Error.InvalidArguments
 			                 org.bluez.Error.NotConnected
+			                 org.bluez.Error.InProgress
 
 		void CreateBonding(string address)
 
@@ -905,6 +912,20 @@
 			                 org.bluez.Error.InProgress
 			                 org.bluez.Error.Failed
 
+		array{string} ListRemoteDevices()
+
+			List addresses of all known remote devices (seen, used or bonded).
+
+			Possible errors: none
+
+		array{string} ListRecentRemoteDevices(string date)
+
+			List addresses of all used or bonded remote devices since date.
+
+			date format is "YYYY-MM-DD HH:MM:SS GMT"
+
+			Possible errors: none
+
 Signals		void ModeChanged(string mode)
 
 			If the current mode is changed with SetMode this signal
@@ -987,6 +1008,12 @@
 			This signal will be send if a low level connection
 			between two devices has been created.
 
+		void RemoteDeviceDisconnectionRequested(string address)
+
+			This signal will be sent when a low level
+			disconnection to a remote device has been requested.
+			The actual disconnection will happen 2 seconds later.
+
 		void RemoteDeviceDisconnected(string address)
 
 			This signal will be send if a low level connection
@@ -1000,20 +1027,6 @@
 
 			Signals that a bonding was removed.
 
-		array{string} ListRemoteDevices()
-
-			List addresses of all known remote devices (seen, used or bonded).
-
-			Possible errors: none
-
-		array{string} ListRecentRemoteDevices(string date)
-
-			List addresses of all used or bonded remote devices since date.
-
-			date format is "YYYY-MM-DD HH:MM:SS GMT"
-
-			Possible errors: none
-
 
 Security hierarchy
 ==================
Index: hcid/dbus-error.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-error.c,v
retrieving revision 1.33
diff -u -r1.33 dbus-error.c
--- hcid/dbus-error.c	4 Dec 2006 12:53:58 -0000	1.33
+++ hcid/dbus-error.c	28 Dec 2006 13:06:01 -0000
@@ -278,6 +278,11 @@
 	return error_does_not_exist(conn, msg, "Trusted device does not exist");
 }
 
+DBusHandlerResult error_disconnect_in_progress(DBusConnection *conn, DBusMessage *msg)
+{
+	return error_in_progress(conn, msg, "Disconnection in progress");
+}
+
 
 static const char *strsdperror(int err)
 {
Index: hcid/dbus-error.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-error.h,v
retrieving revision 1.3
diff -u -r1.3 dbus-error.h
--- hcid/dbus-error.h	4 Dec 2006 12:53:58 -0000	1.3
+++ hcid/dbus-error.h	28 Dec 2006 13:06:01 -0000
@@ -65,5 +65,6 @@
 DBusHandlerResult error_audit_already_exists(DBusConnection *conn, DBusMessage *msg);
 DBusHandlerResult error_trusted_device_already_exists(DBusConnection *conn, DBusMessage *msg);
 DBusHandlerResult error_trusted_device_does_not_exists(DBusConnection *conn, DBusMessage *msg);
+DBusHandlerResult error_disconnect_in_progress(DBusConnection *conn, DBusMessage *msg);
 
 #endif /* __BLUEZ_DBUS_ERROR_H */
Index: hcid/dbus-hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-hci.c,v
retrieving revision 1.5
diff -u -r1.5 dbus-hci.c
--- hcid/dbus-hci.c	18 Dec 2006 12:58:35 -0000	1.5
+++ hcid/dbus-hci.c	28 Dec 2006 13:06:02 -0000
@@ -473,6 +473,14 @@
 		adapter->active_conn = NULL;
 	}
 
+	/* Check if there is a pending RemoteDeviceDisconnect request */
+	if (adapter->pending_dc) {
+ 		error_no_such_adapter(adapter->pending_dc->conn,
+				      adapter->pending_dc->msg);
+		g_timeout_remove(adapter->pending_dc->timeout_id);
+		dc_pending_timeout_cleanup(adapter);
+	}
+
 	free (adapter);
 
 unreg:
@@ -1742,6 +1750,20 @@
 		adapter->bonding = NULL;
 	}
 
+	/* Check if there is a pending RemoteDeviceDisconnect request */
+	if (adapter->pending_dc) {
+		DBusMessage *reply;
+
+		reply = dbus_message_new_method_return(adapter->pending_dc->msg);
+		if (!reply)
+			error("Failed to allocate disconnect reply");
+		else
+			send_message_and_unref(adapter->pending_dc->conn, reply);
+
+		g_timeout_remove(adapter->pending_dc->timeout_id);
+		dc_pending_timeout_cleanup(adapter);
+	}
+
 	/* Send the remote device disconnected signal */
 	message = dev_signal_factory(adapter->dev_id,
 					"RemoteDeviceDisconnected",
Index: test/apitest
===================================================================
RCS file: /cvsroot/bluez/utils/test/apitest,v
retrieving revision 1.3
diff -u -r1.3 apitest
--- test/apitest	10 Nov 2006 17:20:25 -0000	1.3
+++ test/apitest	28 Dec 2006 13:06:02 -0000
@@ -69,6 +69,7 @@
                 "RemoteAliasChanged"
                 "RemoteAliasCleared",
                 "RemoteDeviceConnected",
+                "RemoteDeviceDisconnectionRequested",
                 "RemoteDeviceDisconnected",
                 "BondingCreated",
                 "BondingRemoved" ]

--------------020806010206080402020006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020806010206080402020006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020806010206080402020006--
