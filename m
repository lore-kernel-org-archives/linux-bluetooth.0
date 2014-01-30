Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gitignore: Add unit/avctp to .gitignore
Date: Thu, 30 Jan 2014 16:34:51 +0200
Message-Id: <1391092491-21374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e2b23fc..2210e03 100644
--- a/.gitignore
+++ b/.gitignore
@@ -110,6 +110,7 @@ unit/test-gobex-header
 unit/test-gobex-packet
 unit/test-gobex-transfer
 unit/test-avdtp
+unit/test-avctp
 unit/test-*.log
 unit/test-*.trs
 
-- 
1.8.3.2

