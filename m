Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Return an error if the attribute requires authorization
Date: Wed, 23 Mar 2011 16:40:11 -0300
Message-Id: <1300909212-15709-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If an attribute requires authorization, Insuficient Authorization
will be returned by the attribute server until the Agent supports
a method to authorize attribute access.
---
 src/attrib-server.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 9543da6..dc05d7e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -173,6 +173,8 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
 		return ATT_ECODE_INSUFF_AUTHEN;
+	else if (reqs == ATT_AUTHORIZATION)
+		return ATT_ECODE_INSUFF_AUTHO;
 
 	switch (opcode) {
 	case ATT_OP_READ_BY_GROUP_REQ:
-- 
1.7.4.1

