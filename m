Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Remove unused LTK authentication defines
Date: Mon, 16 Jun 2014 11:00:31 +0300
Message-Id: <1402905633-470-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
References: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These defines were probably put in to track authenticated vs
unauthenticated LTKs, however since the LTK struct has a separate
boolean authenticated member these were never used.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6ec5b3bd1f67..fe584d78008d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -348,10 +348,6 @@ enum {
 #define HCI_LK_UNAUTH_COMBINATION_P256	0x07
 #define HCI_LK_AUTH_COMBINATION_P256	0x08
 
-/* Long Term Key types */
-#define HCI_LTK_UNAUTH			0x00
-#define HCI_LTK_AUTH			0x01
-
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
 #define HCI_ERROR_MEMORY_EXCEEDED	0x07
-- 
1.9.3

