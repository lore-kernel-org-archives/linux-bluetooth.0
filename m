Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/6] Implement Find by Type request encode/decoding
Date: Wed, 17 Nov 2010 16:09:41 -0200
Message-Id: <1290017386-23969-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 attrib/att.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 attrib/att.h |    4 ++-
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index fe41d0e..6c889f2 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -198,9 +198,77 @@ struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len)
 }
 
 uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len)
+			const uint8_t *value, int vlen, uint8_t *pdu, int len)
+{
+	uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end) +
+							sizeof(uint16_t);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (!uuid)
+		return 0;
+
+	if (uuid->type != SDP_UUID16)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (vlen > len - min_len)
+		vlen = len - min_len;
+
+	pdu[0] = ATT_OP_FIND_BY_TYPE_REQ;
+	att_put_u16(start, &pdu[1]);
+	att_put_u16(end, &pdu[3]);
+	att_put_u16(uuid->value.uuid16, &pdu[5]);
+
+	if (vlen > 0) {
+		memcpy(&pdu[7], value, vlen);
+		return min_len + vlen;
+	}
+
+	return min_len;
+}
+
+uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
+			uint16_t *end, uuid_t *uuid, uint8_t *value, int *vlen)
 {
-	return 0;
+	int valuelen;
+	uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) +
+						sizeof(*end) + sizeof(uint16_t);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_FIND_BY_TYPE_REQ)
+		return 0;
+
+	/* First requested handle number */
+	if (start)
+		*start = att_get_u16(&pdu[1]);
+
+	/* Last requested handle number */
+	if (end)
+		*end = att_get_u16(&pdu[3]);
+
+	/* Always UUID16 */
+	if (uuid)
+		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
+
+	valuelen = len - min_len;
+
+	/* Attribute value to find */
+	if (valuelen > 0 && value)
+		memcpy(value, pdu + min_len, valuelen);
+
+	if (vlen)
+		*vlen = valuelen;
+
+	return len;
 }
 
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
diff --git a/attrib/att.h b/attrib/att.h
index ea49dc2..9de338d 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -165,7 +165,9 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
 						uint16_t *end, uuid_t *uuid);
 uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu, int len);
 uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
-							uint8_t *pdu, int len);
+			const uint8_t *value, int vlen, uint8_t *pdu, int len);
+uint16_t dec_find_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
+		uint16_t *end, uuid_t *uuid, uint8_t *value, int *vlen);
 struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, int len);
 uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len);
-- 
1.7.3.2

