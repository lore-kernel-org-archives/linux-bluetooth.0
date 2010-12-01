Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/3] Check authentication permissions on attribute server
Date: Wed,  1 Dec 2010 12:13:06 -0400
Message-Id: <1291219986-29913-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attributes may require encryption for certain operations. This commit
adds checks to the attribute server which verify whether the current
connection is encrypted (currently done by checking the security level,
but may be changed later) and the attribute being accessed requires
authentication. If encryption requirements are not satisfied, the
"Insufficient Encryption" error is returned by the server.
---
 src/attrib-server.c |   76 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 32357f0..fee5462 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -57,6 +57,7 @@ struct gatt_channel {
 	GAttrib *attrib;
 	guint mtu;
 	guint id;
+	uint8_t perms;
 };
 
 struct group_elem {
@@ -138,8 +139,11 @@ static sdp_record_t *server_record_new(void)
 	return record;
 }
 
-static uint8_t att_check_perms(uint8_t opcode, uint8_t perms)
+static uint8_t att_check_perms(struct gatt_channel *channel, uint8_t opcode,
+								uint8_t perms)
 {
+	uint8_t chp = channel->perms;
+
 	switch (opcode) {
 	case ATT_OP_READ_BY_GROUP_REQ:
 	case ATT_OP_READ_BY_TYPE_REQ:
@@ -148,20 +152,41 @@ static uint8_t att_check_perms(uint8_t opcode, uint8_t perms)
 	case ATT_OP_READ_MULTI_REQ:
 		if (!(perms & ATT_ACCESS(ATT_READ, ATT_NONE)))
 			return ATT_ECODE_READ_NOT_PERM;
+
+		if ((perms & ATT_ACCESS(ATT_READ, ATT_AUTHENTICATION)) !=
+				ATT_ACCESS(ATT_READ, ATT_AUTHENTICATION))
+			/* Attribute does not require authentication for read */
+			return 0;
+
+		if ((chp & ATT_ACCESS(ATT_READ, ATT_AUTHENTICATION)) !=
+				ATT_ACCESS(ATT_READ, ATT_AUTHENTICATION))
+			/* Connection is not encrypted */
+			return ATT_ECODE_INSUFF_AUTHEN;
 		break;
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_WRITE_REQ:
 	case ATT_OP_WRITE_CMD:
 		if (!(perms & ATT_ACCESS(ATT_WRITE, ATT_NONE)))
 			return ATT_ECODE_WRITE_NOT_PERM;
+
+		if ((perms & ATT_ACCESS(ATT_WRITE, ATT_AUTHENTICATION)) !=
+				ATT_ACCESS(ATT_WRITE, ATT_AUTHENTICATION))
+			/* Attribute does not require authentication for write */
+			return 0;
+
+		if ((chp & ATT_ACCESS(ATT_WRITE, ATT_AUTHENTICATION)) !=
+				ATT_ACCESS(ATT_WRITE, ATT_AUTHENTICATION))
+			/* Connection is not encrypted */
+			return ATT_ECODE_INSUFF_AUTHEN;
 		break;
 	}
 
 	return 0;
 }
 
-static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len)
+static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
+						uint16_t end, uuid_t *uuid,
+						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
 	struct attribute *a;
@@ -212,7 +237,8 @@ static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
 		if (last_size && (last_size != a->len))
 			break;
 
-		status = att_check_perms(ATT_OP_READ_BY_GROUP_REQ, a->perms);
+		status = att_check_perms(channel, ATT_OP_READ_BY_GROUP_REQ,
+								a->perms);
 		if (status) {
 			g_slist_foreach(groups, (GFunc) g_free, NULL);
 			g_slist_free(groups);
@@ -271,8 +297,9 @@ static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
 	return length;
 }
 
