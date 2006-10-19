Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 19 Oct 2006 13:34:25 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BJvNFFthEqRiu/F"
Message-Id: <200610191334.25362.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] SDP over XML
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

--Boundary-00=_BJvNFFthEqRiu/F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been playing around with the idea of encapsulating SDP information over 
XML.  The primary aim was to enable things like sdptool or hcid to be able to 
exchange SDP records in an open format.  It would also enable for 
applications to register arbitrary SDP records without relying on the sdp 
library (it is GPLed and thus not useable to some people)

I wrote some code for producing and parsing XML SDP records.  The aim would be 
to replace the current hcid GetRemoteServiceRecord method with something that 
produces XML, and also to have something like a RegisterServiceRecord that 
would take either a string description (e.g. OPUSH) and 
RegisterServiceRecordXML that would take an XML string.  

Additionally, a lot of the code that is currently in sdptool.c could be 
refactored into XML files, and it would be much more trivial to add new 
profiles (e.g. as an XML template instead of a function inside sdptool)

Before I continue, I'd like to get some feedback on the direction I should 
take.  What would be most useful to BlueZ?  Would there be any interest in a 
patch against hcid that does this?

Attached is an experimental patch against sdptool that show cases the current 
functionality.  It adds support for outputting records in XML format (e.g. 
sdptool get --xml 0x10000), as well as a XML format registration 
functionality (sdptool addxml <xmlfile>)

-Denis

--Boundary-00=_BJvNFFthEqRiu/F
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sdptool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdptool.patch"


--Boundary-00=_BJvNFFthEqRiu/F
Content-Type: text/x-chdr;
  charset="us-ascii";
  name="sdp-xml.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdp-xml.h"

#ifndef __SDP_XML_H__
#define __SDP_XML_H__

#include <ctype.h>
#include <bluetooth/sdp.h>
#include <expat.h>

typedef struct _sdp_xml_data sdp_xml_data_t;
struct _sdp_xml_data
{
	char *text;			/* Pointer to the current buffer */
	int size;			/* Size of the current buffer */
	sdp_data_t *data;		/* The current item being built */
	sdp_xml_data_t *next;		/* Next item on the stack */
	char type;			/* 0 = Text or Hexadecimal */
};

typedef struct
{
	XML_Parser parser;		/* Parser object being used */
	sdp_record_t *sdprec;		/* SDP Record being built */
	sdp_xml_data_t *stack_head;	/* Top of the stack of attributes */
	int attrId;			/* Id of the most recently processed attribute */
} sdp_xml_context;

sdp_xml_context *sdp_xml_init_context (void);
int sdp_xml_parse_chunk(sdp_xml_context * context,
			const char *data, int size, int final);
sdp_record_t *sdp_xml_get_record(sdp_xml_context * context);
void sdp_xml_free_context(sdp_xml_context * context);

void convert_sdp_record_to_xml(sdp_record_t * rec,
			       void *userData,
			       void (*appendFunc) (void *, const char *));

#endif

--Boundary-00=_BJvNFFthEqRiu/F
Content-Type: text/x-csrc;
  charset="us-ascii";
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

