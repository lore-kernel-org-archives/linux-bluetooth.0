Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 06/34] Bluetooth: Check sk before assigning sk_err
Date: Thu, 19 Jan 2012 11:19:55 +0200
Message-Id: <1326964823-26747-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bc42ee8..643bab8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -732,7 +732,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
 	l2cap_state_change(chan, BT_DISCONN);
-	sk->sk_err = err;
+
+	if (sk)
+		sk->sk_err = err;
 }
 
 /* ---- L2CAP connections ---- */
-- 
1.7.4.1

