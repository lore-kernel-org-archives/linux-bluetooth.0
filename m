Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v3 7/9] Bluetooth: Remove useless check in hci_connect()
Date: Thu, 26 May 2011 16:23:55 -0300
Message-Id: <1306437837-18263-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
References: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
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
index 84ad32b..b21cbb3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -457,8 +457,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_conn_add(hdev, LE_LINK, dst, 0);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
-		if (le->state == BT_OPEN)
-			hci_le_connect(le);
+
+		hci_le_connect(le);
 
 		hci_conn_hold(le);
 
-- 
1.7.4.1

