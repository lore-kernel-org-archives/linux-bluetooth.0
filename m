Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 9 Nov 2006 11:49:13 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241647.20895.denis.kenzior@trolltech.com>
	<1162214837.24333.69.camel@localhost>
In-Reply-To: <1162214837.24333.69.camel@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZkoUF6lh4UlEP4A"
Message-Id: <200611091149.13916.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Proposed DTD
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

--Boundary-00=_ZkoUF6lh4UlEP4A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

On Monday 30 October 2006 23:27, Marcel Holtmann wrote:
> Hi Denis,
>
>
> to get this started, I like to see the method
>
> string GetRemoteServiceRecordAsXML(string address, uint32 handle)
>
> from the org.bluez.Adapter interface gets implemented and make it using
> the simple service-record.dtd I put into the CVS.

Here's a patch that imlements 

string GetRemoteServiceRecordAsXML(string address, uint32 handle)

>
> I choose to simplify the DTD a lot. After having a discussion about XML

Yes, I saw this.  I have made some changes to the DTD however.  Mainly I've 
added the int* data types and have removed the 'data' type since it was not 
used anywhere anymore.

> and binary representation from the SDP part of the specification, I am
> pretty certain, that we should support both. The binary representation
> will cover all tasks ever possible with SDP and it is the default. For
> convenience we will additionally support XML as record description, but
> it will only cover up to 90% of all cases, but it will be simpler to use
> and easier to understand and that should be fine.
>

I'm concerned about this.  BlueZ dbus developers have explicitly and 
repeatedly stated that their intent is to make the dbus interface as 
high-level as possible.  This is why the interface is so nice and easy to 
use, particularly from languages other than C.  Binary SDP record 
representation/registration just does not fit.  I would strongly encourage 
that we adopt an XML format for both view and registration of SDP records, 
and that it should be the default.

There's also the issue of GPL.  Anybody who wants to create such binary 
records and cannot link against the GPL'd libbluetooth would need to spend 
(perhaps considerable) time duplicating what is already there in order to 
produce such data structures.

> This means that all length fields are not represented in XML. They will
> be chosen automatically as needed. The same applies to the UUID. So it
> leaves only int* and uint* where the actual size will be taken care of
> as part of the type name.

I totally agree with this and this was my original thought as well.  Hopefully 
the dtd is getting closer to being finalized.  This reminds me, do you still 
want to base sdptool on XML if an appropriate (no external dependency) parser 
is written?  I don't want to spend time on this unless it is wanted and the 
DTD is stabilized.

Regards,
Denis

--Boundary-00=_ZkoUF6lh4UlEP4A
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sdpxml.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdpxml.patch"

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/Makefile.am,v
retrieving revision 1.59
diff --unified=5 -r1.59 Makefile.am
--- Makefile.am	1 Nov 2006 12:58:31 -0000	1.59
+++ Makefile.am	9 Nov 2006 01:11:23 -0000
@@ -23,11 +23,12 @@
 		dbus-hci.h dbus-hci.c dbus-common.c dbus-common.h \
 		dbus-error.c dbus-error.h dbus-manager.c dbus-manager.h \
 		dbus-adapter.c dbus-adapter.h \
 		dbus-device.c dbus-device.h dbus-service.c dbus-service.h \
 		dbus-security.c dbus-security.h dbus-test.c dbus-test.h \
-		dbus-sdp.c dbus-sdp.h dbus-rfcomm.c dbus-rfcomm.h
+		dbus-sdp.c dbus-sdp.h dbus-rfcomm.c dbus-rfcomm.h \
+		sdp-xml.c sdp-xml.h
 
 hcid_LDADD = @DBUS_LIBS@ @BLUEZ_LIBS@ $(top_builddir)/common/libhelper.a
 
 passkey_agent_SOURCES = passkey-agent.c
 
