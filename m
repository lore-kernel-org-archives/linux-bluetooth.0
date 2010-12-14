Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, rshaffer@codeaurora.org,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH] Added enc_read_blob_req() API to ATT transport, to enable the reading of attributes that exceed the length of the MTU.
Date: Tue, 14 Dec 2010 11:50:46 -0800
Message-Id: <1292356246-24012-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1292356246-24012-1-git-send-email-bgix@codeaurora.org>
References: <1292356246-24012-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

---
 attrib/att.c |   19 +++++++++++++++++++
 attrib/att.h |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 445b192..f8dbc02 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -542,6 +542,25 @@ uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
 	return min_len;
 }
 
+uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
+									int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
+							sizeof(offset);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_BLOB_REQ;
+	att_put_u16(handle, &pdu[1]);
+	att_put_u16(offset, &pdu[3]);
+
+	return min_len;
+}
+
 uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
diff --git a/attrib/att.h b/attrib/att.h
index 2c8c724..0b8612e 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -202,6 +202,8 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
 uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
+uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
+									int len);
 uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
-- 
1.7.1

