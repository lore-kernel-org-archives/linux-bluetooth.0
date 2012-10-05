Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 6/7] Bluetooth: AMP: Use block_mtu for AMP controller
Date: Fri,  5 Oct 2012 16:56:57 +0300
Message-Id: <1349445419-16788-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ab6853d..3066157 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1390,10 +1390,22 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
-	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
-		conn->mtu = hcon->hdev->le_mtu;
-	else
+	switch (hcon->type) {
+	case AMP_LINK:
+		conn->mtu = hcon->hdev->block_mtu;
+		break;
+
+	case LE_LINK:
+		if (hcon->hdev->le_mtu) {
+			conn->mtu = hcon->hdev->le_mtu;
+			break;
+		}
+		/* fall through */
+
+	default:
 		conn->mtu = hcon->hdev->acl_mtu;
+		break;
+	}
 
 	conn->src = &hcon->hdev->bdaddr;
 	conn->dst = &hcon->dst;
-- 
1.7.9.5

