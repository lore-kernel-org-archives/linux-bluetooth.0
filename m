Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] build: Add android/hal-ipc-api.txt to EXTRA_DIST
Date: Mon, 14 Oct 2013 10:05:59 +0200
Message-ID: <1381737959-9138-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381737959-9138-1-git-send-email-szymon.janc@tieto.com>
References: <1381737959-9138-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.android | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.android b/Makefile.android
index e161e6d..3ceefd8 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -6,3 +6,5 @@ android_bluetoothd_LDADD = @GLIB_LIBS@
 endif
 
 EXTRA_DIST += android/Android.mk android/log.c
+
+EXTRA_DIST += android/hal-ipc-api.txt
-- 
1.8.4

