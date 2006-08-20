Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 18:59:57 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060820175957.GA2750@srcf.ucam.org>
References: <20060817100604.GA3350@srcf.ucam.org>
	<1155819858.4075.134.camel@aeonflux.holtmann.net>
	<20060817114116.GC5118@srcf.ucam.org>
	<20060817115912.GA24906@localhost.localdomain>
	<20060819143608.GA31812@srcf.ucam.org>
	<1156037973.3989.14.camel@aeonflux.holtmann.net>
	<20060819235330.GA16375@srcf.ucam.org>
	<1156040029.3989.22.camel@aeonflux.holtmann.net>
	<20060820003154.GA17093@srcf.ucam.org>
	<1156043737.3989.32.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1156043737.3989.32.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] implement
	RFCOMM	Connect	and	Disconnect	methods
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

Ok, how's this? Again not heavily tested, but just to make sure that the 
style is right.

Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.41
diff -u -r1.41 dbus-api.txt
--- dbus-api.txt	18 Aug 2006 19:50:27 -0000	1.41
+++ dbus-api.txt	20 Aug 2006 17:58:03 -0000
@@ -904,8 +904,8 @@
 Methods		string Connect(string address, string service)
 
 			This creates a connection to a remote RFCOMM based
-			service. The service string can either be a UUID-16,
-			a UUID-32, a UUID-128 or a service abbreviation.
+			service. The service string can either be a UUID-128,
+			a service abbreviation or a record handle.
 
 			The return value will be the path of the newly
 			created RFCOMM TTY device (for example /dev/rfcomm0).
Index: dbus-rfcomm.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-rfcomm.c,v
retrieving revision 1.10
diff -u -r1.10 dbus-rfcomm.c
--- dbus-rfcomm.c	18 Aug 2006 18:29:40 -0000	1.10
+++ dbus-rfcomm.c	20 Aug 2006 17:58:06 -0000
@@ -33,11 +33,15 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <arpa/inet.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/rfcomm.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
 
 #include <dbus/dbus.h>
 
@@ -452,18 +456,132 @@
 	return node;
 }
 
