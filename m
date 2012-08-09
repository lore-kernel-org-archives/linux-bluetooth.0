Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/9] client: Port PBAP module to use GObexApparam
Date: Thu,  9 Aug 2012 13:32:30 +0300
Message-Id: <1344508353-24647-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/pbap.c | 181 ++++++++++++++++------------------------------------------
 1 file changed, 49 insertions(+), 132 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 48dbac1..9a1da8d 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -33,6 +33,7 @@
 #include <gdbus.h>
 
 #include <bluetooth/bluetooth.h>
+#include <gobex-apparam.h>
 
 #include "log.h"
 
@@ -72,18 +73,6 @@
 #define PHONEBOOKSIZE_TAG	0X08
 #define NEWMISSEDCALLS_TAG	0X09
 
-/* The following length is in the unit of byte */
-#define ORDER_LEN		1
-#define SEARCHATTRIB_LEN	1
-#define MAXLISTCOUNT_LEN	2
-#define LISTSTARTOFFSET_LEN	2
-#define FILTER_LEN		8
-#define FORMAT_LEN		1
-#define PHONEBOOKSIZE_LEN	2
-#define NEWMISSEDCALLS_LEN	1
-
-#define get_be16(val)	GUINT16_FROM_BE(bt_get_unaligned((guint16 *) val))
-
 static const char *filter_list[] = {
 	"VERSION",
 	"FN",
@@ -137,38 +126,6 @@ struct pending_request {
 	DBusMessage *msg;
 };
 
-struct pullphonebook_apparam {
-	uint8_t     filter_tag;
-	uint8_t     filter_len;
-	uint64_t    filter;
-	uint8_t     format_tag;
-	uint8_t     format_len;
-	uint8_t     format;
-	uint8_t     maxlistcount_tag;
-	uint8_t     maxlistcount_len;
-	uint16_t    maxlistcount;
-	uint8_t     liststartoffset_tag;
-	uint8_t     liststartoffset_len;
-	uint16_t    liststartoffset;
-} __attribute__ ((packed));
-
-struct pullvcardentry_apparam {
-        uint8_t     filter_tag;
-        uint8_t     filter_len;
-        uint64_t    filter;
-        uint8_t     format_tag;
-        uint8_t     format_len;
-        uint8_t     format;
-} __attribute__ ((packed));
-
-struct apparam_hdr {
-	uint8_t		tag;
-	uint8_t		len;
-	uint8_t		val[0];
-} __attribute__ ((packed));
-
-#define APPARAM_HDR_SIZE 2
-
 static DBusConnection *conn = NULL;
 
 static struct pending_request *pending_request_new(struct pbap_data *pbap,
@@ -295,48 +252,28 @@ static void pbap_setpath_cb(struct obc_session *session,
 static void read_return_apparam(struct obc_transfer *transfer,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
-	const struct apparam_hdr *hdr;
+	GObexApparam *apparam;
+	const guint8 *data;
 	size_t size;
 
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	hdr = obc_transfer_get_params(transfer, &size);
-	if (hdr == NULL)
+	data = obc_transfer_get_params(transfer, &size);
+	if (data == NULL)
 		return;
 
-	if (size < APPARAM_HDR_SIZE)
+	apparam = g_obex_apparam_decode(data, size);
+	if (apparam == NULL)
 		return;
 
-	while (size > APPARAM_HDR_SIZE) {
-		if (hdr->len > size - APPARAM_HDR_SIZE) {
-			error("Unexpected PBAP pullphonebook app"
-					" length, tag %d, len %d",
-					hdr->tag, hdr->len);
-			return;
-		}
+	g_obex_apparam_get_uint16(apparam, PHONEBOOKSIZE_TAG,
+							phone_book_size);
+	g_obex_apparam_get_uint8(apparam, NEWMISSEDCALLS_TAG,
+							new_missed_calls);
 
-		switch (hdr->tag) {
-		case PHONEBOOKSIZE_TAG:
-			if (hdr->len == PHONEBOOKSIZE_LEN) {
-				guint16 val;
-				memcpy(&val, hdr->val, sizeof(val));
-				*phone_book_size = get_be16(&val);
-			}
-			break;
-		case NEWMISSEDCALLS_TAG:
-			if (hdr->len == NEWMISSEDCALLS_LEN)
-				*new_missed_calls = hdr->val[0];
-			break;
-		default:
-			error("Unexpected PBAP pullphonebook app"
-					" parameter, tag %d, len %d",
-					hdr->tag, hdr->len);
-		}
 
-		size -= APPARAM_HDR_SIZE + hdr->len;
-		hdr += APPARAM_HDR_SIZE + hdr->len;
-	}
+	g_obex_apparam_free(apparam);
 }
 
 static void phonebook_size_callback(struct obc_session *session,
@@ -425,25 +362,21 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 {
 	struct pending_request *request;
 	struct obc_transfer *transfer;
-	struct pullphonebook_apparam apparam;
+	GObexApparam *apparam;
+	guint8 buf[32];
+	gsize len;
 	session_callback_t func;
 
 	transfer = obc_transfer_get("x-bt/phonebook", name, targetfile, err);
 	if (transfer == NULL)
 		return NULL;
 
-	apparam.filter_tag = FILTER_TAG;
-	apparam.filter_len = FILTER_LEN;
-	apparam.filter = GUINT64_TO_BE(filter);
-	apparam.format_tag = FORMAT_TAG;
-	apparam.format_len = FORMAT_LEN;
-	apparam.format = format;
-	apparam.maxlistcount_tag = MAXLISTCOUNT_TAG;
-	apparam.maxlistcount_len = MAXLISTCOUNT_LEN;
-	apparam.maxlistcount = GUINT16_TO_BE(maxlistcount);
-	apparam.liststartoffset_tag = LISTSTARTOFFSET_TAG;
-	apparam.liststartoffset_len = LISTSTARTOFFSET_LEN;
-	apparam.liststartoffset = GUINT16_TO_BE(liststartoffset);
+	apparam = g_obex_apparam_set_uint64(NULL, FILTER_TAG, filter);
+	apparam = g_obex_apparam_set_uint8(apparam, FORMAT_TAG, format);
+	apparam = g_obex_apparam_set_uint16(apparam, MAXLISTCOUNT_TAG,
+							maxlistcount);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+							liststartoffset);
 
 	switch (type) {
 	case PULLPHONEBOOK:
@@ -459,7 +392,11 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 		return NULL;
 	}
 
-	obc_transfer_set_params(transfer, &apparam, sizeof(apparam));
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	obc_transfer_set_params(transfer, buf, len);
+
+	g_obex_apparam_free(apparam);
 
 	if (!obc_session_queue(pbap->session, transfer, func, request, err)) {
 		if (request != NULL)
@@ -472,18 +409,6 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 	return transfer;
 }
 
-static guint8 *fill_apparam(guint8 *dest, void *buf, guint8 tag, guint8 len)
-{
-	if (dest && buf) {
-		*dest++ = tag;
-		*dest++ = len;
-		memcpy(dest, buf, len);
-		dest += len;
-	}
-
-	return dest;
-}
-
 static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 					DBusMessage *message, const char *name,
 					guint8 order, char *searchval, guint8 attrib,
@@ -491,41 +416,31 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 {
 	struct pending_request *request;
 	struct obc_transfer *transfer;
-	guint8 *p, apparam[272];
-	gint apparam_size;
+	guint8 buf[272];
+	gsize len;
 	GError *err = NULL;
+	GObexApparam *apparam;
 	DBusMessage *reply;
 
 	transfer = obc_transfer_get("x-bt/vcard-listing", name, NULL, &err);
 	if (transfer == NULL)
 		goto fail;
 
-	/* trunc the searchval string if it's length exceed the max value of guint8 */
-	if (strlen(searchval) > 254)
-		searchval[255] = '\0';
-
-	apparam_size = APPARAM_HDR_SIZE + ORDER_LEN +
-			(APPARAM_HDR_SIZE + strlen(searchval) + 1) +
-			(APPARAM_HDR_SIZE + SEARCHATTRIB_LEN) +
-			(APPARAM_HDR_SIZE + MAXLISTCOUNT_LEN) +
-			(APPARAM_HDR_SIZE + LISTSTARTOFFSET_LEN);
-
-	p = apparam;
+	apparam = g_obex_apparam_set_uint8(NULL, ORDER_TAG, order);
+	apparam = g_obex_apparam_set_uint8(apparam, SEARCHATTRIB_TAG, attrib);
+	apparam = g_obex_apparam_set_string(apparam, SEARCHVALUE_TAG,
+								searchval);
+	apparam = g_obex_apparam_set_uint16(apparam, MAXLISTCOUNT_TAG, count);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+								offset);
 
-	p = fill_apparam(p, &order, ORDER_TAG, ORDER_LEN);
-	p = fill_apparam(p, searchval, SEARCHVALUE_TAG, strlen(searchval) + 1);
-	p = fill_apparam(p, &attrib, SEARCHATTRIB_TAG, SEARCHATTRIB_LEN);
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
 
-	count = GUINT16_TO_BE(count);
-	p = fill_apparam(p, &count, MAXLISTCOUNT_TAG, MAXLISTCOUNT_LEN);
+	obc_transfer_set_params(transfer, buf, len);
 
-	offset = GUINT16_TO_BE(offset);
-	fill_apparam(p, &offset, LISTSTARTOFFSET_TAG, LISTSTARTOFFSET_LEN);
+	g_obex_apparam_free(apparam);
 
 	request = pending_request_new(pbap, message);
-
-	obc_transfer_set_params(transfer, apparam, apparam_size);
-
 	if (obc_session_queue(pbap->session, transfer,
 				pull_vcard_listing_callback, request, &err))
 		return NULL;
@@ -739,7 +654,9 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 {
 	struct pbap_data *pbap = user_data;
 	struct obc_transfer *transfer;
-	struct pullvcardentry_apparam apparam;
+	GObexApparam *apparam;
+	guint8 buf[32];
+	gsize len;
 	const char *name, *targetfile;
 	DBusMessage *reply;
 	GError *err = NULL;
@@ -760,14 +677,14 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	apparam.filter_tag = FILTER_TAG;
-	apparam.filter_len = FILTER_LEN;
-	apparam.filter = GUINT64_TO_BE(pbap->filter);
-	apparam.format_tag = FORMAT_TAG;
-	apparam.format_len = FORMAT_LEN;
-	apparam.format = pbap->format;
+	apparam = g_obex_apparam_set_uint64(NULL, FILTER_TAG, pbap->filter);
+	apparam = g_obex_apparam_set_uint8(apparam, FORMAT_TAG, pbap->format);
+
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	obc_transfer_set_params(transfer, buf, len);
 
-	obc_transfer_set_params(transfer, &apparam, sizeof(apparam));
+	g_obex_apparam_free(apparam);
 
 	if (!obc_session_queue(pbap->session, transfer, NULL, NULL, &err))
 		goto fail;
-- 
1.7.11.2

