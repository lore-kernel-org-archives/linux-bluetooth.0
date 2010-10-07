Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Add support for Attribute Write Request
Date: Thu,  7 Oct 2010 14:02:41 -0400
Message-Id: <1286474561-23905-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement encoders/decoders for Write Request/Response and the handling
on attribute server. The attribute client still uses the Write Command
because currently SetProperty() has no means to wait for the server
response.
---
 attrib/att.c        |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h        |    4 ++++
 attrib/gatt.c       |   11 +++++++++++
 attrib/gatt.h       |    3 +++
 src/attrib-server.c |   12 +++++++++++-
 5 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 2ffa8ce..fe41d0e 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -363,6 +363,56 @@ uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
 	return len;
 }
 
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
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
diff --git a/attrib/att.h b/attrib/att.h
index 3913f47..ea49dc2 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -178,6 +178,10 @@ uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, int vlen,
 uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen);
 struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len);
+uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
+							uint8_t *pdu, int len);
+uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
+						uint8_t *value, int *vlen);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
 uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index e8171a9..24ec990 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -76,6 +76,17 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							user_data, NULL);
 }
 
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
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index c99b946..a357f58 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -31,6 +31,9 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 							gpointer user_data);
 
+guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+			int vlen, GAttribResultFunc func, gpointer user_data);
+
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index b45f300..666b5fa 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -504,6 +504,17 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 
 		length = find_info(start, end, opdu, channel->mtu);
 		break;
+	case ATT_OP_WRITE_REQ:
+		length = dec_write_req(ipdu, len, &start, value, &vlen);
+		if (length == 0) {
+			status = ATT_ECODE_INVALID_PDU;
+			goto done;
+		}
+
+		write_value(start, value, vlen);
+		opdu[0] = ATT_OP_WRITE_RESP;
+		length = sizeof(opdu[0]);
+		break;
 	case ATT_OP_WRITE_CMD:
 		length = dec_write_cmd(ipdu, len, &start, value, &vlen);
 		if (length > 0)
@@ -512,7 +523,6 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	case ATT_OP_FIND_BY_TYPE_REQ:
 	case ATT_OP_READ_BLOB_REQ:
 	case ATT_OP_READ_MULTI_REQ:
-	case ATT_OP_WRITE_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
 	default:
-- 
1.7.0.4

