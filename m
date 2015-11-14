Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 17/22] monitor/avdtp: Decode basic Content Protection capabilities
Date: Sat, 14 Nov 2015 14:44:34 +0100
Message-Id: <1447508679-21798-18-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index 003134f..e216a1b 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -192,6 +192,18 @@ static const char *mediacodec2str(uint8_t codec)
 	}
 }
 
+static const char *cptype2str(uint8_t cp)
+{
+	switch (cp) {
+	case 0x0001:
+		return "DTCP";
+	case 0x0002:
+		return "SCMS-T";
+	default:
+		return "Reserved";
+	}
+}
+
 static const char *servicecat2str(uint8_t service_cat)
 {
 	switch (service_cat) {
@@ -229,6 +241,29 @@ static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
 	return true;
 }
 
+static bool service_content_protection(struct avdtp_frame *avdtp_frame,
+								uint8_t losc)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	uint16_t type = 0;
+
+	if (losc < 2)
+		return false;
+
+	if (!l2cap_frame_get_le16(frame, &type))
+		return false;
+
+	losc -= 2;
+
+	print_field("%*cContent Protection Type: %s", 2, ' ', cptype2str(type));
+
+	/* TODO: decode protection specific information */
+
+	l2cap_frame_pull(frame, frame, losc);
+
+	return true;
+}
+
 static bool service_media_codec(struct avdtp_frame *avdtp_frame, uint8_t losc)
 {
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
@@ -278,6 +313,10 @@ static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
 			return false;
 
 		switch (service_cat) {
+		case AVDTP_CONTENT_PROTECTION:
+			if (!service_content_protection(avdtp_frame, losc))
+				return false;
+			break;
 		case AVDTP_MEDIA_CODEC:
 			if (!service_media_codec(avdtp_frame, losc))
 				return false;
@@ -285,7 +324,6 @@ static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
 		case AVDTP_MEDIA_TRANSPORT:
 		case AVDTP_REPORTING:
 		case AVDTP_RECOVERY:
-		case AVDTP_CONTENT_PROTECTION:
 		case AVDTP_HEADER_COMPRESSION:
 		case AVDTP_MULTIPLEXING:
 		case AVDTP_DELAY_REPORTING:
-- 
2.6.2

