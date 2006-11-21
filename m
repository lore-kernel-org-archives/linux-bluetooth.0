Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 21 Nov 2006 15:04:42 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qjoYFhFIwx81MZ6"
Message-Id: <200611211504.42604.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] XML SDP Record Registration
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

--Boundary-00=_qjoYFhFIwx81MZ6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Attached is a patch that adds an expat based parser for parsing XML records.  
I've also added a new API function AddServiceRecordAsXML (does the same thing 
as AddServiceRecord, but in XML format) to the Manager hierarchy.  

I've modified the service-agent example to take a new argument, --xmlfile, 
which will attempt to register a record stored in an XML format.

Let me know what you think!

Regards,
-Denis


--Boundary-00=_qjoYFhFIwx81MZ6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sdpregister.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdpregister.patch"

Index: common/sdp-dummy.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-dummy.c,v
retrieving revision 1.2
diff -u -5 -r1.2 sdp-dummy.c
--- common/sdp-dummy.c	13 Nov 2006 07:38:20 -0000	1.2
+++ common/sdp-dummy.c	21 Nov 2006 04:55:38 -0000
@@ -24,5 +24,28 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
 
 #include "sdp-xml.h"
+
+sdp_xml_context *sdp_xml_init_context()
+{
+	return NULL;
+}
+
+int sdp_xml_parse_chunk(sdp_xml_context * context, const char *data, int size,
+			int final)
+{
+	return -1;
+}
+
+	 
+
+sdp_record_t *sdp_xml_get_record(sdp_xml_context * context)
+{
+	return NULL;
+}
+
+void sdp_xml_free_context(sdp_xml_context * context)
+{
+
+}
Index: common/sdp-expat.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-expat.c,v
retrieving revision 1.2
diff -u -5 -r1.2 sdp-expat.c
--- common/sdp-expat.c	13 Nov 2006 07:38:20 -0000	1.2
+++ common/sdp-expat.c	21 Nov 2006 04:55:38 -0000
@@ -29,5 +29,410 @@
 #include <bluetooth/sdp_lib.h>
 
 #include <expat.h>
 
 #include "sdp-xml.h"
