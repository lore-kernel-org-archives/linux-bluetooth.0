Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 14/22] monitor/avdtp: Decode AVDTP_GET_ALL_CAPABILITIES
Date: Sun, 22 Nov 2015 21:20:26 +0100
Message-Id: <1448223634-23305-15-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 7
      Channel: 832 len 3 [PSM 25 mode 0] {chan 0}
      AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 1 nosp 0
        ACP SEID: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 20
      Channel: 64 len 16 [PSM 25 mode 0] {chan 0}
      AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 1 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
        00 00 3f ff 02 35                                ..?..5
        Service Category: Content Protection (0x04)
        02 00                                            ..
---
 monitor/avdtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 28ddb20..4867c0b 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -602,6 +602,7 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_DISCOVER:
 		return avdtp_discover(avdtp_frame);
 	case AVDTP_GET_CAPABILITIES:
+	case AVDTP_GET_ALL_CAPABILITIES:
 		return avdtp_get_capabilities(avdtp_frame);
 	case AVDTP_SET_CONFIGURATION:
 		return avdtp_set_configuration(avdtp_frame);
-- 
2.6.2

