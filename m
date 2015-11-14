Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 15/22] monitor/avdtp: Decode AVDTP_DELAYREPORT
Date: Sat, 14 Nov 2015 14:44:32 +0100
Message-Id: <1447508679-21798-16-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index a44fd1a..e5bc13e 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -573,6 +573,37 @@ response:
 	return true;
 }
 
+static bool avdtp_delayreport(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t seid;
+	uint16_t delay;
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
+	if (!l2cap_frame_get_be16(frame, &delay))
+		return false;
+
+	print_field("ACP SEID: %d", seid >> 2);
+	print_field("Delay: %d.%dms", delay / 10, delay % 10);
+
+	return true;
+
+reject:
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
@@ -661,6 +692,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_SECURITY_CONTROL:
 		ret = avdtp_security_control(avdtp_frame);
 		break;
+	case AVDTP_DELAYREPORT:
+		ret = avdtp_delayreport(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

