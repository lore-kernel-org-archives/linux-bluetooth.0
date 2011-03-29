Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove "authen" and "autho" short versions for ATT constants
Date: Tue, 29 Mar 2011 16:08:35 -0300
Message-Id: <1301425715-12535-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c        |    4 ++--
 attrib/att.h        |    4 ++--
 src/attrib-server.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 08000e0..972f8bf 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -44,13 +44,13 @@ const char *att_ecode2str(uint8_t status)
 		return "Attribute can't be written";
 	case ATT_ECODE_INVALID_PDU:
 		return "Attribute PDU was invalid";
-	case ATT_ECODE_INSUFF_AUTHEN:
+	case ATT_ECODE_AUTHENTICATION:
 		return "Attribute requires authentication before read/write";
 	case ATT_ECODE_REQ_NOT_SUPP:
 		return "Server doesn't support the request received";
 	case ATT_ECODE_INVALID_OFFSET:
 		return "Offset past the end of the attribute";
-	case ATT_ECODE_INSUFF_AUTHO:
+	case ATT_ECODE_AUTHORIZATION:
 		return "Attribute requires authorization before read/write";
 	case ATT_ECODE_PREP_QUEUE_FULL:
 		return "Too many prepare writes have been queued";
diff --git a/attrib/att.h b/attrib/att.h
index 7a83bfa..93b58dc 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -79,10 +79,10 @@
 #define ATT_ECODE_READ_NOT_PERM			0x02
 #define ATT_ECODE_WRITE_NOT_PERM		0x03
 #define ATT_ECODE_INVALID_PDU			0x04
-#define ATT_ECODE_INSUFF_AUTHEN			0x05
+#define ATT_ECODE_AUTHENTICATION		0x05
 #define ATT_ECODE_REQ_NOT_SUPP			0x06
 #define ATT_ECODE_INVALID_OFFSET		0x07
-#define ATT_ECODE_INSUFF_AUTHO			0x08
+#define ATT_ECODE_AUTHORIZATION			0x08
 #define ATT_ECODE_PREP_QUEUE_FULL		0x09
 #define ATT_ECODE_ATTR_NOT_FOUND		0x0A
 #define ATT_ECODE_ATTR_NOT_LONG			0x0B
diff --git a/src/attrib-server.c b/src/attrib-server.c
index c96351a..03c3501 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -172,9 +172,9 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 	if (!channel->encrypted)
 		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
-		return ATT_ECODE_INSUFF_AUTHEN;
+		return ATT_ECODE_AUTHENTICATION;
 	else if (reqs == ATT_AUTHORIZATION)
-		return ATT_ECODE_INSUFF_AUTHO;
+		return ATT_ECODE_AUTHORIZATION;
 
 	switch (opcode) {
 	case ATT_OP_READ_BY_GROUP_REQ:
-- 
1.7.4.1

