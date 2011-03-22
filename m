Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Fix ATT error code response for authentication
Date: Tue, 22 Mar 2011 17:51:21 -0300
Message-Id: <1300827081-31136-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix the error code in the Error Response PDU. If an attribute
requires authentication and the link security level doesn't meet the
requirements the server should reply Insufficient Authentication(0x05).
---
 src/attrib-server.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 74a1c8d..9543da6 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -167,11 +167,12 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 {
 	/* FIXME: currently, it is assumed an encrypted link is enough for
 	 * authentication. This will allow to enable the SMP negotiation once
-	 * it is on upstream kernel. */
+	 * it is on upstream kernel. High security level should be mapped
+	 * to authentication and medium to encryption permission. */
 	if (!channel->encrypted)
 		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
-		return ATT_ECODE_INSUFF_ENC;
+		return ATT_ECODE_INSUFF_AUTHEN;
 
 	switch (opcode) {
 	case ATT_OP_READ_BY_GROUP_REQ:
-- 
1.7.4.1

