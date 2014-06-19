Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/pts: Update GAP PTS status
Date: Fri, 20 Jun 2014 00:50:34 +0200
Message-Id: <1403218234-19996-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1403218234-19996-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1403218234-19996-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After enabling privacy for peripheral one more test gets enabled in PTS
---
 android/pts-gap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index db2690f..02430f4 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -335,7 +335,7 @@ TC_PRIV_CONN_BV_06_C	N/A
 TC_PRIV_CONN_BV_07_C	N/A
 TC_PRIV_CONN_BV_08_C	N/A
 TC_PRIV_CONN_BV_09_C	N/A
-TC_PRIV_CONN_BV_10_C	N/A
+TC_PRIV_CONN_BV_10_C	INC	PTS issue #12312
 TC_PRIV_CONN_BV_11_C	INC	PTS issue #12310
 TC_ADV_BV_01_C		N/A
 TC_ADV_BV_02_C		FAIL	PTS issue #12254
-- 
1.8.4

