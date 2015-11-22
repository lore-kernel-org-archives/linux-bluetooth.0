Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 07/22] monitor/avdtp: Decode AVDTP_RECONFIGURE
Date: Sun, 22 Nov 2015 21:20:19 +0100
Message-Id: <1448223634-23305-8-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 8377afe..413d966 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -358,6 +358,36 @@ static bool avdtp_get_configuration(struct avdtp_frame *avdtp_frame)
 	return false;
 }
 
+static bool avdtp_reconfigure(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint8_t type = avdtp_frame->hdr & 0x03;
+	uint8_t seid;
+	uint8_t service_cat;
+
+	switch (type) {
+	case AVDTP_MSG_TYPE_COMMAND:
+		if (!l2cap_frame_get_u8(frame, &seid))
+			return false;
+
+		print_field("ACP SEID: %d", seid >> 2);
+
+		return decode_capabilities(avdtp_frame);
+	case AVDTP_MSG_TYPE_RESPONSE_ACCEPT:
+		return true;
+	case AVDTP_MSG_TYPE_RESPONSE_REJECT:
+		if (!l2cap_frame_get_u8(frame, &service_cat))
+			return false;
+
+		print_field("Service Category: %s (0x%02x)",
+				servicecat2str(service_cat), service_cat);
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
@@ -421,6 +451,8 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		return avdtp_set_configuration(avdtp_frame);
 	case AVDTP_GET_CONFIGURATION:
 		return avdtp_get_configuration(avdtp_frame);
+	case AVDTP_RECONFIGURE:
+		return avdtp_reconfigure(avdtp_frame);
 	}
 
 	packet_hexdump(frame->data, frame->size);
-- 
2.6.2

