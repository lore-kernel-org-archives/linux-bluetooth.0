Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Move gattrib source files to src directory
Date: Thu,  4 Nov 2010 20:07:46 +0000
Message-Id: <1288901266-32547-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

gattrib related functions will be required during the device creation
for GATT enabled devices(BR/EDR and LE). Primary service discovery is
a pre-condition to probe the GATT device driver.
---
 Makefile.am      |    7 +-
 attrib/att.c     |  764 ------------------------------------------------------
 attrib/att.h     |  206 ---------------
 attrib/gatt.c    |  113 --------
 attrib/gatt.h    |   43 ---
 attrib/gattrib.c |  535 --------------------------------------
 attrib/gattrib.h |   72 -----
 src/att.c        |  764 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/att.h        |  206 +++++++++++++++
 src/gatt.c       |  113 ++++++++
 src/gatt.h       |   43 +++
 src/gattrib.c    |  535 ++++++++++++++++++++++++++++++++++++++
 src/gattrib.h    |   72 +++++
 13 files changed, 1736 insertions(+), 1737 deletions(-)
 delete mode 100644 attrib/att.c
 delete mode 100644 attrib/att.h
 delete mode 100644 attrib/gatt.c
 delete mode 100644 attrib/gatt.h
 delete mode 100644 attrib/gattrib.c
 delete mode 100644 attrib/gattrib.h
 create mode 100644 src/att.c
 create mode 100644 src/att.h
 create mode 100644 src/gatt.c
 create mode 100644 src/gatt.h
 create mode 100644 src/gattrib.c
 create mode 100644 src/gattrib.h

diff --git a/Makefile.am b/Makefile.am
index 873f2df..47e2740 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -87,8 +87,8 @@ sbc_sbctest_CFLAGS = @SNDFILE_CFLAGS@
 endif
 endif
 
-attrib_sources = attrib/att.h attrib/att.c attrib/gatt.h attrib/gatt.c \
-		attrib/gattrib.h attrib/gattrib.c
+attrib_sources = src/att.h src/att.c src/gatt.h src/gatt.c \
+		src/gattrib.h src/gattrib.c
 
 gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
 					gdbus/object.c gdbus/polkit.c
@@ -176,8 +176,7 @@ endif
 if ATTRIBPLUGIN
 bin_PROGRAMS += attrib/gatttool
 
-attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
-			  attrib/gattrib.c btio/btio.c
+attrib_gatttool_SOURCES = attrib/gatttool.c $(attrib_sources) btio/btio.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
 
 builtin_modules += attrib
