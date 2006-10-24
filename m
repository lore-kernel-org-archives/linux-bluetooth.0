Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 24 Oct 2006 16:47:20 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241547.36330.denis.kenzior@trolltech.com>
	<1161677612.10866.138.camel@aeonflux.holtmann.net>
In-Reply-To: <1161677612.10866.138.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4bbPF1YOXrAcBDK"
Message-Id: <200610241647.20895.denis.kenzior@trolltech.com>
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

--Boundary-00=_4bbPF1YOXrAcBDK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

On Tuesday 24 October 2006 18:13, Marcel Holtmann wrote:
> Hi Denis,
>
> > Based on your feedback a new DTD specification.  Hopefully it is getting
> > closer.
>
> looks good. However the text about hex encoded is not needed. All number
> based values can be either in hex or decimal or whatever. We will use
> the standard encoding to detect it. For example if it starts with 0x
> then it is hex, otherwise it is decimal.

Yes, the encoding is only relevant for the <text[8,16,32]> fields.  The rest 
of the attributes should not have it (this is hard to express in a DTD.)

>
> I am also not sure that the encoding attribute is needed. If you wanna
> encode binary data in text elements (at the moment only HID does this)
> then you can use \000 style encoding to do so.

This does not seem to be supported by expat, unless I'm missing something.  I 
also want to expand encoding to eventually have a base64 option, for space 
saving.  

How would this work, do you mean to just recognize if a character starts with 
\0xxx - Octal
\xx - Hex?

>
> Can also provide an example XML record for a really simple serial port
> profile. This will help to see how it looks like.
>
> Anyone willing to write a really specific and simple XML parser to
> convert these XML files into sdp_record_t structures. And or course a
> function that converts this structure back to XML.

Attached is a sample of OPUSH profile.  Attached also is the code to generate 
one of these and parse one of these as well (you can use attached sdptool 
patch to play with it)

The code is still pretty raw, but it should at least get us started.

>
> Regards
>
> Marcel
>

-Denis

--Boundary-00=_4bbPF1YOXrAcBDK
Content-Type: text/xml;
  charset="iso-8859-1";
  name="OPUSH.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="OPUSH.xml"

<record>
	<attribute id="0x0000">
		<data type="uint32" value="0x00010000" />
	</attribute>
	<attribute id="0x0001">
		<sequence8>
			<data type="uuid16" value="0x1105" />
		</sequence8>
	</attribute>
	<attribute id="0x0004">
		<sequence8>
			<sequence8>
				<data type="uuid16" value="0x0100" />
			</sequence8>
			<sequence8>
				<data type="uuid16" value="0x0003" />
				<data type="uint8" value="0x09" />
			</sequence8>
			<sequence8>
				<data type="uuid16" value="0x0008" />
			</sequence8>
		</sequence8>
	</attribute>
	<attribute id="0x0005">
		<sequence8>
			<data type="uuid16" value="0x1002" />
		</sequence8>
	</attribute>
	<attribute id="0x0009">
		<sequence8>
			<sequence8>
				<data type="uuid16" value="0x1105" />
				<data type="uint16" value="0x0100" />
			</sequence8>
		</sequence8>
	</attribute>
	<attribute id="0x0100">
		<data type="text8" value="OBEX Object Push" />
	</attribute>
	<attribute id="0x0303">
		<sequence8>
			<data type="uint8" value="0x01" />
			<data type="uint8" value="0x02" />
			<data type="uint8" value="0x03" />
			<data type="uint8" value="0x04" />
			<data type="uint8" value="0x05" />
			<data type="uint8" value="0x06" />
		</sequence8>
	</attribute>
</record>

