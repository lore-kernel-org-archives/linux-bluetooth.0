Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 11/22] monitor/avdtp: Decode AVDTP_SUSPEND
Date: Sat, 14 Nov 2015 14:44:28 +0100
Message-Id: <1447508679-21798-12-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index e065d8b..e48e507 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -488,6 +488,44 @@ response:
 	return true;
 }
 
+static bool avdtp_suspend(struct avdtp_frame *avdtp_frame)
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
+	for (;;) {
+		if (!l2cap_frame_get_u8(frame, &seid))
+			break;
+
+		print_field("ACP SEID: %d", seid >> 2);
+	}
+
+	return true;
+
+reject:
+	if (!l2cap_frame_get_u8(frame, &seid))
+		return false;
+
+	print_field("ACP SEID: %d", seid >> 2);
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
@@ -566,6 +604,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_CLOSE:
 		ret = avdtp_close(avdtp_frame);
 		break;
+	case AVDTP_SUSPEND:
+		ret = avdtp_suspend(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

