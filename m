Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Make __next_ident function static.
Date: Sat, 14 Feb 2015 13:36:07 -0800
Message-Id: <1423949767-8669-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The __next_ident function is a local function and so do not export it
and make it static.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 2 +-
 net/bluetooth/a2mp.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index cfc8fe1ee09b..5a04eb1a7e57 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -69,7 +69,7 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *dat
 	kfree(cmd);
 }
 
-u8 __next_ident(struct amp_mgr *mgr)
+static u8 __next_ident(struct amp_mgr *mgr)
 {
 	if (++mgr->ident == 0)
 		mgr->ident = 1;
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 41f9fbc26c29..296f665adb09 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -131,7 +131,6 @@ struct a2mp_physlink_rsp {
 
 struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
-u8 __next_ident(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_discover_amp(struct l2cap_chan *chan);
-- 
2.1.0

