Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ] Workaround for missing seclevel update on acceptor
Date: Tue, 20 Sep 2011 23:09:28 -0400
Message-Id: <1316574568-31707-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This workaround is only useful when testing GATT over BR/EDR. Without
this, you cannot write to attributes which require authentication.

Note: for LE, the seclevel is updated correctly after pairing, so
reading it with getsockopt() works fine.
---
 src/attrib-server.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5c86085..f79d4e8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -168,6 +168,14 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 	 * to authentication and medium to encryption permission. */
 	if (!channel->encrypted)
 		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
+
+	/* FIXME: on BR/EDR, the security level on acceptor side is not updated
+	 * when the link is encrypted. As a workaround, check if there are any
+	 * active linkkeys for the connection. */
+	if (!channel->encrypted && !channel->le && read_link_key(&channel->src,
+						&channel->dst, NULL, NULL) == 0)
+		channel->encrypted = TRUE;
+
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
 		return ATT_ECODE_AUTHENTICATION;
 	else if (reqs == ATT_AUTHORIZATION)
-- 
1.7.0.4

