Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 05/22] Bluetooth: hci_conn_auto_accept() doesn't need locking
Date: Sat, 17 Dec 2011 19:29:25 -0200
Message-Id: <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It doesn't really touch any sensitive information about hdev. So no need
to lock here.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_conn.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d88a61..e6d8a22 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -362,12 +362,8 @@ static void hci_conn_auto_accept(unsigned long arg)
 	struct hci_conn *conn = (void *) arg;
 	struct hci_dev *hdev = conn->hdev;
 
-	hci_dev_lock(hdev);
-
 	hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY, sizeof(conn->dst),
 								&conn->dst);
-
-	hci_dev_unlock(hdev);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
-- 
1.7.6.4

