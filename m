Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] gitignore: Add android/haltest
Date: Thu, 17 Oct 2013 22:28:40 +0200
Message-Id: <1382041721-19960-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
References: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

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
1.8.4.rc3