--Boundary-00=_4bbPF1YOXrAcBDK
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
		appendFunc(userData, "<data type=\"nil\" value=\"\" />\n");
		break;
	case SDP_BOOL:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"bool\" value=\"");
		appendFunc(userData, data->val.uint8 ? "True" : "False");
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UINT8:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uint8\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%02x", data->val.uint8);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UINT16:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uint16\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%04x", data->val.uint16);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UINT32:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uint32\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%08x", data->val.uint32);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UINT64:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uint64\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%016jx", data->val.uint64);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UINT128:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uint128\" value=\"");

		for (i = 0; i < 16; i++) {
			sprintf(&buf[i * 2], "%02x",
				(unsigned char) data->val.uint128.data[i]);
		}

		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_INT8:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"int8\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%d", data->val.int8);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_INT16:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"int16\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%d", data->val.int16);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_INT32:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"int32\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%d", data->val.int32);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_INT64:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"int64\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "%jd", data->val.int64);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_INT128:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"int128\" value=\"");

		for (i = 0; i < 16; i++) {
			sprintf(&buf[i * 2], "%02x",
				(unsigned char) data->val.int128.data[i]);
		}
		appendFunc(userData, buf);

		appendFunc(userData, "\" />\n");
		break;
	case SDP_UUID16:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uuid16\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%04x",
			 data->val.uuid.value.uuid16);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UUID32:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uuid32\" value=\"");
		snprintf(buf, STRBUFSIZE - 1, "0x%08x",
			 data->val.uuid.value.uuid32);
		appendFunc(userData, buf);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_UUID128:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"uuid128\" value=\"");

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

		appendFunc(userData, "\" />\n");
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

		appendFunc(userData, "<data ");

		switch (data->dtd) {
			case SDP_TEXT_STR8:
				appendFunc(userData, "type=\"text8\" ");
				break;
			case SDP_TEXT_STR16:
				appendFunc(userData, "type=\"text16\" ");
				break;
			case SDP_TEXT_STR32:
				appendFunc(userData, "type=\"text32\" ");
				break;
		};

		char *strBuf = 0;

		if (hex) {
			appendFunc(userData, "encoding=\"hex\" ");
			strBuf = (char *) malloc(sizeof(char)
						 * (data->unitSize * 2 + 1));

			// Unit Size seems to include the size for dtd
			// It is thus off by 1
			// This is safe for Normal strings, but not
			// hex encoded data
			for (i = 0; i < (data->unitSize-1); i++)
				sprintf(&strBuf[i * sizeof (char) * 2],
					"%02x",
					(unsigned char) data->val.str[i]);

			strBuf[data->unitSize * 2] = '\0';
		}
		else {
			strBuf = (char *)
				malloc(sizeof(char) * (data->unitSize + 1));
			memcpy(strBuf, data->val.str, data->unitSize);
			strBuf[data->unitSize] = '\0';
		}

		appendFunc(userData, "value=\"");
		appendFunc(userData, strBuf);
		appendFunc(userData, "\" />\n");
		free(strBuf);
		break;
	}
	case SDP_URL_STR8:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"url8\" value=\"");
		appendFunc(userData, data->val.str);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_URL_STR16:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"url16\" value=\"");
		appendFunc(userData, data->val.str);
		appendFunc(userData, "\" />\n");
	case SDP_URL_STR32:
		appendFunc(userData, indent);
		appendFunc(userData, "<data type=\"url32\" value=\"");
		appendFunc(userData, data->val.str);
		appendFunc(userData, "\" />\n");
		break;
	case SDP_SEQ8:
	case SDP_SEQ16:
	case SDP_SEQ32:
		appendFunc(userData, indent);
		switch(data->dtd) {
			case SDP_SEQ8:
				appendFunc(userData, "<sequence8>\n");
				break;
			case SDP_SEQ16:
				appendFunc(userData, "<sequence16>\n");
				break;
			case SDP_SEQ32:
				appendFunc(userData, "<sequence32>\n");
				break;
		};

		convert_raw_data_to_xml(data->val.dataseq,
					indentLevel + 1, userData,
					appendFunc);
					
		appendFunc(userData, indent);
		switch(data->dtd) {
			case SDP_SEQ8:
				appendFunc(userData, "</sequence8>\n");
				break;
			case SDP_SEQ16:
				appendFunc(userData, "</sequence16>\n");
				break;
			case SDP_SEQ32:
				appendFunc(userData, "</sequence32>\n");
				break;
		};
		
		break;
	case SDP_ALT8:
	case SDP_ALT16:
	case SDP_ALT32:
		appendFunc(userData, indent);

		switch(data->dtd) {
			case SDP_ALT8:
				appendFunc(userData, "<alternate8>\n");
				break;
			case SDP_ALT16:
				appendFunc(userData, "<alternate16>\n");
				break;
			case SDP_ALT32:
				appendFunc(userData, "<alternate32>\n");
				break;
		};

		convert_raw_data_to_xml(data->val.dataseq,
					indentLevel + 1, userData,
					appendFunc);
		appendFunc(userData, indent);

		switch(data->dtd) {
			case SDP_ALT8:
				appendFunc(userData, "</alternate8>\n");
				break;
			case SDP_ALT16:
				appendFunc(userData, "</alternate16>\n");
				break;
			case SDP_ALT32:
				appendFunc(userData, "</alternate32>\n");
				break;
		};
	       
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
	snprintf(buf, STRBUFSIZE - 1, "\t<attribute id=\"0x%04x\">\n",
		 data->attrId);
	cd->appendFunc(cd->userData, buf);

	if (data)
		convert_raw_data_to_xml(data, 2, cd->userData,
					cd->appendFunc);
	else
		cd->appendFunc(cd->userData, "\t\tNULL\n");

	cd->appendFunc(cd->userData, "\t</attribute>\n");
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
		appendFunc(userData, "<record>\n");
		sdp_list_foreach(rec->attrlist,
				 convert_raw_attr_to_xml_func, &data);
		appendFunc(userData, "</record>\n");
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

