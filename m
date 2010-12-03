Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/3] Check attribute permissions in attribute server
Date: Fri,  3 Dec 2010 14:26:21 -0400
Message-Id: <1291400782-24736-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1291400782-24736-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1291400782-24736-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The attribute server must verify if the operation (read/write) is
permitted before running the request, and send "Read Not Permitted" or
"Write Not Permitted" error response to client if appropriate.
---
 TODO                |    7 -----
 src/attrib-server.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/TODO b/TODO
index 49a9e76..32d3a61 100644
--- a/TODO
+++ b/TODO
@@ -136,13 +136,6 @@ ATT/GATT
   Priority: Low
   Complexity: C2
 
-- Attribute server shall implement attribute permission verification,
-  returning an error code if necessary. See Volume 3, Part F, 3.2.5
-  for more information.
-
-  Priority: Low
-  Complexity: C2
-
 - Implement Client Characteristic Configuration support in the attribute
   server to manage indications and notications. This is a per client attribute
   to control how the client wants to receive reports of changes in a given
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 410ac98..2ba21e9 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -138,6 +138,28 @@ static sdp_record_t *server_record_new(void)
 	return record;
 }
 
+static uint8_t att_check_reqs(uint8_t opcode, int reqs)
+{
+	switch (opcode) {
+	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_READ_MULTI_REQ:
+		if (reqs == ATT_NOT_PERMITTED)
+			return ATT_ECODE_READ_NOT_PERM;
+		break;
+	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_WRITE_REQ:
+	case ATT_OP_WRITE_CMD:
+		if (reqs == ATT_NOT_PERMITTED)
+			return ATT_ECODE_WRITE_NOT_PERM;
+		break;
+	}
+
+	return 0;
+}
+
 static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
@@ -146,6 +168,7 @@ static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
 	struct group_elem *cur, *old = NULL;
 	GSList *l, *groups;
 	uint16_t length, last_handle, last_size = 0;
+	uint8_t status;
 	int i;
 
 	if (start > end || start == 0x0000)
@@ -189,6 +212,14 @@ static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
 		if (last_size && (last_size != a->len))
 			break;
 
+		status = att_check_reqs(ATT_OP_READ_BY_GROUP_REQ, a->read_reqs);
+		if (status) {
+			g_slist_foreach(groups, (GFunc) g_free, NULL);
+			g_slist_free(groups);
+			return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ,
+						a->handle, status, pdu, len);
+		}
+
 		cur = g_new0(struct group_elem, 1);
 		cur->handle = a->handle;
 		cur->data = a->data;
@@ -247,6 +278,7 @@ static uint16_t read_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 	GSList *l, *types;
 	struct attribute *a;
 	uint16_t num, length;
+	uint8_t status;
 	int i;
 
 	if (start > end || start == 0x0000)
@@ -265,6 +297,13 @@ static uint16_t read_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 		if (sdp_uuid_cmp(&a->uuid, uuid)  != 0)
 			continue;
 
+		status = att_check_reqs(ATT_OP_READ_BY_TYPE_REQ, a->read_reqs);
+		if (status) {
+			g_slist_free(types);
+			return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ,
+						a->handle, status, pdu, len);
+		}
+
 		/* All elements must have the same length */
 		if (length == 0)
 			length = a->len;
@@ -472,6 +511,7 @@ static int attribute_cmp(gconstpointer a1, gconstpointer a2)
 static uint16_t read_value(uint16_t handle, uint8_t *pdu, int len)
 {
 	struct attribute *a;
+	uint8_t status;
 	GSList *l;
 	guint h = handle;
 
@@ -482,23 +522,41 @@ static uint16_t read_value(uint16_t handle, uint8_t *pdu, int len)
 
 	a = l->data;
 
+	status = att_check_reqs(ATT_OP_READ_REQ, a->read_reqs);
+	if (status)
+		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
+									len);
+
 	return enc_read_resp(a->data, a->len, pdu, len);
 }
 
-static void write_value(uint16_t handle, const uint8_t *value, int vlen)
+static uint16_t write_value(uint16_t handle, const uint8_t *value, int vlen,
+							uint8_t *pdu, int len)
 {
 	struct attribute *a;
+	uint8_t status;
 	GSList *l;
 	guint h = handle;
 	uuid_t uuid;
 
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
-		return;
+		return enc_error_resp(ATT_OP_WRITE_REQ, handle,
+				ATT_ECODE_INVALID_HANDLE, pdu, len);
 
 	a = l->data;
+
+	status = att_check_reqs(ATT_OP_WRITE_REQ, a->write_reqs);
+	if (status)
+		return enc_error_resp(ATT_OP_WRITE_REQ, handle, status, pdu,
+									len);
+
 	memcpy(&uuid, &a->uuid, sizeof(uuid_t));
 	attrib_db_update(handle, &uuid, value, vlen);
+
+	pdu[0] = ATT_OP_WRITE_RESP;
+
+	return sizeof(pdu[0]);
 }
 
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
@@ -582,14 +640,12 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			goto done;
 		}
 
-		write_value(start, value, vlen);
-		opdu[0] = ATT_OP_WRITE_RESP;
-		length = sizeof(opdu[0]);
+		length = write_value(start, value, vlen, opdu, channel->mtu);
 		break;
 	case ATT_OP_WRITE_CMD:
 		length = dec_write_cmd(ipdu, len, &start, value, &vlen);
 		if (length > 0)
-			write_value(start, value, vlen);
+			write_value(start, value, vlen, opdu, channel->mtu);
 		return;
 	case ATT_OP_FIND_BY_TYPE_REQ:
 		length = dec_find_by_type_req(ipdu, len, &start, &end,
-- 
1.7.0.4

