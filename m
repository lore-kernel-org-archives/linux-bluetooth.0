Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 16 Aug 2006 21:41:32 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060816204132.GA20440@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
Mime-Version: 1.0
In-Reply-To: <20060816153432.GA13691@srcf.ucam.org>
Subject: [Bluez-devel] [PATCH] - add ConnectRemoteDevice method to dbus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I'm not sure if this is the best approach, but still:

The included patch adds a ConnectRemoteDevice method to the Bluez DBus 
interface. It's the effective equivalent of hcitool cc. The idea is to 
have somthing that can be used by a session daemon when it wants to 
reconnect to devices on login.

Index: dbus-adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-adapter.c,v
retrieving revision 1.70
diff -u -r1.70 dbus-adapter.c
--- dbus-adapter.c	15 Aug 2006 14:55:55 -0000	1.70
+++ dbus-adapter.c	16 Aug 2006 20:35:50 -0000
@@ -1648,6 +1648,56 @@
 
 }
 
+static DBusHandlerResult handle_dev_connect_remote_device_req(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	DBusError err;
+
+	struct hci_dbus_data *dbus_data = data;
+
+	const char *peer_addr;
+	bdaddr_t peer_bdaddr;
+	int dd, ptype;
+	uint16_t handle = 0;
+
+	dbus_error_init(&err);
+	dbus_message_get_args(msg, &err,
+				DBUS_TYPE_STRING, &peer_addr,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&err)) {
+		error("Can't extract message arguments:%s", err.message);
+		dbus_error_free(&err);
+		return error_invalid_arguments(conn, msg);
+	}
+
+	if (check_address(peer_addr) < 0)
+		return error_invalid_arguments(conn, msg);
+
+	str2ba(peer_addr, &peer_bdaddr);
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0)
+		return error_no_such_adapter(conn, msg);
+
+	ptype = HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH3 | HCI_DH5;
+
+	/* Send the HCI connect command */
+	if (hci_create_connection (dd, &peer_bdaddr, htobs(ptype), 0, 0x01, &handle, 25000) < 0) {		
+		error("Connect failed");
+		hci_close_dev(dd);
+		return error_failed(conn, msg, errno);
+	}
+
+	hci_close_dev(dd);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	return send_reply_and_unref(conn, reply);
+}
+
 static DBusHandlerResult handle_dev_create_bonding_req(DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	char filename[PATH_MAX + 1];
@@ -2365,6 +2415,7 @@
 
 	{ "DisconnectRemoteDevice",			handle_dev_disconnect_remote_device_req	},
 
+	{ "ConnectRemoteDevice",                        handle_dev_connect_remote_device_req },
 	{ "CreateBonding",				handle_dev_create_bonding_req		},
 	{ "CancelBonding",				handle_dev_cancel_bonding_req		},
 	{ "RemoveBonding",				handle_dev_remove_bonding_req		},
Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.40
diff -u -r1.40 dbus-api.txt
--- dbus-api.txt	9 Aug 2006 20:10:50 -0000	1.40
+++ dbus-api.txt	16 Aug 2006 20:35:51 -0000
@@ -553,6 +553,15 @@
 
 			Question: Can we find a better name?
 
+		void ConnectRemoteDevice(string address)
+
+		        This method creates a baseband connection to a specific
+			remote device.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NoSuchAdapter
+					 org.bluez.Error.Failed
+
 		void DisconnectRemoteDevice(string address)
 
 			This method disconnects a specific remote device by

Index: dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.22
diff -u -r1.22 dbus-test
--- dbus-test	9 Aug 2006 20:10:50 -0000	1.22
+++ dbus-test	16 Aug 2006 20:35:52 -0000
@@ -45,6 +45,7 @@
              "ClearRemoteAlias",
              "LastSeen",
              "LastUsed",
+	     "ConnectRemoteDevice",
              "DisconnectRemoteDevice",
              "CreateBonding",
              "CancelBondingProcess",
@@ -343,9 +344,14 @@
                    print self.device.LastUsed(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> LastUsed address' % self.name
+           elif self.cmd == 'ConnectRemoteDevice':
+               if len(self.cmd_args) == 1:
+                   print self.device.ConnectRemoteDevice(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> ConnectRemoteDevice address' % self.name
            elif self.cmd == 'DisconnectRemoteDevice':
                if len(self.cmd_args) == 1:
-                   print self.device.LastUsed(self.cmd_args[0])
+                   print self.device.DisconnectRemoteDevice(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> DisconnectRemoteDevice address' % self.name
            elif self.cmd == 'CreateBonding':

-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
