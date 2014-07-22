Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2] doc: Update Android tests coverage
Date: Tue, 22 Jul 2014 14:42:02 +0200
Message-Id: <1406032922-25256-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <20140722083446.GA26403@t440s.lan>
References: <20140722083446.GA26403@t440s.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

One test case was not ported to new tester framework as it was
considered invalid.
---
 doc/test-coverage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 0da8321..6b274b3 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -53,10 +53,10 @@ Android end-to-end testing
 
 Application		Count	Description
 -------------------------------------------
-android-tester		  86	Android HAL interface testing
+android-tester		  85	Android HAL interface testing
 ipc-tester		  94	Android IPC resistance testing
 			-----
-			 180
+			 179
 
 
 Android automated unit testing
-- 
1.9.1