static void convert_raw_data_to_xml(sdp_data_t * data, int indentLevel,
				    void *userData,
				    void (*appendFunc) (void *, const char *))
{
	int i, hex;
	char buf[STRBUFSIZE];
	char indent[MAXINDENT];
	char indentPlusOne[MAXINDENT];

	if (!data)
		return;

	if (indentLevel >= MAXINDENT)
		indentLevel = MAXINDENT - 2;

	for (i = 0; i < indentLevel; i++) {
		indent[i] = '\t';
		indentPlusOne[i] = '\t';
	}

	indent[i] = '\0';
	indentPlusOne[i] = '\t';
	indentPlusOne[i + 1] = '\0';

	buf[STRBUFSIZE - 1] = '\0';

	switch (data->dtd) {
	case SDP_DATA_NIL:
		appendFunc(userData, indent);
		appendFunc(userData, "<NIL>");
		appendFunc(userData, "</NIL>\n");
		break;
	case SDP_BOOL:
		appendFunc(userData, indent);
		appendFunc(userData, "<BOOL>");
		appendFunc(userData, data->val.uint8 ? "True" : "False");
		appendFunc(userData, "</BOOL>\n");
		break;
	case SDP_UINT8:
		appendFunc(userData, indent);
		appendFunc(userData, "<UINT8>");
		snprintf(buf, STRBUFSIZE - 1, "0x%02x", data->val.uint8);
		appendFunc(userData, buf);
		appendFunc(userData, "</UINT8>\n");
		break;
	case SDP_UINT16:
		appendFunc(userData, indent);
		appendFunc(userData, "<UINT16>");
		snprintf(buf, STRBUFSIZE - 1, "0x%04x", data->val.uint16);
		appendFunc(userData, buf);
		appendFunc(userData, "</UINT16>\n");
		break;
	case SDP_UINT32:
		appendFunc(userData, indent);
		appendFunc(userData, "<UINT32>");
		snprintf(buf, STRBUFSIZE - 1, "0x%08x", data->val.uint32);
		appendFunc(userData, buf);
		appendFunc(userData, "</UINT32>\n");
		break;
	case SDP_UINT64:
		appendFunc(userData, indent);
		appendFunc(userData, "<UINT64>");
		snprintf(buf, STRBUFSIZE - 1, "0x%016jx", data->val.uint64);
		appendFunc(userData, buf);
		appendFunc(userData, "</UINT64>\n");
		break;
	case SDP_UINT128:
		appendFunc(userData, indent);
		appendFunc(userData, "<UINT128>");

		for (i = 0; i < 16; i++) {
			sprintf(&buf[i * 2], "%02x",
				(unsigned char) data->val.uint128.data[i]);
		}

		appendFunc(userData, buf);
		appendFunc(userData, "</UINT128>\n");
		break;
	case SDP_INT8:
		appendFunc(userData, indent);
		appendFunc(userData, "<INT8>");
		snprintf(buf, STRBUFSIZE - 1, "%d", data->val.int8);
		appendFunc(userData, buf);
		appendFunc(userData, "</INT8>\n");
		break;
	case SDP_INT16:
		appendFunc(userData, indent);
		appendFunc(userData, "<INT16>");
		snprintf(buf, STRBUFSIZE - 1, "%d", data->val.int16);
		appendFunc(userData, buf);
		appendFunc(userData, "</INT16>\n");
		break;
	case SDP_INT32:
		appendFunc(userData, indent);
		appendFunc(userData, "<INT32>");
		snprintf(buf, STRBUFSIZE - 1, "%d", data->val.int32);
		appendFunc(userData, buf);
		appendFunc(userData, "</INT32>\n");
		break;
	case SDP_INT64:
		appendFunc(userData, indent);
		appendFunc(userData, "<INT64>");
		snprintf(buf, STRBUFSIZE - 1, "%jd", data->val.int64);
		appendFunc(userData, buf);
		appendFunc(userData, "</INT8>\n");
		break;
	case SDP_INT128:
		appendFunc(userData, indent);
		appendFunc(userData, "<INT128>");

		for (i = 0; i < 16; i++) {
			sprintf(&buf[i * 2], "%02x",
				(unsigned char) data->val.int128.data[i]);
		}
		appendFunc(userData, buf);

		appendFunc(userData, "</INT128>\n");
		break;
	case SDP_UUID16:
		appendFunc(userData, indent);
		appendFunc(userData, "<UUID16>");
		snprintf(buf, STRBUFSIZE - 1, "0x%04x",
			 data->val.uuid.value.uuid16);
		appendFunc(userData, buf);
		appendFunc(userData, "</UUID16>\n");
		break;
	case SDP_UUID32:
		appendFunc(userData, indent);
		appendFunc(userData, "<UUID32>");
		snprintf(buf, STRBUFSIZE - 1, "0x%08x",
			 data->val.uuid.value.uuid32);
		appendFunc(userData, buf);
		appendFunc(userData, "</UUID32>\n");
		break;
	case SDP_UUID128:
		appendFunc(userData, indent);
		appendFunc(userData, "<UUID128>");

		snprintf(buf, STRBUFSIZE - 1,
			 "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[0],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[1],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[2],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[3],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[4],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[5],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[6],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[7],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[8],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[9],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[10],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[11],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[12],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[13],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[14],
			 (unsigned char) data->val.uuid.value.
			 uuid128.data[15]);

		appendFunc(userData, "</UUID128>\n");
		break;
	case SDP_TEXT_STR8:
	case SDP_TEXT_STR16:
	case SDP_TEXT_STR32:
		{

			hex = 0;

			for (i = 0; i < data->unitSize; i++) {
				if (i == (data->unitSize - 1)
				    && data->val.str[i] == '\0')
					break;
				if (!isalnum(data->val.str[i])
				    && (data->val.str[i] != ' ')) {
					hex = 1;
					break;
				}
			}
			appendFunc(userData, indent);
			char *strBuf = 0;

			if (hex) {
				strBuf = (char *)
					malloc(sizeof(char)
					       * (data->unitSize * 2 + 1));

				appendFunc(userData, "<Text type=\"data\">");
				for (i = 0; i < data->unitSize; i++)
					sprintf(&strBuf
						[i *
						 sizeof
						 (char) * 2],
						"%02x",
						(unsigned
						 char) data->val.str[i]);

				strBuf[data->unitSize * 2] = '\0';
			}
			else {
				strBuf = (char *)
					malloc(sizeof(char)
					       * (data->unitSize + 1));
				memcpy(strBuf, data->val.str, data->unitSize);
				strBuf[data->unitSize] = '\0';
				appendFunc(userData,
					   "<Text type=\"string\">");
			}

			appendFunc(userData, strBuf);
			free(strBuf);

			appendFunc(userData, "</Text>\n");
			break;
		}
	case SDP_URL_STR8:
	case SDP_URL_STR16:
	case SDP_URL_STR32:
		appendFunc(userData, indent);
		appendFunc(userData, "<URL>");
		appendFunc(userData, data->val.str);
		appendFunc(userData, "</URL>\n");
		break;
	case SDP_SEQ8:
	case SDP_SEQ16:
	case SDP_SEQ32:
		appendFunc(userData, indent);
		appendFunc(userData, "<Sequence>\n");
		convert_raw_data_to_xml(data->val.dataseq,
					indentLevel + 1, userData,
					appendFunc);
		appendFunc(userData, indent);
		appendFunc(userData, "</Sequence>\n");
		break;
	case SDP_ALT8:
	case SDP_ALT16:
	case SDP_ALT32:
		appendFunc(userData, indent);
		appendFunc(userData, "<Alternate>\n");
		convert_raw_data_to_xml(data->val.dataseq,
					indentLevel + 1, userData,
					appendFunc);
		appendFunc(userData, indent);
		appendFunc(userData, "</Alternate>\n");
		break;
	default:
		break;
	}

	convert_raw_data_to_xml(data->next, indentLevel, userData,
				appendFunc);
}

