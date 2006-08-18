Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44E5B2A5.1070002@palmsource.com>
Date: Fri, 18 Aug 2006 14:29:25 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20060816153432.GA13691@srcf.ucam.org>	<1155770177.4075.102.camel@aeonflux.holtmann.net>	<20060816214606.GA21719@srcf.ucam.org>	<1155819360.4075.123.camel@aeonflux.holtmann.net>	<20060817113538.GB5118@srcf.ucam.org>	<1155823499.4075.157.camel@aeonflux.holtmann.net>	<20060817122559.GA6422@srcf.ucam.org>	<20060817124514.GA27427@localhost.localdomain>	<1155819813.18545.36.camel@cookie.hadess.net>
	<1155839761.4075.165.camel@aeonflux.holtmann.net>
In-Reply-To: <1155839761.4075.165.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------010907020507080501050808"
Subject: Re: [Bluez-devel] DBus
	interface	-	determining	whether	a	device	exists
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
--------------010907020507080501050808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

>>>>I guess that since we don't have any guarantees that the device exists 
>>>>at any given point in time anyway, this makes less difference and we 
>>>>should just populate HAL regardless. I suppose I'm open to that.
>>>>        
>>>>
>>>Maybe you could simply use the list of bonded devices to populate HAL?
>>>You could use the ListBondings method and BondingCreated/BondingRemoved 
>>>signals for that.
>>>      
>>>
>>This is how MacOS X populates its selection lists. They have the list of
>>paired devices, as well as "Favourite" devices.
>>    
>>
>
>we also store the last seen (inquiry) and last used (connected) time of
>any device. This can be also used to populate the HAL list. For example
>it should include all bonded devices and additionally devices that have
>been connected in the last 7 days or so.
>  
>
In this case, I think it can be usefull to have same APIs in DBus for 
"used devices" than for "paired devices". You can find in attachement a 
patch that add ListUsed and RemovedUsed methods to hcid.
Hope this helps.

Regards

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


--------------010907020507080501050808
Content-Type: text/plain;
 name="dbus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dbus.patch"

diff -Naur hcid/dbus-adapter.c hcid.new/dbus-adapter.c
--- hcid/dbus-adapter.c	2006-08-18 12:02:36.000000000 +0200
+++ hcid.new/dbus-adapter.c	2006-08-18 12:06:50.000000000 +0200
@@ -1592,6 +1592,81 @@
 	return send_reply_and_unref(conn, reply);
 }
 
+static DBusHandlerResult handle_dev_remove_used_req(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply;
+	DBusMessage *signal;
+	DBusError err;
+	char filename[PATH_MAX + 1];
+	char *addr_ptr;
+
+	dbus_error_init(&err);
+	dbus_message_get_args(msg, &err,
+				DBUS_TYPE_STRING, &addr_ptr,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&err)) {
+		error("Can't extract message arguments:%s", err.message);
+		dbus_error_free(&err);
+		return error_invalid_arguments(conn, msg);
+	}
+
+	if (check_address(addr_ptr) < 0)
+		return error_invalid_arguments(conn, msg);
+
+	snprintf(filename, PATH_MAX, "%s/%s/lastused", STORAGEDIR, dbus_data->address);
+
+	/* Delete the used info from storage */
+	if (textfile_del(filename, addr_ptr))
+		return error_bonding_does_not_exist(conn, msg);
+
+	/* FIXME: which condition must be verified before send the signal */
+	signal = dev_signal_factory(dbus_data->dev_id, "UsedRemoved",
+					DBUS_TYPE_STRING, &addr_ptr,
+					DBUS_TYPE_INVALID);
+	if (signal) {
+		dbus_connection_send(conn, signal, NULL);
+		dbus_connection_flush(conn);
+		dbus_message_unref(signal);
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	return send_reply_and_unref(conn, reply);
+}
+
+static DBusHandlerResult handle_dev_list_used_req(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	void do_append(char *key, char *value, void *data)
+	{
+		DBusMessageIter *iter = data;
+
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &key);
+	}
+
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessage *reply;
+	char filename[PATH_MAX + 1];
+
+	snprintf(filename, PATH_MAX, "%s/%s/lastused", STORAGEDIR, dbus_data->address);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+	textfile_foreach(filename, do_append, &array_iter);
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return send_reply_and_unref(conn, reply);
+}
+
 static DBusHandlerResult handle_dev_disconnect_remote_device_req(DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
@@ -2362,6 +2437,8 @@
 
 	{ "LastSeen",					handle_dev_last_seen_req		},
 	{ "LastUsed",					handle_dev_last_used_req		},
+	{ "RemoveUsed",					handle_dev_remove_used_req		},
+	{ "ListUsed",					handle_dev_list_used_req		},
 
 	{ "DisconnectRemoteDevice",			handle_dev_disconnect_remote_device_req	},
 
diff -Naur hcid/dbus-api.txt hcid.new/dbus-api.txt
--- hcid/dbus-api.txt	2006-08-18 11:58:05.000000000 +0200
+++ hcid.new/dbus-api.txt	2006-08-18 12:07:05.000000000 +0200
@@ -553,6 +553,23 @@
 
 			Question: Can we find a better name?
 
+		array{string} ListUsed()
+
+			List device addresses of already used adapter.
+
+			Possible errors: none
+
+		void RemoveUsed(string address)
+
+			This method removes the used info of a remote device.
+
+			After deleting the link key this method will send a
+			UsedRemoved signal.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
 		void DisconnectRemoteDevice(string address)
 
 			This method disconnects a specific remote device by
@@ -791,6 +808,10 @@
 
 			Signals that a bonding was removed.
 
+		void UsedRemoved(string address)
+
+			Signals that a used info was removed.
+
 
 Security hierarchy
 ==================
diff -Naur hcid/dbus-test hcid.new/dbus-test
--- hcid/dbus-test	2006-08-18 11:58:05.000000000 +0200
+++ hcid.new/dbus-test	2006-08-18 12:07:12.000000000 +0200
@@ -45,6 +45,8 @@
              "ClearRemoteAlias",
              "LastSeen",
              "LastUsed",
+             "RemoveUsed",
+             "ListUsed",
              "DisconnectRemoteDevice",
              "CreateBonding",
              "CancelBondingProcess",
@@ -69,7 +71,8 @@
                 "RemoteDeviceConnected",
                 "RemoteDeviceDisconnected",
                 "BondingCreated",
-                "BondingRemoved" ]
+                "BondingRemoved",
+                "UsedRemoved" ]
 
 dev_signals_filter = [ "/org/bluez/hci0", "/org/bluez/hci1",
                        "/org/bluez/hci2", "/org/bluez/hci3",
@@ -343,6 +346,15 @@
                    print self.device.LastUsed(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> LastUsed address' % self.name
+           elif self.cmd == 'RemoveUsed':
+               if len(self.cmd_args) == 1:
+                   print self.device.RemoveUsed(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> RemoveUsed address' % self.name
+           elif self.cmd == 'ListUsed':
+               used = self.device.ListUsed()
+               for address in used: 
+                   print address,
            elif self.cmd == 'DisconnectRemoteDevice':
                if len(self.cmd_args) == 1:
                    print self.device.LastUsed(self.cmd_args[0])

--------------010907020507080501050808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------010907020507080501050808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010907020507080501050808--
