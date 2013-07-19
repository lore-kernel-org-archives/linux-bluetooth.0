Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ 08/11] attrib: Add encode/decode prepare write support
Date: Fri, 19 Jul 2013 13:34:14 -0400
Message-Id: <1374255257-8753-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

Add functions for encoding/decoding Prepare Write Request PDUs.
---
 attrib/att.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h |    5 +++++
 2 files changed, 61 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index 20a299a..8fd5ab5 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -1024,6 +1024,62 @@ uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
 	return min_len;
 }
 
+uint16_t dec_prep_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
+				uint16_t *offset, uint8_t *value, size_t *vlen)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
+							sizeof(*offset);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (handle == NULL || offset == NULL || value == NULL || vlen == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_PREP_WRITE_REQ)
+		return 0;
+
+	*handle = att_get_u16(&pdu[1]);
+	*offset = att_get_u16(&pdu[3]);
+
+	*vlen = len - min_len;
+	if (*vlen > 0)
+		memcpy(value, pdu + min_len, *vlen);
+
+	return len;
+}
+
+uint16_t enc_prep_write_resp(uint16_t handle, uint16_t offset,
+					const uint8_t *value, size_t vlen,
+					uint8_t *pdu, size_t len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
+								sizeof(offset);
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
+	pdu[0] = ATT_OP_PREP_WRITE_RESP;
+	att_put_u16(handle, &pdu[1]);
+	att_put_u16(offset, &pdu[3]);
+
+	if (vlen > 0) {
+		memcpy(&pdu[5], value, vlen);
+		return min_len + vlen;
+	}
+
+	return min_len;
+}
+
 uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
 				uint16_t *offset, uint8_t *value, size_t *vlen)
 {
diff --git a/attrib/att.h b/attrib/att.h
index 7b585e3..cd102f9 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -272,6 +272,11 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, size_t len, uint16_t *mtu);
 uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t vlen,
 					uint8_t *pdu, size_t len);
+uint16_t dec_prep_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
+				uint16_t *offset, uint8_t *value, size_t *vlen);
+uint16_t enc_prep_write_resp(uint16_t handle, uint16_t offset,
+					const uint8_t *value, size_t vlen,
+					uint8_t *pdu, size_t len);
 uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
 						uint16_t *offset, uint8_t *value,
 						size_t *vlen);
-- 
1.7.9.5

