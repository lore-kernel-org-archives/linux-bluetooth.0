Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] avdtp: Fix typos in errors from avdtp_strerror
Date: Thu, 10 Oct 2013 10:53:36 +0200
Message-ID: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index fe63a40..fc896c7 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3807,7 +3807,7 @@ const char *avdtp_strerror(struct avdtp_error *err)
 	case AVDTP_BAD_ROHC_FORMAT:
 		return "Bad Header Compression Format";
 	case AVDTP_BAD_CP_FORMAT:
-		return "Bad Content Protetion Format";
+		return "Bad Content Protection Format";
 	case AVDTP_BAD_MULTIPLEXING_FORMAT:
 		return "Bad Multiplexing Format";
 	case AVDTP_UNSUPPORTED_CONFIGURATION:
@@ -3815,7 +3815,7 @@ const char *avdtp_strerror(struct avdtp_error *err)
 	case AVDTP_BAD_STATE:
 		return "Bad State";
 	default:
-		return "Unknow error";
+		return "Unknown error";
 	}
 }
 
-- 
1.8.4

