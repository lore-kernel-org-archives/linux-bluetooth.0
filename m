Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/pts: Update GAP results
Date: Wed, 18 Jun 2014 17:29:46 +0200
Message-Id: <1403105386-4496-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 87151bd..db2690f 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -336,7 +336,7 @@ TC_PRIV_CONN_BV_07_C	N/A
 TC_PRIV_CONN_BV_08_C	N/A
 TC_PRIV_CONN_BV_09_C	N/A
 TC_PRIV_CONN_BV_10_C	N/A
-TC_PRIV_CONN_BV_11_C	INC	Privacy feature - not implemented
+TC_PRIV_CONN_BV_11_C	INC	PTS issue #12310
 TC_ADV_BV_01_C		N/A
 TC_ADV_BV_02_C		FAIL	PTS issue #12254
 TC_ADV_BV_03_C		PASS	gattc register_client
-- 
2.0.0

