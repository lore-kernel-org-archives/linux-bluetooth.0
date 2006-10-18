Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45362E18.1040909@palmsource.com>
Date: Wed, 18 Oct 2006 15:37:28 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20060816153432.GA13691@srcf.ucam.org>	<1155770177.4075.102.camel@aeonflux.holtmann.net>	<20060816214606.GA21719@srcf.ucam.org>	<1155819360.4075.123.camel@aeonflux.holtmann.net>	<20060817113538.GB5118@srcf.ucam.org>	<1155823499.4075.157.camel@aeonflux.holtmann.net>	<20060817122559.GA6422@srcf.ucam.org>	<20060817124514.GA27427@localhost.localdomain>	<1155819813.18545.36.camel@cookie.hadess.net>	<1155839761.4075.165.camel@aeonflux.holtmann.net>	<44E5B2A5.1070002@palmsource.com>
	<1155924372.4075.191.camel@aeonflux.holtmann.net>
In-Reply-To: <1155924372.4075.191.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------000104030500090905080204"
Subject: Re: [Bluez-devel]
	DBus	interface	-	determining	whether	a	device	exists
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
--------------000104030500090905080204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,

>>> we also store the last seen (inquiry) and last used (connected) time of
>>> any device. This can be also used to populate the HAL list. For example
>>> it should include all bonded devices and additionally devices that have
>>> been connected in the last 7 days or so.
>>>
>>>       
>> In this case, I think it can be usefull to have same APIs in DBus for 
>> "used devices" than for "paired devices". You can find in attachement a 
>> patch that add ListUsed and RemovedUsed methods to hcid.
>> Hope this helps.
>>     
>
> I am not happy about the RemoveUsed method. I am not sure if one
> application should be able to say when a used device will be removed
> from the list. I think this should be application specific.
>
> I also might prefer to name the method ListRemoteDevices to list all
> paired, seen and used remote devices. We can then have special versions
> of this method for specific tasks. For example ListRecentRemoteDevices
> with a date parameter that will only list paired and used devices in
> that time frame.
>
> Regards
>
> Marcel
>
>   
You can find attached a new patch implementing ListRemoteDevices and 
ListRecentRemoteDevices.

Regards

Fred

--------------000104030500090905080204
Content-Type: text/x-patch;
 name="hcid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid.patch"

diff -Naur hcid.orig/dbus-adapter.c hcid.new/dbus-adapter.c
--- hcid.orig/dbus-adapter.c	2006-10-17 17:54:10.000000000 +0200
+++ hcid.new/dbus-adapter.c	2006-10-18 10:23:27.000000000 +0200
@@ -2615,6 +2615,125 @@
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
+struct remote_device_list_t {
+	struct slist *list;
+	time_t time;
+};
+
+static void list_remote_devices_do_append(char *key, char *value, void *data)
+{
+	struct remote_device_list_t *param = data;
+	char *address;
+	struct tm date;
+
+	if (slist_find(param->list, key, (cmp_func_t) bacmp))
+		return;
+
+	// TODO: check date
+	if (param->time){
+		strptime (value, "%Y-%m-%d %H:%M:%S %Z", &date);
+		if (difftime(mktime(&date), param->time) < 0)
+			return;
+	}
+
+	address = strdup(key);
+	if (!address)
+		return;
+
+	slist_append(param->list, address);
+}
+
+static void remote_devices_do_append(void *data, void *user_data)
+{
+	DBusMessageIter *iter = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &data);
+}
+
+static DBusHandlerResult adapter_list_remote_devices(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct adapter *adapter = data;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessage *reply;
+	char filename[PATH_MAX + 1];
+	struct remote_device_list_t param = {NULL, 0};
+
+	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
+		return error_invalid_arguments(conn, msg);
+
+	/* Add Bonded devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "linkkeys");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	/* Add Last Used devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastused");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	/* Add Last Seen devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastseen");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+	slist_foreach(param.list, remote_devices_do_append, &array_iter);
+
+	slist_free(param.list);
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return send_message_and_unref(conn, reply);
+}
+
+static DBusHandlerResult adapter_list_recent_remote_devices(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct adapter *adapter = data;
+	const char *string;
+	struct tm date;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessage *reply;
+	char filename[PATH_MAX + 1];
+	struct remote_device_list_t param = {NULL, 0};
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &string,
+				DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	if (strptime (string, "%Y-%m-%d %H:%M:%S", &date) == NULL)
+		return error_invalid_arguments(conn, msg);
+	param.time = mktime(&date);
+
+	/* Add Bonded devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "linkkeys");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	/* Add Last Used devices to the list */
+	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastused");
+	textfile_foreach(filename, list_remote_devices_do_append, &param);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+	slist_foreach(param.list, remote_devices_do_append, &array_iter);
+
+	slist_free(param.list);
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return send_message_and_unref(conn, reply);
+}
+
 const char *major_class_str(uint32_t class)
 {
 	uint8_t index = (class >> 8) & 0x1F;
@@ -2746,6 +2865,9 @@
 	{ "DiscoverDevicesWithoutNameResolving",	adapter_discover_devices	},
 	{ "CancelDiscovery",			adapter_cancel_discovery	},
 
+	{ "ListRemoteDevices",				adapter_list_remote_devices		},
+	{ "ListRecentRemoteDevices",		adapter_list_recent_remote_devices		},
+
 	{ NULL, NULL }
 };
 
diff -Naur hcid.orig/dbus-api.txt hcid.new/dbus-api.txt
--- hcid.orig/dbus-api.txt	2006-10-17 17:30:06.000000000 +0200
+++ hcid.new/dbus-api.txt	2006-10-18 12:37:14.000000000 +0200
@@ -789,6 +789,20 @@
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.Failed
 
+		array{string} ListRemoteDevices()
+
+			List device addresses of all known adapters (seen, used or bonded).
+
+			Possible errors: none
+
+		array{string} ListRecentRemoteDevices(string date)
+
+			List device addresses of all used or bonded adapters since date.
+
+			date format is "YYYY-MM-DD HH:MM:SS GMT"
+
+			Possible errors: none
+
 
 Signals		void ModeChanged(string mode)
 


--------------000104030500090905080204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------000104030500090905080204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000104030500090905080204--