static void sdp_xml_parse_uuid(sdp_xml_context *data)
{
	int len;

	len = strlen(data->stack_head->text);

	if (len == 36) {
		sdp_xml_parse_uuid128(data);
	}
	else {
		uint32_t val;

		val = strtoll(data->stack_head->text, 0, 16);

		if (val > USHRT_MAX) {
			data->stack_head->data =
				sdp_data_alloc(SDP_UUID32, &val);
		}
		else {
			uint16_t val2 = val;
			data->stack_head->data =
				sdp_data_alloc(SDP_UUID16, &val2);
		}
	}
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

static void sdp_xml_parse_url_with_size(sdp_xml_context * data, uint8_t dtd)
{
	data->stack_head->data = sdp_data_alloc(dtd, data->stack_head->text);
}

static void sdp_xml_parse_url(sdp_xml_context * data)
{
	uint8_t dtd = SDP_URL_STR8;

	if (strlen(data->stack_head->text) > UCHAR_MAX) {
		dtd = SDP_URL_STR16;
	}

	sdp_xml_parse_url_with_size(data, dtd);
}

static char * sdp_xml_parse_text_decode(sdp_xml_context *data,
					char *shouldFree,
					uint32_t *length)
{
	char *text;

	if (data->stack_head->type == 0) {
		text = data->stack_head->text;
		*length = strlen(text);
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
			fprintf(stderr, "Putting at %d\n", i>>1);
		}

		decoded[len >> 1] = '\0';
		text = decoded;
		*shouldFree = 1;
		*length = len >> 1;
	}

	return text;
}

static void sdp_xml_parse_text_with_size(sdp_xml_context * data, uint8_t dtd)
{
	char shouldFree = 0;
	char *text;
	uint32_t length;

	text = sdp_xml_parse_text_decode(data, &shouldFree, &length);
	data->stack_head->data = sdp_data_alloc_with_length(dtd, text, length);

	fprintf(stderr, "Got text of length %d: -->%s<--\n", length,
		text);
	fprintf(stderr, "Unit size was: %d\n",
		data->stack_head->data->unitSize);

	if (shouldFree)
		free(text);
}

static void sdp_xml_parse_text(sdp_xml_context * data)
{
	uint8_t dtd = SDP_TEXT_STR8;
	char shouldFree = 0;
	char *text;
	uint32_t length;

	text = sdp_xml_parse_text_decode(data, &shouldFree, &length);

	if (length > UCHAR_MAX) {
		dtd = SDP_TEXT_STR16;
	}

	fprintf(stderr, "Got text of length %d: -->%s<--\n", length,
		text);
	fprintf(stderr, "Unit size was: %d\n",
		data->stack_head->data->unitSize);

	data->stack_head->data = sdp_data_alloc(dtd, text);

	if (shouldFree)
		free(text);
}

