Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: [PATCH v4 2/2] Bluetooth: Fix possible use after free in delete path
Date: Mon, 30 Jan 2012 18:26:29 -0200
Message-Id: <1327955189-4604-2-git-send-email-ulisses@profusion.mobi>
In-Reply-To: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to use the _sync() version for cancelling the info and security
timer in the L2CAP connection delete path. Otherwise the delayed work
handler might run after the connection object is freed.

Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ae7fb27..09cd860 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1016,10 +1016,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		__cancel_delayed_work(&conn->info_timer);
+		cancel_delayed_work_sync(&conn->info_timer);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
-		__cancel_delayed_work(&conn->security_timer);
+		cancel_delayed_work_sync(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 
-- 
1.7.8.rc4

