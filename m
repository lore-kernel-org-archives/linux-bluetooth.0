Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/2] Fix Crash where MTU allowed to be set too large
Date: Sat, 19 Feb 2011 12:45:43 -0800
Message-Id: <1298148343-10535-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1298148343-10535-1-git-send-email-bgix@codeaurora.org>
References: <1298148343-10535-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As previously written, a remote device could request, and we would
accept an MTU larger than what we could support.
---
 src/attrib-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 6966ad0..4285f6e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -639,7 +639,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 		uint8_t *pdu, int len)
 {
-	channel->mtu = MIN(mtu, ATT_MAX_MTU);
+	channel->mtu = MIN(mtu, channel->mtu);
 
 	return enc_mtu_resp(channel->mtu, pdu, len);
 }
-- 
1.7.1
--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