Index: dbus-adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-adapter.c,v
retrieving revision 1.135
diff --unified=5 -r1.135 dbus-adapter.c
--- dbus-adapter.c	7 Nov 2006 20:36:10 -0000	1.135
+++ dbus-adapter.c	9 Nov 2006 01:11:24 -0000
@@ -1059,28 +1059,17 @@
 }
 
 static DBusHandlerResult adapter_get_remote_svc(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return get_remote_svc_rec(conn, msg, data);
+	return get_remote_svc_rec(conn, msg, data, SDP_FORMAT_BINARY);
 }
 
 static DBusHandlerResult adapter_get_remote_svc_xml(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	DBusMessage *reply;
-	const char *result = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
-				"<record></record>";
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return DBUS_HANDLER_RESULT_NEED_MEMORY;
-
-	dbus_message_append_args(reply, DBUS_TYPE_STRING, &result,
-					DBUS_TYPE_INVALID);
-
-	return send_message_and_unref(conn, reply);
+	return get_remote_svc_rec(conn, msg, data, SDP_FORMAT_XML);
 }
 
 static DBusHandlerResult adapter_get_remote_svc_handles(DBusConnection *conn,
 							DBusMessage *msg,
 							void *data)
Index: dbus-sdp.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-sdp.c,v
retrieving revision 1.54
diff --unified=5 -r1.54 dbus-sdp.c
--- dbus-sdp.c	1 Nov 2006 12:58:31 -0000	1.54
+++ dbus-sdp.c	9 Nov 2006 01:11:25 -0000
@@ -55,10 +55,11 @@
 #include "dbus-adapter.h"
 #include "dbus-error.h"
 #include "dbus-sdp.h"
 
 #define MAX_IDENTIFIER_LEN	29	/* "XX:XX:XX:XX:XX:XX/0xYYYYYYYY\0" */
+#define DEFAULT_XML_BUFFER_SIZE 1024
 
 struct service_provider {
 	char *owner;	/* null for remote services or unique name if local */
 	char *prov;	/* remote Bluetooth address that provides the service */
 	struct slist *lrec;
@@ -96,10 +97,37 @@
 	char            *name;
 	uint16_t        class;
 	char            *info_name;
 } sdp_service_t;
 
+typedef struct {
+	int size;
+	char *str;
+} string_t;
+
+static void append_and_grow_string(void *data, const char *str)
+{
+	string_t *string = (string_t *)data;
+	char *newbuf;
+
+	int oldlen = strlen(string->str);
+	int newlen = strlen(str);
+	
+	if ((oldlen + newlen + 1) > string->size) {
+		newbuf = (char *) malloc(string->size * 2);
+		if (!newbuf)
+			return;
+
+		memcpy(newbuf, string->str, oldlen+1);
+		string->size *= 2;
+		free(string->str);
+		string->str = newbuf;		
+	}
+
+	strcat(string->str, str);
+}
+
 /* FIXME:  move to a common file */
 sdp_service_t sdp_service[] = {
 	{ "vcp",	VIDEO_CONF_SVCLASS_ID,		"Video Conference"	},
 	{ "map",	0,				NULL			},
 	{ "pbap",	PBAP_SVCLASS_ID,		"Phone Book Access"	},
@@ -608,10 +636,80 @@
 	send_message_and_unref(ctxt->conn, reply);
 failed:
 	transaction_context_free(ctxt);
 }
 
