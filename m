Return-Path: <cyrus@holtmann.org>
From: Eder Ruiz Maria <eder.ruiz@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 1/3] att: Add prepare write support
Date: Fri, 27 Jul 2012 16:29:34 -0400
Message-Id: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add functions for encoding/decoding Prepare Write Request and
Response PDUs.
---
 attrib/att.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h |    5 +++++
 2 files changed, 60 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index 0550ac1..acfb4e0 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -974,3 +974,58 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu)
 
 	return min_len;
 }
+
+uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
+			const uint8_t *value, int vlen, uint8_t *pdu, int len)
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
+	pdu[0] = ATT_OP_PREP_WRITE_REQ;
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
+uint16_t dec_prep_write_resp(const uint8_t *pdu, int len, uint16_t *handle,
+				uint16_t *offset, uint8_t *value, int *vlen)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
+								sizeof(*offset);
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
+	*vlen = len - min_len;
+	if (*vlen > 0)
+		memcpy(value, pdu + min_len, *vlen);
+
+	return len;
+}
+
diff --git a/attrib/att.h b/attrib/att.h
index 1c1102a..ec03be9 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -256,3 +256,8 @@ uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, int len);
 uint16_t dec_mtu_req(const uint8_t *pdu, int len, uint16_t *mtu);
 uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, int len);
 uint16_t dec_mtu_resp(const uint8_t *pdu, int len, uint16_t *mtu);
+
+uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
+			const uint8_t *value, int vlen, uint8_t *pdu, int len);
+uint16_t dec_prep_write_resp(const uint8_t *pdu, int len, uint16_t *handle,
+				uint16_t *offset, uint8_t *value, int *vlen);
-- 
1.7.9.5

