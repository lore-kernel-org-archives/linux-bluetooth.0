Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/6] android: Fix missing log cleanup on daemon exit
Date: Sun, 20 Oct 2013 11:53:53 +0200
Message-Id: <1382262838-25725-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
References: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/main.c b/android/main.c
index c3fb80e..cfa728d 100644
--- a/android/main.c
+++ b/android/main.c
@@ -341,5 +341,7 @@ int main(int argc, char *argv[])
 
 	info("Exit");
 
+	__btd_log_cleanup();
+
 	return EXIT_SUCCESS;
 }
-- 
1.8.4

