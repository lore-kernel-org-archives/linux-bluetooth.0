Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Move A2MP_FEAT_EXT declaration into A2MP source
Date: Sat, 14 Feb 2015 13:36:03 -0800
Message-Id: <1423949767-8669-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The A2MP_FEAT_EXT declaration has a single user in a2mp.c and thus
just move it there.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 2 ++
 net/bluetooth/a2mp.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index cedfbda15dad..6baa78a4e76c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -19,6 +19,8 @@
 #include "a2mp.h"
 #include "amp.h"
 
+#define A2MP_FEAT_EXT	0x8000
+
 /* Global AMP Manager list */
 LIST_HEAD(amp_mgr_list);
 DEFINE_MUTEX(amp_mgr_list_lock);
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 487b54c1308f..5c0a36b7ecc4 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -17,8 +17,6 @@
 
 #include <net/bluetooth/l2cap.h>
 
-#define A2MP_FEAT_EXT	0x8000
-
 enum amp_mgr_state {
 	READ_LOC_AMP_INFO,
 	READ_LOC_AMP_ASSOC,
-- 
2.1.0

