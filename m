Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/4] Bluetooth: Remove unneeded local_amp_id initialization
Date: Thu, 15 Nov 2012 18:14:55 +0200
Message-Id: <1352996096-27374-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

local_amp_id is already set in l2cap_connect() which is called several
lines above.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f6a8960..33eb3f4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4360,7 +4360,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 
 		BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan, hs_hcon);
 
-		chan->local_amp_id = req->amp_id;
 		mgr->bredr_chan = chan;
 		chan->hs_hcon = hs_hcon;
 		conn->mtu = hdev->block_mtu;
-- 
1.7.10.4

