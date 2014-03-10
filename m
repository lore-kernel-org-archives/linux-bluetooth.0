Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 7/7] doc: Update test-hfp coverage statistics
Date: Tue, 11 Mar 2014 00:10:34 +0100
Message-Id: <1394493034-2417-7-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
References: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/test-coverage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index b00ba1d..f6f2de0 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -16,7 +16,7 @@ test-mgmt		   2	Management interface handling
 test-textfile		   4	Old textfile storage format
 test-ringbuf		   3	Ring buffer functionality
 test-queue		   1	Queue handling functionality
-test-hfp		   9	HFP Audio Gateway functionality
+test-hfp		  13	HFP Audio Gateway functionality
 test-avdtp		  60	AVDTP qualification test cases
 test-avctp		   9	AVCTP qualification test cases
 test-avrcp		  37	AVRCP qualification test cases
@@ -27,7 +27,7 @@ test-gobex-apparam	  18	OBEX apparam handling
 test-gobex-transfer	  36	OBEX transfer handling
 test-gdbus-client	  12	D-Bus client handling
 			-----
-			 442
+			 446
 
 
 Automated end-to-end testing
-- 
1.9.0

