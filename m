Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/3] doc: Update Android tests coverage
Date: Mon, 21 Jul 2014 15:23:38 +0200
Message-Id: <1405949020-27462-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

One test case was not ported to new tester framework as it was
considered invalid.
---
 doc/test-coverage.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 0da8321..e19e6c7 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -53,7 +53,7 @@ Android end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-android-tester		  86	Android HAL interface testing
+android-tester		  85	Android HAL interface testing
 ipc-tester		  94	Android IPC resistance testing
 			-----
 			 180
-- 
1.9.1

