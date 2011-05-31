Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 2/4] Bluetooth: Remove useless check in hci_connect()
Date: Tue, 31 May 2011 14:20:55 -0300
Message-Id: <1306862457-20310-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
References: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to check the connection's state since hci_conn_add()
has just created a new connection and its state has been set properly.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3163330..5f352d2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -453,8 +453,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
-		if (le->state == BT_OPEN)
-			hci_le_connect(le);
+
+		hci_le_connect(le);
 
 		hci_conn_hold(le);
 
-- 
1.7.4.1