+static void remote_svc_rec_completed_xml_cb(uint8_t type, uint16_t err, uint8_t *rsp, size_t size, void *udata)
+{
+	struct transaction_context *ctxt = udata;
+	sdp_record_t *rec = NULL;
+	DBusMessage *reply;
+	const char *dst;
+	int scanned;
+	string_t result;
+	
+	if (!ctxt)
+		return;
+
+	if (err == 0xffff) {
+		/* Check for protocol error or I/O error */
+		int sdp_err = sdp_get_error(ctxt->session);
+		if (sdp_err < 0) {
+			error("search failed: Invalid session!");
+			error_failed(ctxt->conn, ctxt->rq, EINVAL);
+			goto failed;
+		}
+
+		error("search failed: %s (%d)", strerror(sdp_err), sdp_err);
+		error_failed(ctxt->conn, ctxt->rq, sdp_err);
+		goto failed;
+	}
+
+	if (type == SDP_ERROR_RSP) {
+		error_sdp_failed(ctxt->conn, ctxt->rq, err);
+		goto failed;
+	}
+
+	/* check response PDU ID */
+	if (type != SDP_SVC_ATTR_RSP) {
+		error("SDP error: %s (%d)", strerror(EPROTO), EPROTO);
+		error_failed(ctxt->conn, ctxt->rq, EPROTO);
+		goto failed;
+	}
+
+	dbus_message_get_args(ctxt->rq, NULL,
+			DBUS_TYPE_STRING, &dst,
+			DBUS_TYPE_INVALID);
+
+	reply = dbus_message_new_method_return(ctxt->rq);
+
+	result.str = 0;
+	
+	rec = sdp_extract_pdu(rsp, &scanned);
+	if (rec == NULL) {
+		error("SVC REC is null");
+		goto done;
+	}
+
+	result.str = malloc(sizeof(char) * DEFAULT_XML_BUFFER_SIZE);
+	result.size = DEFAULT_XML_BUFFER_SIZE;
+	
+	sdp_cache_append(NULL, dst, rec);
+
+	convert_sdp_record_to_xml(rec, &result, append_and_grow_string);
+
+	dbus_message_append_args(reply,
+		DBUS_TYPE_STRING, &result.str,
+		DBUS_TYPE_INVALID);
+
+done:
+	send_message_and_unref(ctxt->conn, reply);
+	free(result.str);
+failed:
+	transaction_context_free(ctxt);
+}
+
 static void remote_svc_handles_completed_cb(uint8_t type, uint16_t err, uint8_t *rsp, size_t size, void *udata)
 {
 	struct transaction_context *ctxt = udata;
 	DBusMessage *reply;
 	DBusMessageIter iter, array_iter;
@@ -898,28 +996,65 @@
 		sdp_list_free(attrids, NULL);
 
 	return err;
 }
 
-DBusHandlerResult get_remote_svc_rec(DBusConnection *conn, DBusMessage *msg, void *data)
+static int remote_svc_rec_conn_xml_cb(struct transaction_context *ctxt)
+{
+	sdp_list_t *attrids = NULL;
+	uint32_t range = 0x0000ffff;
+	const char *dst;
+	uint32_t handle;
+	int err = 0;
+
+	if (sdp_set_notify(ctxt->session, remote_svc_rec_completed_xml_cb, ctxt) < 0) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	dbus_message_get_args(ctxt->rq, NULL,
+			DBUS_TYPE_STRING, &dst,
+			DBUS_TYPE_UINT32, &handle,
+			DBUS_TYPE_INVALID);
+
+	attrids = sdp_list_append(NULL, &range);
+	/* Create/send the search request and set the callback to indicate the request completion */
+	if (sdp_service_attr_async(ctxt->session, handle, SDP_ATTR_REQ_RANGE, attrids) < 0) {
+		err = -sdp_get_error(ctxt->session);
+		goto fail;
+	}
+
+fail:
+	if (attrids)
+		sdp_list_free(attrids, NULL);
+
+	return err;
+}
+
+DBusHandlerResult get_remote_svc_rec(DBusConnection *conn, DBusMessage *msg, void *data, sdp_format_t format)
 {
 	struct adapter *adapter = data;
 	const char *dst;
 	uint32_t handle;
 	int err = 0;
+	connect_cb_t *cb;
 
 	if (!dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_UINT32, &handle,
 			DBUS_TYPE_INVALID))
 		return error_invalid_arguments(conn, msg);
 
 	if (find_pending_connect(dst))
 		return error_service_search_in_progress(conn, msg);
 
+	cb = remote_svc_rec_conn_cb;
+	if (format == SDP_FORMAT_XML)
+		cb = remote_svc_rec_conn_xml_cb;
+
 	if (!connect_request(conn, msg, adapter->dev_id,
-				dst, remote_svc_rec_conn_cb, &err)) {
+				dst, cb, &err)) {
 		error("Search request failed: %s (%d)", strerror(err), err);
 		return error_failed(conn, msg, err);
 	}
 
 	return DBUS_HANDLER_RESULT_HANDLED;
Index: dbus-sdp.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-sdp.h,v
retrieving revision 1.1
diff --unified=5 -r1.1 dbus-sdp.h
--- dbus-sdp.h	30 Oct 2006 18:39:38 -0000	1.1
+++ dbus-sdp.h	9 Nov 2006 01:11:25 -0000
@@ -28,15 +28,20 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 
 #define SDP_INTERFACE "org.bluez.SDP"
 
