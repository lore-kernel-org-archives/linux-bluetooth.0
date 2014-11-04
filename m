Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix sparse warnings in RFCOMM
Date: Tue,  4 Nov 2014 08:45:45 +0200
Message-Id: <1415083545-32629-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the following sparse warnings in rfcomm/core.c:

net/bluetooth/rfcomm/core.c:391:16: warning: dubious: x | !y
net/bluetooth/rfcomm/core.c:546:24: warning: dubious: x | !y

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/rfcomm/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index bce9c3d39324..64e20dde4837 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -81,6 +81,8 @@ static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 #define __test_cr(b)      (!!(b & 0x02))
 #define __test_pf(b)      (!!(b & 0x10))
 
+#define __session_dir(s)  ((s)->initiator ? 0x00 : 0x01)
+
 #define __addr(cr, dlci)       (((dlci & 0x3f) << 2) | (cr << 1) | 0x01)
 #define __ctrl(type, pf)       (((type & 0xef) | (pf << 4)))
 #define __dlci(dir, chn)       (((chn & 0x1f) << 1) | dir)
@@ -388,7 +390,7 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 			return err;
 	}
 
-	dlci = __dlci(!s->initiator, channel);
+	dlci = __dlci(__session_dir(s), channel);
 
 	/* Check if DLCI already exists */
 	if (rfcomm_dlc_get(s, dlci))
@@ -543,7 +545,7 @@ struct rfcomm_dlc *rfcomm_dlc_exists(bdaddr_t *src, bdaddr_t *dst, u8 channel)
 	rfcomm_lock();
 	s = rfcomm_session_get(src, dst);
 	if (s) {
-		dlci = __dlci(!s->initiator, channel);
+		dlci = __dlci(__session_dir(s), channel);
 		dlc = rfcomm_dlc_get(s, dlci);
 	}
 	rfcomm_unlock();
-- 
1.9.3

