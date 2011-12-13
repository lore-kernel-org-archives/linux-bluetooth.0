Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	marcel@holtmann.org, jaikumar@google.com,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH] Bluetooth: Incoming ACL packets do not force active mode
Date: Tue, 13 Dec 2011 15:06:02 -0800
Message-Id: <1323817562-26262-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Incoming sk_buffs always have bt_cb(skb)->force_active set to 0, so
it's misleading to use that value from the control block when calling
hci_conn_enter_active_mode() for incoming data. The destination socket
is not known in the HCI layer, so the force_active setting for each
socket isn't known either. Hard-coding the force_active parameter does
not change any behavior, but makes it obvious that incoming ACL data
never exits sniff mode.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ce3727e..8775acb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2439,7 +2439,7 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn) {
 		register struct hci_proto *hp;
 
-		hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
+		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
 		/* Send to upper protocol */
 		hp = hci_proto[HCI_PROTO_L2CAP];
-- 
1.7.8

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