struct conversion_data
{
	void *userData;
	void (*appendFunc) (void *userData, const char *);
};

static void convert_raw_attr_to_xml_func(void *value, void *userData)
{
	struct conversion_data *cd = (struct conversion_data *) userData;
	sdp_data_t *data = (sdp_data_t *) value;
	char buf[STRBUFSIZE];

	buf[STRBUFSIZE - 1] = '\0';
	snprintf(buf, STRBUFSIZE - 1, "\t<Attribute id=\"0x%04x\">\n",
		 data->attrId);
	cd->appendFunc(cd->userData, buf);

	if (data)
		convert_raw_data_to_xml(data, 2, cd->userData,
					cd->appendFunc);
	else
		cd->appendFunc(cd->userData, "\t\tNULL\n");

	cd->appendFunc(cd->userData, "\t</Attribute>\n");
}

/*
    Will convert the sdp record to XML.  The appendFunc and userData can be used
    to control where to output the record (e.g. file or a data buffer).  The
    appendFunc will be called repeatedly with userData and the character buffer
    (containing parts of the generated XML) to append.
*/
void convert_sdp_record_to_xml(sdp_record_t * rec,
			       void *userData,
			       void (*appendFunc) (void *, const char *))
{
	struct conversion_data data;

	data.userData = userData;
	data.appendFunc = appendFunc;

	if (rec && rec->attrlist) {
		appendFunc(userData, "<SdpRecord>\n");
		sdp_list_foreach(rec->attrlist,
				 convert_raw_attr_to_xml_func, &data);
		appendFunc(userData, "</SdpRecord>\n");
	}
}

