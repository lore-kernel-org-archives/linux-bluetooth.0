Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Make amp_mgr_list and amp_mgr_list_lock static
Date: Sat, 14 Feb 2015 13:36:04 -0800
Message-Id: <1423949767-8669-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to have amp_mgr_list and amp_mgr_list_lock exported
from a2mp.c and thus make both of them static.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 4 ++--
 net/bluetooth/a2mp.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6baa78a4e76c..e4f179117ae2 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -22,8 +22,8 @@
 #define A2MP_FEAT_EXT	0x8000
 
 /* Global AMP Manager list */
-LIST_HEAD(amp_mgr_list);
-DEFINE_MUTEX(amp_mgr_list_lock);
+static LIST_HEAD(amp_mgr_list);
+static DEFINE_MUTEX(amp_mgr_list_lock);
 
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 5c0a36b7ecc4..883266602cbc 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -129,9 +129,6 @@ struct a2mp_physlink_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
 #define A2MP_STATUS_SECURITY_VIOLATION		0x06
 
-extern struct list_head amp_mgr_list;
-extern struct mutex amp_mgr_list_lock;
-
 struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 u8 __next_ident(struct amp_mgr *mgr);
-- 
2.1.0