+static sdp_record_t *get_record_from_string (const char *dst, 
+					     const char *string)	
+{
+	uuid_t short_uuid;
+	uuid_t *uuid;
+	sdp_record_t *rec = NULL;	
+	unsigned int data0, data4;
+	unsigned short data1, data2, data3, data5;
+	long handle;
+
+	/* Check if the string is a service name */
+	short_uuid.value.uuid16 = sdp_str2svclass (string);
+	
+	if (short_uuid.value.uuid16) {
+		short_uuid.type = SDP_UUID16;
+		uuid = sdp_uuid_to_uuid128 (&short_uuid);
+		rec = find_record_by_uuid (dst, uuid);
+	} else if (sscanf (string, "%8x-%4hx-%4hx-%4hx-%8x%4hx", &data0, 
+			   &data1, &data2, &data3, &data4, &data5) == 6) {
+		data0 = htonl(data0);
+		data1 = htons(data1);
+		data2 = htons(data2);
+		data3 = htons(data3);
+		data4 = htonl(data4);
+		data5 = htons(data5);
+		
+		uuid = malloc (sizeof(uuid_t));
+		uuid->type = SDP_UUID128;
+		memcpy (&uuid->value.uuid128.data[0], &data0, 4);
+		memcpy (&uuid->value.uuid128.data[4], &data1, 2);
+		memcpy (&uuid->value.uuid128.data[6], &data2, 2);
+		memcpy (&uuid->value.uuid128.data[8], &data3, 2);
+		memcpy (&uuid->value.uuid128.data[10], &data4, 4);
+		memcpy (&uuid->value.uuid128.data[14], &data5, 2);
+
+		rec = find_record_by_uuid (dst, uuid);
+	} else if ((handle = strtol (string, (char **)NULL, 0))) {
+		rec = find_record_by_handle (dst, handle);
+	}
+	
+	return rec;
+}
+
 static DBusHandlerResult rfcomm_connect_req(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	error("RFCOMM.Connect not implemented");
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	int ch = -1;
+	const char *dst;
+	const char *string;
+	sdp_record_t *rec;	
+	sdp_list_t *protos;
+	bdaddr_t bdaddr;
+	struct hci_dbus_data *dbus_data = data;
+	int err;
+
+	if (!dbus_message_get_args(msg, NULL,
+				   DBUS_TYPE_STRING, &dst,
+				   DBUS_TYPE_STRING, &string,
+				   DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	hci_devba(dbus_data->dev_id, &bdaddr);
+
+	rec = get_record_from_string (dst, string);
+
+	if (!rec)
+		return error_record_does_not_exist (conn, msg);
+	
+	if (sdp_get_access_protos(rec, &protos) == 0)
+		ch = sdp_get_proto_port (protos, RFCOMM_UUID);
+
+	if (ch == -1)
+		return error_record_does_not_exist (conn, msg);
+
+	if (find_pending_connect(dst, ch))
+		return error_connect_in_progress(conn, msg);
+	
+	if (rfcomm_connect(conn, msg, &bdaddr, dst, NULL, ch, &err) < 0)
+		return error_failed(conn, msg, err);
+	
+	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
 static DBusHandlerResult rfcomm_cancel_connect_req(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	error("RFCOMM.CancelConnect not implemented");
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	int ch = -1;
+	const char *dst;
+	const char *string;
+	sdp_record_t *rec;	
+	sdp_list_t *protos;
+	bdaddr_t bdaddr;
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply;
+	struct pending_connect *pending;
+
+	if (!dbus_message_get_args(msg, NULL,
+				   DBUS_TYPE_STRING, &dst,
+				   DBUS_TYPE_STRING, &string,
+				   DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	hci_devba(dbus_data->dev_id, &bdaddr);
+
+	rec = get_record_from_string (dst, string);
+
+	if (!rec)
+		return error_record_does_not_exist (conn, msg);
+	
+	if (sdp_get_access_protos(rec, &protos) == 0)
+		ch = sdp_get_proto_port (protos, RFCOMM_UUID);
+
+	if (ch == -1)
+		return error_record_does_not_exist (conn, msg);
+
+	reply = dbus_message_new_method_return (msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	pending = find_pending_connect(dst, ch);
+	if (!pending)
+		return error_connect_in_progress(conn, msg);
+
+	pending->canceled = 1;
+	
+	return send_reply_and_unref(conn, reply);
 }
 
 static DBusHandlerResult rfcomm_connect_by_ch_req(DBusConnection *conn,
Index: dbus-sdp.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-sdp.c,v
retrieving revision 1.9
diff -u -r1.9 dbus-sdp.c
--- dbus-sdp.c	18 Aug 2006 18:29:40 -0000	1.9
+++ dbus-sdp.c	20 Aug 2006 17:58:11 -0000
@@ -855,6 +855,77 @@
 
 }
 
+static int sdp_uuid_comp_func(const void *key1, const void *key2)
+{	
+	const uuid_t *a = (const uuid_t *)key1;
+	const uuid_t *b = (const uuid_t *)key2;
+
+	if (a->type != b->type)
+		return 1;
+	
+	switch (a->type) {
+	case SDP_UUID16:		
+		return !(a->value.uuid16 == b->value.uuid16);
+		break;
+        case SDP_UUID32:
+		return !(a->value.uuid32 == b->value.uuid32);
+		break;
+        case SDP_UUID128:
+		return !memcmp(&a->value.uuid128, &b->value.uuid128, 
+			       sizeof(uint128_t));
+		break;
+	}
+	return 1;
+}
+
+sdp_record_t *find_record_by_uuid(const char *address, uuid_t *uuid)
+{
+	struct slist *lp, *lr;
+	struct service_provider *p;
+	struct service_record *r;
+	sdp_list_t *list = 0;
+	
+
+	for (lp = sdp_cache; lp; lp = lp->next) {
+		p = lp->data;
+		if (strcmp(p->prov, address))
+			continue;
+
+		for (lr = p->lrec; lr; lr = lr->next) {
+			r = lr->data;
+			/* Check whether the record has the correct uuid */
+			if (sdp_get_service_classes(r->record, &list) !=0)
+				continue;
+			
+			if (sdp_list_find (list, &uuid, sdp_uuid_comp_func))
+				return r->record;
+		}
+	}
+
+	return NULL;
+}	
+
+sdp_record_t *find_record_by_handle(const char *address, int handle)
+{
+	struct slist *lp, *lr;
+	struct service_provider *p;
+	struct service_record *r;
+
+	for (lp = sdp_cache; lp; lp = lp->next) {
+		p = lp->data;
+		if (strcmp(p->prov, address))
+			continue;
+
+		for (lr = p->lrec; lr; lr = lr->next) {
+			r = lr->data;
+			if (r->record->handle == handle)
+				return r->record;
+		}
+	}
+
+	return NULL;
+}
+
 static sdp_record_t *find_record(const char *address, int id)
 {
 	struct slist *lp, *lr;
Index: dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.98
diff -u -r1.98 dbus.h
--- dbus.h	19 Aug 2006 00:30:46 -0000	1.98
+++ dbus.h	20 Aug 2006 17:58:12 -0000
@@ -214,4 +214,8 @@
 
 int discoverable_timeout_handler(void *data);
 
+sdp_record_t *find_record_by_uuid(const char *address, uuid_t *uuid);
+sdp_record_t *find_record_by_handle(const char *address, int handle);
+uint16_t sdp_str2svclass(const char *str);
+
 #endif /* __H_BLUEZ_DBUS_H__ */

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