#define DEFAULT_XML_DATA_SIZE 64

static sdp_xml_data_t *sdp_xml_data_alloc()
{
	sdp_xml_data_t *elem;

	elem = (sdp_xml_data_t *) malloc(sizeof(sdp_xml_data_t));

	/* Null terminate the text */
	elem->size = DEFAULT_XML_DATA_SIZE;
	elem->text = (char *) malloc(sizeof(char) * DEFAULT_XML_DATA_SIZE);
	elem->text[0] = '\0';

	elem->next = 0;
	elem->data = 0;

	elem->type = 0;

	return elem;
}

static void sdp_xml_data_free(sdp_xml_data_t * elem)
{
	if (elem->data)
		sdp_data_free(elem->data);

	free(elem->text);
	free(elem);
}

static sdp_xml_data_t *sdp_xml_data_expand(sdp_xml_data_t * elem)
{
	char *newbuf;

	newbuf = (char *) malloc(elem->size * 2);
	if (!newbuf)
		return NULL;

	memcpy(newbuf, elem->text, elem->size);
	elem->size *= 2;
	free(elem->text);

	elem->text = newbuf;

	return elem;
}

static void convert_xml_to_sdp_chardata(void *data, const XML_Char * s,
					int len)
{
	sdp_xml_context *context = (sdp_xml_context *) data;
	int curlen;
	int i;

	curlen = strlen(context->stack_head->text);

	/* Ensure we're big enough */
	while ((curlen + 1 + len) > context->stack_head->size) {
		fprintf(stderr, "Growing text\n");
		sdp_xml_data_expand(context->stack_head);
	}

	memcpy(&context->stack_head->text[curlen], s, len);
	fprintf(stderr, "Curlen+len: %d\n", curlen + len);
	context->stack_head->text[curlen + len] = '\0';
}

static void convert_xml_to_sdp_start(void *data, const char *el,
				     const char **attr)
{
	int i;
	sdp_xml_context *context = (sdp_xml_context *) data;

	if (!strcmp(el, "SdpRecord"))
		return;

	if (!strcmp(el, "Attribute")) {
		/* Get the ID */
		for (i = 0; attr[i]; i += 1) {
			if (!strcmp(attr[i], "id")) {
				context->attrId = strtol(attr[i + 1], 0, 0);
				break;
			}
		}

		return;
	}

	/* Assume every other tag is an element of some sort */
	if (context->stack_head) {
		sdp_xml_data_t *newElem = sdp_xml_data_alloc();
		newElem->next = context->stack_head;
		context->stack_head = newElem;
	}
	else {
		context->stack_head = sdp_xml_data_alloc();
		context->stack_head->next = 0;
	}

	if (!strcmp(el, "Sequence")) {
		context->stack_head->data = sdp_data_alloc(SDP_SEQ8, NULL);
	}

	else if (!strcmp(el, "Alternate")) {
		context->stack_head->data = sdp_data_alloc(SDP_ALT8, NULL);
	}

	else {
		if (!strcmp(el, "Text")) {
			/* Get the Type */
			for (i = 0; attr[i]; i += 1) {
				if (!strcmp(attr[i], "type")) {
					if (!strcmp(attr[i + 1], "data"))
						context->stack_head->type = 1;

					break;
				}
			}
		}

		XML_SetCharacterDataHandler(context->parser,
					    convert_xml_to_sdp_chardata);
	}
}

static void sdp_xml_parse_uuid16(sdp_xml_context * data)
{
	uint16_t val;

	val = strtol(data->stack_head->text, 0, 16);

	data->stack_head->data = sdp_data_alloc(SDP_UUID16, &val);
}

