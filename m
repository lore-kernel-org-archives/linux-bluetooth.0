Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 4/4] Modify dec_read_req() to get PDU length as parameter
Date: Mon,  4 Oct 2010 15:13:04 -0400
Message-Id: <1286219584-8199-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1286219584-8199-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1286219584-8199-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is consistent with other att.h functions, and allows length checks.
---
 attrib/att.c        |    5 ++++-
 attrib/att.h        |    2 +-
 src/attrib-server.c |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index b18e1d6..2ffa8ce 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -379,7 +379,7 @@ uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
 	return min_len;
 }
 
-uint16_t dec_read_req(const uint8_t *pdu, uint16_t *handle)
+uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
 
@@ -389,6 +389,9 @@ uint16_t dec_read_req(const uint8_t *pdu, uint16_t *handle)
 	if (handle == NULL)
 		return 0;
 
+	if (len < min_len)
+		return 0;
+
 	if (pdu[0] != ATT_OP_READ_REQ)
 		return 0;
 
diff --git a/attrib/att.h b/attrib/att.h
index 3f1e239..e63c58e 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -179,7 +179,7 @@ uint16_t dec_write_cmd(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen);
 struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, int len);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
-uint16_t dec_read_req(const uint8_t *pdu, uint16_t *handle);
+uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 475b68b..b45f300 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -478,7 +478,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		length = read_by_type(start, end, &uuid, opdu, channel->mtu);
 		break;
 	case ATT_OP_READ_REQ:
-		length = dec_read_req(ipdu, &start);
+		length = dec_read_req(ipdu, len, &start);
 		if (length == 0) {
 			status = ATT_ECODE_INVALID_PDU;
 			goto done;
-- 
1.7.0.4

