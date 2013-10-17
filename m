Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 7/8] gitignore: Add android/haltest
Date: Thu, 17 Oct 2013 10:47:08 +0200
Message-ID: <1381999629-9589-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 6b97247..520a3f4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,3 +103,4 @@ unit/test-*.log
 unit/test-*.trs
 
 android/bluetoothd
+android/haltest
-- 
1.8.4

