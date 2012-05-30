Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/3] Bluetooth: Allow only one LE connection attempt
Date: Wed, 30 May 2012 15:39:21 +0200
Message-ID: <1338385163-10589-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only one outgoing LE connection attempt should be possible.
hci_connect() will now return -EBUSY in case there's another pending
outgoing connection.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/hci_conn.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1458667b..2fcced3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -483,6 +483,11 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	if (type == LE_LINK) {
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (!le) {
+			le = hci_conn_hash_lookup_state(hdev, LE_LINK,
+							BT_CONNECT);
+			if (le)
+				return ERR_PTR(-EBUSY);
+
 			le = hci_conn_add(hdev, LE_LINK, dst);
 			if (!le)
 				return ERR_PTR(-ENOMEM);
-- 
1.7.9.5

