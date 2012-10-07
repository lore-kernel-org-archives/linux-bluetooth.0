Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 7/8] Bluetooth: Use locked l2cap_state_change()
Date: Mon,  8 Oct 2012 07:19:40 +0800
Message-Id: <1349651981-6251-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
References: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

No one was protecting the state set in l2cap_send_disconn_req()

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 94b0e75..8882f2e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1062,7 +1062,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 	}
 
 	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
-		__l2cap_state_change(chan, BT_DISCONN);
+		l2cap_state_change(chan, BT_DISCONN);
 		return;
 	}
 
-- 
1.7.11.4

