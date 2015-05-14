Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] doc/test-coverage: Update mgmt-tester test count
Date: Thu, 14 May 2015 12:50:30 +0200
Message-Id: <1431600630-8568-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
References: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/test-coverage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 2fb70ad..268c465 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -39,7 +39,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 295	Kernel management interface testing
+mgmt-tester		 296	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 bnep-tester		   1	Kernel BNEP implementation testing
@@ -48,7 +48,7 @@ sco-tester		   8	Kernel SCO implementation testing
 gap-tester		   1	Daemon D-Bus API testing
 hci-tester		  14	Controller hardware testing
 			-----
-			 361
+			 362
 
 
 Android end-to-end testing
-- 
1.9.3

