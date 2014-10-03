Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] test-gatt: Add test-gatt binary to .gitignore list
Date: Fri,  3 Oct 2014 13:19:54 +0200
Message-Id: <1412335194-25525-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 65d77a5..97daa9f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -120,6 +120,7 @@ unit/test-gobex-transfer
 unit/test-avdtp
 unit/test-avctp
 unit/test-avrcp
+unit/test-gatt
 unit/test-*.log
 unit/test-*.trs
 
-- 
1.9.3

