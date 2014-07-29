Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 7/7] 6lowpan: remove unused LOWPAN_FRAG_SIZE define
Date: Tue, 29 Jul 2014 23:47:04 +0200
Message-Id: <1406670424-15596-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This define is unused since commit
96cb3eb7a1a5f0c3598500a2348f7d2cc76afbd2 ("6lowpan: fix fragmentation on
sending side"). It is a worst case scenario for payload calculation.
Since commit 96cb3eb7a1a5f0c3598500a2348f7d2cc76afbd2 we calculation the
payload to use the optimal size.

This define is also necessary for ieee802154 6lowpan only and the file
include/net/6lowpan.h should contain generic 6lowpan things only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 18010bc..3bb3503 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -155,17 +155,6 @@
 #define LOWPAN_FRAGN_HEAD_SIZE	0x5
 
 /*
- * According IEEE802.15.4 standard:
- *   - MTU is 127 octets
- *   - maximum MHR size is 37 octets
- *   - MFR size is 2 octets
- *
- * so minimal payload size that we may guarantee is:
- *   MTU - MHR - MFR = 88 octets
- */
-#define LOWPAN_FRAG_SIZE	88
-
-/*
  * Values of fields within the IPHC encoding first byte
  * (C stands for compressed and I for inline)
  */
-- 
2.0.3
