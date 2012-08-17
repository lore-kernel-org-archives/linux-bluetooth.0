Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 25/26] Bluetooth: Set Exended Flowspec flag for HS chan
Date: Fri, 17 Aug 2012 17:33:20 +0300
Message-Id: <1345214001-7053-26-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For AMP we always assume EFS L2CAP option.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap_core.c    |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a5d6d16..2cf7229 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -509,6 +509,8 @@ struct l2cap_chan {
 	__u32		remote_acc_lat;
 	__u32		remote_flush_to;
 
+	__u8		ctrl_id;
+
 	struct delayed_work	chan_timer;
 	struct delayed_work	retrans_timer;
 	struct delayed_work	monitor_timer;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 12da90b..d99eaf9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5468,8 +5468,13 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 void l2cap_chan_create_cfm(struct hci_conn *hcon, u8 remote_id)
 {
 	struct amp_mgr *mgr = hcon->amp_mgr;
+	struct l2cap_chan *chan = mgr->bredr_chan;
 
-	l2cap_send_chan_create_req(mgr->bredr_chan, remote_id);
+	/* Set Extended Flow Spec for AMP */
+	set_bit(FLAG_EFS_ENABLE, &chan->flags);
+	chan->ctrl_id = remote_id;
+
+	l2cap_send_chan_create_req(chan, remote_id);
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
-- 
1.7.9.5

