Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 06/22] monitor/avdtp: Decode AVDTP_GET_CONFIGURATION
Date: Sat, 14 Nov 2015 14:44:23 +0100
Message-Id: <1447508679-21798-7-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index f38d359..89c5eb7 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -341,6 +341,31 @@ response:
 	return true;
 }
 
+static bool avdtp_get_configuration(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t seid;
+
+	if (avdtp_frame->hdr & 0x01)
+		goto reject;
+
+	if (avdtp_frame->hdr & 0x02)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &seid))
+		return false;
+
+	print_field("ACP SEID: %d", seid >> 2);
+
+	return decode_capabilities(avdtp_frame);
+
+reject:
+	return avdtp_reject_common(avdtp_frame);
+
+response:
+	return decode_capabilities(avdtp_frame);
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -404,6 +429,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_SET_CONFIGURATION:
 		ret = avdtp_set_configuration(avdtp_frame);
 		break;
+	case AVDTP_GET_CONFIGURATION:
+		ret = avdtp_get_configuration(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

