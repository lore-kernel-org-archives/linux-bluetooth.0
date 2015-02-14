Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Make a2mp_send function static
Date: Sat, 14 Feb 2015 13:36:06 -0800
Message-Id: <1423949767-8669-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The a2mp_send function is a local function and so do not export it
and make it static.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 2 +-
 net/bluetooth/a2mp.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6bba3044dc7f..cfc8fe1ee09b 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -45,7 +45,7 @@ static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 	return cmd;
 }
 
-void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
+static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 {
 	struct l2cap_chan *chan = mgr->a2mp_chan;
 	struct a2mp_cmd *cmd;
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 652117ebf2a5..41f9fbc26c29 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -134,7 +134,6 @@ int amp_mgr_put(struct amp_mgr *mgr);
 u8 __next_ident(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
-void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 void a2mp_discover_amp(struct l2cap_chan *chan);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
-- 
2.1.0

