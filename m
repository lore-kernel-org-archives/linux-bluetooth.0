Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/avdtptest: Fix NULL local stream endpoint queue
Date: Tue, 12 May 2015 10:06:21 +0200
Message-Id: <1431417981-24341-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes missing queue_new()
---
 android/avdtptest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/avdtptest.c b/android/avdtptest.c
index f42f664..2e07d7e 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -866,6 +866,12 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	lseps = queue_new();
+	if (!lseps) {
+		printf("Failed to allocate memory\n");
+		exit(0);
+	}
+
 	local_sep = avdtp_register_sep(lseps, dev_role, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, &sep_cfm, NULL);
 	if (!local_sep) {
-- 
1.9.1

