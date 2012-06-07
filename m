Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/8] attrib-server: Update GAttrib buffer after Exchange MTU
Date: Wed,  6 Jun 2012 21:41:00 -0300
Message-Id: <1339029663-25654-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should update the GAttrib buffer length after exchanging ATT_MTU.
---
 src/attrib-server.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3954f99..5adbf92 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -886,6 +886,7 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 					ATT_ECODE_UNLIKELY, pdu, len);
 
 	channel->mtu = MIN(mtu, imtu);
+	g_attrib_set_mtu(channel->attrib, channel->mtu);
 
 	return enc_mtu_resp(imtu, pdu, len);
 }
-- 
1.7.10.3