static void sdp_xml_parse_uuid32(sdp_xml_context * data)
{
	uint32_t val;

	val = strtoll(data->stack_head->text, 0, 16);
	data->stack_head->data = sdp_data_alloc(SDP_UUID32, &val);
}

static void sdp_xml_parse_uuid128(sdp_xml_context * data)
{
	uint128_t val;
	int i;
	int j;

	char buf[3];

	buf[2] = '\0';

	for (j = 0, i = 0; i < strlen(data->stack_head->text); j++) {
		if (data->stack_head->text[i] == '-') {
			i++;
			continue;
		}

		buf[0] = data->stack_head->text[i];
		buf[1] = data->stack_head->text[i + 1];

		val.data[i] = strtoul(buf, 0, 16);
		i += 2;
	}

	data->stack_head->data = sdp_data_alloc(SDP_UUID128, &val);
}

static void sdp_xml_parse_int(sdp_xml_context * data, uint8_t dtd)
{
	switch (dtd) {
	case SDP_BOOL:
		{
			uint8_t val = 0;

			if (!strcmp("True", data->stack_head->text)) {
				val = 1;
			}
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_INT8:
		{
			int8_t val = strtoul(data->stack_head->text, 0,
					     10);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_UINT8:
		{
			uint8_t val = strtoul(data->stack_head->text, 0,
					      16);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_INT16:
		{
			int16_t val = strtoul(data->stack_head->text, 0,
					      10);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_UINT16:
		{
			uint16_t val = strtoul(data->stack_head->text, 0,
					       16);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_INT32:
		{
			int32_t val = strtoul(data->stack_head->text, 0,
					      10);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_UINT32:
		{
			uint32_t val = strtoul(data->stack_head->text, 0,
					       16);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_INT64:
		{
			int64_t val = strtoull(data->stack_head->text, 0,
					       10);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_UINT64:
		{
			uint64_t val = strtoull(data->stack_head->text, 0,
						16);
			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	case SDP_INT128:
	case SDP_UINT128:
		{
			uint128_t val;
			int i = 0;
			char buf[3];

			buf[2] = '\0';

			for (; i < 32; i += 2) {
				buf[0] = data->stack_head->text[i];
				buf[1] = data->stack_head->text[i + 1];

				val.data[i] = strtoul(buf, 0, 16);
			}

			data->stack_head->data = sdp_data_alloc(dtd, &val);
			break;
		}

	};
}

static void sdp_xml_parse_url(sdp_xml_context * data)
{
	uint8_t dtd = SDP_URL_STR8;

	if (strlen(data->stack_head->text) > UCHAR_MAX) {
		dtd = SDP_URL_STR16;
	}

	data->stack_head->data = sdp_data_alloc(dtd, data->stack_head->text);
}

static void sdp_xml_parse_text(sdp_xml_context * data)
{
	uint8_t dtd = SDP_TEXT_STR8;
	char *text;
	char shouldFree = 0;

	if (data->stack_head->type == 0) {
		text = data->stack_head->text;
	}
	else {
		int len = strlen(data->stack_head->text);
		char buf[3];
		int i;
		char *decoded =
			(char *) malloc(sizeof(char) * ((len >> 1) + 1));

		fprintf(stderr,
			"Got a stack_head->text len of: %d(%s)\n",
			len, data->stack_head->text);
		fprintf(stderr, "len >> 1 = %d\n", len >> 1);

		buf[2] = '\0';

		for (i = 0; i < len; i += 2) {
			buf[0] = data->stack_head->text[i];
			buf[1] = data->stack_head->text[i + 1];

			decoded[i >> 1] = strtoul(buf, 0, 16);
		}

		decoded[len >> 1] = '\0';
		text = decoded;
		shouldFree = 1;
	}

	if (strlen(text) > UCHAR_MAX) {
		dtd = SDP_TEXT_STR16;
	}

	data->stack_head->data = sdp_data_alloc(dtd, text);

	fprintf(stderr, "Got text of length %d: -->%s<--\n", strlen(text),
		text);
	fprintf(stderr, "Unit size was: %d\n",
		data->stack_head->data->unitSize);

	if (shouldFree)
		free(text);
}

static void sdp_xml_parse_datatype(sdp_xml_context * context, const char *el)
{
	if (!strcmp(el, "BOOL")) {
		sdp_xml_parse_int(context, SDP_BOOL);
	}

	else if (!strcmp(el, "UINT8")) {
		sdp_xml_parse_int(context, SDP_UINT8);
	}
	else if (!strcmp(el, "UINT16")) {
		sdp_xml_parse_int(context, SDP_UINT16);
	}

	else if (!strcmp(el, "UINT32")) {
		sdp_xml_parse_int(context, SDP_UINT32);
	}

	else if (!strcmp(el, "UINT64")) {
		sdp_xml_parse_int(context, SDP_UINT64);
	}

	else if (!strcmp(el, "UINT128")) {
		sdp_xml_parse_int(context, SDP_UINT128);
	}

	else if (!strcmp(el, "INT8")) {
		sdp_xml_parse_int(context, SDP_INT8);
	}

	else if (!strcmp(el, "INT16")) {
		sdp_xml_parse_int(context, SDP_INT16);
	}

	else if (!strcmp(el, "INT32")) {
		sdp_xml_parse_int(context, SDP_INT32);
	}

	else if (!strcmp(el, "INT64")) {
		sdp_xml_parse_int(context, SDP_INT64);
	}

	else if (!strcmp(el, "INT128")) {
		sdp_xml_parse_int(context, SDP_INT128);
	}

	else if (!strcmp(el, "UUID16")) {
		sdp_xml_parse_uuid16(context);
	}

	else if (!strcmp(el, "UUID32")) {
		sdp_xml_parse_uuid32(context);

	}

	else if (!strcmp(el, "UUID128")) {
		sdp_xml_parse_uuid128(context);

	}

	else if (!strcmp(el, "URL")) {
		sdp_xml_parse_url(context);
	}

	else if (!strcmp(el, "Text")) {
		sdp_xml_parse_text(context);
	}

	else {
		printf("Ending element: %s\n", el);
		printf("Gathered data: %s\n", context->stack_head->text);
	}
}

static void convert_xml_to_sdp_end(void *data, const char *el)
{
	sdp_xml_context *context = (sdp_xml_context *) data;
	sdp_xml_data_t *elem;

	if (!strcmp(el, "SdpRecord"))
		return;

	XML_SetCharacterDataHandler(context->parser, 0);

	if (!strcmp(el, "Attribute")) {
		if (context->stack_head && context->stack_head->data) {
			int ret = sdp_attr_add(context->sdprec,
					       context->attrId,
					       context->stack_head->data);
			if (ret == -1)
				fprintf(stderr, "Trouble adding attribute\n");

			context->stack_head->data = 0;
			sdp_xml_data_free(context->stack_head);
			context->stack_head = 0;
		}
		else {
			fprintf(stderr,
				"No Data for attribute: %d\n",
				context->attrId);
		}

		return;
	}
	else if (!strcmp(el, "Sequence")) {
		sdp_data_t *seq = context->stack_head->data->val.dataseq;

		fprintf(stderr, "seq unitSize is: %d\n",
			context->stack_head->data->unitSize);

		for (; seq; seq = seq->next)
			context->stack_head->data->unitSize += seq->unitSize;

		fprintf(stderr, "seq unitSize is now: %d\n",
			context->stack_head->data->unitSize);

		if (context->stack_head->data->unitSize > USHRT_MAX) {
			context->stack_head->data->unitSize +=
				sizeof(uint32_t);
			context->stack_head->data->dtd = SDP_SEQ32;
		}
		else if (context->stack_head->data->unitSize > UCHAR_MAX) {
			context->stack_head->data->unitSize +=
				sizeof(uint16_t);
			context->stack_head->data->dtd = SDP_SEQ16;
		}
		else {
			context->stack_head->data->unitSize +=
				sizeof(uint8_t);
		}
	}

	else if (!strcmp(el, "Alternate")) {
		sdp_data_t *alt = context->stack_head->data->val.dataseq;

		fprintf(stderr, "seq unitSize is: %d\n",
			context->stack_head->data->unitSize);

		for (; alt; alt = alt->next)
			context->stack_head->data->unitSize += alt->unitSize;

		fprintf(stderr, "alt unitSize is now: %d\n",
			context->stack_head->data->unitSize);

		if (context->stack_head->data->unitSize > USHRT_MAX) {
			context->stack_head->data->unitSize +=
				sizeof(uint32_t);
			context->stack_head->data->dtd = SDP_ALT32;
		}
		else if (context->stack_head->data->unitSize > UCHAR_MAX) {
			context->stack_head->data->unitSize +=
				sizeof(uint16_t);
			context->stack_head->data->dtd = SDP_ALT16;
		}
		else {
			context->stack_head->data->unitSize +=
				sizeof(uint8_t);
		}
	}

	else {
		sdp_xml_parse_datatype(context, el);
	}

	/* If we're not inside a seq or alt, then we're inside an attribute
	   which will be taken care of later
	 */
	if (context->stack_head->next &&
	    context->stack_head->data && context->stack_head->next->data) {
		switch (context->stack_head->next->data->dtd) {
		case SDP_SEQ8:
		case SDP_SEQ16:
		case SDP_SEQ32:
		case SDP_ALT8:
		case SDP_ALT16:
		case SDP_ALT32:
			context->stack_head->next->data->val.
				dataseq =
				sdp_seq_append(context->
					       stack_head->
					       next->data->
					       val.dataseq,
					       context->stack_head->data);
			context->stack_head->data = 0;
			break;
		}

		elem = context->stack_head;
		context->stack_head = context->stack_head->next;

		sdp_xml_data_free(elem);
	}
}

sdp_xml_context *sdp_xml_init_context()
{
	sdp_xml_context *context = 0;

	context = (sdp_xml_context *) malloc(sizeof(sdp_xml_context));

	if (!context)
		return NULL;

	context->parser = 0;
	context->sdprec = 0;
	context->stack_head = 0;

	context->parser = XML_ParserCreate(NULL);
	XML_SetElementHandler(context->parser, convert_xml_to_sdp_start,
			      convert_xml_to_sdp_end);
	XML_SetUserData(context->parser, context);

	if (!context->parser)
		goto fail;

	context->sdprec = sdp_record_alloc();

	if (!context->sdprec)
		goto fail;

	return context;

      fail:
	fprintf(stderr, "Failed to allocated context\n");

	if (context->parser)
		free(context->parser);

	if (context->sdprec)
		sdp_record_free(context->sdprec);

	if (context)
		free(context);

	return NULL;
}

/*
    Should be called after sdp_xml_parse_chunk has been called with the final flag set
    Returns the resulting sdp_record_t.  The returned value is will need to be freed
    by the caller by usig sdp_record_free.
*/
sdp_record_t *sdp_xml_get_record(sdp_xml_context * context)
{
	sdp_record_t *rec = context->sdprec;

	context->sdprec = 0;

	return rec;
}

/*
    Frees all data except the sdp_record if the sdp_xml_get_record was called.  Otherwise
    everything is freed.
*/
void sdp_xml_free_context(sdp_xml_context * context)
{
	sdp_xml_data_t *elem;

	/* Free the stack */
	while (context->stack_head) {
		elem = context->stack_head;
		context->stack_head = elem->next;
		sdp_xml_data_free(elem);
	}

	if (context->sdprec)
		sdp_record_free(context->sdprec);
	XML_ParserFree(context->parser);
	free(context);
}

/*
    parses an XML chunk.  Returns -1 if a parse error occured, and 0 if successful
    pass final as 1 if the chunk is the final chunk
*/
int sdp_xml_parse_chunk(sdp_xml_context * context, const char *data, int size,
			int final)
{
	if (!XML_Parse(context->parser, data, size, final)) {
		fprintf(stderr, "Parse error at line %d:\n%s\n",
			XML_GetCurrentLineNumber(context->parser),
			XML_ErrorString(XML_GetErrorCode(context->parser)));
		return -1;
	}

	return 0;
}

--Boundary-00=_BJvNFFthEqRiu/F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_BJvNFFthEqRiu/F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_BJvNFFthEqRiu/F--
