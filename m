Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 12/22] monitor/avdtp: Decode AVDTP_ABORT
Date: Sun, 22 Nov 2015 21:20:24 +0100
Message-Id: <1448223634-23305-13-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 256 flags 0x02 dlen 7
      Channel: 66 len 3 [PSM 25 mode 0] {chan 2}
      AVDTP: Abort (0x0a) Command (0x00) type 0x00 label 3 nosp 0
        ACP SEID: 3
< ACL Data TX: Handle 256 flags 0x00 dlen 6
      Channel: 258 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Abort (0x0a) Response Accept (0x02) type 0x00 label 3 nosp 0
---
 monitor/avdtp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 8051fee..a69ddbe 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -496,6 +496,27 @@ static bool avdtp_suspend(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_abort(struct avdtp_frame *avdtp_frame)
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
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		return true;
+	}
+
+	return false;
+}
+
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -569,6 +590,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return avdtp_close(avdtp_frame);
 	case AVDTP_SUSPEND:
 		return avdtp_suspend(avdtp_frame);
+	case AVDTP_ABORT:
+		return avdtp_abort(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

