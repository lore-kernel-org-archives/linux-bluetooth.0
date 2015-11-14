Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 14/22] monitor/avdtp: Decode AVDTP_GET_ALL_CAPABILITIES
Date: Sat, 14 Nov 2015 14:44:31 +0100
Message-Id: <1447508679-21798-15-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avdtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index ecd55de..a44fd1a 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -631,6 +631,7 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 		ret = avdtp_discover(avdtp_frame);
 		break;
 	case AVDTP_GET_CAPABILITIES:
+	case AVDTP_GET_ALL_CAPABILITIES:
 		ret = avdtp_get_capabilities(avdtp_frame);
 		break;
 	case AVDTP_SET_CONFIGURATION:
-- 
2.6.2

