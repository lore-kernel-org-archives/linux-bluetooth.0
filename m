Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Fix const declaration for swap function src parameter
Date: Tue, 18 Mar 2014 12:58:23 +0200
Message-Id: <1395140304-15747-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make it possible to (correctly) pass data declared as const as the
src parameter to the swap56 and swap128 functions declare this parameter
also as const.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8a1b1bf79555..4f3cde9dd1ea 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -35,14 +35,14 @@
 
 #define AUTH_REQ_MASK   0x07
 
-static inline void swap128(u8 src[16], u8 dst[16])
+static inline void swap128(const u8 src[16], u8 dst[16])
 {
 	int i;
 	for (i = 0; i < 16; i++)
 		dst[15 - i] = src[i];
 }
 
-static inline void swap56(u8 src[7], u8 dst[7])
+static inline void swap56(const u8 src[7], u8 dst[7])
 {
 	int i;
 	for (i = 0; i < 7; i++)
-- 
1.8.5.3

