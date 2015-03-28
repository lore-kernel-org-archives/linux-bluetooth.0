Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 3/3] doc/test-coverage.txt: Update mgmt-tester test count
Date: Sat, 28 Mar 2015 12:40:15 -0700
Message-Id: <1427571615-29289-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1427571615-29289-1-git-send-email-armansito@chromium.org>
References: <1427571615-29289-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/test-coverage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 268d310..53d0ba4 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -40,7 +40,7 @@ Automated end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-mgmt-tester		 274	Kernel management interface testing
+mgmt-tester		 280	Kernel management interface testing
 l2cap-tester		  27	Kernel L2CAP implementation testing
 rfcomm-tester		   9	Kernel RFCOMM implementation testing
 smp-tester		   5	Kernel SMP implementation testing
@@ -48,7 +48,7 @@ sco-tester		   8	Kernel SCO implementation testing
 gap-tester		   1	Daemon D-Bus API testing
 hci-tester		  14	Controller hardware testing
 			-----
-			 338
+			 344
 
 
 Android end-to-end testing
-- 
2.2.0.rc0.207.ga3a616c