diff --git a/attrib/att.c b/attrib/att.c
deleted file mode 100644
index fe41d0e..0000000
--- a/attrib/att.c
+++ /dev/null
@@ -1,764 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include <errno.h>
-#include <stdint.h>
-#include <stdlib.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include "att.h"
-
-const char *att_ecode2str(uint8_t status)
-{
-	switch (status)  {
-	case ATT_ECODE_INVALID_HANDLE:
-		return "Invalid handle";
-	case ATT_ECODE_READ_NOT_PERM:
-		return "Atribute can't be read";
-	case ATT_ECODE_WRITE_NOT_PERM:
-		return "Attribute can't be written";
-	case ATT_ECODE_INVALID_PDU:
-		return "Attribute PDU was invalid";
-	case ATT_ECODE_INSUFF_AUTHEN:
-		return "Attribute requires authentication before read/write";
-	case ATT_ECODE_REQ_NOT_SUPP:
-		return "Server doesn't support the request received";
-	case ATT_ECODE_INVALID_OFFSET:
-		return "Offset past the end of the attribute";
-	case ATT_ECODE_INSUFF_AUTHO:
-		return "Attribute requires authorization before read/write";
-	case ATT_ECODE_PREP_QUEUE_FULL:
-		return "Too many prepare writes have been queued";
-	case ATT_ECODE_ATTR_NOT_FOUND:
-		return "No attribute found within the given range";
-	case ATT_ECODE_ATTR_NOT_LONG:
-		return "Attribute can't be read/written using Read Blob Req";
-	case ATT_ECODE_INSUFF_ENCR_KEY_SIZE:
-		return "Encryption Key Size is insufficient";
-	case ATT_ECODE_INVAL_ATTR_VALUE_LEN:
-		return "Attribute value length is invalid";
-	case ATT_ECODE_UNLIKELY:
-		return "Request attribute has encountered an unlikely error";
-	case ATT_ECODE_INSUFF_ENC:
-		return "Encryption required before read/write";
-	case ATT_ECODE_UNSUPP_GRP_TYPE:
-		return "Attribute type is not a supported grouping attribute";
-	case ATT_ECODE_INSUFF_RESOURCES:
-		return "Insufficient Resources to complete the request";
-	case ATT_ECODE_IO:
-		return "Internal application error: I/O";
-	default:
-		return "Unexpected error code";
-	}
-}
-
-void att_data_list_free(struct att_data_list *list)
-{
-	int i;
-
-	for (i = 0; i < list->num; i++)
-		free(list->data[i]);
-
-	free(list->data);
-	free(list);
-}
-
-uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
-	uint16_t length;
-
-	if (!uuid)
-		return 0;
-
-	if (uuid->type == SDP_UUID16)
-		length = 2;
-	else if (uuid->type == SDP_UUID128)
-		length = 16;
-	else
-		return 0;
-
-	if (len < min_len + length)
-		return 0;
-
-	pdu[0] = ATT_OP_READ_BY_GROUP_REQ;
-	att_put_u16(start, &pdu[1]);
-	att_put_u16(end, &pdu[3]);
-
-	if (uuid->type == SDP_UUID16)
-		att_put_u16(uuid->value.uuid16, &pdu[5]);
-	else
-		memcpy(&pdu[5], &uuid->value.uuid128, length);
-
-	return min_len + length;
-}
-
-uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (start == NULL || end == NULL || uuid == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_BY_GROUP_REQ)
-		return 0;
-
-	if (len < min_len + 2)
-		return 0;
-
-	*start = att_get_u16(&pdu[1]);
-	*end = att_get_u16(&pdu[3]);
-	if (len == min_len + 2)
-		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
-	else
-		sdp_uuid128_create(uuid, &pdu[5]);
-
-	return len;
-}
-
-uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu,
-								int len)
-{
-	int i;
-	uint16_t w;
-	uint8_t *ptr;
-
-	if (list == NULL)
-		return 0;
-
-	if (len < list->len + 2)
-		return 0;
-
-	pdu[0] = ATT_OP_READ_BY_GROUP_RESP;
-	pdu[1] = list->len;
-
-	ptr = &pdu[2];
-
-	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
-		memcpy(ptr, list->data[i], list->len);
-		ptr += list->len;
-		w += list->len;
-	}
-
-	return w;
-}
-
-struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len)
-{
-	struct att_data_list *list;
-	const uint8_t *ptr;
-	int i;
-
-	if (pdu[0] != ATT_OP_READ_BY_GROUP_RESP)
-		return NULL;
-
-	list = malloc(sizeof(struct att_data_list));
-	list->len = pdu[1];
-	list->num = (len - 2) / list->len;
-
-	list->data = malloc(sizeof(uint8_t *) * list->num);
-	ptr = &pdu[2];
-
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(sizeof(uint8_t) * list->len);
-		memcpy(list->data[i], ptr, list->len);
-		ptr += list->len;
-	}
-
-	return list;
-}
-
-uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len)
-{
-	return 0;
-}
-
-uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
-	uint16_t length;
-
-	if (!uuid)
-		return 0;
-
-	if (uuid->type == SDP_UUID16)
-		length = 2;
-	else if (uuid->type == SDP_UUID128)
-		length = 16;
-	else
-		return 0;
-
-	if (len < min_len + length)
-		return 0;
-
-	pdu[0] = ATT_OP_READ_BY_TYPE_REQ;
-	att_put_u16(start, &pdu[1]);
-	att_put_u16(end, &pdu[3]);
-
-	if (uuid->type == SDP_UUID16)
-		att_put_u16(uuid->value.uuid16, &pdu[5]);
-	else
-		memcpy(&pdu[5], &uuid->value.uuid128, length);
-
-	return min_len + length;
-}
-
-uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (start == NULL || end == NULL || uuid == NULL)
-		return 0;
-
-	if (len < min_len + 2)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
-		return 0;
-
-	*start = att_get_u16(&pdu[1]);
-	*end = att_get_u16(&pdu[3]);
-
-	if (len == min_len + 2)
-		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
-	else
-		sdp_uuid128_create(uuid, &pdu[5]);
-
-	return len;
-}
-
-uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu, int len)
-{
-	uint8_t *ptr;
-	int i, w;
-
-	if (list == NULL)
-		return 0;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < list->len + 2)
-		return 0;
-
-	pdu[0] = ATT_OP_READ_BY_TYPE_RESP;
-	pdu[1] = list->len;
-	ptr = &pdu[2];
-
-	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
-		memcpy(ptr, list->data[i], list->len);
-		ptr += list->len;
-		w += list->len;
-	}
-
-	return w;
-}
-
-struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len)
-{
-	struct att_data_list *list;
-	const uint8_t *ptr;
-	int i;
-
-	if (pdu[0] != ATT_OP_READ_BY_TYPE_RESP)
-		return NULL;
-
-	list = malloc(sizeof(struct att_data_list));
-	list->len = pdu[1];
-	list->num = (len - 2) / list->len;
-
-	list->data = malloc(sizeof(uint8_t *) * list->num);
-	ptr = &pdu[2];
-
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(sizeof(uint8_t) * list->len);
-		memcpy(list->data[i], ptr, list->len);
-		ptr += list->len;
-	}
-
-	return list;
-}
-
-uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
-							uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_WRITE_CMD;
-	att_put_u16(handle, &pdu[1]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[3], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
-						uint8_t *value, int *vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (value == NULL || vlen == NULL || handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_WRITE_CMD)
-		return 0;
-
-	*handle = att_get_u16(&pdu[1]);
-	memcpy(value, pdu + min_len, len - min_len);
-	*vlen = len - min_len;
-
-	return len;
-}
-
-uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
-							uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_WRITE_REQ;
-	att_put_u16(handle, &pdu[1]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[3], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
-						uint8_t *value, int *vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (value == NULL || vlen == NULL || handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_WRITE_REQ)
-		return 0;
-
-	*handle = att_get_u16(&pdu[1]);
-	*vlen = len - min_len;
-	if (*vlen > 0)
-		memcpy(value, pdu + min_len, *vlen);
-
-	return len;
-}
-
-uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	pdu[0] = ATT_OP_READ_REQ;
-	att_put_u16(handle, &pdu[1]);
-
-	return min_len;
-}
-
-uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_REQ)
-		return 0;
-
-	*handle = att_get_u16(&pdu[1]);
-
-	return min_len;
-}
-
-uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* If the attribute value length is longer than the allowed PDU size,
-	 * send only the octets that fit on the PDU. The remaining octets can
-	 * be requested using the Read Blob Request. */
-	if (vlen > len - 1)
-		vlen = len - 1;
-
-	pdu[0] = ATT_OP_READ_RESP;
-
-	memcpy(pdu + 1, value, vlen);
-
-	return vlen + 1;
-}
-
-uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen)
-{
-	if (pdu == NULL)
-		return 0;
-
-	if (value == NULL || vlen == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_RESP)
-		return 0;
-
-	memcpy(value, pdu + 1, len - 1);
-
-	*vlen = len - 1;
-
-	return len;
-}
-
-uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
-							uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(opcode) +
-						sizeof(handle) + sizeof(status);
-	uint16_t u16;
-
-	if (len < min_len)
-		return 0;
-
-	u16 = htobs(handle);
-	pdu[0] = ATT_OP_ERROR;
-	pdu[1] = opcode;
-	memcpy(&pdu[2], &u16, sizeof(u16));
-	pdu[4] = status;
-
-	return min_len;
-}
-
-uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	pdu[0] = ATT_OP_FIND_INFO_REQ;
-	att_put_u16(start, &pdu[1]);
-	att_put_u16(end, &pdu[3]);
-
-	return min_len;
-}
-
-uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
-								uint16_t *end)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (start == NULL || end == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_FIND_INFO_REQ)
-		return 0;
-
-	*start = att_get_u16(&pdu[1]);
-	*end = att_get_u16(&pdu[3]);
-
-	return min_len;
-}
-
-uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
-							uint8_t *pdu, int len)
-{
-	uint8_t *ptr;
-	int i, w;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (list == NULL)
-		return 0;
-
-	if (len < list->len + 2)
-		return 0;
-
-	pdu[0] = ATT_OP_FIND_INFO_RESP;
-	pdu[1] = format;
-	ptr = (void *) &pdu[2];
-
-	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
-		memcpy(ptr, list->data[i], list->len);
-		ptr += list->len;
-		w += list->len;
-	}
-
-	return w;
-}
-
-struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
-							uint8_t *format)
-{
-	struct att_data_list *list;
-	uint8_t *ptr;
-	int i;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (format == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_FIND_INFO_RESP)
-		return 0;
-
-	*format = pdu[1];
-
-	list = malloc(sizeof(struct att_data_list));
-
-	list->len = sizeof(pdu[0]) + sizeof(*format);
-	if (*format == 0x01)
-		list->len += 2;
-	else if (*format == 0x02)
-		list->len += 16;
-
-	list->num = (len - 2) / list->len;
-	list->data = malloc(sizeof(uint8_t *) * list->num);
-
-	ptr = (void *) &pdu[2];
-
-	for (i = 0; i < list->num; i++) {
-		list->data[i] = malloc(list->len);
-		memcpy(list->data[i], ptr, list->len);
-		ptr += list->len;
-	}
-
-	return list;
-}
-
-uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < (a->len + min_len))
-		return 0;
-
-	pdu[0] = ATT_OP_HANDLE_NOTIFY;
-	att_put_u16(a->handle, &pdu[1]);
-	memcpy(&pdu[3], a->data, a->len);
-
-	return a->len + min_len;
-}
-
-uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < (a->len + min_len))
-		return 0;
-
-	pdu[0] = ATT_OP_HANDLE_IND;
-	att_put_u16(a->handle, &pdu[1]);
-	memcpy(&pdu[3], a->data, a->len);
-
-	return a->len + min_len;
-}
-
-struct attribute *dec_indication(const uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-
-	struct attribute *a;
-
-	if (pdu == NULL)
-		return NULL;
-
-	if (pdu[0] != ATT_OP_HANDLE_IND)
-		return NULL;
-
-	if (len < min_len)
-		return NULL;
-
-	a = malloc(sizeof(struct attribute) + len - min_len);
-	if (a == NULL)
-		return NULL;
-
-	a->len = len - min_len;
-
-	a->handle = att_get_u16(&pdu[1]);
-	memcpy(a->data, &pdu[3], a->len);
-
-	return a;
-}
-
-uint16_t enc_confirmation(uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	pdu[0] = ATT_OP_HANDLE_CNF;
-
-	return min_len;
-}
-
-uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	pdu[0] = ATT_OP_MTU_REQ;
-	att_put_u16(mtu, &pdu[1]);
-
-	return min_len;
-}
-
-uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (mtu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_MTU_REQ)
-		return 0;
-
-	*mtu = att_get_u16(&pdu[1]);
-
-	return min_len;
-}
-
-uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	pdu[0] = ATT_OP_MTU_RESP;
-	att_put_u16(mtu, &pdu[1]);
-
-	return min_len;
-}
-
-uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (mtu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_MTU_RESP)
-		return 0;
-
-	*mtu = att_get_u16(&pdu[1]);
-
-	return min_len;
-}
diff --git a/attrib/att.h b/attrib/att.h
deleted file mode 100644
index ea49dc2..0000000
--- a/attrib/att.h
+++ /dev/null
@@ -1,206 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-/* GATT Profile Attribute types */
-#define GATT_PRIM_SVC_UUID		0x2800
-#define GATT_SND_SVC_UUID		0x2801
-#define GATT_INCLUDE_UUID		0x2802
-#define GATT_CHARAC_UUID		0x2803
-
-/* GATT Characteristic Types */
-#define GATT_CHARAC_DEVICE_NAME			0x2A00
-#define GATT_CHARAC_APPEARANCE			0x2A01
-#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG	0x2A02
-#define GATT_CHARAC_RECONNECTION_ADDRESS	0x2A03
-#define GATT_CHARAC_PERIPHERAL_PREF_CONN	0x2A04
-#define GATT_CHARAC_SERVICE_CHANGED		0x2A05
-
-/* GATT Characteristic Descriptors */
-#define GATT_CHARAC_EXT_PROPER_UUID	0x2900
-#define GATT_CHARAC_USER_DESC_UUID	0x2901
-#define GATT_CLIENT_CHARAC_CFG_UUID	0x2902
-#define GATT_SERVER_CHARAC_CFG_UUID	0x2903
-#define GATT_CHARAC_FMT_UUID		0x2904
-#define GATT_CHARAC_AGREG_FMT_UUID	0x2905
-
-/* Attribute Protocol Opcodes */
-#define ATT_OP_ERROR			0x01
-#define ATT_OP_MTU_REQ			0x02
-#define ATT_OP_MTU_RESP			0x03
-#define ATT_OP_FIND_INFO_REQ		0x04
-#define ATT_OP_FIND_INFO_RESP		0x05
-#define ATT_OP_FIND_BY_TYPE_REQ		0x06
-#define ATT_OP_FIND_BY_TYPE_RESP	0x07
-#define ATT_OP_READ_BY_TYPE_REQ		0x08
-#define ATT_OP_READ_BY_TYPE_RESP	0x09
-#define ATT_OP_READ_REQ			0x0A
-#define ATT_OP_READ_RESP		0x0B
-#define ATT_OP_READ_BLOB_REQ		0x0C
-#define ATT_OP_READ_BLOB_RESP		0x0D
-#define ATT_OP_READ_MULTI_REQ		0x0E
-#define ATT_OP_READ_MULTI_RESP		0x0F
-#define ATT_OP_READ_BY_GROUP_REQ	0x10
-#define ATT_OP_READ_BY_GROUP_RESP	0x11
-#define ATT_OP_WRITE_REQ		0x12
-#define ATT_OP_WRITE_RESP		0x13
-#define ATT_OP_WRITE_CMD		0x52
-#define ATT_OP_PREP_WRITE_REQ		0x16
-#define ATT_OP_PREP_WRITE_RESP		0x17
-#define ATT_OP_EXEC_WRITE_REQ		0x18
-#define ATT_OP_EXEC_WRITE_RESP		0x19
-#define ATT_OP_HANDLE_NOTIFY		0x1B
-#define ATT_OP_HANDLE_IND		0x1D
-#define ATT_OP_HANDLE_CNF		0x1E
-#define ATT_OP_SIGNED_WRITE_CMD		0xD2
-
-/* Error codes for Error response PDU */
-#define ATT_ECODE_INVALID_HANDLE		0x01
-#define ATT_ECODE_READ_NOT_PERM			0x02
-#define ATT_ECODE_WRITE_NOT_PERM		0x03
-#define ATT_ECODE_INVALID_PDU			0x04
-#define ATT_ECODE_INSUFF_AUTHEN			0x05
-#define ATT_ECODE_REQ_NOT_SUPP			0x06
-#define ATT_ECODE_INVALID_OFFSET		0x07
-#define ATT_ECODE_INSUFF_AUTHO			0x08
-#define ATT_ECODE_PREP_QUEUE_FULL		0x09
-#define ATT_ECODE_ATTR_NOT_FOUND		0x0A
-#define ATT_ECODE_ATTR_NOT_LONG			0x0B
-#define ATT_ECODE_INSUFF_ENCR_KEY_SIZE		0x0C
-#define ATT_ECODE_INVAL_ATTR_VALUE_LEN		0x0D
-#define ATT_ECODE_UNLIKELY			0x0E
-#define ATT_ECODE_INSUFF_ENC			0x0F
-#define ATT_ECODE_UNSUPP_GRP_TYPE		0x10
-#define ATT_ECODE_INSUFF_RESOURCES		0x11
-/* Application error */
-#define ATT_ECODE_IO				0xFF
-
-/* Characteristic Property bit field */
-#define ATT_CHAR_PROPER_BROADCAST		0x01
-#define ATT_CHAR_PROPER_READ			0x02
-#define ATT_CHAR_PROPER_WRITE_WITHOUT_RESP	0x04
-#define ATT_CHAR_PROPER_WRITE			0x08
-#define ATT_CHAR_PROPER_NOTIFY			0x10
-#define ATT_CHAR_PROPER_INDICATE		0x20
-#define ATT_CHAR_PROPER_AUTH			0x40
-#define ATT_CHAR_PROPER_EXT_PROPER		0x80
-
-
-#define ATT_MAX_MTU				256
-#define ATT_DEFAULT_MTU				23
-
-struct attribute {
-	uint16_t handle;
-	uuid_t uuid;
-	int len;
-	uint8_t data[0];
-};
-
-struct att_data_list {
-	uint16_t num;
-	uint16_t len;
-	uint8_t **data;
-};
-
-/* These functions do byte conversion */
-static inline uint8_t att_get_u8(const void *ptr)
-{
-	const uint8_t *u8_ptr = ptr;
-	return bt_get_unaligned(u8_ptr);
-}
-
-static inline uint16_t att_get_u16(const void *ptr)
-{
-	const uint16_t *u16_ptr = ptr;
-	return btohs(bt_get_unaligned(u16_ptr));
-}
-
-static inline uint32_t att_get_u32(const void *ptr)
-{
-	const uint32_t *u32_ptr = ptr;
-	return btohl(bt_get_unaligned(u32_ptr));
-}
-
-static inline void att_put_u8(uint8_t src, void *dst)
-{
-	bt_put_unaligned(src, (uint8_t *) dst);
-}
-
-static inline void att_put_u16(uint16_t src, void *dst)
-{
-	bt_put_unaligned(htobs(src), (uint16_t *) dst);
-}
-
-static inline void att_put_u32(uint16_t src, void *dst)
-{
-	bt_put_unaligned(htobl(src), (uint32_t *) dst);
-}
-
-void att_data_list_free(struct att_data_list *list);
-
-const char *att_ecode2str(uint8_t status);
-uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len);
-uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid);
-uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu, int len);
-uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len);
-struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len);
-uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len);
-uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
-						uint16_t *end, uuid_t *uuid);
-uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu,
-								int len);
-uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
-							uint8_t *pdu, int len);
-uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
-						uint8_t *value, int *vlen);
-struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len);
-uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
-							uint8_t *pdu, int len);
-uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
-						uint8_t *value, int *vlen);
-uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
-uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
-uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
-uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
-uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
-							uint8_t *pdu, int len);
-uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, int len);
-uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
-								uint16_t *end);
-uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
-							uint8_t *pdu, int len);
-struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
-							uint8_t *format);
-uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len);
-uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len);
-struct attribute *dec_indication(const uint8_t *pdu, int len);
-uint16_t enc_confirmation(uint8_t *pdu, int len);
-
-uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len);
-uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu);
-uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len);
-uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu);
diff --git a/attrib/gatt.c b/attrib/gatt.c
deleted file mode 100644
index 24ec990..0000000
--- a/attrib/gatt.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include <stdint.h>
-#include <glib.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include "att.h"
-#include "gattrib.h"
-#include "gatt.h"
-
-guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
-		uint16_t end, GAttribResultFunc func, gpointer user_data)
-{
-	uint8_t pdu[ATT_DEFAULT_MTU];
-	uuid_t uuid;
-	guint16 plen;
-
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-
-	plen = enc_read_by_grp_req(start, end, &uuid, pdu, sizeof(pdu));
-	if (plen == 0)
-		return 0;
-
-	return g_attrib_send(attrib, ATT_OP_READ_BY_GROUP_REQ,
-					pdu, plen, func, user_data, NULL);
-}
-
-guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data)
-{
-	uint8_t pdu[ATT_DEFAULT_MTU];
-	uuid_t uuid;
-	guint16 plen;
-
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-
-	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
-	if (plen == 0)
-		return 0;
-
-	return g_attrib_send(attrib, ATT_OP_READ_BY_TYPE_REQ,
-					pdu, plen, func, user_data, NULL);
-}
-
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data)
-{
-	uint8_t pdu[ATT_DEFAULT_MTU];
-	guint16 plen;
-
-	plen = enc_read_req(handle, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen, func,
-							user_data, NULL);
-}
-
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-			int vlen, GAttribResultFunc func, gpointer user_data)
-{
-	uint8_t pdu[ATT_DEFAULT_MTU];
-	guint16 plen;
-
-	plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_WRITE_REQ, pdu, plen, func,
-							user_data, NULL);
-}
-
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data)
-{
-	uint8_t pdu[ATT_DEFAULT_MTU];
-	guint16 plen;
-
-	plen = enc_find_info_req(start, end, pdu, sizeof(pdu));
-	if (plen == 0)
-		return 0;
-
-	return g_attrib_send(attrib, ATT_OP_FIND_INFO_REQ, pdu, plen, func,
-							user_data, NULL);
-}
-
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data)
-{
-	uint8_t pdu[ATT_DEFAULT_MTU];
-	guint16 plen;
-
-	plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_WRITE_CMD, pdu, plen, NULL,
-							user_data, notify);
-}
diff --git a/attrib/gatt.h b/attrib/gatt.h
deleted file mode 100644
index f1599c2..0000000
--- a/attrib/gatt.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#define GATT_CID 4
-
-guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
-		uint16_t end, GAttribResultFunc func, gpointer user_data);
-
-guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data);
-
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data);
-
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-			int vlen, GAttribResultFunc func, gpointer user_data);
-
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data);
-
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
deleted file mode 100644
index ed18168..0000000
--- a/attrib/gattrib.c
+++ /dev/null
@@ -1,535 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include <stdint.h>
-#include <string.h>
-#include <glib.h>
-
-#include <stdio.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-
-#include "att.h"
-#include "gattrib.h"
-
-struct _GAttrib {
-	GIOChannel *io;
-	gint refs;
-	gint mtu;
-	guint read_watch;
-	guint write_watch;
-	GQueue *queue;
-	GSList *events;
-	guint next_cmd_id;
-	guint next_evt_id;
-	GDestroyNotify destroy;
-	GAttribDisconnectFunc disconnect;
-	gpointer destroy_user_data;
-	gpointer disc_user_data;
-};
-
-struct command {
-	guint id;
-	guint8 opcode;
-	guint8 *pdu;
-	guint16 len;
-	guint8 expected;
-	gboolean sent;
-	GAttribResultFunc func;
-	gpointer user_data;
-	GDestroyNotify notify;
-};
-
-struct event {
-	guint id;
-	guint8 expected;
-	GAttribNotifyFunc func;
-	gpointer user_data;
-	GDestroyNotify notify;
-};
-
-static guint8 opcode2expected(guint8 opcode)
-{
-	switch (opcode) {
-	case ATT_OP_MTU_REQ:
-		return ATT_OP_MTU_RESP;
-
-	case ATT_OP_FIND_INFO_REQ:
-		return ATT_OP_FIND_INFO_RESP;
-
-	case ATT_OP_FIND_BY_TYPE_REQ:
-		return ATT_OP_FIND_BY_TYPE_RESP;
-
-	case ATT_OP_READ_BY_TYPE_REQ:
-		return ATT_OP_READ_BY_TYPE_RESP;
-
-	case ATT_OP_READ_REQ:
-		return ATT_OP_READ_RESP;
-
-	case ATT_OP_READ_BLOB_REQ:
-		return ATT_OP_READ_BLOB_RESP;
-
-	case ATT_OP_READ_MULTI_REQ:
-		return ATT_OP_READ_MULTI_RESP;
-
-	case ATT_OP_READ_BY_GROUP_REQ:
-		return ATT_OP_READ_BY_GROUP_RESP;
-
-	case ATT_OP_WRITE_REQ:
-		return ATT_OP_WRITE_RESP;
-
-	case ATT_OP_PREP_WRITE_REQ:
-		return ATT_OP_PREP_WRITE_RESP;
-
-	case ATT_OP_EXEC_WRITE_REQ:
-		return ATT_OP_EXEC_WRITE_RESP;
-
-	case ATT_OP_HANDLE_IND:
-		return ATT_OP_HANDLE_CNF;
-	}
-
-	return 0;
-}
-
-static gboolean is_response(guint8 opcode)
-{
-	switch (opcode) {
-	case ATT_OP_ERROR:
-	case ATT_OP_MTU_RESP:
-	case ATT_OP_FIND_INFO_RESP:
-	case ATT_OP_FIND_BY_TYPE_RESP:
-	case ATT_OP_READ_BY_TYPE_RESP:
-	case ATT_OP_READ_RESP:
-	case ATT_OP_READ_BLOB_RESP:
-	case ATT_OP_READ_MULTI_RESP:
-	case ATT_OP_READ_BY_GROUP_RESP:
-	case ATT_OP_WRITE_RESP:
-	case ATT_OP_PREP_WRITE_RESP:
-	case ATT_OP_EXEC_WRITE_RESP:
-	case ATT_OP_HANDLE_CNF:
-		return TRUE;
-	}
-
-	return FALSE;
-}
-
-GAttrib *g_attrib_ref(GAttrib *attrib)
-{
-	if (!attrib)
-		return NULL;
-
-	g_atomic_int_inc(&attrib->refs);
-
-	return attrib;
-}
-
-static void command_destroy(struct command *cmd)
-{
-	if (cmd->notify)
-		cmd->notify(cmd->user_data);
-
-	g_free(cmd->pdu);
-	g_free(cmd);
-}
-
-static void event_destroy(struct event *evt)
-{
-	if (evt->notify)
-		evt->notify(evt->user_data);
-
-	g_free(evt);
-}
-
-void g_attrib_unref(GAttrib *attrib)
-{
-	GSList *l;
-	struct command *c;
-
-	if (!attrib)
-		return;
-
-	if (g_atomic_int_dec_and_test(&attrib->refs) == FALSE)
-		return;
-
-	while ((c = g_queue_pop_head(attrib->queue)))
-		command_destroy(c);
-
-	attrib->queue = NULL;
-
-	for (l = attrib->events; l; l = l->next)
-		event_destroy(l->data);
-
-	g_slist_free(attrib->events);
-	attrib->events = NULL;
-
-	if (attrib->write_watch > 0)
-		g_source_remove(attrib->write_watch);
-
-	if (attrib->read_watch > 0) {
-		g_source_remove(attrib->read_watch);
-		g_io_channel_unref(attrib->io);
-	}
-
-
-	if (attrib->destroy)
-		attrib->destroy(attrib->destroy_user_data);
-
-	g_free(attrib);
-}
-
-gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
-		GAttribDisconnectFunc disconnect, gpointer user_data)
-{
-	if (attrib == NULL)
-		return FALSE;
-
-	attrib->disconnect = disconnect;
-	attrib->disc_user_data = user_data;
-
-	return TRUE;
-}
-
-gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-		GDestroyNotify destroy, gpointer user_data)
-{
-	if (attrib == NULL)
-		return FALSE;
-
-	attrib->destroy = destroy;
-	attrib->destroy_user_data = user_data;
-
-	return TRUE;
-}
-
-static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
-								gpointer data)
-{
-	struct _GAttrib *attrib = data;
-	struct command *cmd;
-	GError *gerr = NULL;
-	gsize len;
-	GIOStatus iostat;
-
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		if (attrib->disconnect)
-			attrib->disconnect(attrib->disc_user_data);
-
-		return FALSE;
-	}
-
-	cmd = g_queue_peek_head(attrib->queue);
-	if (cmd == NULL)
-		return FALSE;
-
-	iostat = g_io_channel_write_chars(io, (gchar *) cmd->pdu, cmd->len,
-								&len, &gerr);
-	if (iostat != G_IO_STATUS_NORMAL)
-		return FALSE;
-
-	g_io_channel_flush(io, NULL);
-
-	if (cmd->expected == 0) {
-		g_queue_pop_head(attrib->queue);
-		command_destroy(cmd);
-
-		return TRUE;
-	}
-
-	cmd->sent = TRUE;
-
-	return FALSE;
-}
-
-static void destroy_sender(gpointer data)
-{
-	struct _GAttrib *attrib = data;
-
-	attrib->write_watch = 0;
-}
-
-static void wake_up_sender(struct _GAttrib *attrib)
-{
-	if (attrib->write_watch == 0)
-		attrib->write_watch = g_io_add_watch_full(attrib->io,
-			G_PRIORITY_DEFAULT, G_IO_OUT, can_write_data,
-			attrib, destroy_sender);
-}
-
-static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
-{
-	struct _GAttrib *attrib = data;
-	struct command *cmd = NULL;
-	GSList *l;
-	uint8_t buf[512], status;
-	gsize len;
-	GIOStatus iostat;
-
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		attrib->read_watch = 0;
-		if (attrib->disconnect)
-			attrib->disconnect(attrib->disc_user_data);
-		return FALSE;
-	}
-
-	memset(buf, 0, sizeof(buf));
-
-	iostat = g_io_channel_read_chars(io, (gchar *) buf, sizeof(buf),
-								&len, NULL);
-	if (iostat != G_IO_STATUS_NORMAL) {
-		status = ATT_ECODE_IO;
-		goto done;
-	}
-
-	for (l = attrib->events; l; l = l->next) {
-		struct event *evt = l->data;
-
-		if (evt->expected == buf[0] ||
-					evt->expected == GATTRIB_ALL_EVENTS)
-			evt->func(buf, len, evt->user_data);
-	}
-
-	if (is_response(buf[0]) == FALSE)
-		return TRUE;
-
-	cmd = g_queue_pop_head(attrib->queue);
-	if (cmd == NULL) {
-		/* Keep the watch if we have events to report */
-		return attrib->events != NULL;
-	}
-
-	if (buf[0] == ATT_OP_ERROR) {
-		status = buf[4];
-		goto done;
-	}
-
-	if (cmd->expected != buf[0]) {
-		status = ATT_ECODE_IO;
-		goto done;
-	}
-
-	status = 0;
-
-done:
-	if (attrib->queue && g_queue_is_empty(attrib->queue) == FALSE)
-		wake_up_sender(attrib);
-
-	if (cmd) {
-		if (cmd->func)
-			cmd->func(status, buf, len, cmd->user_data);
-
-		command_destroy(cmd);
-	}
-
-	return TRUE;
-}
-
-GAttrib *g_attrib_new(GIOChannel *io)
-{
-	struct _GAttrib *attrib;
-
-	g_io_channel_set_encoding(io, NULL, NULL);
-
-	attrib = g_try_new0(struct _GAttrib, 1);
-	if (attrib == NULL)
-		return NULL;
-
-	attrib->io = g_io_channel_ref(io);
-	attrib->mtu = 512;
-	attrib->queue = g_queue_new();
-
-	attrib->read_watch = g_io_add_watch(attrib->io,
-			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-			received_data, attrib);
-
-	return g_attrib_ref(attrib);
-}
-
-guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
-				guint16 len, GAttribResultFunc func,
-				gpointer user_data, GDestroyNotify notify)
-{
-	struct command *c;
-
-	c = g_try_new0(struct command, 1);
-	if (c == NULL)
-		return 0;
-
-	c->opcode = opcode;
-	c->expected = opcode2expected(opcode);
-	c->pdu = g_malloc(len);
-	memcpy(c->pdu, pdu, len);
-	c->len = len;
-	c->func = func;
-	c->user_data = user_data;
-	c->notify = notify;
-	c->id = ++attrib->next_cmd_id;
-
-	g_queue_push_tail(attrib->queue, c);
-
-	if (g_queue_get_length(attrib->queue) == 1)
-		wake_up_sender(attrib);
-
-	return c->id;
-}
-
-static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
-{
-	const struct command *cmd = a;
-	guint id = GPOINTER_TO_UINT(b);
-
-	return cmd->id - id;
-}
-
-gboolean g_attrib_cancel(GAttrib *attrib, guint id)
-{
-	GList *l;
-	struct command *cmd;
-
-	if (attrib == NULL || attrib->queue == NULL)
-		return FALSE;
-
-	l = g_queue_find_custom(attrib->queue, GUINT_TO_POINTER(id),
-							command_cmp_by_id);
-	if (l == NULL)
-		return FALSE;
-
-	cmd = l->data;
-
-	if (cmd == g_queue_peek_head(attrib->queue) && cmd->sent)
-		cmd->func = NULL;
-	else {
-		g_queue_remove(attrib->queue, cmd);
-		command_destroy(cmd);
-	}
-
-	return TRUE;
-}
-
-gboolean g_attrib_cancel_all(GAttrib *attrib)
-{
-	struct command *c, *head = NULL;
-	gboolean first = TRUE;
-
-	if (attrib == NULL || attrib->queue == NULL)
-		return FALSE;
-
-	while ((c = g_queue_pop_head(attrib->queue))) {
-		if (first && c->sent) {
-			/* If the command was sent ignore its callback ... */
-			c->func = NULL;
-			head = c;
-			continue;
-		}
-
-		first = FALSE;
-		command_destroy(c);
-	}
-
-	if (head) {
-		/* ... and put it back in the queue */
-		g_queue_push_head(attrib->queue, head);
-	}
-
-	return TRUE;
-}
-
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data)
-{
-	return TRUE;
-}
-
-guint g_attrib_register(GAttrib *attrib, guint8 opcode,
-				GAttribNotifyFunc func, gpointer user_data,
-				GDestroyNotify notify)
-{
-	struct event *event;
-
-	event = g_try_new0(struct event, 1);
-	if (event == NULL)
-		return 0;
-
-	event->expected = opcode;
-	event->func = func;
-	event->user_data = user_data;
-	event->notify = notify;
-	event->id = ++attrib->next_evt_id;
-
-	attrib->events = g_slist_append(attrib->events, event);
-
-	return event->id;
-}
-
-static gint event_cmp_by_id(gconstpointer a, gconstpointer b)
-{
-	const struct event *evt = a;
-	guint id = GPOINTER_TO_UINT(b);
-
-	return evt->id - id;
-}
-
-gboolean g_attrib_unregister(GAttrib *attrib, guint id)
-{
-	struct event *evt;
-	GSList *l;
-
-	l = g_slist_find_custom(attrib->events, GUINT_TO_POINTER(id),
-							event_cmp_by_id);
-	if (l == NULL)
-		return FALSE;
-
-	evt = l->data;
-
-	attrib->events = g_slist_remove(attrib->events, evt);
-
-	if (evt->notify)
-		evt->notify(evt->user_data);
-
-	g_free(evt);
-
-	return TRUE;
-}
-
-gboolean g_attrib_unregister_all(GAttrib *attrib)
-{
-	GSList *l;
-
-	if (attrib->events == NULL)
-		return FALSE;
-
-	for (l = attrib->events; l; l = l->next) {
-		struct event *evt = l->data;
-
-		if (evt->notify)
-			evt->notify(evt->user_data);
-
-		g_free(evt);
-	}
-
-	g_slist_free(attrib->events);
-	attrib->events = NULL;
-
-	return TRUE;
-}
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
deleted file mode 100644
index 4306ca4..0000000
--- a/attrib/gattrib.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-#ifndef __GATTRIB_H
-#define __GATTRIB_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#define GATTRIB_ALL_EVENTS 0xFF
-
-struct _GAttrib;
-typedef struct _GAttrib GAttrib;
-
-typedef void (*GAttribResultFunc) (guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data);
-typedef void (*GAttribDisconnectFunc)(gpointer user_data);
-typedef void (*GAttribDebugFunc)(const char *str, gpointer user_data);
-typedef void (*GAttribNotifyFunc)(const guint8 *pdu, guint16 len,
-							gpointer user_data);
-
-GAttrib *g_attrib_new(GIOChannel *io);
-GAttrib *g_attrib_ref(GAttrib *attrib);
-void g_attrib_unref(GAttrib *attrib);
-
-gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
-		GAttribDisconnectFunc disconnect, gpointer user_data);
-
-gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-		GDestroyNotify destroy, gpointer user_data);
-
-guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
-				guint16 len, GAttribResultFunc func,
-				gpointer user_data, GDestroyNotify notify);
-gboolean g_attrib_cancel(GAttrib *attrib, guint id);
-gboolean g_attrib_cancel_all(GAttrib *attrib);
-
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data);
-
-guint g_attrib_register(GAttrib *attrib, guint8 opcode,
-		GAttribNotifyFunc func, gpointer user_data,
-					GDestroyNotify notify);
-
-gboolean g_attrib_unregister(GAttrib *attrib, guint id);
-gboolean g_attrib_unregister_all(GAttrib *attrib);
-
-#ifdef __cplusplus
-}
-#endif
-#endif
diff --git a/src/att.c b/src/att.c
new file mode 100644
index 0000000..fe41d0e
--- /dev/null
+++ b/src/att.c
@@ -0,0 +1,764 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "att.h"
+
+const char *att_ecode2str(uint8_t status)
+{
+	switch (status)  {
+	case ATT_ECODE_INVALID_HANDLE:
+		return "Invalid handle";
+	case ATT_ECODE_READ_NOT_PERM:
+		return "Atribute can't be read";
+	case ATT_ECODE_WRITE_NOT_PERM:
+		return "Attribute can't be written";
+	case ATT_ECODE_INVALID_PDU:
+		return "Attribute PDU was invalid";
+	case ATT_ECODE_INSUFF_AUTHEN:
+		return "Attribute requires authentication before read/write";
+	case ATT_ECODE_REQ_NOT_SUPP:
+		return "Server doesn't support the request received";
+	case ATT_ECODE_INVALID_OFFSET:
+		return "Offset past the end of the attribute";
+	case ATT_ECODE_INSUFF_AUTHO:
+		return "Attribute requires authorization before read/write";
+	case ATT_ECODE_PREP_QUEUE_FULL:
+		return "Too many prepare writes have been queued";
+	case ATT_ECODE_ATTR_NOT_FOUND:
+		return "No attribute found within the given range";
+	case ATT_ECODE_ATTR_NOT_LONG:
+		return "Attribute can't be read/written using Read Blob Req";
+	case ATT_ECODE_INSUFF_ENCR_KEY_SIZE:
+		return "Encryption Key Size is insufficient";
+	case ATT_ECODE_INVAL_ATTR_VALUE_LEN:
+		return "Attribute value length is invalid";
+	case ATT_ECODE_UNLIKELY:
+		return "Request attribute has encountered an unlikely error";
+	case ATT_ECODE_INSUFF_ENC:
+		return "Encryption required before read/write";
+	case ATT_ECODE_UNSUPP_GRP_TYPE:
+		return "Attribute type is not a supported grouping attribute";
+	case ATT_ECODE_INSUFF_RESOURCES:
+		return "Insufficient Resources to complete the request";
+	case ATT_ECODE_IO:
+		return "Internal application error: I/O";
+	default:
+		return "Unexpected error code";
+	}
+}
+
+void att_data_list_free(struct att_data_list *list)
+{
+	int i;
+
+	for (i = 0; i < list->num; i++)
+		free(list->data[i]);
+
+	free(list->data);
+	free(list);
+}
+
+uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
+							uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
+	uint16_t length;
+
+	if (!uuid)
+		return 0;
+
+	if (uuid->type == SDP_UUID16)
+		length = 2;
+	else if (uuid->type == SDP_UUID128)
+		length = 16;
+	else
+		return 0;
+
+	if (len < min_len + length)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_BY_GROUP_REQ;
+	att_put_u16(start, &pdu[1]);
+	att_put_u16(end, &pdu[3]);
+
+	if (uuid->type == SDP_UUID16)
+		att_put_u16(uuid->value.uuid16, &pdu[5]);
+	else
+		memcpy(&pdu[5], &uuid->value.uuid128, length);
+
+	return min_len + length;
+}
+
+uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
+						uint16_t *end, uuid_t *uuid)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (start == NULL || end == NULL || uuid == NULL)
+		return 0;
+
+	if (pdu[0] != ATT_OP_READ_BY_GROUP_REQ)
+		return 0;
+
+	if (len < min_len + 2)
+		return 0;
+
+	*start = att_get_u16(&pdu[1]);
+	*end = att_get_u16(&pdu[3]);
+	if (len == min_len + 2)
+		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
+	else
+		sdp_uuid128_create(uuid, &pdu[5]);
+
+	return len;
+}
+
+uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu,
+								int len)
+{
+	int i;
+	uint16_t w;
+	uint8_t *ptr;
+
+	if (list == NULL)
+		return 0;
+
+	if (len < list->len + 2)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_BY_GROUP_RESP;
+	pdu[1] = list->len;
+
+	ptr = &pdu[2];
+
+	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
+		memcpy(ptr, list->data[i], list->len);
+		ptr += list->len;
+		w += list->len;
+	}
+
+	return w;
+}
+
+struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len)
+{
+	struct att_data_list *list;
+	const uint8_t *ptr;
+	int i;
+
+	if (pdu[0] != ATT_OP_READ_BY_GROUP_RESP)
+		return NULL;
+
+	list = malloc(sizeof(struct att_data_list));
+	list->len = pdu[1];
+	list->num = (len - 2) / list->len;
+
+	list->data = malloc(sizeof(uint8_t *) * list->num);
+	ptr = &pdu[2];
+
+	for (i = 0; i < list->num; i++) {
+		list->data[i] = malloc(sizeof(uint8_t) * list->len);
+		memcpy(list->data[i], ptr, list->len);
+		ptr += list->len;
+	}
+
+	return list;
+}
+
+uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+							uint8_t *pdu, int len)
+{
+	return 0;
+}
+
+uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+							uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
+	uint16_t length;
+
+	if (!uuid)
+		return 0;
+
+	if (uuid->type == SDP_UUID16)
+		length = 2;
+	else if (uuid->type == SDP_UUID128)
+		length = 16;
+	else
+		return 0;
+
+	if (len < min_len + length)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_BY_TYPE_REQ;
+	att_put_u16(start, &pdu[1]);
+	att_put_u16(end, &pdu[3]);
+
+	if (uuid->type == SDP_UUID16)
+		att_put_u16(uuid->value.uuid16, &pdu[5]);
+	else
+		memcpy(&pdu[5], &uuid->value.uuid128, length);
+
+	return min_len + length;
+}
+
+uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
+						uint16_t *end, uuid_t *uuid)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (start == NULL || end == NULL || uuid == NULL)
+		return 0;
+
+	if (len < min_len + 2)
+		return 0;
+
+	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
+		return 0;
+
+	*start = att_get_u16(&pdu[1]);
+	*end = att_get_u16(&pdu[3]);
+
+	if (len == min_len + 2)
+		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
+	else
+		sdp_uuid128_create(uuid, &pdu[5]);
+
+	return len;
+}
+
+uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu, int len)
+{
+	uint8_t *ptr;
+	int i, w;
+
+	if (list == NULL)
+		return 0;
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < list->len + 2)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_BY_TYPE_RESP;
+	pdu[1] = list->len;
+	ptr = &pdu[2];
+
+	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
+		memcpy(ptr, list->data[i], list->len);
+		ptr += list->len;
+		w += list->len;
+	}
+
+	return w;
+}
+
+struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len)
+{
+	struct att_data_list *list;
+	const uint8_t *ptr;
+	int i;
+
+	if (pdu[0] != ATT_OP_READ_BY_TYPE_RESP)
+		return NULL;
+
+	list = malloc(sizeof(struct att_data_list));
+	list->len = pdu[1];
+	list->num = (len - 2) / list->len;
+
+	list->data = malloc(sizeof(uint8_t *) * list->num);
+	ptr = &pdu[2];
+
+	for (i = 0; i < list->num; i++) {
+		list->data[i] = malloc(sizeof(uint8_t) * list->len);
+		memcpy(list->data[i], ptr, list->len);
+		ptr += list->len;
+	}
+
+	return list;
+}
+
+uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
+							uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (vlen > len - min_len)
+		vlen = len - min_len;
+
+	pdu[0] = ATT_OP_WRITE_CMD;
+	att_put_u16(handle, &pdu[1]);
+
+	if (vlen > 0) {
+		memcpy(&pdu[3], value, vlen);
+		return min_len + vlen;
+	}
+
+	return min_len;
+}
+
+uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int *vlen)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (value == NULL || vlen == NULL || handle == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_WRITE_CMD)
+		return 0;
+
+	*handle = att_get_u16(&pdu[1]);
+	memcpy(value, pdu + min_len, len - min_len);
+	*vlen = len - min_len;
+
+	return len;
+}
+
+uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
+							uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (vlen > len - min_len)
+		vlen = len - min_len;
+
+	pdu[0] = ATT_OP_WRITE_REQ;
+	att_put_u16(handle, &pdu[1]);
+
+	if (vlen > 0) {
+		memcpy(&pdu[3], value, vlen);
+		return min_len + vlen;
+	}
+
+	return min_len;
+}
+
+uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int *vlen)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (value == NULL || vlen == NULL || handle == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_WRITE_REQ)
+		return 0;
+
+	*handle = att_get_u16(&pdu[1]);
+	*vlen = len - min_len;
+	if (*vlen > 0)
+		memcpy(value, pdu + min_len, *vlen);
+
+	return len;
+}
+
+uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_REQ;
+	att_put_u16(handle, &pdu[1]);
+
+	return min_len;
+}
+
+uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (handle == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_READ_REQ)
+		return 0;
+
+	*handle = att_get_u16(&pdu[1]);
+
+	return min_len;
+}
+
+uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len)
+{
+	if (pdu == NULL)
+		return 0;
+
+	/* If the attribute value length is longer than the allowed PDU size,
+	 * send only the octets that fit on the PDU. The remaining octets can
+	 * be requested using the Read Blob Request. */
+	if (vlen > len - 1)
+		vlen = len - 1;
+
+	pdu[0] = ATT_OP_READ_RESP;
+
+	memcpy(pdu + 1, value, vlen);
+
+	return vlen + 1;
+}
+
+uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen)
+{
+	if (pdu == NULL)
+		return 0;
+
+	if (value == NULL || vlen == NULL)
+		return 0;
+
+	if (pdu[0] != ATT_OP_READ_RESP)
+		return 0;
+
+	memcpy(value, pdu + 1, len - 1);
+
+	*vlen = len - 1;
+
+	return len;
+}
+
+uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
+							uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(opcode) +
+						sizeof(handle) + sizeof(status);
+	uint16_t u16;
+
+	if (len < min_len)
+		return 0;
+
+	u16 = htobs(handle);
+	pdu[0] = ATT_OP_ERROR;
+	pdu[1] = opcode;
+	memcpy(&pdu[2], &u16, sizeof(u16));
+	pdu[4] = status;
+
+	return min_len;
+}
+
+uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_FIND_INFO_REQ;
+	att_put_u16(start, &pdu[1]);
+	att_put_u16(end, &pdu[3]);
+
+	return min_len;
+}
+
+uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
+								uint16_t *end)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (start == NULL || end == NULL)
+		return 0;
+
+	if (pdu[0] != ATT_OP_FIND_INFO_REQ)
+		return 0;
+
+	*start = att_get_u16(&pdu[1]);
+	*end = att_get_u16(&pdu[3]);
+
+	return min_len;
+}
+
+uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
+							uint8_t *pdu, int len)
+{
+	uint8_t *ptr;
+	int i, w;
+
+	if (pdu == NULL)
+		return 0;
+
+	if (list == NULL)
+		return 0;
+
+	if (len < list->len + 2)
+		return 0;
+
+	pdu[0] = ATT_OP_FIND_INFO_RESP;
+	pdu[1] = format;
+	ptr = (void *) &pdu[2];
+
+	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
+		memcpy(ptr, list->data[i], list->len);
+		ptr += list->len;
+		w += list->len;
+	}
+
+	return w;
+}
+
+struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
+							uint8_t *format)
+{
+	struct att_data_list *list;
+	uint8_t *ptr;
+	int i;
+
+	if (pdu == NULL)
+		return 0;
+
+	if (format == NULL)
+		return 0;
+
+	if (pdu[0] != ATT_OP_FIND_INFO_RESP)
+		return 0;
+
+	*format = pdu[1];
+
+	list = malloc(sizeof(struct att_data_list));
+
+	list->len = sizeof(pdu[0]) + sizeof(*format);
+	if (*format == 0x01)
+		list->len += 2;
+	else if (*format == 0x02)
+		list->len += 16;
+
+	list->num = (len - 2) / list->len;
+	list->data = malloc(sizeof(uint8_t *) * list->num);
+
+	ptr = (void *) &pdu[2];
+
+	for (i = 0; i < list->num; i++) {
+		list->data[i] = malloc(list->len);
+		memcpy(list->data[i], ptr, list->len);
+		ptr += list->len;
+	}
+
+	return list;
+}
+
+uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < (a->len + min_len))
+		return 0;
+
+	pdu[0] = ATT_OP_HANDLE_NOTIFY;
+	att_put_u16(a->handle, &pdu[1]);
+	memcpy(&pdu[3], a->data, a->len);
+
+	return a->len + min_len;
+}
+
+uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < (a->len + min_len))
+		return 0;
+
+	pdu[0] = ATT_OP_HANDLE_IND;
+	att_put_u16(a->handle, &pdu[1]);
+	memcpy(&pdu[3], a->data, a->len);
+
+	return a->len + min_len;
+}
+
+struct attribute *dec_indication(const uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
+
+	struct attribute *a;
+
+	if (pdu == NULL)
+		return NULL;
+
+	if (pdu[0] != ATT_OP_HANDLE_IND)
+		return NULL;
+
+	if (len < min_len)
+		return NULL;
+
+	a = malloc(sizeof(struct attribute) + len - min_len);
+	if (a == NULL)
+		return NULL;
+
+	a->len = len - min_len;
+
+	a->handle = att_get_u16(&pdu[1]);
+	memcpy(a->data, &pdu[3], a->len);
+
+	return a;
+}
+
+uint16_t enc_confirmation(uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_HANDLE_CNF;
+
+	return min_len;
+}
+
+uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_MTU_REQ;
+	att_put_u16(mtu, &pdu[1]);
+
+	return min_len;
+}
+
+uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (mtu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_MTU_REQ)
+		return 0;
+
+	*mtu = att_get_u16(&pdu[1]);
+
+	return min_len;
+}
+
+uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(mtu);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_MTU_RESP;
+	att_put_u16(mtu, &pdu[1]);
+
+	return min_len;
+}
+
+uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (mtu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_MTU_RESP)
+		return 0;
+
+	*mtu = att_get_u16(&pdu[1]);
+
+	return min_len;
+}
diff --git a/src/att.h b/src/att.h
new file mode 100644
index 0000000..ea49dc2
--- /dev/null
+++ b/src/att.h
@@ -0,0 +1,206 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/* GATT Profile Attribute types */
+#define GATT_PRIM_SVC_UUID		0x2800
+#define GATT_SND_SVC_UUID		0x2801
+#define GATT_INCLUDE_UUID		0x2802
+#define GATT_CHARAC_UUID		0x2803
+
+/* GATT Characteristic Types */
+#define GATT_CHARAC_DEVICE_NAME			0x2A00
+#define GATT_CHARAC_APPEARANCE			0x2A01
+#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG	0x2A02
+#define GATT_CHARAC_RECONNECTION_ADDRESS	0x2A03
+#define GATT_CHARAC_PERIPHERAL_PREF_CONN	0x2A04
+#define GATT_CHARAC_SERVICE_CHANGED		0x2A05
+
+/* GATT Characteristic Descriptors */
+#define GATT_CHARAC_EXT_PROPER_UUID	0x2900
+#define GATT_CHARAC_USER_DESC_UUID	0x2901
+#define GATT_CLIENT_CHARAC_CFG_UUID	0x2902
+#define GATT_SERVER_CHARAC_CFG_UUID	0x2903
+#define GATT_CHARAC_FMT_UUID		0x2904
+#define GATT_CHARAC_AGREG_FMT_UUID	0x2905
+
+/* Attribute Protocol Opcodes */
+#define ATT_OP_ERROR			0x01
+#define ATT_OP_MTU_REQ			0x02
+#define ATT_OP_MTU_RESP			0x03
+#define ATT_OP_FIND_INFO_REQ		0x04
+#define ATT_OP_FIND_INFO_RESP		0x05
+#define ATT_OP_FIND_BY_TYPE_REQ		0x06
+#define ATT_OP_FIND_BY_TYPE_RESP	0x07
+#define ATT_OP_READ_BY_TYPE_REQ		0x08
+#define ATT_OP_READ_BY_TYPE_RESP	0x09
+#define ATT_OP_READ_REQ			0x0A
+#define ATT_OP_READ_RESP		0x0B
+#define ATT_OP_READ_BLOB_REQ		0x0C
+#define ATT_OP_READ_BLOB_RESP		0x0D
+#define ATT_OP_READ_MULTI_REQ		0x0E
+#define ATT_OP_READ_MULTI_RESP		0x0F
+#define ATT_OP_READ_BY_GROUP_REQ	0x10
+#define ATT_OP_READ_BY_GROUP_RESP	0x11
+#define ATT_OP_WRITE_REQ		0x12
+#define ATT_OP_WRITE_RESP		0x13
+#define ATT_OP_WRITE_CMD		0x52
+#define ATT_OP_PREP_WRITE_REQ		0x16
+#define ATT_OP_PREP_WRITE_RESP		0x17
+#define ATT_OP_EXEC_WRITE_REQ		0x18
+#define ATT_OP_EXEC_WRITE_RESP		0x19
+#define ATT_OP_HANDLE_NOTIFY		0x1B
+#define ATT_OP_HANDLE_IND		0x1D
+#define ATT_OP_HANDLE_CNF		0x1E
+#define ATT_OP_SIGNED_WRITE_CMD		0xD2
+
+/* Error codes for Error response PDU */
+#define ATT_ECODE_INVALID_HANDLE		0x01
+#define ATT_ECODE_READ_NOT_PERM			0x02
+#define ATT_ECODE_WRITE_NOT_PERM		0x03
+#define ATT_ECODE_INVALID_PDU			0x04
+#define ATT_ECODE_INSUFF_AUTHEN			0x05
+#define ATT_ECODE_REQ_NOT_SUPP			0x06
+#define ATT_ECODE_INVALID_OFFSET		0x07
+#define ATT_ECODE_INSUFF_AUTHO			0x08
+#define ATT_ECODE_PREP_QUEUE_FULL		0x09
+#define ATT_ECODE_ATTR_NOT_FOUND		0x0A
+#define ATT_ECODE_ATTR_NOT_LONG			0x0B
+#define ATT_ECODE_INSUFF_ENCR_KEY_SIZE		0x0C
+#define ATT_ECODE_INVAL_ATTR_VALUE_LEN		0x0D
+#define ATT_ECODE_UNLIKELY			0x0E
+#define ATT_ECODE_INSUFF_ENC			0x0F
+#define ATT_ECODE_UNSUPP_GRP_TYPE		0x10
+#define ATT_ECODE_INSUFF_RESOURCES		0x11
+/* Application error */
+#define ATT_ECODE_IO				0xFF
+
+/* Characteristic Property bit field */
+#define ATT_CHAR_PROPER_BROADCAST		0x01
+#define ATT_CHAR_PROPER_READ			0x02
+#define ATT_CHAR_PROPER_WRITE_WITHOUT_RESP	0x04
+#define ATT_CHAR_PROPER_WRITE			0x08
+#define ATT_CHAR_PROPER_NOTIFY			0x10
+#define ATT_CHAR_PROPER_INDICATE		0x20
+#define ATT_CHAR_PROPER_AUTH			0x40
+#define ATT_CHAR_PROPER_EXT_PROPER		0x80
+
+
+#define ATT_MAX_MTU				256
+#define ATT_DEFAULT_MTU				23
+
+struct attribute {
+	uint16_t handle;
+	uuid_t uuid;
+	int len;
+	uint8_t data[0];
+};
+
+struct att_data_list {
+	uint16_t num;
+	uint16_t len;
+	uint8_t **data;
+};
+
+/* These functions do byte conversion */
+static inline uint8_t att_get_u8(const void *ptr)
+{
+	const uint8_t *u8_ptr = ptr;
+	return bt_get_unaligned(u8_ptr);
+}
+
+static inline uint16_t att_get_u16(const void *ptr)
+{
+	const uint16_t *u16_ptr = ptr;
+	return btohs(bt_get_unaligned(u16_ptr));
+}
+
+static inline uint32_t att_get_u32(const void *ptr)
+{
+	const uint32_t *u32_ptr = ptr;
+	return btohl(bt_get_unaligned(u32_ptr));
+}
+
+static inline void att_put_u8(uint8_t src, void *dst)
+{
+	bt_put_unaligned(src, (uint8_t *) dst);
+}
+
+static inline void att_put_u16(uint16_t src, void *dst)
+{
+	bt_put_unaligned(htobs(src), (uint16_t *) dst);
+}
+
+static inline void att_put_u32(uint16_t src, void *dst)
+{
+	bt_put_unaligned(htobl(src), (uint32_t *) dst);
+}
+
+void att_data_list_free(struct att_data_list *list);
+
+const char *att_ecode2str(uint8_t status);
+uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
+							uint8_t *pdu, int len);
+uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
+						uint16_t *end, uuid_t *uuid);
+uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu, int len);
+uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+							uint8_t *pdu, int len);
+struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len);
+uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
+							uint8_t *pdu, int len);
+uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
+						uint16_t *end, uuid_t *uuid);
+uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu,
+								int len);
+uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
+							uint8_t *pdu, int len);
+uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int *vlen);
+struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len);
+uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
+							uint8_t *pdu, int len);
+uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int *vlen);
+uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
+uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
+uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
+uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
+uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
+							uint8_t *pdu, int len);
+uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, int len);
+uint16_t dec_find_info_req(const uint8_t *pdu, int len, uint16_t *start,
+								uint16_t *end);
+uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
+							uint8_t *pdu, int len);
+struct att_data_list *dec_find_info_resp(const uint8_t *pdu, int len,
+							uint8_t *format);
+uint16_t enc_notification(struct attribute *a, uint8_t *pdu, int len);
+uint16_t enc_indication(struct attribute *a, uint8_t *pdu, int len);
+struct attribute *dec_indication(const uint8_t *pdu, int len);
+uint16_t enc_confirmation(uint8_t *pdu, int len);
+
+uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len);
+uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu);
+uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len);
+uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu);
diff --git a/src/gatt.c b/src/gatt.c
new file mode 100644
index 0000000..24ec990
--- /dev/null
+++ b/src/gatt.c
@@ -0,0 +1,113 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <glib.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
+
+guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
+		uint16_t end, GAttribResultFunc func, gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	uuid_t uuid;
+	guint16 plen;
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+
+	plen = enc_read_by_grp_req(start, end, &uuid, pdu, sizeof(pdu));
+	if (plen == 0)
+		return 0;
+
+	return g_attrib_send(attrib, ATT_OP_READ_BY_GROUP_REQ,
+					pdu, plen, func, user_data, NULL);
+}
+
+guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
+				GAttribResultFunc func, gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	uuid_t uuid;
+	guint16 plen;
+
+	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+
+	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
+	if (plen == 0)
+		return 0;
+
+	return g_attrib_send(attrib, ATT_OP_READ_BY_TYPE_REQ,
+					pdu, plen, func, user_data, NULL);
+}
+
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
+							gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+
+	plen = enc_read_req(handle, pdu, sizeof(pdu));
+	return g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen, func,
+							user_data, NULL);
+}
+
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+			int vlen, GAttribResultFunc func, gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+
+	plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
+	return g_attrib_send(attrib, ATT_OP_WRITE_REQ, pdu, plen, func,
+							user_data, NULL);
+}
+
+guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+				GAttribResultFunc func, gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+
+	plen = enc_find_info_req(start, end, pdu, sizeof(pdu));
+	if (plen == 0)
+		return 0;
+
+	return g_attrib_send(attrib, ATT_OP_FIND_INFO_REQ, pdu, plen, func,
+							user_data, NULL);
+}
+
+guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
+				GDestroyNotify notify, gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+
+	plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
+	return g_attrib_send(attrib, ATT_OP_WRITE_CMD, pdu, plen, NULL,
+							user_data, notify);
+}
diff --git a/src/gatt.h b/src/gatt.h
new file mode 100644
index 0000000..f1599c2
--- /dev/null
+++ b/src/gatt.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define GATT_CID 4
+
+guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
+		uint16_t end, GAttribResultFunc func, gpointer user_data);
+
+guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
+				GAttribResultFunc func, gpointer user_data);
+
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
+							gpointer user_data);
+
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+			int vlen, GAttribResultFunc func, gpointer user_data);
+
+guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+				GAttribResultFunc func, gpointer user_data);
+
+guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
+				GDestroyNotify notify, gpointer user_data);
diff --git a/src/gattrib.c b/src/gattrib.c
new file mode 100644
index 0000000..ed18168
--- /dev/null
+++ b/src/gattrib.c
@@ -0,0 +1,535 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <string.h>
+#include <glib.h>
+
+#include <stdio.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+
+#include "att.h"
+#include "gattrib.h"
+
+struct _GAttrib {
+	GIOChannel *io;
+	gint refs;
+	gint mtu;
+	guint read_watch;
+	guint write_watch;
+	GQueue *queue;
+	GSList *events;
+	guint next_cmd_id;
+	guint next_evt_id;
+	GDestroyNotify destroy;
+	GAttribDisconnectFunc disconnect;
+	gpointer destroy_user_data;
+	gpointer disc_user_data;
+};
+
+struct command {
+	guint id;
+	guint8 opcode;
+	guint8 *pdu;
+	guint16 len;
+	guint8 expected;
+	gboolean sent;
+	GAttribResultFunc func;
+	gpointer user_data;
+	GDestroyNotify notify;
+};
+
+struct event {
+	guint id;
+	guint8 expected;
+	GAttribNotifyFunc func;
+	gpointer user_data;
+	GDestroyNotify notify;
+};
+
+static guint8 opcode2expected(guint8 opcode)
+{
+	switch (opcode) {
+	case ATT_OP_MTU_REQ:
+		return ATT_OP_MTU_RESP;
+
+	case ATT_OP_FIND_INFO_REQ:
+		return ATT_OP_FIND_INFO_RESP;
+
+	case ATT_OP_FIND_BY_TYPE_REQ:
+		return ATT_OP_FIND_BY_TYPE_RESP;
+
+	case ATT_OP_READ_BY_TYPE_REQ:
+		return ATT_OP_READ_BY_TYPE_RESP;
+
+	case ATT_OP_READ_REQ:
+		return ATT_OP_READ_RESP;
+
+	case ATT_OP_READ_BLOB_REQ:
+		return ATT_OP_READ_BLOB_RESP;
+
+	case ATT_OP_READ_MULTI_REQ:
+		return ATT_OP_READ_MULTI_RESP;
+
+	case ATT_OP_READ_BY_GROUP_REQ:
+		return ATT_OP_READ_BY_GROUP_RESP;
+
+	case ATT_OP_WRITE_REQ:
+		return ATT_OP_WRITE_RESP;
+
+	case ATT_OP_PREP_WRITE_REQ:
+		return ATT_OP_PREP_WRITE_RESP;
+
+	case ATT_OP_EXEC_WRITE_REQ:
+		return ATT_OP_EXEC_WRITE_RESP;
+
+	case ATT_OP_HANDLE_IND:
+		return ATT_OP_HANDLE_CNF;
+	}
+
+	return 0;
+}
+
+static gboolean is_response(guint8 opcode)
+{
+	switch (opcode) {
+	case ATT_OP_ERROR:
+	case ATT_OP_MTU_RESP:
+	case ATT_OP_FIND_INFO_RESP:
+	case ATT_OP_FIND_BY_TYPE_RESP:
+	case ATT_OP_READ_BY_TYPE_RESP:
+	case ATT_OP_READ_RESP:
+	case ATT_OP_READ_BLOB_RESP:
+	case ATT_OP_READ_MULTI_RESP:
+	case ATT_OP_READ_BY_GROUP_RESP:
+	case ATT_OP_WRITE_RESP:
+	case ATT_OP_PREP_WRITE_RESP:
+	case ATT_OP_EXEC_WRITE_RESP:
+	case ATT_OP_HANDLE_CNF:
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+GAttrib *g_attrib_ref(GAttrib *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	g_atomic_int_inc(&attrib->refs);
+
+	return attrib;
+}
+
+static void command_destroy(struct command *cmd)
+{
+	if (cmd->notify)
+		cmd->notify(cmd->user_data);
+
+	g_free(cmd->pdu);
+	g_free(cmd);
+}
+
+static void event_destroy(struct event *evt)
+{
+	if (evt->notify)
+		evt->notify(evt->user_data);
+
+	g_free(evt);
+}
+
+void g_attrib_unref(GAttrib *attrib)
+{
+	GSList *l;
+	struct command *c;
+
+	if (!attrib)
+		return;
+
+	if (g_atomic_int_dec_and_test(&attrib->refs) == FALSE)
+		return;
+
+	while ((c = g_queue_pop_head(attrib->queue)))
+		command_destroy(c);
+
+	attrib->queue = NULL;
+
+	for (l = attrib->events; l; l = l->next)
+		event_destroy(l->data);
+
+	g_slist_free(attrib->events);
+	attrib->events = NULL;
+
+	if (attrib->write_watch > 0)
+		g_source_remove(attrib->write_watch);
+
+	if (attrib->read_watch > 0) {
+		g_source_remove(attrib->read_watch);
+		g_io_channel_unref(attrib->io);
+	}
+
+
+	if (attrib->destroy)
+		attrib->destroy(attrib->destroy_user_data);
+
+	g_free(attrib);
+}
+
+gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
+		GAttribDisconnectFunc disconnect, gpointer user_data)
+{
+	if (attrib == NULL)
+		return FALSE;
+
+	attrib->disconnect = disconnect;
+	attrib->disc_user_data = user_data;
+
+	return TRUE;
+}
+
+gboolean g_attrib_set_destroy_function(GAttrib *attrib,
+		GDestroyNotify destroy, gpointer user_data)
+{
+	if (attrib == NULL)
+		return FALSE;
+
+	attrib->destroy = destroy;
+	attrib->destroy_user_data = user_data;
+
+	return TRUE;
+}
+
+static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	struct _GAttrib *attrib = data;
+	struct command *cmd;
+	GError *gerr = NULL;
+	gsize len;
+	GIOStatus iostat;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		if (attrib->disconnect)
+			attrib->disconnect(attrib->disc_user_data);
+
+		return FALSE;
+	}
+
+	cmd = g_queue_peek_head(attrib->queue);
+	if (cmd == NULL)
+		return FALSE;
+
+	iostat = g_io_channel_write_chars(io, (gchar *) cmd->pdu, cmd->len,
+								&len, &gerr);
+	if (iostat != G_IO_STATUS_NORMAL)
+		return FALSE;
+
+	g_io_channel_flush(io, NULL);
+
+	if (cmd->expected == 0) {
+		g_queue_pop_head(attrib->queue);
+		command_destroy(cmd);
+
+		return TRUE;
+	}
+
+	cmd->sent = TRUE;
+
+	return FALSE;
+}
+
+static void destroy_sender(gpointer data)
+{
+	struct _GAttrib *attrib = data;
+
+	attrib->write_watch = 0;
+}
+
+static void wake_up_sender(struct _GAttrib *attrib)
+{
+	if (attrib->write_watch == 0)
+		attrib->write_watch = g_io_add_watch_full(attrib->io,
+			G_PRIORITY_DEFAULT, G_IO_OUT, can_write_data,
+			attrib, destroy_sender);
+}
+
+static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
+{
+	struct _GAttrib *attrib = data;
+	struct command *cmd = NULL;
+	GSList *l;
+	uint8_t buf[512], status;
+	gsize len;
+	GIOStatus iostat;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		attrib->read_watch = 0;
+		if (attrib->disconnect)
+			attrib->disconnect(attrib->disc_user_data);
+		return FALSE;
+	}
+
+	memset(buf, 0, sizeof(buf));
+
+	iostat = g_io_channel_read_chars(io, (gchar *) buf, sizeof(buf),
+								&len, NULL);
+	if (iostat != G_IO_STATUS_NORMAL) {
+		status = ATT_ECODE_IO;
+		goto done;
+	}
+
+	for (l = attrib->events; l; l = l->next) {
+		struct event *evt = l->data;
+
+		if (evt->expected == buf[0] ||
+					evt->expected == GATTRIB_ALL_EVENTS)
+			evt->func(buf, len, evt->user_data);
+	}
+
+	if (is_response(buf[0]) == FALSE)
+		return TRUE;
+
+	cmd = g_queue_pop_head(attrib->queue);
+	if (cmd == NULL) {
+		/* Keep the watch if we have events to report */
+		return attrib->events != NULL;
+	}
+
+	if (buf[0] == ATT_OP_ERROR) {
+		status = buf[4];
+		goto done;
+	}
+
+	if (cmd->expected != buf[0]) {
+		status = ATT_ECODE_IO;
+		goto done;
+	}
+
+	status = 0;
+
+done:
+	if (attrib->queue && g_queue_is_empty(attrib->queue) == FALSE)
+		wake_up_sender(attrib);
+
+	if (cmd) {
+		if (cmd->func)
+			cmd->func(status, buf, len, cmd->user_data);
+
+		command_destroy(cmd);
+	}
+
+	return TRUE;
+}
+
+GAttrib *g_attrib_new(GIOChannel *io)
+{
+	struct _GAttrib *attrib;
+
+	g_io_channel_set_encoding(io, NULL, NULL);
+
+	attrib = g_try_new0(struct _GAttrib, 1);
+	if (attrib == NULL)
+		return NULL;
+
+	attrib->io = g_io_channel_ref(io);
+	attrib->mtu = 512;
+	attrib->queue = g_queue_new();
+
+	attrib->read_watch = g_io_add_watch(attrib->io,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			received_data, attrib);
+
+	return g_attrib_ref(attrib);
+}
+
+guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
+				guint16 len, GAttribResultFunc func,
+				gpointer user_data, GDestroyNotify notify)
+{
+	struct command *c;
+
+	c = g_try_new0(struct command, 1);
+	if (c == NULL)
+		return 0;
+
+	c->opcode = opcode;
+	c->expected = opcode2expected(opcode);
+	c->pdu = g_malloc(len);
+	memcpy(c->pdu, pdu, len);
+	c->len = len;
+	c->func = func;
+	c->user_data = user_data;
+	c->notify = notify;
+	c->id = ++attrib->next_cmd_id;
+
+	g_queue_push_tail(attrib->queue, c);
+
+	if (g_queue_get_length(attrib->queue) == 1)
+		wake_up_sender(attrib);
+
+	return c->id;
+}
+
+static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct command *cmd = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return cmd->id - id;
+}
+
+gboolean g_attrib_cancel(GAttrib *attrib, guint id)
+{
+	GList *l;
+	struct command *cmd;
+
+	if (attrib == NULL || attrib->queue == NULL)
+		return FALSE;
+
+	l = g_queue_find_custom(attrib->queue, GUINT_TO_POINTER(id),
+							command_cmp_by_id);
+	if (l == NULL)
+		return FALSE;
+
+	cmd = l->data;
+
+	if (cmd == g_queue_peek_head(attrib->queue) && cmd->sent)
+		cmd->func = NULL;
+	else {
+		g_queue_remove(attrib->queue, cmd);
+		command_destroy(cmd);
+	}
+
+	return TRUE;
+}
+
+gboolean g_attrib_cancel_all(GAttrib *attrib)
+{
+	struct command *c, *head = NULL;
+	gboolean first = TRUE;
+
+	if (attrib == NULL || attrib->queue == NULL)
+		return FALSE;
+
+	while ((c = g_queue_pop_head(attrib->queue))) {
+		if (first && c->sent) {
+			/* If the command was sent ignore its callback ... */
+			c->func = NULL;
+			head = c;
+			continue;
+		}
+
+		first = FALSE;
+		command_destroy(c);
+	}
+
+	if (head) {
+		/* ... and put it back in the queue */
+		g_queue_push_head(attrib->queue, head);
+	}
+
+	return TRUE;
+}
+
+gboolean g_attrib_set_debug(GAttrib *attrib,
+		GAttribDebugFunc func, gpointer user_data)
+{
+	return TRUE;
+}
+
+guint g_attrib_register(GAttrib *attrib, guint8 opcode,
+				GAttribNotifyFunc func, gpointer user_data,
+				GDestroyNotify notify)
+{
+	struct event *event;
+
+	event = g_try_new0(struct event, 1);
+	if (event == NULL)
+		return 0;
+
+	event->expected = opcode;
+	event->func = func;
+	event->user_data = user_data;
+	event->notify = notify;
+	event->id = ++attrib->next_evt_id;
+
+	attrib->events = g_slist_append(attrib->events, event);
+
+	return event->id;
+}
+
+static gint event_cmp_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct event *evt = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return evt->id - id;
+}
+
+gboolean g_attrib_unregister(GAttrib *attrib, guint id)
+{
+	struct event *evt;
+	GSList *l;
+
+	l = g_slist_find_custom(attrib->events, GUINT_TO_POINTER(id),
+							event_cmp_by_id);
+	if (l == NULL)
+		return FALSE;
+
+	evt = l->data;
+
+	attrib->events = g_slist_remove(attrib->events, evt);
+
+	if (evt->notify)
+		evt->notify(evt->user_data);
+
+	g_free(evt);
+
+	return TRUE;
+}
+
+gboolean g_attrib_unregister_all(GAttrib *attrib)
+{
+	GSList *l;
+
+	if (attrib->events == NULL)
+		return FALSE;
+
+	for (l = attrib->events; l; l = l->next) {
+		struct event *evt = l->data;
+
+		if (evt->notify)
+			evt->notify(evt->user_data);
+
+		g_free(evt);
+	}
+
+	g_slist_free(attrib->events);
+	attrib->events = NULL;
+
+	return TRUE;
+}
diff --git a/src/gattrib.h b/src/gattrib.h
new file mode 100644
index 0000000..4306ca4
--- /dev/null
+++ b/src/gattrib.h
@@ -0,0 +1,72 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+#ifndef __GATTRIB_H
+#define __GATTRIB_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define GATTRIB_ALL_EVENTS 0xFF
+
+struct _GAttrib;
+typedef struct _GAttrib GAttrib;
+
+typedef void (*GAttribResultFunc) (guint8 status, const guint8 *pdu,
+					guint16 len, gpointer user_data);
+typedef void (*GAttribDisconnectFunc)(gpointer user_data);
+typedef void (*GAttribDebugFunc)(const char *str, gpointer user_data);
+typedef void (*GAttribNotifyFunc)(const guint8 *pdu, guint16 len,
+							gpointer user_data);
+
+GAttrib *g_attrib_new(GIOChannel *io);
+GAttrib *g_attrib_ref(GAttrib *attrib);
+void g_attrib_unref(GAttrib *attrib);
+
+gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
+		GAttribDisconnectFunc disconnect, gpointer user_data);
+
+gboolean g_attrib_set_destroy_function(GAttrib *attrib,
+		GDestroyNotify destroy, gpointer user_data);
+
+guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
+				guint16 len, GAttribResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
+gboolean g_attrib_cancel(GAttrib *attrib, guint id);
+gboolean g_attrib_cancel_all(GAttrib *attrib);
+
+gboolean g_attrib_set_debug(GAttrib *attrib,
+		GAttribDebugFunc func, gpointer user_data);
+
+guint g_attrib_register(GAttrib *attrib, guint8 opcode,
+		GAttribNotifyFunc func, gpointer user_data,
+					GDestroyNotify notify);
+
+gboolean g_attrib_unregister(GAttrib *attrib, guint id);
+gboolean g_attrib_unregister_all(GAttrib *attrib);
+
+#ifdef __cplusplus
+}
+#endif
+#endif
-- 
1.7.3.2

