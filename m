Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 3/4] Bluetooth: Add error mapping for Directed Advertising Timeout
Date: Mon, 24 Mar 2014 20:21:52 +0200
Message-Id: <1395685313-26085-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
References: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When a timeout occurs using directed advertising a 0x3c error gets
generated. Since the operation is analogous to conventional connection
creation map this to the usual EHOSTDOWN error.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index b3fbc73516c4..941ad7530eda 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -58,6 +58,7 @@ int bt_to_errno(__u16 code)
 		return EIO;
 
 	case 0x04:
+	case 0x3c:
 		return EHOSTDOWN;
 
 	case 0x05:
-- 
1.8.5.3

