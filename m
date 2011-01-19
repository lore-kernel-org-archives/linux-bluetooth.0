Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	johan.hedberg@nokia.com, padovan@profusion.mobi,
	rshaffer@codeaurora.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 3/3] Add READ_BLOB_REQUEST support to attribute server
Date: Wed, 19 Jan 2011 14:00:53 -0800
Message-Id: <1295474453-8495-4-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
References: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c        |   44 ++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h        |    6 +++++-
 src/attrib-server.c |   39 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index f8dbc02..dff8597 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -582,6 +582,33 @@ uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
 	return min_len;
 }
 
+uint16_t dec_read_blob_req(const uint8_t *pdu, int len, uint16_t *handle,
+							uint16_t *offset)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
+							sizeof(*offset);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (handle == NULL)
+		return 0;
+
+	if (offset == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_READ_BLOB_REQ)
+		return 0;
+
+	*handle = att_get_u16(&pdu[1]);
+	*offset = att_get_u16(&pdu[3]);
+
+	return min_len;
+}
+
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len)
 {
 	if (pdu == NULL)
@@ -600,6 +627,23 @@ uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len)
 	return vlen + 1;
 }
 
+uint16_t enc_read_blob_resp(uint8_t *value, int vlen, uint16_t offset,
+							uint8_t *pdu, int len)
+{
+	if (pdu == NULL)
+		return 0;
+
+	vlen -= offset;
+	if (vlen > len - 1)
+		vlen = len - 1;
+
+	pdu[0] = ATT_OP_READ_BLOB_RESP;
+
+	memcpy(pdu + 1, &value[offset], vlen);
+
+	return vlen + 1;
+}
+
 uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen)
 {
 	if (pdu == NULL)
diff --git a/attrib/att.h b/attrib/att.h
index a4f6ab1..8803ae3 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -217,9 +217,13 @@ uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
 uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
-									int len);
+								int len);
 uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
+uint16_t dec_read_blob_req(const uint8_t *pdu, int len, uint16_t *handle,
+							uint16_t *offset);
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
+uint16_t enc_read_blob_resp(uint8_t *value, int vlen, uint16_t offset,
+							uint8_t *pdu, int len);
 uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 							uint8_t *pdu, int len);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index f38d61a..631b43e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -546,6 +546,33 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	return enc_read_resp(a->data, a->len, pdu, len);
 }
 
+static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
+					uint16_t offset, uint8_t *pdu, int len)
+{
+	struct attribute *a;
+	uint8_t status;
+	GSList *l;
+	guint h = handle;
+
+	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
+	if (!l)
+		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
+					ATT_ECODE_INVALID_HANDLE, pdu, len);
+
+	a = l->data;
+
+	if (a->len <= offset)
+		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
+					ATT_ECODE_INVALID_OFFSET, pdu, len);
+
+	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
+	if (status)
+		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle, status,
+								pdu, len);
+
+	return enc_read_blob_resp(a->data, a->len, offset, pdu, len);
+}
+
 static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 						const uint8_t *value, int vlen,
 						uint8_t *pdu, int len)
@@ -599,7 +626,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 {
 	struct gatt_channel *channel = user_data;
 	uint8_t opdu[ATT_MAX_MTU], value[ATT_MAX_MTU];
-	uint16_t length, start, end, mtu;
+	uint16_t length, start, end, mtu, offset;
 	uuid_t uuid;
 	uint8_t status = 0;
 	int vlen;
@@ -634,6 +661,15 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 
 		length = read_value(channel, start, opdu, channel->mtu);
 		break;
+	case ATT_OP_READ_BLOB_REQ:
+		length = dec_read_blob_req(ipdu, len, &start, &offset);
+		if (length == 0) {
+			status = ATT_ECODE_INVALID_PDU;
+			goto done;
+		}
+
+		length = read_blob(channel, start, offset, opdu, channel->mtu);
+		break;
 	case ATT_OP_MTU_REQ:
 		length = dec_mtu_req(ipdu, len, &mtu);
 		if (length == 0) {
@@ -679,7 +715,6 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		length = find_by_type(start, end, &uuid, value, vlen,
 							opdu, channel->mtu);
 		break;
-	case ATT_OP_READ_BLOB_REQ:
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
-- 
1.7.1

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
