Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 15/22] monitor/avdtp: Decode AVDTP_DELAYREPORT
Date: Sun, 22 Nov 2015 21:20:27 +0100
Message-Id: <1448223634-23305-16-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 4867c0b..3b2271e 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -544,6 +544,35 @@ static bool avdtp_security_control(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_delayreport(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t type = avdtp_frame->hdr & 0x03;
+	uint8_t seid;
+	uint16_t delay;
+
+	switch (type) {
+	case AVDTP_MSG_TYPE_COMMAND:
+		if (!l2cap_frame_get_u8(frame, &seid))
+			return false;
+
+		print_field("ACP SEID: %d", seid >> 2);
+
+		if (!l2cap_frame_get_be16(frame, &delay))
+			return false;
+
+		print_field("Delay: %d.%dms", delay / 10, delay % 10);
+
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_REJECT:
+		return avdtp_reject_common(avdtp_frame);
+	}
+
+	return false;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -622,6 +651,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return avdtp_abort(avdtp_frame);
 	case AVDTP_SECURITY_CONTROL:
 		return avdtp_security_control(avdtp_frame);
+	case AVDTP_DELAYREPORT:
+		return avdtp_delayreport(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

