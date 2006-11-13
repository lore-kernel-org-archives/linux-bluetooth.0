Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 13 Nov 2006 11:14:43 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<e1effdeb0611101009t24de879fk3bca7ed96821514e@mail.gmail.com>
	<e1effdeb0611101338v1902b247if13f2239622f1a3a@mail.gmail.com>
In-Reply-To: <e1effdeb0611101338v1902b247if13f2239622f1a3a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Dc8VFZVaDqB3ibh"
Message-Id: <200611131114.43541.denis.kenzior@trolltech.com>
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

--Boundary-00=_Dc8VFZVaDqB3ibh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Claudio,

> >
> > Hi Denis,
> >
> > the patch is in cvs now!
> >
> > The sdp-xml.* were moved to common directory.
> >
> > Some points to be improved:
> > 1. append_and_grow_string: avoid a lot of strlen calls and string copy
> > 2. Analyze if it is possible use sdp_buf_t instead of string_t
> > 3. I got some system bus disconnection messages when calling
> > GetRemoteServiceRecordAsXML consecutively. We need fix this bug.
> >
> > BR,
> > Claudio.
> > --
>
> Hi Marcel, Denis,
>
> this patch replaces string_t by sdp_buf_t and fix system bus
> disconnection problem. Check if this patch make sense or if it is
> better keep  string_t.

I agree we should replace string_t by sdp_buf_t since this avoids an extra 
strlen.  However, I think that the buffer should be grown by factors.  Your  
proposed solution would call realloc many times, as the append function is 
called quite frequently with small strings, but this is no biggie.

Would the attached patch be better?

>
> BR,
> Claudio

-Denis

--Boundary-00=_Dc8VFZVaDqB3ibh
Content-Type: text/x-diff; charset="utf-8"; name="remove_string_t_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove_string_t_2.patch"

Index: dbus-sdp.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-sdp.c,v
retrieving revision 1.55
diff -u -5 -r1.55 dbus-sdp.c
--- dbus-sdp.c	10 Nov 2006 17:59:15 -0000	1.55
+++ dbus-sdp.c	13 Nov 2006 00:54:20 -0000
@@ -56,11 +56,11 @@
 #include "dbus-error.h"
 #include "dbus-sdp.h"
 #include "sdp-xml.h"
 
 #define MAX_IDENTIFIER_LEN	29	/* "XX:XX:XX:XX:XX:XX/0xYYYYYYYY\0" */
-#define DEFAULT_XML_BUFFER_SIZE 1024
+#define DEFAULT_XML_BUF_SIZE	1024
 
 struct service_provider {
 	char *owner;	/* null for remote services or unique name if local */
 	char *prov;	/* remote Bluetooth address that provides the service */
 	struct slist *lrec;
@@ -98,35 +98,37 @@
 	char            *name;
 	uint16_t        class;
 	char            *info_name;
 } sdp_service_t;
 
-typedef struct {
-	int size;
-	char *str;
-} string_t;
-
 static void append_and_grow_string(void *data, const char *str)
 {
-	string_t *string = (string_t *)data;
-	char *newbuf;
+	sdp_buf_t *buff = (sdp_buf_t *) data;
+	int len;
 
-	int oldlen = strlen(string->str);
-	int newlen = strlen(str);
-	
-	if ((oldlen + newlen + 1) > string->size) {
-		newbuf = (char *) malloc(string->size * 2);
-		if (!newbuf)
+	len = strlen(str);
+
+	if (!buff->data) {
+		buff->buf_size = DEFAULT_XML_BUF_SIZE;
+		buff->data = realloc(buff->data, buff->buf_size);
+		if (!buff->data)
 			return;
+	}
+
+	/* Grow string */
+	while (buff->buf_size < (buff->data_size + len + 1)) {
+		/* Grow buffer by a factor of 2 */
+		buff->buf_size = (buff->buf_size << 1);
 
-		memcpy(newbuf, string->str, oldlen+1);
-		string->size *= 2;
-		free(string->str);
-		string->str = newbuf;		
+		buff->data = realloc(buff->data, buff->buf_size);
+		if (!buff->data)
+			return;
 	}
 
-	strcat(string->str, str);
+	/* Include the NULL character */
+	memcpy(buff->data + buff->data_size, str, len + 1);
+	buff->data_size += len;
 }
 
 /* FIXME:  move to a common file */
 sdp_service_t sdp_service[] = {
 	{ "vcp",	VIDEO_CONF_SVCLASS_ID,		"Video Conference"	},
@@ -646,12 +648,12 @@
 	struct transaction_context *ctxt = udata;
 	sdp_record_t *rec = NULL;
 	DBusMessage *reply;
 	const char *dst;
 	int scanned;
-	string_t result;
-	
+	sdp_buf_t result;
+
 	if (!ctxt)
 		return;
 
 	if (err == 0xffff) {
 		/* Check for protocol error or I/O error */
@@ -683,32 +685,32 @@
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_INVALID);
 
 	reply = dbus_message_new_method_return(ctxt->rq);
 
-	result.str = 0;
 	
 	rec = sdp_extract_pdu(rsp, &scanned);
 	if (rec == NULL) {
 		error("SVC REC is null");
 		goto done;
 	}
 
-	result.str = malloc(sizeof(char) * DEFAULT_XML_BUFFER_SIZE);
-	result.size = DEFAULT_XML_BUFFER_SIZE;
-	
+	memset(&result, 0, sizeof(sdp_buf_t));
+
 	sdp_cache_append(NULL, dst, rec);
 
 	convert_sdp_record_to_xml(rec, &result, append_and_grow_string);
 
-	dbus_message_append_args(reply,
-		DBUS_TYPE_STRING, &result.str,
-		DBUS_TYPE_INVALID);
+	if (result.data) {
+		dbus_message_append_args(reply,
+				DBUS_TYPE_STRING, &result.data,
+				DBUS_TYPE_INVALID);
 
+		free(result.data);
+	}
 done:
 	send_message_and_unref(ctxt->conn, reply);
-	free(result.str);
 failed:
 	transaction_context_free(ctxt);
 }
 
 static void remote_svc_handles_completed_cb(uint8_t type, uint16_t err, uint8_t *rsp, size_t size, void *udata)

--Boundary-00=_Dc8VFZVaDqB3ibh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_Dc8VFZVaDqB3ibh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_Dc8VFZVaDqB3ibh--
