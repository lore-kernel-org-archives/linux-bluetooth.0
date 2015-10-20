Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/README: Update known Android issues section
Date: Tue, 20 Oct 2015 16:05:02 +0200
Message-Id: <1445349902-16586-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a patch which allows handling ssp passkey request.
---
 android/README | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/README b/android/README
index 9aa9a37..6b7f79d 100644
--- a/android/README
+++ b/android/README
@@ -9,7 +9,7 @@ replacement to Android provided Bluetooth stack.
 More details about BlueZ for Android architecture and components can be found
 in android/hal-ipc-api.txt file.
 
-Supported Android version: 4.4 KitKat and 5.0 Lollipop
+Supported Android version: 4.4 KitKat and 5.0, 5.1.1 Lollipop
 
 
 Building and running on Android
@@ -402,12 +402,16 @@ affect qualification or user experience. This section provides list of
 recommended Android fixes that are not part of latest AOSP release supported by
 BlueZ.
 
+For Android 5.1.1 Lollipop:
+https://android-review.googlesource.com/177314
+
 For Android 5.0 Lollipop:
 https://android-review.googlesource.com/99761
 https://android-review.googlesource.com/100297
 https://android-review.googlesource.com/102882
 https://android-review.googlesource.com/132733
 https://android-review.googlesource.com/132763
+https://android-review.googlesource.com/177314
 
 For Android 4.4 KitKat:
 https://android-review.googlesource.com/82757
@@ -417,6 +421,7 @@ https://android-review.googlesource.com/99761
 https://android-review.googlesource.com/99850
 https://android-review.googlesource.com/100297
 https://android-review.googlesource.com/102882
+https://android-review.googlesource.com/177314
 
 Unimplemented Bluetooth features
 ================================
-- 
2.1.0

