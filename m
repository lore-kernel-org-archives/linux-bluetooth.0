Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 13/22] monitor/avdtp: Decode AVDTP_SECURITY_CONTROL
Date: Fri, 20 Nov 2015 15:13:31 +0100
Message-Id: <1448028820-25330-14-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 3dfae0d..bb2409e 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -550,6 +550,33 @@ response:
 	return true;
 }
 
+static bool avdtp_security_control(struct avdtp_frame *avdtp_frame)
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
+	packet_hexdump(frame->data, frame->size);
+	return true;
+
+reject:
+	return avdtp_reject_common(avdtp_frame);
+
+response:
+	packet_hexdump(frame->data, frame->size);
+	return true;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -636,6 +663,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_ABORT:
 		ret = avdtp_abort(avdtp_frame);
 		break;
+	case AVDTP_SECURITY_CONTROL:
+		ret = avdtp_security_control(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