-static uint16_t read_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len)
+static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
+						uint16_t end, uuid_t *uuid,
+						uint8_t *pdu, int len)
 {
 	struct att_data_list *adl;
 	GSList *l, *types;
@@ -297,7 +324,8 @@ static uint16_t read_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 		if (sdp_uuid_cmp(&a->uuid, uuid)  != 0)
 			continue;
 
-		status = att_check_perms(ATT_OP_READ_BY_TYPE_REQ, a->perms);
+		status = att_check_perms(channel, ATT_OP_READ_BY_TYPE_REQ,
+								a->perms);
 		if (status) {
 			g_slist_free(types);
 			return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ,
@@ -508,7 +536,8 @@ static int attribute_cmp(gconstpointer a1, gconstpointer a2)
 	return attrib1->handle - attrib2->handle;
 }
 
-static uint16_t read_value(uint16_t handle, uint8_t *pdu, int len)
+static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
+							uint8_t *pdu, int len)
 {
 	struct attribute *a;
 	uint8_t status;
@@ -522,7 +551,7 @@ static uint16_t read_value(uint16_t handle, uint8_t *pdu, int len)
 
 	a = l->data;
 
-	status = att_check_perms(ATT_OP_READ_REQ, a->perms);
+	status = att_check_perms(channel, ATT_OP_READ_REQ, a->perms);
 	if (status)
 		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
 									len);
@@ -530,8 +559,9 @@ static uint16_t read_value(uint16_t handle, uint8_t *pdu, int len)
 	return enc_read_resp(a->data, a->len, pdu, len);
 }
 
-static uint16_t write_value(uint16_t handle, const uint8_t *value, int vlen,
-							uint8_t *pdu, int len)
+static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
+						const uint8_t *value, int vlen,
+						uint8_t *pdu, int len)
 {
 	struct attribute *a;
 	uint8_t status;
@@ -546,7 +576,7 @@ static uint16_t write_value(uint16_t handle, const uint8_t *value, int vlen,
 
 	a = l->data;
 
-	status = att_check_perms(ATT_OP_WRITE_REQ, a->perms);
+	status = att_check_perms(channel, ATT_OP_WRITE_REQ, a->perms);
 	if (status)
 		return enc_error_resp(ATT_OP_WRITE_REQ, handle, status, pdu,
 									len);
@@ -595,7 +625,8 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = read_by_group(start, end, &uuid, opdu, channel->mtu);
+		length = read_by_group(channel, start, end, &uuid, opdu,
+								channel->mtu);
 		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
 		length = dec_read_by_type_req(ipdu, len, &start, &end, &uuid);
@@ -604,7 +635,8 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = read_by_type(start, end, &uuid, opdu, channel->mtu);
+		length = read_by_type(channel, start, end, &uuid, opdu,
+								channel->mtu);
 		break;
 	case ATT_OP_READ_REQ:
 		length = dec_read_req(ipdu, len, &start);
@@ -613,7 +645,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = read_value(start, opdu, channel->mtu);
+		length = read_value(channel, start, opdu, channel->mtu);
 		break;
 	case ATT_OP_MTU_REQ:
 		length = dec_mtu_req(ipdu, len, &mtu);
@@ -640,12 +672,14 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		length = write_value(start, value, vlen, opdu, channel->mtu);
+		length = write_value(channel, start, value, vlen, opdu,
+								channel->mtu);
 		break;
 	case ATT_OP_WRITE_CMD:
 		length = dec_write_cmd(ipdu, len, &start, value, &vlen);
 		if (length > 0)
-			write_value(start, value, vlen, opdu, channel->mtu);
+			write_value(channel, start, value, vlen, opdu,
+								channel->mtu);
 		return;
 	case ATT_OP_FIND_BY_TYPE_REQ:
 		length = dec_find_by_type_req(ipdu, len, &start, &end,
@@ -682,6 +716,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 {
 	struct gatt_channel *channel;
 	GError *gerr = NULL;
+	int sec_level;
 
 	if (err) {
 		error("%s", err->message);
@@ -693,6 +728,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	bt_io_get(io, BT_IO_L2CAP, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &channel->src,
 			BT_IO_OPT_DEST_BDADDR, &channel->dst,
+			BT_IO_OPT_SEC_LEVEL, &sec_level,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -705,6 +741,12 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 	channel->attrib = g_attrib_new(io);
 	channel->mtu = ATT_DEFAULT_MTU;
 
+	if (sec_level > BT_IO_SEC_LOW)
+		channel->perms = ATT_ACCESS(ATT_READ | ATT_WRITE,
+							ATT_AUTHENTICATION);
+	else
+		channel->perms = ATT_ACCESS(ATT_READ | ATT_WRITE, ATT_NONE);
+
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
 				channel_handler, channel, NULL);
 
-- 
1.7.0.4