+typedef enum {
+	SDP_FORMAT_XML,
+	SDP_FORMAT_BINARY
+} sdp_format_t;
+
 DBusHandlerResult handle_sdp_method(DBusConnection *conn, DBusMessage *msg, void *data);
 
 DBusHandlerResult get_remote_svc_handles(DBusConnection *conn, DBusMessage *msg, void *data);
 
-DBusHandlerResult get_remote_svc_rec(DBusConnection *conn, DBusMessage *msg, void *data);
+DBusHandlerResult get_remote_svc_rec(DBusConnection *conn, DBusMessage *msg, void *data, sdp_format_t format);
 
 uint16_t sdp_str2svclass(const char *str);
 
 typedef void get_record_cb_t(sdp_record_t *rec, void *data, int err);
 
Index: service-record.dtd
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/service-record.dtd,v
retrieving revision 1.2
diff --unified=5 -r1.2 service-record.dtd
--- service-record.dtd	30 Oct 2006 14:11:16 -0000	1.2
+++ service-record.dtd	9 Nov 2006 01:11:25 -0000
@@ -1,16 +1,17 @@
 <!ELEMENT record (attribute)*>
 
-<!ELEMENT attribute (sequence|alternate|text|url|uuid|boolean|uint8|uint16|uint32|uint64|nil|data)+>
+<!ELEMENT attribute (sequence|alternate|text|url|uuid|boolean|uint8|uint16|uint32|uint64|nil)+>
 <!ATTLIST attribute id CDATA #REQUIRED>
 
-<!ELEMENT sequence (sequence|alternate|text|url|uuid|boolean|uint8|uint16|uint32|uint64|nil|data)+>
+<!ELEMENT sequence (sequence|alternate|text|url|uuid|boolean|uint8|uint16|uint32|uint64|uint128|int8|int16|int32|int64|int128|nil)+>
 
-<!ELEMENT alternate (sequence|alternate|text|url|uuid|boolean|uint8|uint16|uint32|uint64|nil|data)+>
+<!ELEMENT alternate (sequence|alternate|text|url|uuid|boolean|uint8|uint16|uint32|uint64|uint128|int8|int16|int32|int64|int128|nil)+>
 
 <!ELEMENT text EMPTY>
 <!ATTLIST text value CDATA #REQUIRED>
+<!ATTLIST text encoding (normal|hex) "normal">
 
 <!ELEMENT url EMPTY>
 <!ATTLIST url value CDATA #REQUIRED>
 
 <!ELEMENT uuid EMPTY>
@@ -29,10 +30,24 @@
 <!ATTLIST uint32 value CDATA #REQUIRED>
 
 <!ELEMENT uint64 EMPTY>
 <!ATTLIST uint64 value CDATA #REQUIRED>
 
-<!ELEMENT nil EMPTY>
+<!ELEMENT uint128 EMPTY>
+<!ATTLIST uint128 value CDATA #REQUIRED>
+
+<!ELEMENT int8 EMPTY>
+<!ATTLIST int8 value CDATA #REQUIRED>
+
+<!ELEMENT int16 EMPTY>
+<!ATTLIST int16 value CDATA #REQUIRED>
+
+<!ELEMENT int32 EMPTY>
+<!ATTLIST int32 value CDATA #REQUIRED>
 
-<!ELEMENT data EMPTY>
-<!ATTLIST data type CDATA #REQUIRED>
-<!ATTLIST data value CDATA #REQUIRED>
+<!ELEMENT int64 EMPTY>
+<!ATTLIST int64 value CDATA #REQUIRED>
+
+<!ELEMENT int128 EMPTY>
+<!ATTLIST int128 value CDATA #REQUIRED>
+
+<!ELEMENT nil EMPTY>

--Boundary-00=_ZkoUF6lh4UlEP4A
Content-Type: text/x-chdr;
  charset="iso-8859-1";
  name="sdp-xml.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdp-xml.h"

#ifndef __SDP_XML_H__
#define __SDP_XML_H__

#include <ctype.h>
#include <bluetooth/sdp.h>

void convert_sdp_record_to_xml(sdp_record_t * rec,
			       void *userData,
			       void (*appendFunc) (void *, const char *));

#endif

--Boundary-00=_ZkoUF6lh4UlEP4A
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="sdp-xml.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdp-xml.c"

#include "sdp-xml.h"

#include <stdio.h>
#include <string.h>
#include <bluetooth/sdp_lib.h>
#include <malloc.h>
#include <limits.h>