static void sdp_xml_parse_nil(sdp_xml_context * data)
{
	data->stack_head->data = sdp_data_alloc(SDP_DATA_NIL, 0);
}

static void sdp_xml_parse_datatype(sdp_xml_context * context, const char *el)
{
	if (!strcmp(el, "bool")) {
		sdp_xml_parse_int(context, SDP_BOOL);
	}

	else if (!strcmp(el, "uint8")) {
		sdp_xml_parse_int(context, SDP_UINT8);
	}
	else if (!strcmp(el, "uint16")) {
		sdp_xml_parse_int(context, SDP_UINT16);
	}

	else if (!strcmp(el, "uint32")) {
		sdp_xml_parse_int(context, SDP_UINT32);
	}

	else if (!strcmp(el, "uint64")) {
		sdp_xml_parse_int(context, SDP_UINT64);
	}

	else if (!strcmp(el, "uint128")) {
		sdp_xml_parse_int(context, SDP_UINT128);
	}

	else if (!strcmp(el, "int8")) {
		sdp_xml_parse_int(context, SDP_INT8);
	}

	else if (!strcmp(el, "int16")) {
		sdp_xml_parse_int(context, SDP_INT16);
	}

	else if (!strcmp(el, "int32")) {
		sdp_xml_parse_int(context, SDP_INT32);
	}

	else if (!strcmp(el, "int64")) {
		sdp_xml_parse_int(context, SDP_INT64);
	}

	else if (!strcmp(el, "int128")) {
		sdp_xml_parse_int(context, SDP_INT128);
	}

	else if (!strcmp(el, "uuid16")) {
		sdp_xml_parse_uuid16(context);
	}

	else if (!strcmp(el, "uuid32")) {
		sdp_xml_parse_uuid32(context);

	}

	else if (!strcmp(el, "uuid128")) {
		sdp_xml_parse_uuid128(context);
	}

	else if (!strcmp(el, "uuid")) {
		sdp_xml_parse_uuid(context);
	}

	else if (!strcmp(el, "url")) {
		sdp_xml_parse_url(context);
	}

	else if (!strcmp(el, "url8")) {
		sdp_xml_parse_url_with_size(context, SDP_URL_STR8);
	}

	else if (!strcmp(el, "url16")) {
		sdp_xml_parse_url_with_size(context, SDP_URL_STR16);
	}

	else if (!strcmp(el, "url32")) {
		sdp_xml_parse_url_with_size(context, SDP_URL_STR32);
	}

	else if (!strcmp(el, "text")) {
		sdp_xml_parse_text(context);
	}

	else if (!strcmp(el, "text8")) {
		sdp_xml_parse_text_with_size(context, SDP_TEXT_STR8);
	}

	else if (!strcmp(el, "text16")) {
		sdp_xml_parse_text_with_size(context, SDP_TEXT_STR16);
	}

	else if (!strcmp(el, "text32")) {
		sdp_xml_parse_text_with_size(context, SDP_TEXT_STR32);
	}

	else if (!strcmp(el, "nil")) {
		sdp_xml_parse_nil(context);
	}

	else {
		printf("Can't parse element: %s\n", el);
		printf("Gathered data: %s\n", context->stack_head->text);
	}
}

