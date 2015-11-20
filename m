Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 08/22] monitor/avdtp: Decode AVDTP_OPEN
Date: Fri, 20 Nov 2015 15:13:26 +0100
Message-Id: <1448028820-25330-9-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 7
      Channel: 258 len 3 [PSM 25 mode 0] {chan 2}
      AVDTP: Open (0x06) Command (0x00) type 0x00 label 6 nosp 0
        ACP SEID: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 6
      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 6 nosp 0
---
 monitor/avdtp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 2dc0578..cc51587 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -402,6 +402,32 @@ response:
 	return true;
 }
 
+static bool avdtp_open(struct avdtp_frame *avdtp_frame)
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
@@ -473,6 +499,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_RECONFIGURE:
 		ret = avdtp_reconfigure(avdtp_frame);
 		break;
+	case AVDTP_OPEN:
+		ret = avdtp_open(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

