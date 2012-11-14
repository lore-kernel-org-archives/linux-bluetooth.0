Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 2/3] Bluetooth: Disable FCS only for new HS channels
Date: Wed, 14 Nov 2012 17:39:31 +0200
Message-Id: <1352907572-7113-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set chan->fcs to L2CAP_FCS_NONE only for new L2CAP channels
(not moved). Other side can still request to use FCS.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/amp.c        |    1 -
 net/bluetooth/l2cap_core.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index eaf473f..0258b26 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -392,7 +392,6 @@ void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon)
 	bredr_chan->remote_amp_id = hs_hcon->remote_id;
 	bredr_chan->hs_hcon = hs_hcon;
 	bredr_chan->conn->mtu = hs_hcon->hdev->block_mtu;
-	bredr_chan->fcs = L2CAP_FCS_NONE;
 
 	__l2cap_physical_cfm(bredr_chan, 0);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 138d505..10b3062 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4518,6 +4518,8 @@ void l2cap_move_start(struct l2cap_chan *chan)
 static void l2cap_do_create(struct l2cap_chan *chan, int result,
 			    u8 local_amp_id, u8 remote_amp_id)
 {
+	chan->fcs = L2CAP_FCS_NONE;
+
 	if (!test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
 		struct l2cap_conn_rsp rsp;
 		char buf[128];
-- 
1.7.10.4

