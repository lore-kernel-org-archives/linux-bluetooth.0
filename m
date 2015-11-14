Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 05/22] monitor/avdtp: Decode AVDTP_SET_CONFIGURATION
Date: Sat, 14 Nov 2015 14:44:22 +0100
Message-Id: <1447508679-21798-6-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index cae704a..f38d359 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -305,6 +305,42 @@ response:
 	return decode_capabilities(avdtp_frame);
 }
 
+static bool avdtp_set_configuration(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t acp_seid, int_seid;
+	uint8_t service_cat;
+
+	if (avdtp_frame->hdr & 0x01)
+		goto reject;
+
+	if (avdtp_frame->hdr & 0x02)
+		goto response;
+
+	if (!l2cap_frame_get_u8(frame, &acp_seid))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &int_seid))
+		return false;
+
+	print_field("ACP SEID: %d", acp_seid >> 2);
+	print_field("INT SEID: %d", int_seid >> 2);
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
@@ -365,6 +401,9 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 	case AVDTP_GET_CAPABILITIES:
 		ret = avdtp_get_capabilities(avdtp_frame);
 		break;
+	case AVDTP_SET_CONFIGURATION:
+		ret = avdtp_set_configuration(avdtp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 		ret = true;
-- 
2.6.2

