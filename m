Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 11/22] monitor/avdtp: Decode AVDTP_SUSPEND
Date: Sun, 22 Nov 2015 21:20:23 +0100
Message-Id: <1448223634-23305-12-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 7
      Channel: 258 len 3 [PSM 25 mode 0] {chan 2}
      AVDTP: Suspend (0x09) Command (0x00) type 0x00 label 8 nosp 0
        ACP SEID: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 6
      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Suspend (0x09) Response Accept (0x02) type 0x00 label 8 nosp 0
---
 monitor/avdtp.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 6e2bb25..8051fee 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -465,6 +465,37 @@ static bool avdtp_close(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_suspend(struct avdtp_frame *avdtp_frame)
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
+		while (l2cap_frame_get_u8(frame, &seid))
+			print_field("ACP SEID: %d", seid >> 2);
+
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_REJECT:
+		if (!l2cap_frame_get_u8(frame, &seid))
+			return false;
+
+		print_field("ACP SEID: %d", seid >> 2);
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
@@ -536,6 +567,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return avdtp_start(avdtp_frame);
 	case AVDTP_CLOSE:
 		return avdtp_close(avdtp_frame);
+	case AVDTP_SUSPEND:
+		return avdtp_suspend(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

