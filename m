Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update test notes for L2CAP
Date: Thu, 12 Feb 2015 13:52:42 +0100
Message-Id: <1423745562-15295-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Daemon should be stopped for test purposes.
---
 android/pts-l2cap.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index b5fdb05..b625861 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -14,6 +14,8 @@ N/A    test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
+				For all tests daemon should be stopped then:
+					setprop ctl.start hciattach
 TC_COS_CED_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_CED_BV_03_C	PASS	l2test -y -N 1 -P 4113 <bdaddr>
 TC_COS_CED_BV_04_C	PASS	l2test -n -P 4113 <bdaddr>
@@ -151,9 +153,6 @@ TC_ECF_BV_05_C		N/A
 TC_ECF_BV_06_C		N/A
 TC_ECF_BV_07_C		N/A
 TC_ECF_BV_08_C		N/A
-				NOTE: for LE tests daemon should be stopped
-				then:
-				setprop ctl.start hciattach
 TC_LE_CPU_BV_01_C	PASS	l2test -n -V le_public -J 4
 TC_LE_CPU_BV_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
 TC_LE_CPU_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
-- 
1.9.1

