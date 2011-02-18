Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	anderson.lizardo@openbossa.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/2] Fix bugs found at UPF38 - Las Vegas
Date: Fri, 18 Feb 2011 15:37:41 -0800
Message-Id: <1298072261-7232-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1298072261-7232-1-git-send-email-bgix@codeaurora.org>
References: <1298072261-7232-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example Included Service Attribute missing UUID16 field.
MTU Exchange not bounded by actual size required not to crash.
---
 attrib/example.c    |    3 ++-
 src/attrib-server.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index cd18168..395650a 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -124,7 +124,8 @@ static int register_attributes(void)
 	/* Thermometer: Include */
 	att_put_u16(0x0550, &atval[0]);
 	att_put_u16(0x0568, &atval[2]);
-	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 4);
+	att_put_u16(VENDOR_SPECIFIC_SVC_UUID, &atval[4]);
+	attrib_db_add(0x0202, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 6);
 
 	/* Thermometer: temperature characteristic */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
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
