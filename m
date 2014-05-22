Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 02/12] attrib: Add helpers to enc and dec signed write command
Date: Thu, 22 May 2014 21:06:16 +0200
Message-Id: <1400785586-22710-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h | 11 +++++++++++
 2 files changed, 66 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index 8e9c06d..e7d5682 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -561,6 +561,61 @@ uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
 	return len;
 }
 
+uint16_t enc_signed_write_cmd(uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					const uint8_t signature[12],
+					uint8_t *pdu, size_t len)
+{
+	const uint16_t hdr_len = sizeof(pdu[0]) + sizeof(handle);
+	const uint16_t min_len =  hdr_len + ATT_SIGNATURE_LEN;
+
+	if (pdu == NULL)
+		return 0;
+
+	if (vlen > len - min_len)
+		vlen = len - min_len;
+
+	pdu[0] = ATT_OP_SIGNED_WRITE_CMD;
+	put_le16(handle, &pdu[1]);
+
+	if (vlen > 0)
+		memcpy(&pdu[hdr_len], value, vlen);
+
+	memcpy(&pdu[hdr_len + vlen], signature, ATT_SIGNATURE_LEN);
+
+	return min_len + vlen;
+}
+
+uint16_t dec_signed_write_cmd(const uint8_t *pdu, size_t len,
+						uint16_t *handle,
+						uint8_t *value, size_t *vlen,
+						uint8_t signature[12])
+{
+	const uint16_t hdr_len = sizeof(pdu[0]) + sizeof(*handle);
+	const uint16_t min_len =  hdr_len + ATT_SIGNATURE_LEN;
+
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
+	if (pdu[0] != ATT_OP_SIGNED_WRITE_CMD)
+		return 0;
+
+	*vlen = len - min_len;
+	*handle = get_le16(&pdu[1]);
+	memcpy(value, pdu + hdr_len, *vlen);
+
+	memcpy(signature, pdu + hdr_len + *vlen, ATT_SIGNATURE_LEN);
+
+	return len;
+}
+
 uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
 						uint8_t *pdu, size_t len)
 {
diff --git a/attrib/att.h b/attrib/att.h
index c612d80..068ddf8 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -22,6 +22,9 @@
  *
  */
 
+/* Len of signature in write signed packet */
+#define ATT_SIGNATURE_LEN		12
+
 /* Attribute Protocol Opcodes */
 #define ATT_OP_ERROR			0x01
 #define ATT_OP_MTU_REQ			0x02
@@ -129,6 +132,14 @@ uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, size_t vlen,
 						uint8_t *pdu, size_t len);
 uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
 						uint8_t *value, size_t *vlen);
+uint16_t enc_signed_write_cmd(uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					const uint8_t signature[12],
+					uint8_t *pdu, size_t len);
+uint16_t dec_signed_write_cmd(const uint8_t *pdu, size_t len,
+						uint16_t *handle,
+						uint8_t *value, size_t *vlen,
+						uint8_t signature[12]);
 struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, size_t len);
 uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
 						uint8_t *pdu, size_t len);
-- 
1.8.4