+#include "logging.h"
+
+/* Expat specific implementation of the context struct */
+
+typedef struct _sdp_xml_data sdp_xml_data_t;
+struct _sdp_xml_data
+{
+	char *text;                     /* Pointer to the current buffer */
+	int size;                       /* Size of the current buffer */
+	sdp_data_t *data;               /* The current item being built */
+	sdp_xml_data_t *next;           /* Next item on the stack */
+	char type;                      /* 0 = Text or Hexadecimal */
+	char *name;                     /* Name, optional in the dtd */
+					/* TODO: What is it used for? */
+};
+
+struct _sdp_xml_context
+{
+	XML_Parser parser;              /* Parser object being used */
+	sdp_record_t *sdprec;           /* SDP Record being built */
+	sdp_xml_data_t *stack_head;     /* Top of the stack of attributes */
+	int attrId;                     /* Id of the most recently processed attribute */
+};
+
+#define DEFAULT_XML_DATA_SIZE 1024
+
+static sdp_xml_data_t *sdp_xml_data_alloc()
+{
+	sdp_xml_data_t *elem;
+
+	elem = (sdp_xml_data_t *) malloc(sizeof(sdp_xml_data_t));
+
+	/* Null terminate the text */
+	elem->size = DEFAULT_XML_DATA_SIZE;
+	elem->text = (char *) malloc(sizeof(char) * DEFAULT_XML_DATA_SIZE);
+	elem->text[0] = '\0';
+
+	elem->next = 0;
+	elem->data = 0;
+
+	elem->type = 0;
+	elem->name = 0;
+
+	return elem;
+}
+
+static void sdp_xml_data_free(sdp_xml_data_t * elem)
+{
+	if (elem->data)
+		sdp_data_free(elem->data);
+
+	if (elem->name)
+		free(elem->name);
+
+	free(elem->text);
+	free(elem);
+}
+
+static sdp_xml_data_t *sdp_xml_data_expand(sdp_xml_data_t * elem)
+{
+	char *newbuf;
+
+	newbuf = (char *) malloc(elem->size * 2);
+	if (!newbuf)
+		return NULL;
+
+	memcpy(newbuf, elem->text, elem->size);
+	elem->size *= 2;
+	free(elem->text);
+
+	elem->text = newbuf;
+
+	return elem;
+}
+
+static sdp_data_t * sdp_xml_parse_datatype(const char *el, sdp_xml_context *context)
+{
+	sdp_data_t *ret = NULL;
+	const char *data = context->stack_head->text;
+
+	if (!strcmp(el, "bool")) {
+		ret = sdp_xml_parse_int(data, SDP_BOOL);
+	}
+
+	else if (!strcmp(el, "uint8")) {
+		ret = sdp_xml_parse_int(data, SDP_UINT8);
+	}
+	
+	else if (!strcmp(el, "uint16")) {
+		ret = sdp_xml_parse_int(data, SDP_UINT16);
+	}
+
+	else if (!strcmp(el, "uint32")) {
+		ret = sdp_xml_parse_int(data, SDP_UINT32);
+	}
+
+	else if (!strcmp(el, "uint64")) {
+		ret = sdp_xml_parse_int(data, SDP_UINT64);
+	}
+
+	else if (!strcmp(el, "uint128")) {
+		ret = sdp_xml_parse_int(data, SDP_UINT128);
+	}
+
+	else if (!strcmp(el, "int8")) {
+		ret = sdp_xml_parse_int(data, SDP_INT8);
+	}
+
+	else if (!strcmp(el, "int16")) {
+		ret = sdp_xml_parse_int(data, SDP_INT16);
+	}
+
+	else if (!strcmp(el, "int32")) {
+		ret = sdp_xml_parse_int(data, SDP_INT32);
+	}
+
+	else if (!strcmp(el, "int64")) {
+		ret = sdp_xml_parse_int(data, SDP_INT64);
+	}
+
+	else if (!strcmp(el, "int128")) {
+		ret = sdp_xml_parse_int(data, SDP_INT128);
+	}
+
+	else if (!strcmp(el, "uuid")) {
+		ret = sdp_xml_parse_uuid(data);
+	}
+
+	else if (!strcmp(el, "url")) {
+		ret = sdp_xml_parse_url(data);
+	}
+
+	else if (!strcmp(el, "text")) {
+		ret = sdp_xml_parse_text(data, context->stack_head->type);
+	}
+
+	else if (!strcmp(el, "nil")) {
+		ret = sdp_xml_parse_nil(data);
+	}
+
+	return ret;
+}
+
+static void convert_xml_to_sdp_start(void *data, const char *el,
+				     const char **attr)
+{
+	int i;
+	sdp_xml_context *context = (sdp_xml_context *) data;
+
+	if (!strcmp(el, "record"))
+		return;
+
+	if (!strcmp(el, "attribute")) {
+		/* Get the ID */
+		for (i = 0; attr[i]; i += 1) {
+			if (!strcmp(attr[i], "id")) {
+				context->attrId = strtol(attr[i + 1], 0, 0);
+				break;
+			}
+		}
+
+		return;
+	}
+
+	/* Assume every other tag is an element of some sort */
+	if (context->stack_head) {
+		sdp_xml_data_t *newelem = sdp_xml_data_alloc();
+		newelem->next = context->stack_head;
+		context->stack_head = newelem;
+	}
+	else {
+		context->stack_head = sdp_xml_data_alloc();
+		context->stack_head->next = 0;
+	}
+
+	if (!strcmp(el, "sequence")) {
+		context->stack_head->data = sdp_data_alloc(SDP_SEQ8, NULL);
+	}
+
+	else if (!strcmp(el, "alternate")) {
+		context->stack_head->data = sdp_data_alloc(SDP_ALT8, NULL);
+	}
+
+	else {
+		const char *type = el;
+		/* Parse value, name, encoding */
+		for (i = 0; attr[i]; i += 2) {
+			if (!strcmp(attr[i], "value")) {
+				int curlen = strlen(context->stack_head->text);
+				int attrlen = strlen(attr[i+1]);
+
+				/* Ensure we're big enough */
+				while ((curlen + 1 + attrlen) >
+				       context->stack_head->size) {
+					sdp_xml_data_expand(context->stack_head);
+				}
+
+				memcpy(&context->stack_head->text[curlen],
+				       attr[i+1], attrlen);
+				context->stack_head->text[curlen + attrlen] = '\0';
+			}
+
+			if (!strcmp(attr[i], "encoding")) {
+				if (!strcmp(attr[i+1], "hex"))
+					context->stack_head->type = 1;
+			}
+
+			if (!strcmp(attr[i], "name")) {
+				context->stack_head->name = strdup(attr[i+1]);
+			}
+		}
+
+		context->stack_head->data = sdp_xml_parse_datatype(type, context);
+
+		/* Could not parse an entry */
+		if (context->stack_head->data == NULL)
+			XML_StopParser(context->parser, 0);
+	}
+}
+
+static int compute_seq_size(sdp_data_t *data)
+{
+	int unit_size = data->unitSize;
+	sdp_data_t *seq = data->val.dataseq;
+
+	for (; seq; seq = seq->next)
+		unit_size += seq->unitSize;
+
+	return unit_size;
+}
+
+static void convert_xml_to_sdp_end(void *data, const char *el)
+{
+	sdp_xml_context *context = (sdp_xml_context *) data;
+	sdp_xml_data_t *elem;
+
+	if (!strcmp(el, "record"))
+		return;
+
+	if (!strcmp(el, "attribute")) {
+		if (context->stack_head && context->stack_head->data) {
+			int ret = sdp_attr_add(context->sdprec,
+					       context->attrId,
+					       context->stack_head->data);
+			if (ret == -1)
+				debug("Trouble adding attribute\n");
+
+			context->stack_head->data = 0;
+			sdp_xml_data_free(context->stack_head);
+			context->stack_head = 0;
+		}
+		else {
+			debug("No Data for attribute: %d\n",
+				context->attrId);
+		}
+
+		return;
+	}
+	else if (!strcmp(el, "sequence")) {
+		context->stack_head->data->unitSize =
+			compute_seq_size(context->stack_head->data);
+	
+		if (context->stack_head->data->unitSize > USHRT_MAX) {
+			context->stack_head->data->unitSize +=
+				sizeof(uint32_t);
+			context->stack_head->data->dtd = SDP_SEQ32;
+		}
+		else if (context->stack_head->data->unitSize > UCHAR_MAX) {
+			context->stack_head->data->unitSize +=
+				sizeof(uint16_t);
+			context->stack_head->data->dtd = SDP_SEQ16;
+		}
+		else {
+			context->stack_head->data->unitSize += sizeof(uint8_t);
+		}
+	}
+
+	else if (!strcmp(el, "alternate")) {
+		context->stack_head->data->unitSize =
+			compute_seq_size(context->stack_head->data);
+		
+		if (context->stack_head->data->unitSize > USHRT_MAX) {
+			context->stack_head->data->unitSize +=
+				sizeof(uint32_t);
+			context->stack_head->data->dtd = SDP_ALT32;
+		}
+		else if (context->stack_head->data->unitSize > UCHAR_MAX) {
+			context->stack_head->data->unitSize +=
+				sizeof(uint16_t);
+			context->stack_head->data->dtd = SDP_ALT16;
+		}
+		else {
+			context->stack_head->data->unitSize += sizeof(uint8_t);
+		}
+	}
+
+	/* If we're not inside a seq or alt, then we're inside an attribute
+	   which will be taken care of later
+	 */
+	if (context->stack_head->next &&
+	    context->stack_head->data && context->stack_head->next->data) {
+		switch (context->stack_head->next->data->dtd) {
+		case SDP_SEQ8:
+		case SDP_SEQ16:
+		case SDP_SEQ32:
+		case SDP_ALT8:
+		case SDP_ALT16:
+		case SDP_ALT32:
+			context->stack_head->next->data->val.
+				dataseq =
+				sdp_seq_append(context->
+					       stack_head->
+					       next->data->
+					       val.dataseq,
+					       context->stack_head->data);
+			context->stack_head->data = 0;
+			break;
+		}
+
+		elem = context->stack_head;
+		context->stack_head = context->stack_head->next;
+
+		sdp_xml_data_free(elem);
+	}
+}
+
+sdp_xml_context *sdp_xml_init_context()
+{
+	sdp_xml_context *context = 0;
+
+	context = (sdp_xml_context *) malloc(sizeof(sdp_xml_context));
+
+	if (!context)
+		return NULL;
+
+	context->parser = 0;
+	context->sdprec = 0;
+	context->stack_head = 0;
+
+	context->parser = XML_ParserCreate(NULL);
+	XML_SetElementHandler(context->parser, convert_xml_to_sdp_start,
+			      convert_xml_to_sdp_end);
+	XML_SetUserData(context->parser, context);
+
+	if (!context->parser)
+		goto fail;
+
+	context->sdprec = sdp_record_alloc();
+
+	if (!context->sdprec)
+		goto fail;
+
+	return context;
+
+fail:
+	if (context->parser)
+		free(context->parser);
+
+	if (context->sdprec)
+		sdp_record_free(context->sdprec);
+
+	if (context)
+		free(context);
+
+	return NULL;
+}
+
+sdp_record_t *sdp_xml_get_record(sdp_xml_context * context)
+{
+	sdp_record_t *rec = context->sdprec;
+
+	context->sdprec = 0;
+
+	return rec;
+}
+
+void sdp_xml_free_context(sdp_xml_context * context)
+{
+	sdp_xml_data_t *elem;
+
+	/* Free the stack */
+	while (context->stack_head) {
+		elem = context->stack_head;
+		context->stack_head = elem->next;
+		sdp_xml_data_free(elem);
+	}
+
+	if (context->sdprec)
+		sdp_record_free(context->sdprec);
+	XML_ParserFree(context->parser);
+	free(context);
+}
+
+int sdp_xml_parse_chunk(sdp_xml_context * context, const char *data, int size,
+			int final)
+{
+	if (!XML_Parse(context->parser, data, size, final)) {
+		debug("Parse error at line %d:\n%s\n",
+			XML_GetCurrentLineNumber(context->parser),
+			XML_ErrorString(XML_GetErrorCode(context->parser)));
+		return -1;
+	}
+
+	return 0;
+}
Index: common/sdp-xml.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-xml.c,v
retrieving revision 1.2
diff -u -5 -r1.2 sdp-xml.c
--- common/sdp-xml.c	13 Nov 2006 07:38:20 -0000	1.2
+++ common/sdp-xml.c	21 Nov 2006 04:55:38 -0000
@@ -29,17 +29,20 @@
 #include <errno.h>
 #include <ctype.h>
 #include <malloc.h>
 #include <string.h>
 #include <limits.h>
