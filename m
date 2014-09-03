Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/avdtptest: Print info when matching SEP was found
Date: Wed,  3 Sep 2014 15:13:45 +0200
Message-Id: <1409750027-20992-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
References: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index 92312fa..a56b9c0 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -350,6 +350,8 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 		return;
 	}
 
+	printf("Matching endpoint found\n");
+
 	service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
 	caps = g_slist_append(caps, service);
 
-- 
1.9.1

