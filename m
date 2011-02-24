Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Fix MTU value used on MTU exchange response
Date: Thu, 24 Feb 2011 17:37:34 -0400
Message-Id: <1298583454-18227-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new MTU value only should be applied in server side after sending
the ATT_MTU_RESP so encode the response using the old MTU value.
---
 src/attrib-server.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 62c10f4..9de4c81 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -773,9 +773,11 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 		uint8_t *pdu, int len)
 {
+	guint old_mtu = channel->mtu;
+
 	channel->mtu = MIN(mtu, channel->mtu);
 
-	return enc_mtu_resp(channel->mtu, pdu, len);
+	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
 static void channel_disconnect(void *user_data)
-- 
1.7.0.4