#define STRBUFSIZE 256
#define MAXINDENT 64

static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
				    void *data,
				    void (*appender) (void *, const char *))
{
	int i, hex;
	char buf[STRBUFSIZE];
	char indent[MAXINDENT];
	char next_indent[MAXINDENT];

	if (!value)
		return;

	if (indent_level >= MAXINDENT)
		indent_level = MAXINDENT - 2;

	for (i = 0; i < indent_level; i++) {
		indent[i] = '\t';
		next_indent[i] = '\t';
	}

	indent[i] = '\0';
	next_indent[i] = '\t';
	next_indent[i + 1] = '\0';

	buf[STRBUFSIZE - 1] = '\0';

	switch (value->dtd) {
	case SDP_DATA_NIL:
		appender(data, indent);
		appender(data, "<nil/>\n");
		break;
	case SDP_BOOL:
		appender(data, indent);
		appender(data, "<boolean value=\"");
		appender(data, value->val.uint8 ? "true" : "false");
		appender(data, "\" />\n");
		break;
	case SDP_UINT8:
		appender(data, indent);
		appender(data, "<uint8 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%02x", value->val.uint8);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_UINT16:
		appender(data, indent);
		appender(data, "<uint16 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%04x", value->val.uint16);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_UINT32:
		appender(data, indent);
		appender(data, "<uint32 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%08x", value->val.uint32);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_UINT64:
		appender(data, indent);
		appender(data, "<uint64 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%016jx", value->val.uint64);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_UINT128:
		appender(data, indent);
		appender(data, "<uint128 value=\"");

		for (i = 0; i < 16; i++) {
			sprintf(&buf[i * 2], "%02x",
				(unsigned char) value->val.uint128.data[i]);
		}

		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_INT8:
		appender(data, indent);
		appender(data, "<int8 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%d", value->val.int8);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_INT16:
		appender(data, indent);
		appender(data, "<int16 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%d", value->val.int16);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_INT32:
		appender(data, indent);
		appender(data, "<int32 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%d", value->val.int32);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_INT64:
		appender(data, indent);
		appender(data, "<int64 value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%jd", value->val.int64);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_INT128:
		appender(data, indent);
		appender(data, "<int128 value=\"");

		for (i = 0; i < 16; i++) {
			sprintf(&buf[i * 2], "%02x",
				(unsigned char) value->val.int128.data[i]);
		}
		appender(data, buf);

		appender(data, "\" />\n");
		break;
	case SDP_UUID16:
		appender(data, indent);
		appender(data, "<uuid value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%04x",
			 value->val.uuid.value.uuid16);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_UUID32:
		appender(data, indent);
		appender(data, "<uuid value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%08x",
			 value->val.uuid.value.uuid32);
		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_UUID128:
		appender(data, indent);
		appender(data, "<uuid value=\"");

		snprintf(buf, STRBUFSIZE - 1,
			 "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[0],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[1],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[2],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[3],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[4],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[5],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[6],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[7],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[8],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[9],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[10],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[11],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[12],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[13],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[14],
			 (unsigned char) value->val.uuid.value.
			 uuid128.data[15]);

		appender(data, buf);
		appender(data, "\" />\n");
		break;
	case SDP_TEXT_STR8:
	case SDP_TEXT_STR16:
	case SDP_TEXT_STR32:
	{
		hex = 0;

		int num_chars_to_escape = 0;
		
		for (i = 0; i < value->unitSize; i++) {
			if (i == (value->unitSize - 1)
			    && value->val.str[i] == '\0')
				break;
			if (!isprint(value->val.str[i])) {
				hex = 1;
				break;
			}
			
			/* XML is evil, must do this... */
			if ((value->val.str[i] == '<') ||
			    (value->val.str[i] == '>') ||
			    (value->val.str[i] == '"') ||
			    (value->val.str[i] == '&'))
			    num_chars_to_escape++;
			
		}
		
		appender(data, indent);

		appender(data, "<text ");

		char *strBuf = 0;

		if (hex) {
			appender(data, "encoding=\"hex\" ");
			strBuf = (char *) malloc(sizeof(char)
						 * (value->unitSize * 2 + 1));

			/* Unit Size seems to include the size for dtd
			   It is thus off by 1
			   This is safe for Normal strings, but not
			   hex encoded data */
			for (i = 0; i < (value->unitSize-1); i++)
				sprintf(&strBuf[i * sizeof (char) * 2],
					"%02x",
					(unsigned char) value->val.str[i]);

			strBuf[value->unitSize * 2] = '\0';
		}
		else {
			int j;
			/* escape the XML disallowed chars */
			strBuf = (char *)
				malloc(sizeof(char) *
				(value->unitSize + 1 + num_chars_to_escape * 4));
			for (i = 0, j = 0; i < value->unitSize; i++) {
				if (value->val.str[i] == '&') {
					strBuf[j++] = '&';
					strBuf[j++] = 'a';
					strBuf[j++] = 'm';
					strBuf[j++] = 'p';
				}
				else if (value->val.str[i] == '<') {
					strBuf[j++] = '&';
					strBuf[j++] = 'l';
					strBuf[j++] = 't';
				}
				else if (value->val.str[i] == '>') {
					strBuf[j++] = '&';
					strBuf[j++] = 'g';
					strBuf[j++] = 't';
				}
				else if (value->val.str[i] == '"') {
					strBuf[j++] = '&';
					strBuf[j++] = 'q';
					strBuf[j++] = 'u';
					strBuf[j++] = 'o';
					strBuf[j++] = 't';
				}
				else {
					strBuf[j++] = value->val.str[i];
				}
			}

			strBuf[j] = '\0';
		}

		appender(data, "value=\"");
		appender(data, strBuf);
		appender(data, "\" />\n");
		free(strBuf);
		break;
	}
	case SDP_URL_STR8:
	case SDP_URL_STR16:
	case SDP_URL_STR32:
		appender(data, indent);
		appender(data, "<url value=\"");
		appender(data, value->val.str);
		appender(data, "\" />\n");
		break;
	case SDP_SEQ8:
	case SDP_SEQ16:
	case SDP_SEQ32:
		appender(data, indent);
		appender(data, "<sequence>\n");

		convert_raw_data_to_xml(value->val.dataseq,
					indent_level + 1, data,
					appender);
					
		appender(data, indent);
		appender(data, "</sequence>\n");
		
		break;
	case SDP_ALT8:
	case SDP_ALT16:
	case SDP_ALT32:
		appender(data, indent);

		appender(data, "<alternate>\n");

		convert_raw_data_to_xml(value->val.dataseq,
					indent_level + 1, data,
					appender);
		appender(data, indent);

		appender(data, "</alternate>\n");
	       
		break;
	default:
		break;
	}

	convert_raw_data_to_xml(value->next, indent_level, data,
				appender);
}

