Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/2] doc/pts: Update OPP PTS test results
Date: Wed, 26 Aug 2015 15:29:54 +0530
Message-id: <1440583195-11541-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS issues got resolved after updating the ETS file attached in
https://www.bluetooth.org/pts/issues/view_issue.cfm?id=13842,
which will be updated in next PTS release.
---
 doc/pts-opp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/pts-opp.txt b/doc/pts-opp.txt
index ae1bb7c..832028c 100644
--- a/doc/pts-opp.txt
+++ b/doc/pts-opp.txt
@@ -1,7 +1,7 @@
 PTS test results for OPP
 
 PTS version: 6.2.0
-Tested: 30-Jul-2015
+Tested: 26-Aug-2015
 
 Results:
 PASS	test passed
@@ -92,9 +92,9 @@ TC_SERVER_OPH_BV_15_I	N/A
 TC_SERVER_OPH_BV_16_I	N/A
 TC_SERVER_OPH_BV_17_I	PASS
 TC_SERVER_OPH_BV_18_I	PASS
-TC_SERVER_OPH_BV_19_I	INC	PTS issue #13842
+TC_SERVER_OPH_BV_19_I	PASS
 TC_SERVER_OPH_BV_21_I	N/A
-TC_SERVER_OPH_BV_22_I	INC	PTS issue #13842
+TC_SERVER_OPH_BV_22_I	PASS
 TC_SERVER_OPH_BV_23_I	PASS
 TC_SERVER_OPH_BV_24_I	N/A
 TC_SERVER_OPH_BV_25_I	N/A
-- 
1.9.1

