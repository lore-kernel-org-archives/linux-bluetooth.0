Return-Path: <cyrus@holtmann.org>
Message-ID: <4872DE41.7040007@aircable.net>
Date: Tue, 08 Jul 2008 00:25:53 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48728258.6080809@aircable.net>
In-Reply-To: <48728258.6080809@aircable.net>
Content-Type: multipart/mixed; boundary="------------070503050008010402010103"
Subject: [Bluez-devel] [PATCH] Re: No more binary SDP registration in new
	4.0 API?
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
--------------070503050008010402010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> On Dbus api 3.X you could register binary sdp records over dbus, but 
> new api can't I all ready implemented adding records, I need to 
> implement the update records. But I would like to know if it makes 
> sense to commit this patch or not.
Just in case it makes sense, here's the patch that implements 
AddBinServiceRecord and UpdateBinServiceRecord.

--------------070503050008010402010103
Content-Type: text/plain;
 name="binrecords.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="binrecords.patch"

Index: doc/adapter-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/doc/adapter-api.txt,v
retrieving revision 1.17
diff -u -r1.17 adapter-api.txt
--- doc/adapter-api.txt	3 Jun 2008 14:29:57 -0000	1.17
+++ doc/adapter-api.txt	8 Jul 2008 03:22:23 -0000
@@ -182,6 +182,25 @@
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotAvailable
 					 org.bluez.Error.Failed
+		
+		uint32 AddBinServiceRecord(array{byte})
+
+			Adds a new service record from and returns the assigned 
+			record handle.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void UpdateBinServiceRecord(uint32 handle, array{byte})
+
+			Updates a given service record.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotAvailable
+					 org.bluez.Error.Failed
+		
+		
+
 
 		void RemoveServiceRecord(uint32 handle)
 
Index: hcid/adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/adapter.c,v
retrieving revision 1.129
diff -u -r1.129 adapter.c
--- hcid/adapter.c	30 Jun 2008 17:26:18 -0000	1.129
+++ hcid/adapter.c	8 Jul 2008 03:22:28 -0000
@@ -4119,6 +4119,8 @@
 	auth->agent = NULL;
 }
 
+
+
 static DBusMessage *register_agent(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -4180,6 +4182,44 @@
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *add_bin_service_record(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter, array;
+	DBusMessage *reply;
+	struct adapter *adapter = data;
+	const char *sender;
+	const uint8_t *record;
+	int len = -1, err;
+	dbus_uint32_t handle;
+	bdaddr_t src;
+	
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_recurse(&iter, &array);
+	
+	dbus_message_iter_get_fixed_array(&array, &record, &len);
+	if ( len <= 0)
+	    return NULL;
+	
+	sender = dbus_message_get_sender(msg);
+	
+	str2ba(adapter->address, &src);
+	
+	err = add_bin_record(conn, sender, &src, record, len, &handle);
+	
+	if ( err < 0 )
+	    return failed_strerror(msg, err);
+	
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_append_args(reply, DBUS_TYPE_UINT32, &handle,
+							DBUS_TYPE_INVALID);
+
+	return reply;	
+}
+
 static DBusMessage *add_service_record(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -4207,7 +4248,20 @@
 	dbus_message_append_args(reply, DBUS_TYPE_UINT32, &handle,
 							DBUS_TYPE_INVALID);
 
-	return reply;
+	return reply;	
+
+
+}
+
+static DBusMessage *update_bin_service_record(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct adapter *adapter = data;
+	bdaddr_t src;
+
+	str2ba(adapter->address, &src);
+
+        return update_bin_service_record(conn, msg, &src);
 }
 
 static DBusMessage *update_service_record(DBusConnection *conn,
@@ -4276,7 +4330,9 @@
 	{ "RegisterAgent",	"os",	"",	register_agent		},
 	{ "UnregisterAgent",	"o",	"",	unregister_agent	},
 	{ "AddServiceRecord",	"s",	"u",	add_service_record	},
+	{ "AddBinServiceRecord","ay",	"u",	add_bin_service_record	},
 	{ "UpdateServiceRecord","us",	"",	update_service_record	},
+	{ "UpdateBinServiceRecord","uay","",	update_bin_service_record},
 	{ "RemoveServiceRecord","u",	"",	remove_service_record	},
 	{ "RequestAuthorization","su",	"",	request_authorization,
 						G_DBUS_METHOD_FLAG_ASYNC},
Index: hcid/dbus-database.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-database.c,v
retrieving revision 1.57
diff -u -r1.57 dbus-database.c
--- hcid/dbus-database.c	24 Jun 2008 00:24:08 -0000	1.57
+++ hcid/dbus-database.c	8 Jul 2008 03:22:28 -0000
@@ -102,59 +102,75 @@
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "Failed");
 }
 