struct conversion_data
{
	void *data;
	void (*appender) (void *data, const char *);
};

static void convert_raw_attr_to_xml_func(void *val, void *data)
{
	struct conversion_data *cd = (struct conversion_data *) data;
	sdp_data_t *value = (sdp_data_t *) val;
	char buf[STRBUFSIZE];

	buf[STRBUFSIZE - 1] = '\0';
	snprintf(buf, STRBUFSIZE - 1, "\t<attribute id=\"0x%04x\">\n",
		 value->attrId);
	cd->appender(cd->data, buf);

	if (data)
		convert_raw_data_to_xml(value, 2, cd->data,
					cd->appender);
	else
		cd->appender(cd->data, "\t\tNULL\n");

	cd->appender(cd->data, "\t</attribute>\n");
}

/*
    Will convert the sdp record to XML.  The appender and data can be used
    to control where to output the record (e.g. file or a data buffer).  The
    appender will be called repeatedly with data and the character buffer
    (containing parts of the generated XML) to append.
*/
void convert_sdp_record_to_xml(sdp_record_t *rec,
			       void *data,
			       void (*appender) (void *, const char *))
{
	struct conversion_data cd;

	cd.data = data;
	cd.appender = appender;

	if (rec && rec->attrlist) {
		appender(data, "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n\n");
		appender(data, "<record>\n");
		sdp_list_foreach(rec->attrlist,
				 convert_raw_attr_to_xml_func, &cd);
		appender(data, "</record>\n");
	}
}

--Boundary-00=_ZkoUF6lh4UlEP4A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_ZkoUF6lh4UlEP4A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_ZkoUF6lh4UlEP4A--