static void convert_xml_to_sdp_start(void *data, const char *el,
				     const char **attr)
{
	int i;
	sdp_xml_context *context = (sdp_xml_context *) data;

	if (!strcmp(el, "record"))
		return;

	if (!strcmp(el, "attribute")) {
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

	if (!strcmp(el, "sequence")) {
		context->stack_head->data = sdp_data_alloc(SDP_SEQ8, NULL);
	}

        else if (!strcmp(el, "sequence8")) {
		context->stack_head->data = sdp_data_alloc(SDP_SEQ8, NULL);
	}

	else if (!strcmp(el, "sequence16")) {
		context->stack_head->data = sdp_data_alloc(SDP_SEQ16, NULL);
	}
	
        else if (!strcmp(el, "sequence32")) {
		context->stack_head->data = sdp_data_alloc(SDP_SEQ32, NULL);
	}

	else if (!strcmp(el, "alternate")) {
		context->stack_head->data = sdp_data_alloc(SDP_ALT8, NULL);
	}

	else if (!strcmp(el, "alternate8")) {
		context->stack_head->data = sdp_data_alloc(SDP_ALT8, NULL);
	}

	else {
		const char *type;
		/* Parse value, datatype, encoding */
		for (i = 0; attr[i]; i += 2) {
			if (!strcmp(attr[i], "type")) {
				type = attr[i+1];
			}

			if (!strcmp(attr[i], "value")) {
				int curlen = strlen(context->stack_head->text);
				int attrlen = strlen(attr[i+1]);

				/* Ensure we're big enough */
				while ((curlen + 1 + attrlen) >
				       context->stack_head->size) {
					fprintf(stderr, "Growing text\n");
					sdp_xml_data_expand(context->stack_head);
				}

				memcpy(&context->stack_head->text[curlen],
				       attr[i+1], attrlen);
				context->stack_head->text[curlen + attrlen] = '\0';
				fprintf(stderr, "Text is now: -->%s<--\n",
					context->stack_head->text);
			}

			if (!strcmp(attr[i], "encoding")) {
				if (!strcmp(attr[i+1], "hex"))
					context->stack_head->type = 1;
			}
			
		}

		sdp_xml_parse_datatype(context, type);
	}
}

static int compute_seq_size(sdp_data_t *data)
{
	int unitSize = data->unitSize;
	sdp_data_t *seq = data->val.dataseq;

	fprintf(stderr, "seq unitSize is: %d\n",
		unitSize);

	for (; seq; seq = seq->next)
		unitSize += seq->unitSize;

	fprintf(stderr, "seq unitSize is now: %d\n",
		unitSize);

	return unitSize;
}

static void convert_xml_to_sdp_end(void *data, const char *el)
{
	sdp_xml_context *context = (sdp_xml_context *) data;
	sdp_xml_data_t *elem;

	if (!strcmp(el, "record"))
		return;

	if (!strcmp(el, "attribute")) {
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
	else if (!strcmp(el, "sequence")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);
	
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
			context->stack_head->data->unitSize += sizeof(uint8_t);
		}
	}

	else if (!strcmp(el, "sequence8")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);

		context->stack_head->data->unitSize += sizeof(uint8_t);
	}

	else if (!strcmp(el, "sequence16")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);

		context->stack_head->data->unitSize += sizeof(uint16_t);
	}

	else if (!strcmp(el, "sequence32")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);

		context->stack_head->data->unitSize += sizeof(uint32_t);
	}

	else if (!strcmp(el, "alternate")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);
		
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
			context->stack_head->data->unitSize += sizeof(uint8_t);
		}
	}

	else if (!strcmp(el, "alternate8")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);

		context->stack_head->data->unitSize += sizeof(uint8_t);

	}

	else if (!strcmp(el, "alternate16")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);

		context->stack_head->data->unitSize += sizeof(uint16_t);
	}

	else if (!strcmp(el, "alternate32")) {
		context->stack_head->data->unitSize =
			compute_seq_size(context->stack_head->data);

		context->stack_head->data->unitSize += sizeof(uint32_t);
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
    Should be called after sdp_xml_parse_chunk has been called with the
    final flag set

    Returns the resulting sdp_record_t.  The returned value will need to
    be freed by the caller by usig sdp_record_free.
*/
sdp_record_t *sdp_xml_get_record(sdp_xml_context * context)
{
	sdp_record_t *rec = context->sdprec;

	context->sdprec = 0;

	return rec;
}

/*
    Frees all data except the sdp_record if the sdp_xml_get_record was called.
    Otherwise everything is freed.
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
    parses an XML chunk.  Returns -1 if a parse error occured, and 0
    if successful pass final as 1 if the chunk is the final chunk
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

--Boundary-00=_4bbPF1YOXrAcBDK
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

--Boundary-00=_4bbPF1YOXrAcBDK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sdptool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdptool.patch"

Index: sdptool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/sdptool.c,v
retrieving revision 1.61
diff -u -5 -r1.61 sdptool.c
--- sdptool.c	15 Oct 2006 13:07:47 -0000	1.61
+++ sdptool.c	24 Oct 2006 06:43:13 -0000
@@ -43,10 +43,12 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
 #include <netinet/in.h>
 
+#include "sdp-xml.h"
+
 #ifndef APPLE_AGENT_SVCLASS_ID
 #define APPLE_AGENT_SVCLASS_ID 0x2112
 #endif
 
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, 0)) != -1)
@@ -65,10 +67,11 @@
 }
 
 #define DEFAULT_VIEW	0	/* Display only known attribute */
 #define TREE_VIEW	1	/* Display full attribute tree */
 #define RAW_VIEW	2	/* Display raw tree */
+#define XML_VIEW        3       /* Display xml tree */
 
 /* Pass args to the inquiry/search handler */
 struct search_context {
 	char		*svc;		/* Service */
 	uuid_t		group;		/* Browse group */
@@ -3168,10 +3234,78 @@
 	sdp_close(sess);
 
 	return ret;
 }
 
+#define BUFFSIZE 256
+
+static int add_xml_service(bdaddr_t *bdaddr, svc_info_t *si)
+{
+	sdp_session_t *sess;
+	int ret = -1;
+	FILE *fp;
+	char buf[BUFFSIZE];
+	sdp_xml_context *context = 0;
+	sdp_record_t *rec = 0;
+
+	if (!si->name)
+		return -1;
+
+	fp = fopen(si->name, "r");
+	if (!fp) {
+		fprintf(stderr, "Couldn't open %s\n", si->name);
+		return -1;
+	}
+
+	context = sdp_xml_init_context();
+	if (!context) {
+		fprintf(stderr, "Couldn't allocate context\n");
+		return -1;
+	}
+
+	for (;;) {
+		int done;
+		int len;
+
+		len = fread(buf, 1, BUFFSIZE, fp);
+
+		if (ferror(fp)) {
+			return -1;
+		}
+		done = feof(fp);
+
+		if (sdp_xml_parse_chunk(context, buf, len, done) != 0) {
+			return -1;
+		}
+
+		if (done)
+			break;
+	}
+
+	rec = sdp_xml_get_record(context);
+	sdp_xml_free_context(context);
+	
+	sess = sdp_connect(&interface, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);
+	if (!sess)
+		return -1;	
+
+	rec->handle = si->handle;
+	/* Remove the record handle attribute so SDP server assigns a new one */
+	sdp_attr_remove(rec, 0x0);
+	
+	if (sdp_record_register(sess, rec, SDP_RECORD_PERSIST) < 0)
+		fprintf(stderr, "Registration failed\n");
+
+done:
+	sdp_record_free(rec);
+		
+	free(si->name);
+	sdp_close(sess);
+
+	return ret;
+}
+
 static struct option add_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "handle",	1, 0, 'r' },
 	{ "psm",	1, 0, 'p' },
 	{ "channel",	1, 0, 'c' },