+#include <stdlib.h>
 
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
 #include "sdp-xml.h"
 
-#define STRBUFSIZE 256
+#undef SDP_XML_DEBUG
+
+#define STRBUFSIZE 1024
 #define MAXINDENT 64
 
 static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		void *data, void (*appender) (void *, const char *))
 {
@@ -397,5 +400,346 @@
 		sdp_list_foreach(rec->attrlist,
 				 convert_raw_attr_to_xml_func, &cd);
 		appender(data, "</record>\n");
 	}
 }
+
+sdp_data_t * sdp_xml_parse_uuid16(const char *data)
+{
+	uint16_t val;
+	char *endptr;
+
+	val = strtol(data, &endptr, 16);
+
+	/* Failed to parse */
+	if (*endptr != '\0')
+		return NULL;
+
+	return sdp_data_alloc(SDP_UUID16, &val);
+}
+
+sdp_data_t * sdp_xml_parse_uuid32(const char *data)
+{
+	uint32_t val;
+	char *endptr;
+
+	val = strtoll(data, &endptr, 16);
+
+	/* Failed to parse */
+	if (*endptr != '\0')
+		return NULL;
+
+	return sdp_data_alloc(SDP_UUID32, &val);
+}
+
+sdp_data_t * sdp_xml_parse_uuid128(const char *data)
+{
+	uint128_t val;
+	int i;
+	int j;
+
+	char buf[3];
+
+	memset(&val, 0, sizeof(val));
+
+	buf[2] = '\0';
+
+	for (j = 0, i = 0; i < strlen(data);) {
+		if (data[i] == '-') {
+			i++;
+			continue;
+		}
+
+		buf[0] = data[i];
+		buf[1] = data[i + 1];
+
+		val.data[j++] = strtoul(buf, 0, 16);
+		i += 2;
+	}
+
+	return sdp_data_alloc(SDP_UUID128, &val);
+}
+
+sdp_data_t * sdp_xml_parse_uuid(const char *data)
+{
+	int len;
+	char *endptr;
+
+	len = strlen(data);
+
+	if (len == 36) {
+		return sdp_xml_parse_uuid128(data);
+	}
+	else {
+		uint32_t val;
+
+		val = strtoll(data, &endptr, 16);
+
+		/* Couldn't parse */
+		if (*endptr != '\0')
+			return NULL;
+
+		if (val > USHRT_MAX) {
+			return sdp_data_alloc(SDP_UUID32, &val);
+		}
+		else {
+			uint16_t val2 = val;
+			return sdp_data_alloc(SDP_UUID16, &val2);
+		}
+	}
+
+	/* Should never get here */
+	return NULL;
+}
+
+sdp_data_t * sdp_xml_parse_int(const char * data, uint8_t dtd)
+{
+	char *endptr;
+	sdp_data_t *ret = NULL;
+
+	switch (dtd) {
+	case SDP_BOOL:
+	{
+		uint8_t val = 0;
+
+		if (!strcmp("true", data)) {
+			val = 1;
+		}
+		
+		else if (!strcmp("false", data)) {
+			val = 0;
+		}
+		else {
+			return NULL;
+		}
+		
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_INT8:
+	{
+		int8_t val = strtoul(data, &endptr, 0);
+
+       		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;		
+
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_UINT8:
+	{
+		uint8_t val = strtoul(data, &endptr, 0);
+
+		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;
+		
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_INT16:
+	{
+		int16_t val = strtoul(data, &endptr, 0);
+
+		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;
+	
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_UINT16:
+	{
+		uint16_t val = strtoul(data, &endptr, 0);
+
+       		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;		
+
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_INT32:
+	{
+		int32_t val = strtoul(data, &endptr, 0);
+
+       		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;		
+		
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_UINT32:
+	{
+		uint32_t val = strtoul(data, &endptr, 0);
+
+       		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;		
+
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_INT64:
+	{
+		int64_t val = strtoull(data, &endptr, 0);
+		
+       		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;		
+		
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_UINT64:
+	{
+		uint64_t val = strtoull(data, &endptr, 0);
+
+       		/* Failed to parse */
+		if ((endptr != data) && (*endptr != '\0'))
+			return NULL;		
+
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	case SDP_INT128:
+	case SDP_UINT128:
+	{
+		uint128_t val;
+		int i = 0;
+		char buf[3];
+
+		buf[2] = '\0';
+
+		for (; i < 32; i += 2) {
+			buf[0] = data[i];
+			buf[1] = data[i + 1];
+
+			val.data[i] = strtoul(buf, 0, 16);
+		}
+
+		ret = sdp_data_alloc(dtd, &val);
+		break;
+	}
+
+	};
+
+	return ret;
+}
+
+sdp_data_t * sdp_xml_parse_url_with_size(const char * data, uint8_t dtd)
+{
+	return sdp_data_alloc(dtd, data);
+}
+
+sdp_data_t * sdp_xml_parse_url(const char * data)
+{
+	uint8_t dtd = SDP_URL_STR8;
+
+	if (strlen(data) > UCHAR_MAX) {
+		dtd = SDP_URL_STR16;
+	}
+
+	return sdp_xml_parse_url_with_size(data, dtd);
+}
+
+static const char * sdp_xml_parse_text_decode(const char *data, char encoding,
+		char *should_free, uint32_t *length)
+{
+	const char *text;
+
+	if (encoding == SDP_XML_NORMAL_ENCODING) {
+		text = data;
+		*length = strlen(text);
+	}
+	else {
+		int len = strlen(data);
+		char buf[3];
+		int i;
+		char *decoded =
+			(char *) malloc(sizeof(char) * ((len >> 1) + 1));
+
+		/* Ensure the string is a power of 2 */
+		len = (len >> 1) << 1;
+			
+		buf[2] = '\0';
+
+		for (i = 0; i < len; i += 2) {
+			buf[0] = data[i];
+			buf[1] = data[i + 1];
+
+			decoded[i >> 1] = strtoul(buf, 0, 16);
+		}
+
+		decoded[len >> 1] = '\0';
+		text = decoded;
+		*should_free = 1;
+		*length = len >> 1;
+	}
+
+	return text;
+}
+
+sdp_data_t * sdp_xml_parse_text_with_size(const char * data, char encoding, uint8_t dtd)
+{
+	char should_free = 0;
+	const char *text;
+	uint32_t length;
+	sdp_data_t *ret;
+
+	text = sdp_xml_parse_text_decode(data, encoding, &should_free, &length);
+	ret = sdp_data_alloc_with_length(dtd, text, length);
+
+#ifdef SDP_XML_DEBUG
+	debug("Got text of length %d: -->%s<--\n", length, text);
+	debug("Unit size was: %d\n", ret->unitSize);
+#endif
+
+	if (should_free)
+		free((char *)text);
+
+	return ret;
+}
+
+sdp_data_t * sdp_xml_parse_text(const char *data, char encoding)
+{
+	uint8_t dtd = SDP_TEXT_STR8;
+	char should_free = 0;
+	const char *text;
+	uint32_t length;
+	sdp_data_t *ret;
+
+	text = sdp_xml_parse_text_decode(data, encoding, &should_free, &length);
+
+	if (length > UCHAR_MAX) {
+		dtd = SDP_TEXT_STR16;
+	}
+
+	ret = sdp_data_alloc_with_length(dtd, text, length);
+
+#ifdef SDP_XML_DEBUG
+	debug("Got text of length %d: -->%s<--\n", length, text);
+	debug("Unit size was: %d\n", ret->unitSize);
+#endif
+
+	if (should_free)
+		free((char *)text);
+
+	return ret;
+}
+
+sdp_data_t * sdp_xml_parse_nil(const char * data)
+{
+	return sdp_data_alloc(SDP_DATA_NIL, 0);
+}
+
Index: common/sdp-xml.h
===================================================================
RCS file: /cvsroot/bluez/utils/common/sdp-xml.h,v
retrieving revision 1.2
diff -u -5 -r1.2 sdp-xml.h
--- common/sdp-xml.h	13 Nov 2006 07:38:20 -0000	1.2
+++ common/sdp-xml.h	21 Nov 2006 04:55:38 -0000
@@ -25,9 +25,50 @@
 #ifndef __SDP_XML_H
 #define __SDP_XML_H
 
 #include <bluetooth/sdp.h>
 
+#define SDP_XML_NORMAL_ENCODING 0
+#define SDP_XML_HEX_ENCODING 1
+
 void convert_sdp_record_to_xml(sdp_record_t *rec,
 		void *user_data, void (*append_func) (void *, const char *));
 
+sdp_data_t * sdp_xml_parse_nil(const char * data);
+sdp_data_t * sdp_xml_parse_text(const char *data, char encoding);
+sdp_data_t * sdp_xml_parse_text_with_size(const char * data, char encoding, uint8_t dtd);
+sdp_data_t * sdp_xml_parse_url(const char * data);
+sdp_data_t * sdp_xml_parse_url_with_size(const char * data, uint8_t dtd);
+sdp_data_t * sdp_xml_parse_int(const char * data, uint8_t dtd);
+sdp_data_t * sdp_xml_parse_uuid(const char *data);
+sdp_data_t * sdp_xml_parse_uuid128(const char *data);
+sdp_data_t * sdp_xml_parse_uuid32(const char *data);
+sdp_data_t * sdp_xml_parse_uuid16(const char *data);
+
+typedef struct _sdp_xml_context sdp_xml_context;
+
+sdp_xml_context *sdp_xml_init_context();
+
+/*
+	parses an XML chunk.  Returns -1 if a parse error occured, and 0
+	if successful.  Pass final as 1 if the chunk is the final chunk,
+	and 0 otherwise.
+*/
+int sdp_xml_parse_chunk(sdp_xml_context * context, const char *data, int size,
+			int final);
+
+/*
+	Should be called after sdp_xml_parse_chunk has been called with the
+	final flag set
+
+	Returns the resulting sdp_record_t.  The returned value will need to
+	be freed by the caller by usig sdp_record_free.
+*/
+sdp_record_t *sdp_xml_get_record(sdp_xml_context * context);
+
+/*
+	Frees all data except the sdp_record if the sdp_xml_get_record
+	was called.  Otherwise everything is freed.
+*/
+void sdp_xml_free_context(sdp_xml_context * context);
+		
 #endif /* __SDP_XML_H */
Index: hcid/dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.84
diff -u -5 -r1.84 dbus-api.txt
--- hcid/dbus-api.txt	14 Nov 2006 19:54:04 -0000	1.84
+++ hcid/dbus-api.txt	21 Nov 2006 04:55:38 -0000
@@ -189,10 +189,21 @@
 			representation of a service record. If the service
 			agent is running the service record will be automatically
 			registered, otherwise the record will be available
 			when the service agent Start method is called.
 
+		uint32 AddServiceRecordAsXML(string path, string record)
+
+			Add a new service record to the service agent
+			and returns the assigned handle.
+
+			The path parameter is the object path of the
+			service agent. The record parameter is the XML
+			representation of a service record. If the service
+			agent is running the service record will be automatically
+			registered, otherwise the record will be available
+			when the service agent Start method is called.
 
 		void  RemoveServiceRecord(string path, uint32 handle)
 
 			Remove a service record from the service agent
 			records list.
Index: hcid/dbus-manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-manager.c,v
retrieving revision 1.44
diff -u -5 -r1.44 dbus-manager.c
--- hcid/dbus-manager.c	17 Nov 2006 22:36:47 -0000	1.44
+++ hcid/dbus-manager.c	21 Nov 2006 04:55:39 -0000
@@ -43,10 +43,11 @@
 #include "dbus-common.h"
 #include "dbus-error.h"
 #include "dbus-security.h"
 #include "dbus-service.h"
 #include "dbus-manager.h"
+#include "sdp-xml.h"
 
 static int default_adapter_id = -1;
 static int autostart = 1;
 
 static uint32_t next_handle = 0x10000;
@@ -471,10 +472,126 @@
 	dbus_message_unref(reply);
 
 	return error_failed(conn, msg, err);
 }
 
+static DBusHandlerResult add_service_record_xml(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct service_agent *agent;
+	DBusMessage *reply;
+	struct binary_record *rec = 0;
+	sdp_record_t *sdp_rec = 0;
+	const char *path;
+	const char *record;
+	sdp_xml_context *xml_context = 0;
+	int err;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &path,
+				DBUS_TYPE_STRING, &record,
+				DBUS_TYPE_INVALID))
+		return error_invalid_arguments(conn, msg);
+
+	if (!dbus_connection_get_object_path_data(conn, path,
+						(void *) &agent)) {
+		/* If failed the path is invalid! */
+		return error_invalid_arguments(conn, msg);
+	}
+
+	if (!agent || strcmp(dbus_message_get_sender(msg), agent->id))
+		return error_not_authorized(conn, msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	xml_context = sdp_xml_init_context();
+	if (!xml_context) {
+		dbus_message_unref(reply);
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	}
+
+	if (sdp_xml_parse_chunk(xml_context, record, strlen(record), 1)) {
+		debug("Parsing failed...");
+		sdp_xml_free_context(xml_context);
+		dbus_message_unref(reply);
+		return error_invalid_arguments(conn, msg);
+	}
+
+	sdp_rec = sdp_xml_get_record(xml_context);
+
+	sdp_xml_free_context(xml_context);	
+	
+        /* TODO: Is this correct? We remove the record handle attribute
+	   (if it exists) so SDP server assigns a new one */
+        sdp_attr_remove(sdp_rec, 0x0);
+
+	/* TODO: How to handle RFCOMM / L2CAP PSMs? */
+	
+	if (!sdp_rec) {
+		dbus_message_unref(reply);
+		return error_invalid_arguments(conn, msg);
+	}
+
+	rec = binary_record_new();
+	if (!rec) {
+		sdp_record_free(sdp_rec);
+		dbus_message_unref(reply);
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	}
+
+	rec->buf = (sdp_buf_t *) malloc(sizeof(sdp_buf_t));
+
+	if (!rec->buf) {
+		sdp_record_free(sdp_rec);
+		binary_record_free(rec);
+		dbus_message_unref(reply);
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	}
+
+	/* Generate binary record */
+	if (sdp_gen_record_pdu(sdp_rec, rec->buf) != 0) {
+		sdp_record_free(sdp_rec);
+		binary_record_free(rec);
+		dbus_message_unref(reply);
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	}
+
+	sdp_record_free(sdp_rec);
+
+	/* Assign a new handle */
+	rec->ext_handle = next_handle++;
+
+	if (agent->running) {
+		uint32_t handle = 0;
+
+		if (register_sdp_record(rec->buf->data,	rec->buf->data_size, &handle) < 0) {
+			err = errno;
+			error("Service record registration failed: %s (%d)",
+							strerror(err), err);
+			goto fail;
+		}
+
+		rec->handle = handle;
+	}
+
+	agent->records = slist_append(agent->records, rec);
+
+	dbus_message_append_args(reply,
+				DBUS_TYPE_UINT32, &rec->ext_handle,
+				DBUS_TYPE_INVALID);
+
+	return send_message_and_unref(conn, reply);
+
+fail:
+	binary_record_free(rec);
+	dbus_message_unref(reply);
+
+	return error_failed(conn, msg, err);
+}
+
 static DBusHandlerResult remove_service_record(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct service_agent *agent;
 	struct binary_record *rec;
@@ -530,10 +647,11 @@
 	{ "ListAdapters",	list_adapters				},
 	{ "ListServices",	list_services				},
 	{ "RegisterService",	register_service			},
 	{ "UnregisterService",	unregister_service			},
 	{ "AddServiceRecord",		add_service_record		},
+	{ "AddServiceRecordAsXML", 	add_service_record_xml		},
 	{ "RemoveServiceRecord",	remove_service_record		},
 	{ NULL, NULL }
 };
 
 DBusHandlerResult handle_manager_method(DBusConnection *conn,
Index: hcid/service-agent.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/service-agent.c,v
retrieving revision 1.11
diff -u -5 -r1.11 service-agent.c
--- hcid/service-agent.c	8 Nov 2006 18:28:52 -0000	1.11
+++ hcid/service-agent.c	21 Nov 2006 04:55:39 -0000
@@ -30,17 +30,21 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <getopt.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include <dbus/dbus.h>
 
 #define INTERFACE "org.bluez.Manager"
 
 static char *name = NULL;
 static char *description = NULL;
+static char *xml_record = NULL;
 
 static volatile sig_atomic_t __io_canceled = 0;
 static volatile sig_atomic_t __io_terminated = 0;
 
 static void sig_term(int sig)
@@ -242,10 +246,49 @@
 	dbus_connection_flush(conn);
 
 	return 0;
 }
 
+static int add_record_xml(DBusConnection *conn, const char *service_path)
+{
+	DBusMessage *msg, *reply;
+	DBusError err;
+
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+					INTERFACE, "AddServiceRecordAsXML");
+	if (!msg) {
+		fprintf(stderr, "Can't allocate new method call\n");
+		return -1;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &service_path,
+							DBUS_TYPE_INVALID);
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &xml_record,
+							DBUS_TYPE_INVALID);
+
+	dbus_error_init(&err);
+
+	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
+
+	dbus_message_unref(msg);
+
+	if (!reply) {
+		fprintf(stderr, "Can't register service record\n");
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return -1;
+	}
+
+	dbus_message_unref(reply);
+
+	dbus_connection_flush(conn);
+
+	return 0;
+}
+
 static int register_service(DBusConnection *conn, const char *service_path)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
 
@@ -284,11 +327,14 @@
 
 	dbus_message_unref(reply);
 
 	dbus_connection_flush(conn);
 
-	return add_record(conn, service_path);
+	if (xml_record)
+		return add_record_xml(conn, service_path);
+	else
+		return add_record(conn, service_path);
 }
 
 static int unregister_service(DBusConnection *conn, const char *service_path)
 {
 	DBusMessage *msg, *reply;
@@ -335,27 +381,30 @@
 
 	printf("Usage:\n"
 		"\tservice-agent [--name service-name]"
 			" [--description service-description]"
 			" [--path service-path]\n"
+			" [--xmlfile xmlfile]\n"
 		"\n");
 }
 
 static struct option main_options[] = {
 	{ "name",		1, 0, 'n' },
 	{ "description",	1, 0, 'd' },
 	{ "path",		1, 0, 'p' },
+	{ "xmlfile",		1, 0, 'x' },
 	{ "help",		0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
 int main(int argc, char *argv[])
 {
 	struct sigaction sa;
 	DBusConnection *conn;
 	char match_string[128], default_path[128], *service_path = NULL;
 	int opt;
+	char *xmlfile = NULL;
 
 	snprintf(default_path, sizeof(default_path),
 				"/org/bluez/service_agent_%d", getpid());
 
 	while ((opt = getopt_long(argc, argv, "+n:d:p:h", main_options, NULL)) != EOF) {
@@ -364,10 +413,13 @@
 			name = strdup(optarg);
 			break;
 		case 'd':
 			description = strdup(optarg);
 			break;
+		case 'x':
+			xmlfile = strdup(optarg);
+			break;
 		case 'p':
 			if (optarg[0] != '/') {
 				fprintf(stderr, "Invalid path\n");
 				exit(1);
 			}
@@ -386,10 +438,37 @@
 	optind = 0;
 
 	if (!service_path)
 		service_path = strdup(default_path);
 
+	if (xmlfile) {
+		struct stat buf;
+		int fd;
+		
+		if (stat(xmlfile, &buf)) {
+			perror("Couldn't open xml file\n");
+			exit(1);
+		}
+
+		xml_record = (char *) malloc(buf.st_size);
+		if (!xml_record) {
+			fprintf(stderr, "Couldn't allocate XML Record\n");
+			exit(1);
+		}
+
+		fd = open(xmlfile, 0);
+
+		if (fd == -1) {
+			free(xml_record);
+			perror("Couldn't open XML file\n");
+			exit(1);
+		}
+
+		read(fd, xml_record,buf.st_size);
+		close(fd);
+	}
+
 	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 	if (!conn) {
 		fprintf(stderr, "Can't get on system bus");
 		exit(1);
 	}
@@ -432,9 +511,15 @@
 		free(name);
 
 	if (description)
 		free(description);
 
+	if (xmlfile)
+		free(xmlfile);
+
+	if (xml_record)
+		free(xml_record);
+
 	dbus_connection_unref(conn);
 
 	return 0;
 }

--Boundary-00=_qjoYFhFIwx81MZ6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_qjoYFhFIwx81MZ6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_qjoYFhFIwx81MZ6--
