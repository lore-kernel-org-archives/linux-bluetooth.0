Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 10/12] Bluetooth: Remove useless check in hci_connect()
Date: Fri,  6 May 2011 14:05:19 -0300
Message-Id: <1304701521-26459-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to check the connection's state since hci_le_conn_add()
has just created a new connection and its state has been set properly.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8896174..b67c83c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -465,8 +465,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_le_conn_add(hdev, dst, 0);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
-		if (le->state == BT_OPEN)
-			hci_le_connect(le);
+
+		hci_le_connect(le);
 
 		hci_conn_hold(le);
 
-- 
1.7.1

