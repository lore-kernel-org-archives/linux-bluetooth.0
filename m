Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 05/22] monitor/avdtp: Decode AVDTP_SET_CONFIGURATION
Date: Sun, 22 Nov 2015 21:20:17 +0100
Message-Id: <1448223634-23305-6-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 18
      Channel: 258 len 14 [PSM 25 mode 0] {chan 2}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
        ACP SEID: 1
        INT SEID: 3
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
        00 00 21 15 02 35                                ..!..5
> ACL Data RX: Handle 256 flags 0x02 dlen 6
      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 5 nosp 0
---
 monitor/avdtp.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 065e79a..3e71384 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -300,6 +300,41 @@ static bool avdtp_get_capabilities(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_set_configuration(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t type = avdtp_frame->hdr & 0x03;
+	uint8_t acp_seid, int_seid;
+	uint8_t service_cat;
+
+	switch (type) {
+	case AVDTP_MSG_TYPE_COMMAND:
+		if (!l2cap_frame_get_u8(frame, &acp_seid))
+			return false;
+
+		print_field("ACP SEID: %d", acp_seid >> 2);
+
+		if (!l2cap_frame_get_u8(frame, &int_seid))
+			return false;
+
+		print_field("INT SEID: %d", int_seid >> 2);
+
+		return decode_capabilities(avdtp_frame);
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_REJECT:
+		if (!l2cap_frame_get_u8(frame, &service_cat))
+			return false;
+
+		print_field("Service Category: %s (0x%02x)",
+				servicecat2str(service_cat), service_cat);
+
+		return avdtp_reject_common(avdtp_frame);
+	}
+
+	return false;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -359,6 +394,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return avdtp_discover(avdtp_frame);
 	case AVDTP_GET_CAPABILITIES:
 		return avdtp_get_capabilities(avdtp_frame);
+	case AVDTP_SET_CONFIGURATION:
+		return avdtp_set_configuration(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

