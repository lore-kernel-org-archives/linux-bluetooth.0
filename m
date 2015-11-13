Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 2/2] android/README: Fix typo
Date: Fri, 13 Nov 2015 11:46:08 +0100
Message-Id: <1447411568-4361-3-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447411568-4361-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447411568-4361-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/README b/android/README
index 83a902b..fa4c42a 100644
--- a/android/README
+++ b/android/README
@@ -207,7 +207,7 @@ It is possible to customize BlueZ for Android through Android system properties.
 This may include enabling extra profiles or features inside HALs implementation
 These properties are read on Bluetooth stack startup only and require stack
 restart if changed. All customization properties names start with
-"persist.sys.bluetooth." or "ro.bluerooth." followed by specific HAL name e.g.
+"persist.sys.bluetooth." or "ro.bluetooth." followed by specific HAL name e.g.
 "persist.sys.bluetooth.handsfree". If both are present "persist.sys.bluetooth."
 takes precedence. This allows for read only properties to be set during build
 leaving enough flexibility for developing or debugging purposes.
-- 
2.6.2