-static DBusMessage *add_service_record(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+int add_bin_record(DBusConnection *conn, const char *sender, bdaddr_t *src,
+		    const uint8_t *record, const int len, dbus_uint32_t *handle)
 {
-	DBusMessageIter iter, array;
-	const char *sender;
 	struct record_data *user_record;
 	sdp_record_t *sdp_record;
-	const uint8_t *record;
-	int scanned, len = -1;
-
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_recurse(&iter, &array);
-
-	dbus_message_iter_get_fixed_array(&array, &record, &len);
-	if (len <= 0)
-		return invalid_arguments(msg);
+	int scanned;
 
 	sdp_record = sdp_extract_pdu_safe(record, len, &scanned);
 	if (!sdp_record) {
 		error("Parsing of service record failed");
-		return failed(msg);
+		return -EIO;
 	}
 
 	if (scanned != len) {
 		error("Size mismatch of service record");
 		sdp_record_free(sdp_record);
-		return failed(msg);
+		return -EIO;
 	}
 
-	if (add_record_to_server(BDADDR_ANY, sdp_record) < 0) {
+	if (add_record_to_server(src, sdp_record) < 0) {
 		error("Failed to register service record");
 		sdp_record_free(sdp_record);
-		return failed(msg);
+		return -EIO;
 	}
-
+	
 	user_record = g_new0(struct record_data, 1);
 
 	user_record->handle = sdp_record->handle;
 
-	sender = dbus_message_get_sender(msg);
-
 	user_record->sender = g_strdup(sender);
 
 	records = g_slist_append(records, user_record);
 
 	user_record->listener_id = g_dbus_add_disconnect_watch(conn, sender,
-								exit_callback,
-								user_record,
-								NULL);
+					exit_callback, user_record, NULL);
 
 	debug("listener_id %d", user_record->listener_id);
 
-	return g_dbus_create_reply(msg, DBUS_TYPE_UINT32, &user_record->handle,
+	*handle = user_record->handle;
+	
+	return 0;
+}
+
+
+DBusMessage *add_service_record(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter, array;
+	const char *sender;
+	const uint8_t *record;
+	int len = -1, err;
+	dbus_uint32_t handle;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_recurse(&iter, &array);
+
+	dbus_message_iter_get_fixed_array(&array, &record, &len);
+	if (len <= 0)
+	    return invalid_arguments(msg);
+	    
+	sender = dbus_message_get_sender(msg);
+
+	err = add_bin_record(conn, sender, BDADDR_ANY, 
+		    record, len, &handle );
+		
+	if ( err < 0 )
+	    return failed(msg);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_UINT32, &handle,
 							DBUS_TYPE_INVALID);
 }
 
@@ -240,8 +256,8 @@
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *update_service_record(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+DBusMessage *update_bin_record(DBusConnection *conn,
+				    DBusMessage *msg, bdaddr_t *src)
 {
 	struct record_data *user_record;
 	DBusMessageIter iter, array;
@@ -275,9 +291,15 @@
 		return invalid_arguments(msg);
 	}
 
-	return update_record(conn, msg, BDADDR_ANY, handle, sdp_record);
+	return update_record(conn, msg, src, handle, sdp_record);
+}
+
+DBusMessage *update_service_record(DBusConnection *conn,
+						DBusMessage *msg, void *data){
+	return update_bin_record(conn, msg, BDADDR_ANY);
 }
 
+
 DBusMessage *update_xml_record(DBusConnection *conn,
 				DBusMessage *msg, bdaddr_t *src)
 {
@@ -362,7 +384,7 @@
 static GDBusMethodTable database_methods[] = {
 	{ "AddServiceRecord",		"ay",  "u",	add_service_record		},
 	{ "AddServiceRecordFromXML",	"s",   "u",	add_service_record_from_xml	},
-	{ "UpdateServiceRecord",	"uay", "",	update_service_record		},
+	{ "UpdateServiceRecord",	"uay", "",	update_service_record  		},
 	{ "UpdateServiceRecordFromXML",	"us",  "",	update_service_record_from_xml	},
 	{ "RemoveServiceRecord",	"u",   "",	remove_service_record		},
 	{ }
Index: hcid/dbus-database.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-database.h,v
retrieving revision 1.12
diff -u -r1.12 dbus-database.h
--- hcid/dbus-database.h	3 Jun 2008 17:47:44 -0000	1.12
+++ hcid/dbus-database.h	8 Jul 2008 03:22:28 -0000
@@ -27,9 +27,13 @@
 dbus_bool_t database_init(DBusConnection *conn, const char *path);
 void database_cleanup(DBusConnection *conn, const char *path);
 
+int add_bin_record(DBusConnection *conn, const char *sender, bdaddr_t *src,
+		const uint8_t *record, const int len, dbus_uint32_t *handle);
 int add_xml_record(DBusConnection *conn, const char *sender, bdaddr_t *src,
 				const char *record, dbus_uint32_t *handle);
 DBusMessage *update_xml_record(DBusConnection *conn,
 				DBusMessage *msg, bdaddr_t *src);
+DBusMessage *update_bin_record(DBusConnection *conn,
+                                DBusMessage *msg, bdaddr_t *src);
 int remove_record(DBusConnection *conn, const char *sender,
 						dbus_uint32_t handle);

--------------070503050008010402010103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--------------070503050008010402010103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070503050008010402010103--
