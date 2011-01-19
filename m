Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	johan.hedberg@nokia.com, padovan@profusion.mobi,
	rshaffer@codeaurora.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/3] Fix default GATT/ATT MTU sizes
Date: Wed, 19 Jan 2011 14:00:51 -0800
Message-Id: <1295474453-8495-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
References: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LE and BR/EDR (standard L2CAP) have different default MTU sizes.
The LE deafult is 23, and the L2CAP default is 48. The LE default is
properly used for all GATT Commands, as they have all been designed
to fit within that constraint. However the attribute server should
use the actual MTU of the transport being used.
---
 attrib/att.h        |    3 ++-
 attrib/gatt.c       |   28 ++++++++++++++--------------
 src/attrib-server.c |    6 +++++-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index a1e0b62..a4f6ab1 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -107,7 +107,8 @@
 
 
 #define ATT_MAX_MTU				256
-#define ATT_DEFAULT_MTU				23
+#define ATT_DEFAULT_LE_MTU			23
+#define ATT_DEFAULT_L2CAP_MTU			48
 
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
index 7e85d17..04bc1ec 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -722,8 +722,12 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
+	if (io == le_io)
+		channel->mtu = ATT_DEFAULT_LE_MTU;
+	else
+		channel->mtu = ATT_DEFAULT_L2CAP_MTU;
+
 	channel->attrib = g_attrib_new(io);
-	channel->mtu = ATT_DEFAULT_MTU;
 	g_io_channel_unref(io);
 
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
-- 
1.7.1

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
