Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 10/10] attrib-server: Fix MTU for GATT
Date: Wed, 20 Jun 2012 14:27:52 -0300
Message-Id: <1340213272-2853-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the size of the input and output buffers to the same size of
the channel MTU. The channel MTU, in turn, is the L2CAP MTU for BR/EDR
channels, and the ATT MTU for LE channels. This value can change between calls
to channel_handler if a GATT MTU exchange procedure is performed, which is only
supported by LE channels.
---
 src/attrib-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5adbf92..9064d15 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -910,7 +910,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 							gpointer user_data)
 {
 	struct gatt_channel *channel = user_data;
-	uint8_t opdu[ATT_MAX_MTU], value[ATT_MAX_MTU];
+	uint8_t opdu[channel->mtu], value[ATT_MAX_MTU];
 	uint16_t length, start, end, mtu, offset;
 	bt_uuid_t uuid;
 	uint8_t status = 0;
-- 
1.7.8.6

