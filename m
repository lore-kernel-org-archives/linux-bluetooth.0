Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 13/22] monitor/avdtp: Decode AVDTP_SECURITY_CONTROL
Date: Sun, 22 Nov 2015 21:20:25 +0100
Message-Id: <1448223634-23305-14-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index a69ddbe..28ddb20 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -517,6 +517,33 @@ static bool avdtp_abort(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_security_control(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t type = avdtp_frame->hdr & 0x03;
+	uint8_t seid;
+
+	switch (type) {
+	case AVDTP_MSG_TYPE_COMMAND:
+		if (!l2cap_frame_get_u8(frame, &seid))
+			return false;
+
+		print_field("ACP SEID: %d", seid >> 2);
+
+		/* TODO: decode more information */
+		packet_hexdump(frame->data, frame->size);
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		/* TODO: decode more information */
+		packet_hexdump(frame->data, frame->size);
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
@@ -592,6 +619,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return avdtp_suspend(avdtp_frame);
 	case AVDTP_ABORT:
 		return avdtp_abort(avdtp_frame);
+	case AVDTP_SECURITY_CONTROL:
+		return avdtp_security_control(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