@@ -3234,10 +3368,55 @@
 	si.name = strdup(argv[0]);
 
 	return add_service(0, &si);
 }
 
+static struct option addxml_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "handle",	1, 0, 'r' },
+	{ 0, 0, 0, 0 }
+};
+
+static char *addxml_help = 
+	"Usage:\n"
+	"\tadd [--handle=RECORD_HANDLE] xmlfile\n";
+
+static int cmd_addxml(int argc, char **argv)
+{
+	svc_info_t si;
+	int opt;
+
+	memset(&si, 0, sizeof(si));
+	si.handle = 0xffffffff;
+
+	for_each_opt(opt, addxml_options, 0) {
+		switch (opt) {
+		case 'r':
+			if (strncasecmp(optarg, "0x", 2))
+				si.handle = atoi(optarg);
+			else
+				si.handle = strtol(optarg + 2, NULL, 16);
+			break;
+		default:
+			printf(addxml_help);
+			return -1;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 1) {
+		printf(add_help);
+		return -1;
+	}
+
+	si.name = strdup(argv[0]);
+
+	return add_xml_service(0, &si);
+}
+
 /* Delete local service */
 static int del_service(bdaddr_t *bdaddr, void *arg)
 {
 	uint32_t handle, range = 0x0000ffff;
 	sdp_list_t *attr;
@@ -3327,10 +3506,15 @@
 
 	for (i = 0; i < count; i++)
 		handler(&ii[i].bdaddr, arg);
 }
 
+static void doprintf(void *data, const char *str)
+{
+	printf(str);
+}
+
 /*
  * Search for a specific SDP service
  */
 static int do_search(bdaddr_t *bdaddr, struct search_context *context)
 {
@@ -3381,12 +3565,15 @@
 		case TREE_VIEW:
 			/* Display full tree */
 			print_tree_attr(rec);
 			printf("\n");
 			break;
+		case XML_VIEW:
+			/* Display raw XML tree */
+			convert_sdp_record_to_xml(rec, 0, doprintf);
+			break;
 		default:
-			/* Display raw tree */
 			print_raw_attr(rec);
 			break;
 		}
 
 		if (sdp_get_group_id(rec, &sub_context.group) != -1) {
@@ -3407,10 +3594,11 @@
 
 static struct option browse_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",        0, 0, 'x' },
 	{ "uuid",	1, 0, 'u' },
 	{ "l2cap",	0, 0, 'l' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -3438,10 +3626,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		case 'u':
 			if (sscanf(optarg, "%i", &num) != 1 || num < 0 || num > 0xffff) {
 				printf("Invalid uuid %s\n", optarg);
 				return -1;
 			}
@@ -3471,10 +3662,11 @@
 static struct option search_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "bdaddr",	1, 0, 'b' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",        0, 0, 'x' },
 	{ 0, 0, 0, 0}
 };
 
 static char *search_help = 
 	"Usage:\n"
@@ -3512,10 +3704,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		default:
 			printf(search_help);
 			return -1;
 		}
 	}
