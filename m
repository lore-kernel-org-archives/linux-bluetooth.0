Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/pts: Update GAP result for handling directed advertising
Date: Tue, 19 Aug 2014 11:32:07 +0200
Message-Id: <1408440727-31627-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously used connection procedure was to slow for remotes preforming
directed advertising. This issue is no longer valid on the latest kernel
and auto connection support added recently to the daemon.
---
 android/pts-gap.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index af75dff..d154a38 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -137,7 +137,6 @@ TC_CONN_GCEP_BV_03_C	PASS	gattc connect
 				gattc disconnect
 TC_CONN_GCEP_BV_04_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_SCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
-				Note: test is not always passing. JIRA: BA-55
 TC_CONN_SCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
 TC_CONN_DCEP_BV_01_C	PASS	'gattc connect' prior to pressing OK on PTS
 TC_CONN_DCEP_BV_02_C	INC	Privacy feature - PTS issue #12308
-- 
1.9.1

