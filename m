Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 07/22] monitor/avdtp: Decode AVDTP_RECONFIGURE
Date: Sat, 14 Nov 2015 14:44:24 +0100
Message-Id: <1447508679-21798-8-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 89c5eb7..9c28c64 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -366,6 +366,38 @@ response:
 	return decode_capabilities(avdtp_frame);
 }
 
+static bool avdtp_reconfigure(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t seid;
+	uint8_t service_cat;
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
+	if (!l2cap_frame_get_u8(frame, &service_cat))
+		return false;
+
+	print_field("Service Category: %s", servicecat2str(service_cat));
+
+	return avdtp_reject_common(avdtp_frame);
+
+response:
+	/* no extra parameters */
+	return true;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -432,6 +464,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_GET_CONFIGURATION:
 		ret = avdtp_get_configuration(avdtp_frame);
 		break;
+	case AVDTP_RECONFIGURE:
+		ret = avdtp_reconfigure(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

