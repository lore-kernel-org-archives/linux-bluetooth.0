Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] gitignore: Add android/android-tester-ng
Date: Tue, 15 Jul 2014 12:30:37 +0200
Message-Id: <1405420237-12054-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1405420237-12054-1-git-send-email-szymon.janc@tieto.com>
References: <1405420237-12054-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 1a7b417..13e0bcb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -128,6 +128,7 @@ android/bluetoothd
 android/mcaptest
 android/haltest
 android/android-tester
+android/android-tester-ng
 android/ipc-tester
 android/bluetoothd-snoop
 android/test-ipc
-- 
1.9.1

