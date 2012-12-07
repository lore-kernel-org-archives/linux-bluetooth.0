Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/5] Bluetooth: AMP: Remove dead code
Date: Fri,  7 Dec 2012 14:59:07 +0200
Message-Id: <1354885148-4677-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove code which cannot execute. l2cap_conn_add for AMP_LINK
might only be invoked when receiving data in l2cap_recv_acldata.
But this case is checked in the first statement there.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d4a44dc..4976d12 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1527,17 +1527,12 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
 	switch (hcon->type) {
-	case AMP_LINK:
-		conn->mtu = hcon->hdev->block_mtu;
-		break;
-
 	case LE_LINK:
 		if (hcon->hdev->le_mtu) {
 			conn->mtu = hcon->hdev->le_mtu;
 			break;
 		}
 		/* fall through */
-
 	default:
 		conn->mtu = hcon->hdev->acl_mtu;
 		break;
-- 
1.7.10.4

