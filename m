Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	johan.hedberg@nokia.com, padovan@profusion.mobi,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH] Fix incoming attrib-server connection MTUs
Date: Thu, 20 Jan 2011 11:09:01 -0800
Message-Id: <1295550541-30535-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1295550541-30535-1-git-send-email-bgix@codeaurora.org>
References: <1295550541-30535-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is important for the Attribute Server to be aware of and
completely fill response packets up to the full MTU when
reading long attributes.  Some remote devices will only request
additional (READ_BLOB) data if the preceding read sent the
maximum amount of data.

Incoming connections are identified as L2CAP or LE by pointers
to the Service IO channel the incoming connection was recieved on
in the user_data parameter. L2CAP channels are set to the BR/EDR minimum
MTU of 48, and LE channels to the LE payload size of 23.
---
 attrib/att.h        |    3 ++-
 attrib/gatt.c       |   28 ++++++++++++++--------------
 src/attrib-server.c |   13 +++++++++----
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 29ab0e6..1caa62a 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -107,7 +107,8 @@
 
 
 #define ATT_MAX_MTU				256
-#define ATT_DEFAULT_MTU				23
+#define ATT_DEFAULT_L2CAP_MTU			48
+#define ATT_DEFAULT_LE_MTU			23
 
 /* Requirements for read/write operations */
 enum {
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 5d7887e..f3b513e 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -105,7 +105,7 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	struct discover_primary *dp = user_data;
 	GSList *ranges, *last;
 	struct att_range *range;
-	uint8_t opdu[ATT_DEFAULT_MTU];
+	uint8_t opdu[ATT_DEFAULT_LE_MTU];
 	guint16 oplen;
 	int err = 0;
 
@@ -195,7 +195,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	err = 0;
 
 	if (end != 0xffff) {
-		uint8_t opdu[ATT_DEFAULT_MTU];
+		uint8_t opdu[ATT_DEFAULT_LE_MTU];
 		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 							opdu, sizeof(opdu));
 
@@ -214,7 +214,7 @@ guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data)
 {
 	struct discover_primary *dp;
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	GAttribResultFunc cb;
 	guint16 plen;
 
@@ -245,7 +245,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
 	unsigned int i, err;
-	uint8_t opdu[ATT_DEFAULT_MTU];
+	uint8_t opdu[ATT_DEFAULT_LE_MTU];
 	guint16 oplen;
 	uuid_t uuid;
 	uint16_t last = 0;
@@ -314,7 +314,7 @@ done:
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					gatt_cb_t func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	struct discover_char *dc;
 	guint16 plen;
 	uuid_t uuid;
@@ -342,7 +342,7 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 					uuid_t *uuid, GAttribResultFunc func,
 					gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 
 	plen = enc_read_by_type_req(start, end, uuid, pdu, sizeof(pdu));
@@ -381,7 +381,7 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 							gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint8 *tmp;
 	guint16 plen;
 	guint id;
@@ -402,7 +402,7 @@ static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
 	long_read->buffer = tmp;
 	long_read->size += rlen - 1;
 
-	if (rlen < ATT_DEFAULT_MTU)
+	if (rlen < ATT_DEFAULT_LE_MTU)
 		goto done;
 
 	plen = enc_read_blob_req(long_read->handle, long_read->size - 1,
@@ -427,11 +427,11 @@ static void read_char_helper(guint8 status, const guint8 *rpdu,
 					guint16 rlen, gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 	guint id;
 
-	if (status != 0 || rlen < ATT_DEFAULT_MTU)
+	if (status != 0 || rlen < ATT_DEFAULT_LE_MTU)
 		goto done;
 
 	long_read->buffer = g_malloc(rlen);
@@ -461,7 +461,7 @@ done:
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 	guint id;
 	struct read_long_data *long_read;
@@ -493,7 +493,7 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 			int vlen, GAttribResultFunc func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 
 	plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
@@ -504,7 +504,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 
 	plen = enc_find_info_req(start, end, pdu, sizeof(pdu));
@@ -518,7 +518,7 @@ guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 				GDestroyNotify notify, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 
 	plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 923bde7..f03a5b9 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -737,6 +737,7 @@ done:
 static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
 	struct gatt_channel *channel;
+	GIOChannel **server_io = user_data;
 	GError *gerr = NULL;
 
 	if (err) {
@@ -758,8 +759,12 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
+	if (server_io == &l2cap_io)
+		channel->mtu = ATT_DEFAULT_L2CAP_MTU;
+	else
+		channel->mtu = ATT_DEFAULT_LE_MTU;
+
 	channel->attrib = g_attrib_new(io);
-	channel->mtu = ATT_DEFAULT_MTU;
 	g_io_channel_unref(io);
 
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
@@ -775,7 +780,7 @@ static void confirm_event(GIOChannel *io, void *user_data)
 {
 	GError *gerr = NULL;
 
-	if (bt_io_accept(io, connect_event, NULL, NULL, &gerr) == FALSE) {
+	if (bt_io_accept(io, connect_event, user_data, NULL, &gerr) == FALSE) {
 		error("bt_io_accept: %s", gerr->message);
 		g_error_free(gerr);
 		g_io_channel_unref(io);
@@ -824,7 +829,7 @@ int attrib_server_init(void)
 
 	/* BR/EDR socket */
 	l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
-					NULL, NULL, &gerr,
+					&l2cap_io, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
 					BT_IO_OPT_PSM, GATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
@@ -857,7 +862,7 @@ int attrib_server_init(void)
 
 	/* LE socket */
 	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
-					NULL, NULL, &gerr,
+					&le_io, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
 					BT_IO_OPT_CID, GATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-- 
1.7.1
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