@@ -3608,10 +3803,14 @@
 	case TREE_VIEW:
 		/* Display full tree */
 		print_tree_attr(rec);
 		printf("\n");
 		break;
+	case XML_VIEW:
+		/* Display raw XML tree */
+		convert_sdp_record_to_xml(rec, 0, doprintf);
+		break;
 	default:
 		/* Display raw tree */
 		print_raw_attr(rec);
 		break;
 	}
@@ -3622,10 +3821,11 @@
 
 static struct option records_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",        0, 0, 'x' },
 	{ 0, 0, 0, 0 }
 };
 
 static char *records_help = 
 	"Usage:\n"
@@ -3650,10 +3850,14 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		default:
 			printf(records_help);
 			return -1;
 		}
 	}
@@ -3684,10 +3888,11 @@
 static struct option get_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "bdaddr",	1, 0, 'b' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",        0, 0, 'x' },
 	{ 0, 0, 0, 0 }
 };
 
 static char *get_help = 
 	"Usage:\n"
@@ -3716,10 +3921,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		default:
 			printf(get_help);
 			return -1;
 		}
 	}
@@ -3749,10 +3957,11 @@
 	{ "add",     cmd_add,         "Add local service"             },
 	{ "del",     cmd_del,         "Delete local service"          },
 	{ "get",     cmd_get,         "Get local service"             },
 	{ "setattr", cmd_setattr,     "Set/Add attribute to a SDP record"          },
 	{ "setseq",  cmd_setseq,      "Set/Add attribute sequence to a SDP record" },
+	{ "addxml",  cmd_addxml,      "Add local service (XML format)" },
 	{ 0, 0, 0 }
 };
 
 static void usage(void)
 {

--Boundary-00=_4bbPF1YOXrAcBDK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_4bbPF1YOXrAcBDK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_4bbPF1YOXrAcBDK--
