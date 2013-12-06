Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix valid LE PSM check
Date: Fri,  6 Dec 2013 07:01:55 +0200
Message-Id: <1386306115-30686-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386306115-30686-1-git-send-email-johan.hedberg@gmail.com>
References: <1386306115-30686-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The range of valid LE PSMs is 0x0001-0x00ff so the check should be for
"less than or equal to" instead of "less than".

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8f42cae96dc3..23c57b4cdbcb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1851,7 +1851,7 @@ static bool is_valid_psm(u16 psm, u8 dst_type)
 		return false;
 
 	if (bdaddr_type_is_le(dst_type))
-		return (psm < 0x00ff);
+		return (psm <= 0x00ff);
 
 	/* PSM must be odd and lsb of upper byte must be 0 */
 	return ((psm & 0x0101) == 0x0001);
-- 
1.8.4.2

