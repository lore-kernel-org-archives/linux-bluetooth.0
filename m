Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/bluetooth: Fix Supported feature bitmask for MPMD scenarios
Date: Mon, 20 Oct 2014 15:33:51 +0200
Message-Id: <1413812032-26631-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set A2DP-SRC_AVRCP-TG instead of A2DP-SNK_AVRCP-CT_DUN-DT bit.
It was affecting TC_SDP_CTH_SD_BV_01_I PTS test case.
---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 827e205..03eb1a1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -70,7 +70,7 @@
  */
 #define MPS_DEFAULT_MPMD ((1ULL << 1) | (1ULL << 3) | (1ULL << 5) | \
 				(1ULL << 6) | (1ULL << 8) | (1ULL << 10) | \
-				(1ULL << 12) | (1ULL << 15) | (1ULL << 18))
+				(1ULL << 12) | (1ULL << 15) | (1ULL << 17))
 
 /*
  * bits in bitmask as defined in table 6.5 of Multi Profile Specification
-- 
1.9.3

