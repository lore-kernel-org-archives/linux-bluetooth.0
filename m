Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gitignore: Add cscope files
Date: Fri,  7 Feb 2014 19:28:00 -0300
Message-Id: <1391812080-19529-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index b86deae..fe6636e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -121,3 +121,7 @@ android/android-tester
 android/ipc-tester
 android/bluetoothd-snoop
 android/test-ipc
+
+cscope.in.out
+cscope.out
+cscope.po.out
-- 
1.8.5.3

