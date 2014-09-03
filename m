Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/avdtptest: Enable delay reporting
Date: Wed,  3 Sep 2014 15:13:43 +0200
Message-Id: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtptest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index d1f2ef4..d520bc0 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -856,7 +856,7 @@ int main(int argc, char *argv[])
 	}
 
 	local_sep = avdtp_register_sep(dev_role, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, FALSE, &sep_ind, &sep_cfm, NULL);
+					0x00, TRUE, &sep_ind, &sep_cfm, NULL);
 	if (!local_sep) {
 		printf("Failed to register sep\n");
 		exit(0);
-- 
1.9.1

