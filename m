Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/pts: Update PBAP results
Date: Mon, 18 Aug 2014 13:13:34 +0200
Message-Id: <1408360414-8132-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-pbap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index bead56d..6341f5c 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -126,7 +126,7 @@ TC_PSE_PBB_BV_46_C	N/A
 TC_PSE_PBB_BV_28_C	N/A
 TC_PSE_PBB_BV_29_C	N/A
 TC_PSE_PBB_BV_30_C	N/A
-TC_PSE_PBB_BV_31_C	INC	JIRA #BA-71
+TC_PSE_PBB_BV_31_C	PASS	Requires entries in IUT's /och and /ich folders
 TC_PSE_PBB_BV_32_C	N/A
 TC_PSE_PBF_BV_01_I	PASS
 TC_PSE_PBF_BV_02_I	PASS	Tester must verify vcard content received by PTS
-- 
1.9.1

